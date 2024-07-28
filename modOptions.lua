

return {
    tabName = '/AdvancedPathTracing',
    tabLabel = 'Advanced Path Tracing',
    categories = {
        {
            name = 'path_tracing',
            label = 'Path Tracing'
        },
        {
            name = 'misc',
            label = 'Misc'
        }
    },
    options = {
        {
            index = 'PT_PRESET',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Global Preset',
            description = "Global preset Path Tracing quality.\n\nVanilla is the game's default mode\n\nVery Low is the lowest quality that makes some sense to still enable PT, but you can go lower\n\nLow increases very low quality to not be as noisy\n\nMedium switches to ReSTIR DI/GI with better quality\n\nHigh disables SHARC since it can be noisier sometimes, but it aids with tertiary bounces in dark areas.\n\nUltra changes to ReGIR which can look better, but also noiser (specially with RR), so results vary\n\nPsycho flatlines your GPU. Changes back to ReSTIR DI to have way less noise and be more like offline rendering. Results with Ray Reconstruction vary",
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
            value = 'ptPreset',
            stateCallback = function(state)
                setPTPreset(state)
            end,
            typeFunction = 'addSelectorString'
        },
        {
            index = 'PT_MODE',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Mode',
            description = "Changes Path Tracing mode\n\nReSTIR DI - The older PT from update 2.0, mainly used for DI. Enables control of rays per pixel and bounces per ray.\n\nReSTIR DI/GI - Reservoir Spatio Temporal Importance Resampling for Global Illumination, is a screen space light sampling used for illuminating secondary surfaces. This is the vanilla mode.\n\nReGIR DI/GI - Reservoir-based Grid Importance Sampling, is a world space light sampling on top of ReSTIR",
            range = {
                [1] = "ReSTIR DI",
                [2] = "ReSTIR DI/GI",
                [3] = "ReGIR DI/GI"
            },
            value = 'ptMode',
            stateCallback = function(state)
                setPTMode(state)
            end,
            typeFunction = 'addSelectorString'
        },
        {
            index = 'PT_QUALITY',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Quality',
            description = "Adjust internal path tracing quality settings.\n\nVanilla: Default quality\n\nPerformance: Faster but noisier\n\nBalanced: Improve on Vanilla and increase performance by up to 1%\n\nQuality: Heavier but less noise and higher quality.\n\nPsycho: Flatline your GPU",
            range = {
                [1] = "Vanilla",
                [2] = "Performance",
                [3] = "Balanced",
                [4] = "Quality",
                [5] = "Psycho"
            },
            value = "ptQuality",
            stateCallback = function(state)
                setPTQuality(state)
            end,
            typeFunction = 'addSelectorString'
        },
        {
            index = 'PT_SHARC',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'NVIDIA SHARC',
            description = "Enables NVIDIA's Spatial Hash Radiance Cache (SHARC) for light bounces. Enabled is the vanilla mode. Scales with PT Quality. Disables when using ReGIR. Performance and visual quality vary",
            range = nil,
            value = "sharc",
            stateCallback = function(state)
                setSharc(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'PT_OPTIMIZATIONS',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Optimizations',
            description = "Adds missing PT Reflections through Screen Space Reflections\n\nReduce noise on some scenarios. Some scenes may appear a little darker\n\nUse PDF (Probability Density Function) for minor performance boost\n\nMinor reflections improvement on transparent surfaces\n\nMinor GI/DI light behavior optimizations. May improve performance",
            range = nil,
            value = "ptOptimizations",
            stateCallback = function(state)
                setPTOptimizations(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'RAY_NUMBER',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Rays Per Pixel',
            description = "Number of rays per pixel. Only works when using ReSTIR DI mode",
            range = {
                min = 1,
                max = 8,
                step = 1
            },
            value = "rayNumber",
            stateCallback = function(state)
                setRayNumber(state)
            end,
            typeFunction = 'addRangeInt'
        },
        {
            index = 'RAY_BOUNCE',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Bounces Per Ray',
            description = "Number of bounces per ray. Only works when using ReSTIR DI mode",
            range = {
                min = 0,
                max = 8,
                step = 1
            },
            value = "rayBounce",
            stateCallback = function(state)
                setRayBounce(state)
            end,
            typeFunction = 'addRangeInt'
        },
        {
            index = 'DLSSD_PARTICLES',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Ray Reconstruction Particles',
            description = "Enables particles to not be separated in Ray Reconstruction, when it's not raining and outdoors",
            range = nil,
            value = "dlssdParticles",
            stateCallback = function(state)
                setDLSSDParticlesControl(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'SELF_REFLECTION',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Self Reflection',
            description = "Enables self-reflaction of V without showing the head (internal game limitation). Also works with normal Ray Tracing",
            range = nil,
            value = "selfReflection",
            stateCallback = function(state)
                setSelfReflection(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'NRD',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'NRD Disable Helper',
            description = "Disables NRD denoisier from time to time to mitigate Ray Reconstruction (RR) loss of performance over time. Only works with RR on",
            range = nil,
            value = "enableNRDControl",
            stateCallback = function(state)
                setNRDControl(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'REFRESH_GAME',
            path = '/AdvancedPathTracing/misc',
            label = 'Refresh Game',
            description = "Enables refresh game, by rapidly pause/unpause the game, on closing the menu or loading saves to mitigate loss of performance",
            range = nil,
            value = "refreshGame",
            stateCallback = function(state)
                setRefreshControl(state)
            end,
            typeFunction = 'addSwitch'
        },
        {
            index = 'REFRESH_GAME_INTERVAL',
            path = '/AdvancedPathTracing/misc',
            label = 'Refresh Game Interval (min)',
            description = "The amount of time in minutes to wait for the next refresh. Zero will refresh every time",
            range = {
                min = 0,
                max = 60,
                step = 1
            },
            value = "refreshInterval",
            stateCallback = function(state)
                setRefreshTime(state)
            end,
            typeFunction = 'addRangeInt'
        }
    }
}
