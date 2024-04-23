--[[
    Created by codecrafting-io

	AdvancedPathTracing is a small mod for properly setting some advanced path tracing settings

	Credits
		- Ultra Plus Control
		- Weathermancer
		- betterHeadlights

	Nvidia Docs - https://github.com/NVIDIAGameWorks/RTXDI/blob/main/doc/Integration.md
    Native Settings Docs - https://github.com/justarandomguyintheinternet/CP77_nativeSettings
]]--

AdvancedPathTracing = { version = "0.2.0" }
settings = {}
local defaults = require("defaults")
local previous = {}
local Cron = require("Cron")
local GameUI = require("GameUI")
local GameSettings = require("GameSettings")
local Utils = require("Utils")
local NativeSettings = {}
local optionsUI = {}
local runtime = {
    firstLoad = true,
    reGIRApplied = false,
    inGame = false,
    inMainMenu = false,
    nrdTimer = nil,
    particleTimer = nil,
	enableReGIR = false,
	enableReSTIR = true,
    hasDLSSD = false
}

local function saveSettings()
    Utils.DebugMessage("Saving Settings")
    local validJson, contents = pcall(function() return json.encode(settings) end)

    if validJson and contents ~= nil then
        local file = io.open("settings.json", "w+")
        file:write(contents)
        file:close()
    end
end

local function loadSettings()
    defaultSettings = Utils.Clone(defaults)
    Utils.DebugMessage("Loading Settings")
    local file = io.open('settings.json', 'r')

    if file ~= nil then
        local contents = file:read("*a")
        local validJson, savedSettings = pcall(function() return json.decode(contents) end)
        file:close()

        if validJson then
            settings = Utils.Clone(savedSettings)

            --Validate timings
            if settings.slowTimeout < settings.fastTimeout then
                settings.slowTimeout = settings.fastTimeout + 2.0
            elseif settings.refreshTimeout < settings.fastTimeout then
                settings.refreshTimeout = settings.fastTimeout * 5.0
            end
        end

        --New version requires settings reset
        if defaults.version ~= settings["version"] then
            Utils.DebugMessage("New Version " .. defaults.version)
            settings = defaultSettings
            saveSettings()
        end
    else
        settings = defaultSettings
        saveSettings()
    end

    if settings.debug then
        Utils.Dump(settings)
    end
end

local function pushChanges()
    Game.GetSettingsSystem():ConfirmChanges()
    Cron.After(0.25, function()
        if NativeSettings then
            NativeSettings.refresh()
        end
    end)
end

local function refreshDLSSD()
    local dlssPreset = GameSettings.GetIndex("/graphics/presets", "DLSS")
    local dlssPresetName = GameSettings.Get("/graphics/presets", "DLSS")

    previous["dlssPreset"] = dlssPresetName
    Utils.DebugMessage("Refreshing DLSS Ray Reconstruction - " .. dlssPresetName)
    GameSettings.Set("/graphics/presets", "DLSS_D", false)
    pushChanges()
    Cron.After(settings.fastTimeout, function()
        GameSettings.Set("/graphics/presets", "DLSS_D", true)
        pushChanges()
    end)
end

local function hasDLSSDChanged()
    return previous["hasDLSSD"] ~= runtime.hasDLSSD or previous["dlssPreset"] ~= GameSettings.Get("/graphics/presets", "DLSS")
end

local function setDLSSDParticles()
    -- enable particle PT integration unless player is outdoors AND it's raining
    runtime.particleTimer = Cron.Every(settings.fastTimeout * 2.0, function()
        if runtime.inGame then
            local isRaining = GameSettings.IsRaining()
            local isIndoors = GameSettings.IsIndoors()

            --Change detection
            if isRaining ~= previous["isRaining"] or isIndoors ~= previous["isIndoors"] then
                previous["isRaining"] = isRaining
                previous["isIndoors"] = isIndoors

                if isIndoors or not isRaining then
                    Utils.DebugMessage("It's not raining or is indoors. Enabling DLSSD separate particle colour")
                    GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "true")

                else
                    Utils.DebugMessage("It's raining and it's outdoors. Disabling DLSSD separate particle colour")
                    GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "false")
                end
            end
        end
    end)
end

local function setNRDControl()
    runtime.nrdTimer = Cron.Every(settings.slowTimeout, function()

        --hasDLSSD should not be necessary but sometimes the timer dosen't stop at the right time and executes one more time
        if runtime.inGame and runtime.hasDLSSD then
            Utils.DebugMessage("Disabling NRD")
            GameSettings.Set("RayTracing", "EnableNRD", "false")
        end
    end)
end

local function setReGIR()
    Utils.DebugMessage("Disabling ReGIR")
    GameSettings.Set("Editor/ReGIR", "UseForDI", "false")
    GameSettings.Set("Editor/ReGIR", "Enable", "false")

    if runtime.enableReGIR then

        --Regir requires to wait a bit before be enabled
        Cron.After(settings.fastTimeout * 1.5, function()
            Utils.DebugMessage("Enabling ReGIR")
            runtime.reGIRApplied = true
            GameSettings.Set("Editor/ReGIR", "Enable", "true")
            GameSettings.Set("Editor/ReGIR", "UseForDI", "true")
        end)
    end
end

local function setReSTIR()
    if runtime.enableReSTIR then
        Utils.DebugMessage("Enabling ReSTIR")
        GameSettings.Set("Editor/ReSTIRGI", "Enable", "true")
    else
        Utils.DebugMessage("Disabling ReSTIR")
        runtime.enableReGIR = false
        GameSettings.Set("Editor/ReSTIRGI", "Enable", "false")
    end

    if not runtime.reGIRApplied then
        setReGIR()
    end

    Cron.After(settings.fastTimeout * 2.0, function()
        if runtime.hasDLSSD and hasDLSSDChanged() then
            refreshDLSSD()
        end
        previous["hasDLSSD"] = runtime.hasDLSSD
    end)
end

local function setRayNumber(number)
    GameSettings.Set("RayTracing/Reference", "RayNumber", tostring(number))
end

local function setRayBounce(number)
    GameSettings.Set("RayTracing/Reference", "BounceNumber", tostring(number))
end

local function setPTMode(modeIndex)
    settings.ptModeIndex = modeIndex

    if not NativeSettings then
        return
    end

    if settings.ptModeIndex == 1 then
        --ReSTIR DI
        runtime.enableReGIR = false
        runtime.enableReSTIR = false
        runtime.reGIRApplied = false
    elseif settings.ptModeIndex == 2 then
        --ReSTIR DI/GI
        runtime.enableReGIR = false
        runtime.reGIRApplied = false
        runtime.enableReSTIR = true
    else
        --ReGIR DI/GI
        previous["hasDLSSD"] = nil
        runtime.enableReGIR = true
        runtime.enableReSTIR = true
    end
end

local function setPTQuality(qualityIndex)
    settings.ptQualityIndex = qualityIndex
    Utils.DebugMessage("Setting Path Tracing Quality")
    GameSettings.SetAll(settings.ptQualitySettings[qualityIndex])
end

local function setPTOptimizations(optimizationsIndex)
    settings.ptOptimizationsIndex = optimizationsIndex
    Utils.DebugMessage("Setting Path Tracing Optimizations")
    GameSettings.SetAll(settings.ptOptimizationsSettings[optimizationsIndex])
end

local function setModMenu()
    NativeSettings = GetMod("nativeSettings")

    --Return if NativeSettings not found
    if not NativeSettings then
        return
    end

    ptQuality = {
        [1] = "Vanilla",
        [2] = "Performance",
        [3] = "Balanced",
        [4] = "Quality",
        [5] = "Psycho"
    }

    ptMode = {
        [1] = "ReSTIR DI",
        [2] = "ReSTIR DI/GI",
        [3] = "ReGIR DI/GI"
    }

    if not NativeSettings.pathExists("/AdvancedPathTracing") then
        NativeSettings.addTab("/AdvancedPathTracing", "Advanced Path Tracing")
        NativeSettings.addSubcategory("/AdvancedPathTracing/path_tracing", "Path Tracing")
        NativeSettings.addSubcategory("/AdvancedPathTracing/misc", "Misc")
    end

    optionsUI["PT_MODE"] = NativeSettings.addSelectorString(
        "/AdvancedPathTracing/path_tracing",
        "Mode",
        "Changes Path Tracing mode\n\nReSTIR DI is the older PT from update 2.0, only used for DI. Enables control of rays per pixel and bounces per ray.\n\nReSTIR DI/GI - Reservoir SpatioTemporal Importance Resampling for Global Illumination, is a screen space light sampling used for illuminating secondary surfaces. This is the vanilla mode.\n\nReGIR DI/GI - Reservoir-based Grid Importance Sampling, is a world space light sampling on top of ReSTIR.",
        ptMode,
        settings.ptModeIndex,
        defaults.ptModeIndex,
        function(value)
            setPTMode(value)
    end)

    optionsUI["PT_QUALITY"] = NativeSettings.addSelectorString(
        "/AdvancedPathTracing/path_tracing",
        "Quality",
        "Adjust internal path tracing quality settings.\n\nVanilla: Default quality\n\nPerformance: Faster but noisier\n\nBalanced: Improve on Vanilla and increase performance by up to 1%\n\nQuality: Heavy but less noise and higher quality\n\nPsycho: Flatline your GPU",
        ptQuality,
        settings.ptQualityIndex,
        defaults.ptQualityIndex,
        function(value)
            setPTQuality(value)
    end)

    optionsUI["PT_OPTIMIZATION"] = NativeSettings.addSwitch(
        "/AdvancedPathTracing/path_tracing",
        "Optimizations",
        "Enables small path tracing optimizations without relevant loss of quality. May improve performance",
        settings.ptOptimizationsIndex == 2,
        defaults.ptOptimizationsIndex == 2,
        function(state)
            setPTOptimizations(state and 2 or 1)
    end)

    optionsUI["RAY_NUMBER"] = NativeSettings.addRangeInt(
        "/AdvancedPathTracing/path_tracing",
        "Rays Per Pixel",
        "Number of rays per pixel. Only works when using ReSTIR DI mode",
        1, 8, 1,
        settings.rayNumber,
        defaults.rayNumber,
        function(value)
            setRayNumber(value)
    end)

    optionsUI["RAY_BOUNCE"] = NativeSettings.addRangeInt(
        "/AdvancedPathTracing/path_tracing",
        "Bounces Per Ray",
        "Number of bounces per ray. Only works when using ReSTIR DI mode",
        0, 8, 1,
        settings.rayBounce,
        defaults.rayBounce,
        function(value)
            setRayBounce(value)
    end)

    optionsUI["DLSSD_PARTICLE"] = NativeSettings.addSwitch(
        "/AdvancedPathTracing/path_tracing",
        "Ray Reconstruction Particles",
        "Enables particles to not be separated in Ray Reconstruction, when it's not raining or indoors",
        settings.enableDLSSDParticles,
        defaults.enableDLSSDParticles,
        function(state)
            settings.enableDLSSDParticles = state

            if not runtime.particleTimer and settings.enableDLSSDParticles then
                setDLSSDParticles()
            end

            if settings.enableDLSSDParticles then
                Cron.Resume(runtime.particleTimer)
            else
                Cron.Pause(runtime.particleTimer)
                GameSettings.Set("Rendering", "DLSSDSeparateParticleColor", "false")
            end
    end)

    optionsUI["NRD"] = NativeSettings.addSwitch(
        "/AdvancedPathTracing/path_tracing",
        "NRD Disable Helper",
        "Disables NRD denoisier every " .. settings.slowTimeout .. "s to mitigate Ray Reconstruction (RR) loss of performance over time. Only works with RR on.",
        settings.enableNRDControl,
        defaults.enableNRDControl,
        function(state)
            settings.enableNRDControl = state

            if not runtime.nrdTimer and settings.enableNRDControl then
                setNRDControl()
            end

            if settings.enableNRDControl then
                Cron.Resume(runtime.nrdTimer)
            else
                if runtime.nrdTimer then
                    Cron.Pause(runtime.nrdTimer)
                end
            end
    end)

    optionsUI["REFRESH_GAME"] = NativeSettings.addSwitch(
        "/AdvancedPathTracing/misc",
        "Auto Refresh Game",
        "Enables auto refresh game, by rapidly pause/unpause the game, on closing the menu or loading saves to improve performance",
        settings.refreshGame,
        defaults.refreshGame,
        function(state)
            settings.refreshGame = state
    end)
end

local function refreshSettings(refreshGame)
    runtime.hasDLSSD = GameSettings.HasDLSSD()
    GameSettings.Set("RayTracing", "EnableNRD", tostring(not runtime.hasDLSSD))

    if not runtime.hasDLSSD then
        NativeSettings.setOption(optionsUI["NRD"], false)
    end

    if hasDLSSDChanged() then
        runtime.reGIRApplied = false
    end

    if runtime.firstLoad then
        Utils.DebugMessage('First Load')
        runtime.firstLoad = false
    end

    if GameSettings.HasPathTracing() then
        setReSTIR()
    end

    if refreshGame then
        GameSettings.RefreshGame(settings.refreshTimeout)
    end
end

function setRuntime()
    GameUI.Listen(function(state)
        --GameUI.PrintState(state)
    end)

    GameUI.OnSessionStart(function(state)
        runtime.inGame = true
        runtime.inMainMenu = false
        refreshSettings(settings.refreshGame)
    end)
    GameUI.OnSessionEnd(function(state)
        runtime.inGame = false
        runtime.inMainMenu = true
        runtime.reGIRApplied = false
        previous["hasDLSSD"] = nil
    end)
    GameUI.OnMenuClose(function(state)
        if runtime.inGame then
            refreshSettings(settings.refreshGame)
        end
    end)
    GameUI.Listen("MenuNav", function(state)
		if state.lastSubmenu ~= nil and state.lastSubmenu == "Settings" then
            saveSettings()
        end
	end)

    runtime.inGame = not GameUI.IsDetached()
    runtime.inMainMenu = not runtime.inGame
end

registerForEvent('onInit', function()
    loadSettings()
    setModMenu()

    if NativeSettings then
        setRuntime()
        setPTMode(settings.ptModeIndex)
        setPTQuality(settings.ptQualityIndex)
        setPTOptimizations(settings.ptOptimizationsIndex)

        if settings.enableNRDControl then
            setNRDControl()
        end

        if settings.enableDLSSDParticles then
            setDLSSDParticles()
        end
    else
        error('Failed to load Advanced Path Tracing: NativeSettings missing')
    end
end)

registerForEvent('onUpdate', function(delta)
    Cron.Update(delta)
end)

