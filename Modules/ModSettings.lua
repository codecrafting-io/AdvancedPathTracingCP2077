local ModSettings = {}
local Debug = require("Modules/Debug")

Debug:SetLogLevel(settings.debug and Debug.DEBUG or Debug.ERROR)

---Save mod settings to the file
---@param settings table
---@param filename string
function ModSettings.saveSettings(settings, filename)
    Debug:Info("Saving Settings")
    local validJson, contents = pcall(function() return json.encode(settings) end)

    if validJson and contents ~= nil then
        local file = io.open(filename, "w+")
        if file ~= nil then
            file:write(contents)
            file:close()
        else
            Debug:Error("Failed to save settings file '" .. filename .. "'")
        end
    end
end

---Load mod settings from the file
---@param defaults table --Default settings in case of no settings file
---@param filename string
---@return table
function ModSettings.loadSettings(defaults, filename)
    local file = io.open(filename, 'r')
    local shouldSave = false
    local settings = {}
    Debug:Log('Loading settings file ' .. filename)

    if file ~= nil then
        local contents = file:read("*a")
        local validJson, savedSettings = pcall(function() return json.decode(contents) end)
        file:close()
        Debug:SetLogLevel(savedSettings["debug"] and Debug.DEBUG or Debug.ERROR)
        settings = Debug:Clone(defaults)

        if validJson then

            --Only load valid saved settings
            for index, value in pairs(defaults) do
                if savedSettings[index] ~= nil and type(value) == type(savedSettings[index]) then
                    settings[index] = savedSettings[index]
                else
                    Debug:Debug(string.format("Saved setting '%s' not found. Should save again", index))
                    shouldSave = true
                end
            end

            if defaults.version ~= settings.version then
                settings.version = defaults.version
                Debug:Log(string.format("New version '%s' installed!", defaults.version))
                shouldSave = true
            end

            --Validate timings
            if settings.slowTimeout < settings.fastTimeout then
                settings.slowTimeout = settings.fastTimeout + 2.0
            end

            if settings.refreshPauseTimeout < settings.fastTimeout then
                settings.refreshPauseTimeout = settings.fastTimeout + 5.0
            end
        else
            Debug:Error('Invalid settings file')
            shouldSave = true
        end
    else
        Debug:SetLogLevel(defaults["debug"] and Debug.INFO or Debug.ERROR)
        settings = Debug:Clone(defaults)
        shouldSave = true
    end

    if shouldSave then
        ModSettings.saveSettings(settings, filename)
    end

    if settings.debug then
        Debug:Debug(string.format('%s Settings', _Mod.name))
        Debug:Debug(Debug:Parse(settings))
    end

    return settings
end

return ModSettings
