--[[
    Created by codecrafting-io

	AdvancedPathTracing is a small mod for properly setting some advanced path tracing settings

	Credits
    - [Ultra Plus Control (sammilucia)](https://www.nexusmods.com/cyberpunk2077/mods/10490)
    - [Weathermancer (RMK)](https://www.nexusmods.com/cyberpunk2077/mods/9805)
    - [JB - TPP MOD WIP third person (Jelle Bakker)](https://www.nexusmods.com/cyberpunk2077/mods/669)
    - [betterHeadlights (keanuWheeze)](https://www.nexusmods.com/cyberpunk2077/mods/5013)
    - [Lua Kit for CET (Pavel Siberx)](https://github.com/psiberx/cp2077-cet-kit)

	Nvidia Docs - https://github.com/NVIDIAGameWorks/RTXDI/blob/main/doc/Integration.md
    Native Settings Docs - https://github.com/justarandomguyintheinternet/CP77_nativeSettings
]]--

--do return end
settings = {}
Cron = require("Modules/Cron")
GameUI = require("Modules/GameUI")
GameSettings = require("Modules/GameSettings")

local settingsFilename = "settings.json"
local defaults = require("defaults")
local ptSettings = require("ptSettings")
local Debug = require("Modules/Debug")
local NativeSettings = {}
local modOptions = require("modOptions")
local PRESET = {
    VANILLA = 1,
    VERY_LOW = 2,
    LOW = 3,
    MEDIUM = 4,
    HIGH = 5,
    ULTRA = 6,
    PSYCHO = 7,
    CUSTOM = 8
}
local previous = {
    dlssSharpness = nil,
    dlssPreset = nil,
    dlssBackend = nil,
    hasDLSSD = nil,
    isRaining = nil,
    isIndoors = nil
}
local runtime = {
    firstLoad = true,
    reGIRApplied = false,
    inGame = false,
    nrdTimer = nil,
    particleTimer = nil,
	enableReGIR = false,
	enableReSTIR = true,
    refreshGame = false,
    refreshTimer = nil,
    hasDLSSD = false,
    fppHeadAdded = false
}
local AdvancedPathTracingEvents = {
    settings = {},
    events = {
        beforeRefresh = {},
        afterRefresh = {}
    }
}
local eventHandler = {
    --Register events
    __index = function(self, key)
        return function(callback)
            if self.events[key] then
                table.insert(self.events[key], callback)
            end
        end
    end,
    --Call events
    __call = function(self, event, ...)
        if self.events[event] then
            for _, callback in ipairs(self.events[event]) do
                callback(...)
            end
        end
    end
}
setmetatable(AdvancedPathTracingEvents, eventHandler)

---Checks if preset has a valid range, except custom
---@param preset integer
---@return boolean
local function isPresetInRange(preset)
    return preset >= PRESET.VANILLA and preset <= PRESET.PSYCHO
end

---Checks if the provided setting index of the current ptPreset is identical to value, if not set "Custom" profile
---@param setting string
---@param value any
local function checkCustomPreset(setting, value)
    if isPresetInRange(settings.ptPreset) and ptSettings.preset[settings.ptPreset][setting] ~= value then
        NativeSettings.setOption(modOptions.options["PT_PRESET"].option, 8)
    end
end

---Save mod settings to the file
local function saveSettings()
    Debug:Info("Saving Settings")
    local validJson, contents = pcall(function() return json.encode(settings) end)

    if validJson and contents ~= nil then
        local file = io.open(settingsFilename, "w+")
        if file ~= nil then
            file:write(contents)
            file:close()
        else
            Debug:Error("Failed to save settings file '" .. settingsFilename .. "'")
        end
    end
end

---Load mod settings from the file
local function loadSettings()
    local file = io.open(settingsFilename, 'r')
    defaultSettings = Debug:Clone(defaults)
    Debug:Log('Loading settings file ' .. settingsFilename)

    if file ~= nil then
        local contents = file:read("*a")
        local validJson, savedSettings = pcall(function() return json.decode(contents) end)
        file:close()
        Debug:SetLogLevel(savedSettings["debug"] and Debug.INFO or Debug.ERROR)

        --New version requires settings reset
        if defaults.version ~= savedSettings["version"] then
            Debug:Info("New Version " .. defaults.version)
            settings = defaultSettings
            saveSettings()
        elseif validJson then
            settings = Debug:Clone(savedSettings)

            --Validate timings
            if settings.slowTimeout < settings.fastTimeout then
                settings.slowTimeout = settings.fastTimeout + 2.0
            end

            if settings.refreshPauseTimeout < settings.fastTimeout then
                settings.refreshPauseTimeout = settings.fastTimeout + 5.0
            end
        end
    else
        Debug:SetLogLevel(defaultSettings["debug"] and Debug.INFO or Debug.ERROR)
        settings = defaultSettings
        saveSettings()
    end

    if settings.debug then
        Debug:Debug(string.format('%s Settings', 'Advanced Path Tracing'))
        Debug:Debug(Debug:Parse(settings))
    end
end

---Confirm game changes and refresh NativeSettings
local function pushChanges()
    Game.GetSettingsSystem():ConfirmChanges()
    Cron.After(0.25, function()
        if NativeSettings then
            NativeSettings.refresh()
        end
    end)
end

---Refresh Ray Reconstruction if preset or sharpness was changed
local function refreshDLSSD()
    previous.hasDLSSD = runtime.hasDLSSD
    previous.dlssSharpness = GameSettings.Get("/graphics/presets", "DLSS_NewSharpness")
    previous.dlssPreset = GameSettings.Get("/graphics/presets", "DLSS")
    previous.dlssBackend = GameSettings.Get("/graphics/presets", "DLSS_BackendPreset")
    Debug:Info("Refreshing DLSS Ray Reconstruction - " .. previous.dlssPreset)

    --Enabling NRD also disables DLSSD
    GameSettings.Set("RayTracing", "EnableNRD", "true")
    GameSettings.Set("/graphics/presets", "DLSS_D", false)
    pushChanges()
    Cron.After(0.025, function()
        --This should be true, but set it to false also enables DLSSD and reduce noise while refreshing DLSS_D
        GameSettings.Set("RayTracing", "EnableNRD", "false")
        Cron.After(settings.fastTimeout, function()
            --DLSSD is already enabled, but this will update game settings
            GameSettings.Set("/graphics/presets", "DLSS_D", true)
            GameSettings.Set("RayTracing", "EnableNRD", "false")
            pushChanges()
        end)
    end)
end

---Check for Ray Reconstruction changes in preset or sharpness
---@return boolean
local function hasDLSSDChanged()
    return previous.hasDLSSD ~= runtime.hasDLSSD
            or previous.dlssPreset ~= GameSettings.Get("/graphics/presets", "DLSS")
            or previous.dlssSharpness ~= GameSettings.Get("/graphics/presets", "DLSS_NewSharpness")
            or previous.dlssBackend ~= GameSettings.Get("/graphics/presets", "DLSS_BackendPreset")
end

---Set Ray Reconstruction particles control detection
---@param dlssdParticles boolean
function setDLSSDParticlesControl(dlssdParticles)
    settings.dlssdParticles = dlssdParticles
    if not runtime.particleTimer and dlssdParticles then
        -- enable particle PT integration unless player is outdoors AND it's raining
        runtime.particleTimer = Cron.Every(settings.fastTimeout * 2.0, function()
            if runtime.inGame then
                local isRaining = GameSettings.IsRaining()
                local isIndoors = GameSettings.IsIndoors()

                --Change detection
                if isRaining ~= previous.isRaining or isIndoors ~= previous.isIndoors then
                    previous.isRaining = isRaining
                    previous.isIndoors = isIndoors

                    if isIndoors or isRaining then
                        Debug:Info("It's raining or is indoors. Enabling DLSSD separate particle color")
                        GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "true")
                    else
                        Debug:Info("It's not raining and it's outdoors. Disabling DLSSD separate particle color")
                        GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "false")
                    end
                end
            end
        end)
    end

    if dlssdParticles then
        Debug:Info("Resume Particle Timer")
        Cron.Resume(runtime.particleTimer)
    else
        if runtime.particleTimer then
            Debug:Info("Pause Particle Timer")
            Cron.Pause(runtime.particleTimer)
        end
        GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "false")
    end

    checkCustomPreset('dlssdParticles', dlssdParticles)
end

---Set NRD denoiser control (timer only)
---@param enableNRDControl boolean
function setNRDControl(enableNRDControl)
    --Keep last setting when user disables DLSSD
    if runtime.hasDLSSD then
        settings.enableNRDControl = enableNRDControl
    end
    if not runtime.nrdTimer and enableNRDControl then
        runtime.nrdTimer = Cron.Every(settings.slowTimeout, function()
            --hasDLSSD should not be necessary but sometimes the timer dosen't stop at the right time and executes one more time
            if runtime.inGame and runtime.hasDLSSD then
                Debug:Info("Disabling NRD")
                GameSettings.Set("RayTracing", "EnableNRD", "false")
            end
        end)
    end

    if enableNRDControl and runtime.hasDLSSD then
        Debug:Info("Resume NRD Control")
        Cron.Resume(runtime.nrdTimer)
    elseif runtime.nrdTimer then
        Debug:Info("Pause NRD Control")
        Cron.Pause(runtime.nrdTimer)

        --Just for aid user understanding. NativeSettings does not trigger if value stays the same
        NativeSettings.setOption(modOptions.options["NRD"].option, false)
    end
end

---Set Refresh Game control (timer only)
---@param refreshGame boolean
function setRefreshControl(refreshGame)
    settings.refreshGame = refreshGame
    runtime.refreshGame = refreshGame
    if settings.refreshInterval > 0 then
        if not runtime.refreshTimer and refreshGame then
            --In minutes
            runtime.refreshTimer = Cron.Every(settings.refreshInterval * 60, function()
                Debug:Info("Enabling Refresh Game for the next time")
                runtime.refreshGame = true
            end)
        end
    elseif refreshGame then
        Debug:Info("Enabling Refresh Game every time")
    end

    if refreshGame then
        Debug:Info("Resume Refresh Control")
        Cron.Resume(runtime.refreshTimer)
    elseif runtime.refreshTimer then
        Debug:Info("Pause Refresh Control")
        Cron.Pause(runtime.refreshTimer)
    end
end

---Set a new interval for the Refresh Game control. Will reset current timer
---@param time number
function setRefreshTime(time)
    if runtime.refreshTimer then
        Cron.Halt(runtime.refreshTimer)
    end
    runtime.refreshTimer = nil
    settings.refreshInterval = time
    setRefreshControl(settings.refreshGame)
end

function setRefreshNow()
    runtime.refreshGame = true
    previous.dlssPreset = nil
    Debug:Info("Will refresh game and DLSSD")
end

---Set ReGIR PT mode. ReGIR will be enabled after a fast timeout * 1.5
local function setReGIR()
    Debug:Info("Disabling ReGIR")
    GameSettings.Set("Editor/ReGIR", "UseForDI", "false")
    GameSettings.Set("Editor/ReGIR", "Enable", "false")

    if runtime.enableReGIR then
        --Regir requires to wait a bit before be enabled
        Cron.After(settings.fastTimeout * 1.5, function()
            Debug:Info("Enabling ReGIR")
            runtime.reGIRApplied = true
            GameSettings.Set("Editor/ReGIR", "Enable", "true")

            --Only for ReGIR DI/GI
            if settings.ptMode == 4 then
                GameSettings.Set("Editor/ReGIR", "UseForDI", "true")
            end
        end)
    end
end

---Set ReSTIR PT mode. Will trigger ReGIR if enabled, and also refreshes Ray Reconstruction
local function setReSTIR()
    if runtime.enableReSTIR then
        Debug:Info("Enabling ReSTIRGI")
        GameSettings.Set("Editor/ReSTIRGI", "Enable", "true")
    else
        Debug:Info("Disabling ReSTIRGI")
        runtime.enableReGIR = false
        GameSettings.Set("Editor/ReSTIRGI", "Enable", "false")
    end

    local dlssdHasChanged = hasDLSSDChanged()

    if dlssdHasChanged then
        Debug:Info('DLSSD has changed')
        runtime.reGIRApplied = false
    end

    if not runtime.reGIRApplied then
        setReGIR()
    end

    if runtime.hasDLSSD and dlssdHasChanged then
        Cron.After(settings.fastTimeout * 2.0, function()
            refreshDLSSD()
        end)
    end
end

---Set the PT Ray Number. Only works in ReSTIR DI mode
---@param number integer
function setRayNumber(number)
    Debug:Info("Setting Ray Number")
    settings.rayNumber = number
    GameSettings.Set("RayTracing/Reference", "RayNumber", tostring(number))
    GameSettings.Set("RayTracing/Reference", "RayNumberScreenshot", tostring(number))
    GameSettings.Set("RayTracing/ReferenceScreenshot", "SampleNumber", tostring(number))
    checkCustomPreset('rayNumber', number)
end

---Set the PT Ray Bounce Number. Only works in ReSTIR DI mode
---@param number integer
function setRayBounce(number)
    Debug:Info("Setting Ray Bounce")
    settings.rayBounce = number
    GameSettings.Set("RayTracing/Reference", "BounceNumber", tostring(number))
    GameSettings.Set("RayTracing/Reference", "BounceNumberScreenshot", tostring(number))
    checkCustomPreset('rayBounce', number)
end

---Set NVIDIA's SHARC
---@param sharc boolean
function setSharc(sharc)
    settings.sharc = sharc

    --Trigger a DLSS Refresh is better on changing SHARC
    previous.hasDLSSD = nil

    if not (sharc and runtime.enableReGIR) then
        Debug:Info("Setting SHARC")
        GameSettings.Set("Editor/SHARC", "Enable", tostring(sharc))
    else
        settings.sharc = false
        Debug:Info("Skipping SHARC because ReGIR is enabled")
        NativeSettings.setOption(modOptions.options["PT_SHARC"].option, false)
    end

    checkCustomPreset('sharc', sharc)
end

---Set PT mode
---@param mode integer the index of PT mode
function setPTMode(mode)
    settings.ptMode = mode

    if not NativeSettings then
        return
    end

    if settings.ptMode == 1 then
        --ReSTIR DI
        Debug:Info("Setting Path Tracing Mode: ReSTIR DI")
        runtime.enableReGIR = false
        runtime.enableReSTIR = false
        runtime.reGIRApplied = false
        GameSettings.Set("Editor/SHARC", "Enable", tostring(settings.sharc))
    elseif settings.ptMode == 2 then
        --ReSTIR DI/GI
        Debug:Info("Setting Path Tracing Mode: ReSTIR DI/GI")
        runtime.enableReGIR = false
        runtime.reGIRApplied = false
        runtime.enableReSTIR = true
        GameSettings.Set("Editor/SHARC", "Enable", tostring(settings.sharc))
    else
        --ReGIR
        if mode == 3 then
            Debug:Info("Setting Path Tracing Mode: ReSTIR DI + ReGIR GI")
        else
            Debug:Info("Setting Path Tracing Mode: ReGIR DI/GI")
        end

        previous.hasDLSSD = nil
        runtime.enableReGIR = true
        runtime.enableReSTIR = true
        GameSettings.Set("Editor/SHARC", "Enable", "false")
        NativeSettings.setOption(modOptions.options["PT_SHARC"].option, false)
    end

    checkCustomPreset('ptMode', mode)
end

---Set PT Quality
---@param quality any the PT quality index
function setPTQuality(quality)
    Debug:Info("Setting Path Tracing Quality")
    settings.ptQuality = quality
    GameSettings.SetAll(ptSettings.quality[quality])
    checkCustomPreset('ptQuality', quality)
end

---Set PT optimizations
---@param ptOptimizations boolean
function setPTOptimizations(ptOptimizations)
    Debug:Info("Setting Path Tracing Optimizations")
    settings.ptOptimizations = ptOptimizations
    GameSettings.SetAll(ptSettings.optimizations[ptOptimizations])
    checkCustomPreset('ptOptimizations', ptOptimizations)
end

---Set self reflections to show or not
---@param selfReflection boolean
function setSelfReflection(selfReflection)
    Debug:Info("Setting Self Reflection")
    settings.selfReflection = selfReflection
    GameSettings.Set("RayTracing", "HideFPPAvatar", tostring(not selfReflection))
    checkCustomPreset('selfReflection', selfReflection)
end

---Set Path Tracing presetNumber
---@param preset integer
function setPTPreset(preset)
    local ptQualityPreset = ptSettings.preset[preset]
    settings.ptPreset = preset

    if isPresetInRange(preset) and ptQualityPreset then
        Debug:Info(string.format('Setting PT Preset "%s"', modOptions.options["PT_PRESET"].settings.range[preset]))

        --Settings only change if current value is different from ptQualityPreset value
        NativeSettings.setOption(modOptions.options["PT_MODE"].option, ptQualityPreset.ptMode)
        NativeSettings.setOption(modOptions.options["PT_QUALITY"].option, ptQualityPreset.ptQuality)
        NativeSettings.setOption(modOptions.options["PT_SHARC"].option, ptQualityPreset.sharc)
        NativeSettings.setOption(modOptions.options["PT_OPTIMIZATIONS"].option, ptQualityPreset.ptOptimizations)
        NativeSettings.setOption(modOptions.options["RAY_NUMBER"].option, ptQualityPreset.rayNumber)
        NativeSettings.setOption(modOptions.options["RAY_BOUNCE"].option, ptQualityPreset.rayBounce)
        NativeSettings.setOption(modOptions.options["DLSSD_PARTICLES"].option, ptQualityPreset.dlssdParticles)
        NativeSettings.setOption(modOptions.options["SELF_REFLECTION"].option, ptQualityPreset.selfReflection)
    else
        Debug:Info('Setting PT Preset "Custom"')
    end
end

---Setup Native Settings menu
local function setNativeSettings()
    NativeSettings = GetMod("nativeSettings")

    --Return if NativeSettings not found
    if not NativeSettings then
        return
    end

    if not NativeSettings.pathExists(modOptions.tabName) then
        NativeSettings.addTab(modOptions.tabName, modOptions.tabLabel)
        for _, c in pairs(modOptions.categories) do
            NativeSettings.addSubcategory(modOptions.tabName .. '/' .. c.name, c.label)
        end
    end

    local nativeOption = nil

    --Only loop with indexed values with ipairs
    for _, v in ipairs(modOptions.options) do
        if v.range then
            if v.range['min'] ~= nil then
                nativeOption = NativeSettings[v.typeFunction](
                    v.path,
                    v.label,
                    v.description,
                    v.range.min, v.range.max, v.range.step,
                    settings[v.value],
                    defaults[v.value],
                    v.stateCallback
                )
            else
                nativeOption = NativeSettings[v.typeFunction](
                    v.path,
                    v.label,
                    v.description,
                    v.range,
                    settings[v.value],
                    defaults[v.value],
                    v.stateCallback
                )
            end
        elseif v.typeFunction == 'addButton' then
            nativeOption = NativeSettings[v.typeFunction](
                v.path,
                v.label,
                v.description,
                v.buttonText,
                v.textSize,
                v.stateCallback
            )
        else
            nativeOption = NativeSettings[v.typeFunction](
                v.path,
                v.label,
                v.description,
                settings[v.value],
                defaults[v.value],
                v.stateCallback
            )
        end

        modOptions.options[v.index] = {
            settings = v,
            option = nativeOption
        }
    end
end

---Update Runtime mod state and refresh settings
local function updateRuntime()
    GameSettings.Set("RayTracing", "EnableNRD", tostring(not runtime.hasDLSSD))

    if runtime.firstLoad then
        Debug:Info('First Load')
        runtime.firstLoad = false
    end

    if GameSettings.HasPathTracing() then
        setReSTIR()
    end

    if runtime.refreshGame then
        if GameSettings.CanRefresh() then
            --Apply delay for LUTSwitcher
            GameSettings.RefreshGame(settings.refreshPauseTimeout, 0.45, AdvancedPathTracingEvents)

            --Always refresh
            if settings.refreshInterval > 0 then
                runtime.refreshGame = false
            end
        else
            --Should not refresh due to limited gameplay scene
            Debug:Info("Can't Refresh now")
        end
    elseif settings.refreshGame then
        --It could refresh but hasn't passed enough time
        Debug:Info("Won't Refresh now")
    end
end

---Set runtime mod state controls and events
local function setRuntime()
    GameUI.Listen(function(state)
        --GameUI.PrintState(state)

        --Some events if you clear console can trigger an access memory violation when exiting to MainMenu. Game, CET or GameUI fault?
        if state.event == 'SessionStart' or state.event == 'FastTravelFinish' then
            runtime.inGame = true

            --Reset Refresh Control
            setRefreshTime(settings.refreshInterval)
            updateRuntime()
        elseif state.event == 'SessionEnd' or state.event == 'FastTravelStart' then
            runtime.inGame = false
            runtime.reGIRApplied = false
            runtime.refreshGame = settings.refreshGame
            previous.hasDLSSD = nil
            --runtime.fppHeadAdded = false
        end
    end)
    GameUI.OnMenuClose(function(state)
        --Avoid update runtime if the player may use fast travel
        if runtime.inGame and state.lastMenu ~= "FastTravel" then
            updateRuntime()
        end
    end)
    GameUI.OnMenuNav(function(state)
		if state.lastSubmenu == "Settings" then
            runtime.hasDLSSD = GameSettings.HasDLSSD()

            if not runtime.hasDLSSD then
                --If user disables DLSSD and don't open Mod settings NRD Control has to turn off
                NativeSettings.setOption(modOptions.options["NRD"].option, false)
            else
                NativeSettings.setOption(modOptions.options["NRD"].option, settings.enableNRDControl)
            end

            saveSettings()
        end
	end)

    runtime.inGame = not GameUI.IsDetached()
    runtime.hasDLSSD = GameSettings.HasDLSSD()
end

registerForEvent('onInit', function()
    loadSettings()
    setNativeSettings()

    if NativeSettings then
        setRuntime()
        setPTPreset(settings.ptPreset)

        --The setNativeSettings loads the same settings of preset, so values are not loaded yet
        setPTMode(settings.ptMode)
        setPTQuality(settings.ptQuality)
        setSharc(settings.sharc)
        setPTOptimizations(settings.ptOptimizations)
        setRayNumber(settings.rayNumber)
        setRayBounce(settings.rayBounce)
        setSelfReflection(settings.selfReflection)
        setDLSSDParticlesControl(settings.dlssdParticles)
        setNRDControl(settings.enableNRDControl)
        setRefreshControl(settings.refreshGame)
        Debug:Log(string.format('%s v%s loaded', 'AdvancedPathTracing', settings.version))
        AdvancedPathTracingEvents.settings = Debug:Clone(settings)
    else
        Debug:Error('Failed to load Advanced Path Tracing: NativeSettings missing')
    end
end)

registerForEvent('onUpdate', function(delta)
    Cron.Update(delta)
end)

return AdvancedPathTracingEvents
