local nativeSettingsConfig = {
    tabName = '/AdvancedPathTracing',
    tabLabel = 'Advanced Path Tracing',
    categories = {
        {
            name = 'global_settings',
            label = 'Path Tracing Settings'
        },
        {
            name = 'photo_mode',
            label = 'Screenshots Override'
        },
        {
            name = 'helpers',
            label = 'Helpers'
        }
    },
    options = {
        {
            index = 'ptPreset',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Global Preset',
            description = "Global preset Path Tracing quality.\n\nVanilla is the game's default mode\n\nVery Low is the lowest quality worth enabling PT, but lower is possible.\n\nLow increases very low quality to not be as noisy\n\nMedium uses ReSTIR DI/GI, similar quality to Vanilla, but up to 8% performance increase\n\nHigh further increase quality over medium\n\nUltra enables global light and changes to ReSTIR DI + ReGIR GI which can look better but with high cost\n\nPsycho flatlines your GPU. Changes back to ReSTIR DI to have way less noise and to be more like offline rendering. Results vary",
            range = {
                [1] = "Vanilla",
                [2] = "Very Low",
                [3] = "Low",
                [4] = "Medium",
                [5] = "High",
                [6] = "Ultra",
                [7] = "Psycho",
                [8] = "Custom"
            },
            stateCallback = function(state)
                setPTPreset(state)
            end,
            typeFunction = 'addSelectorString',
        },
        {
            index = 'ptMode',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Mode',
            description = "Changes Path Tracing mode\n\nReSTIR DI - The older PT from update 2.0, used with DI and naive GI. Enables control of rays per pixel and bounces per ray (also for Photo Mode screenshots).\n\nReSTIR DI/GI - Reservoir Spatio Temporal Importance Resampling for Global Illumination, is a screen space light sampling used for illuminating secondary surfaces. This is the vanilla mode.\n\nReSTIR DI + ReGIR GI - Uses Reservoir-based Grid Importance Sampling, for a world space light sampling on top of ReSTIR, but only for GI\n\n ReGIR DI/GI - Uses ReGIR for both DI and GI",
            range = {
                [1] = "ReSTIR DI",
                [2] = "ReSTIR DI/GI",
                [3] = "ReSTIR DI + ReGIR GI",
                [4] = "ReGIR DI/GI"
            },
            stateCallback = function(state)
                setPTMode(state)
            end,
            typeFunction = 'addSelectorString',
        },
        {
            index = 'ptQuality',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Quality',
            description = "Adjust internal path tracing quality settings.\n\nVanilla: Default quality\n\nPerformance: Faster but noisier\n\nBalanced: Improves over Vanilla by losing up to 3%\n\nQuality: Heavier but less noise and higher quality.\n\nPsycho: Flatline your GPU",
            range = {
                [1] = "Vanilla",
                [2] = "Performance",
                [3] = "Balanced",
                [4] = "Quality",
                [5] = "Psycho"
            },
            stateCallback = function(state)
                setPTQuality(state)
            end,
            typeFunction = 'addSelectorString',
        },
        {
            index = 'rtxdiHistory',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Light Frame Accumulation',
            description = "Defines ReSTIR DI light reservoir frame accumulation\n\nVanilla: Default value\n\nDisabled: No accumulation. Increase the performance by up to 8% with minimal visual loss, but some surfaces may exhibit flickering noise\n\nOptimized: Not as high as vanilla, but more responsive with some accumulation to fix occasional noise flickering",
            range = {
                [1] = "Vanilla",
                [2] = "Disabled",
                [3] = "Optimized"
            },
            stateCallback = function(state)
                setRTXDIHistory(state)
            end,
            typeFunction = 'addSelectorString',
        },
        {
            index = 'rayNumber',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Rays Per Pixel',
            description = "Number of rays per pixel. Only works when using ReSTIR DI mode.",
            range = {
                min = 1,
                max = 8,
                step = 1
            },
            stateCallback = function(state)
                setRayNumber(state, false)
            end,
            typeFunction = 'addRangeInt',
        },
        {
            index = 'rayBounce',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Bounces Per Ray',
            description = "Number of bounces per ray. Only works when using ReSTIR DI mode.",
            range = {
                min = 0,
                max = 8,
                step = 1
            },
            stateCallback = function(state)
                setRayBounce(state, false)
            end,
            typeFunction = 'addRangeInt',
        },
        {
            index = 'sharc',
            path = '/AdvancedPathTracing/global_settings',
            label = 'NVIDIA SHARC',
            description = "Enables NVIDIA's Spatial Hash Radiance Cache (SHARC) for light bounces. Helps stabilize light bounces in dark areas and during fast camera movement. Scales with PT quality with performance ranging from 1.5% (Vanilla) to 10% (Psycho). Disabled when using ReGIR. Performance and image quality varies",
            range = nil,
            stateCallback = function(state)
                setSharc(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'ptTweaks',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Tweaks',
            description = "Adds missing PT Reflections through Screen Space Reflections\n\nReduce noise on some scenarios. Some scenes may appear a little darker\n\nUse PDF (Probability Density Function) for minor performance boost\n\nMinor reflections improvement on transparent surfaces\n\nImproved RT distance\n\nMinor GI/DI optimizations",
            range = nil,
            stateCallback = function(state)
                setPTTweaks(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'globalLight',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Enhanced Global Light',
            description = "Enables enhanced PT global light for sun/moon, with better radiance\n\nIt mostly affects the sunlight and shadows for the foliage animation (wind). However, the shadows may appear duplicated/misaligned.",
            range = nil,
            stateCallback = function(state)
                setGlobalLight(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'dlssdParticles',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Ray Reconstruction Particles',
            description = "Use Ray Reconstruction on particles, when it's not raining and outdoors",
            range = nil,
            stateCallback = function(state)
                setDLSSDParticlesControl(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'selfReflection',
            path = '/AdvancedPathTracing/global_settings',
            label = 'Self Reflection',
            description = "Enables self-reflection of V without showing the head (internal game limitation). Also works with normal Ray Tracing",
            range = nil,
            stateCallback = function(state)
                setSelfReflection(state)
            end,
            typeFunction = 'addSwitch',
        },


        {
            index = 'rayNumberPm',
            path = '/AdvancedPathTracing/photo_mode',
            label = 'Rays Per Pixel',
            description = "Number of rays per pixel (ReSTIR DI) for the Photo Mode screenshots",
            range = {
                min = 1,
                max = 8,
                step = 1
            },
            stateCallback = function(state)
                setRayNumber(state, true)
            end,
            typeFunction = 'addRangeInt',
        },
        {
            index = 'rayBouncePm',
            path = '/AdvancedPathTracing/photo_mode',
            label = 'Bounces Per Ray',
            description = "Number of bounces per ray (ReSTIR DI) for the Photo Mode screenshots",
            range = {
                min = 0,
                max = 8,
                step = 1
            },
            stateCallback = function(state)
                setRayBounce(state, true)
            end,
            typeFunction = 'addRangeInt',
        },


        {
            index = 'nrdControl',
            path = '/AdvancedPathTracing/helpers',
            label = 'NRD Disable Helper',
            description = "Disables NRD denoiser from time to time to mitigate Ray Reconstruction (RR) loss of performance over time. Only works with RR on",
            range = nil,
            stateCallback = function(state)
                setNRDControl(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'refreshGame',
            path = '/AdvancedPathTracing/helpers',
            label = 'Auto Refresh Game',
            description = "Enables auto refresh game, by rapidly pause/unpause the game, on closing the menu or loading saves to mitigate loss of performance. Refresh only happens after exiting menus, loading saves or teleports",
            range = nil,
            stateCallback = function(state)
                setRefreshControl(state)
            end,
            typeFunction = 'addSwitch',
        },
        {
            index = 'refreshInterval',
            path = '/AdvancedPathTracing/helpers',
            label = 'Refresh Game Interval (min)',
            description = "The amount of time in minutes to wait for the next refresh. Zero will refresh every time",
            range = {
                min = 0,
                max = 60,
                step = 1
            },
            stateCallback = function(state)
                setRefreshTime(state)
            end,
            typeFunction = 'addRangeInt',
        },
        {
            index = 'refreshGameNow',
            path = '/AdvancedPathTracing/helpers',
            label = '',
            description = 'Ignore the interval and refresh the game after exiting the menu. Also refreshes DLSS Ray Reconstruction',
            range = nil,
            buttonText = 'Refresh',
            textSize = 45,
            stateCallback = function(state)
                setRefreshNow()
            end,
            typeFunction = 'addButton',
        }
    }
}

local ModOptionsShared = {}
local ModOptions = {
    loaded = false,
    nativeSettings = nil,
    nativeOptions = {}
}

--[[
ModOptions.__index = ModOptions

function ModOptions.new()
    local self = setmetatable({}, ModOptions)

    self.loaded = false
    self.options = {}

    return self
end
--]]

function ModOptionsShared.isLoaded()
    return ModOptions.loaded
end

function ModOptionsShared.refresh()
    if ModOptions.loaded then
        ModOptions.nativeSettings.refresh()
    end
end

function ModOptionsShared.getNativeSettings(index)
    if ModOptions.loaded and ModOptions.nativeOptions[index] then
        return ModOptions.nativeOptions[index].settings
    end
end

function ModOptionsShared.callAction(index, value)
    if ModOptions.loaded and ModOptions.nativeOptions[index] then
        ModOptions.nativeOptions[index].settings.stateCallback(value)
    end
end

function ModOptionsShared.setOption(index, value)
    if ModOptions.loaded and ModOptions.nativeOptions[index] then
        ModOptions.nativeSettings.setOption(ModOptions.nativeOptions[index].option, value)
    end
end

---Loads NativeSettings menus
---@param settings table --The settings values
---@param defaults table --The default settings values
---@return boolean -- Whether or not NativeSettings were load
function ModOptionsShared.loadNativeSettings(settings, defaults)
    local nativeSettings = GetMod("nativeSettings")

    --Return if NativeSettings not found
    if not nativeSettings then
        ModOptions.loaded = false
        return false
    end

    if not nativeSettings.pathExists(nativeSettingsConfig.tabName) then
        nativeSettings.addTab(nativeSettingsConfig.tabName, nativeSettingsConfig.tabLabel)
        for _, c in pairs(nativeSettingsConfig.categories) do
            nativeSettings.addSubcategory(nativeSettingsConfig.tabName .. '/' .. c.name, c.label)
        end
    end

    local nativeOption = nil

    --Only loop with indexed values with ipairs
    for _, v in ipairs(nativeSettingsConfig.options) do
        if v.range then
            if v.range['min'] ~= nil then
                nativeOption = nativeSettings[v.typeFunction](
                    v.path,
                    v.label,
                    v.description,
                    v.range.min, v.range.max, v.range.step,
                    settings[v.index],
                    defaults[v.index],
                    v.stateCallback
                )
            else
                nativeOption = nativeSettings[v.typeFunction](
                    v.path,
                    v.label,
                    v.description,
                    v.range,
                    settings[v.index],
                    defaults[v.index],
                    v.stateCallback
                )
            end
        elseif v.typeFunction == 'addButton' then
            nativeOption = nativeSettings[v.typeFunction](
                v.path,
                v.label,
                v.description,
                v.buttonText,
                v.textSize,
                v.stateCallback
            )
        else
            nativeOption = nativeSettings[v.typeFunction](
                v.path,
                v.label,
                v.description,
                settings[v.index],
                defaults[v.index],
                v.stateCallback
            )
        end

        ModOptions.nativeOptions[v.index] = {
            settings = v,
            option = nativeOption
        }
    end

    ModOptions.nativeSettings = nativeSettings
    ModOptions.loaded = true

    return true
end

return ModOptionsShared
