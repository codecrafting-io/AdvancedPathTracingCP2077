

local modOptions = {
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
            index = 'PT_MODE',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Mode',
            description = "Changes Path Tracing mode\n\nReSTIR DI is the older PT from update 2.0, mainly used for DI. Enables control of rays per pixel and bounces per ray.\n\nReSTIR DI/GI - Reservoir Spatio Temporal Importance Resampling for Global Illumination, is a screen space light sampling used for illuminating secondary surfaces. This is the vanilla mode.\n\nReGIR DI/GI - Reservoir-based Grid Importance Sampling, is a world space light sampling on top of ReSTIR.",
            range = {
                [1] = "ReSTIR DI",
                [2] = "ReSTIR DI/GI",
                [3] = "ReGIR DI/GI"
            },
            value = 'ptModeIndex',
            stateCallback = function(state)
                setPTMode(state)
            end,
            typeFunction = 'addSelectorString'
        },
        {
            index = 'PT_QUALITY',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Quality',
            description = "Adjust internal path tracing quality settings.\n\nVanilla: Default quality\n\nPerformance: Faster but noisier\n\nBalanced: Improve on Vanilla and increase performance by up to 1%\n\nQuality: Heavy but less noise and higher quality\n\nPsycho: Flatline your GPU",
            range = {
                [1] = "Vanilla",
                [2] = "Performance",
                [3] = "Balanced",
                [4] = "Quality",
                [5] = "Psycho"
            },
            value = "ptQualityIndex",
            stateCallback = function(state)
                setPTQuality(state)
            end,
            typeFunction = 'addSelectorString'
        },
        {
            index = 'PT_OPTIMIZATIONS',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Optimizations',
            description = "Enables small path tracing optimizations without relevant loss of quality. May improve performance",
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
                setRayBounce(state)
            end,
            typeFunction = 'addRangeInt'
        },
        {
            index = 'RAY_NUMBER',
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
            index = 'DLSSD_PARTICLE',
            path = '/AdvancedPathTracing/path_tracing',
            label = 'Ray Reconstruction Particles',
            description = "Enables particles to not be separated in Ray Reconstruction, when it's not raining and outdoors",
            range = nil,
            value = "enableDLSSDParticles",
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
            label = 'Auto Refresh Game',
            description = "Enables auto refresh game, by rapidly pause/unpause the game, on closing the menu or loading saves to improve performance",
            range = nil,
            value = "refreshGame",
            stateCallback = function(state)
                settings.refreshGame = state
            end,
            typeFunction = 'addSwitch'
        }
    }
}

return modOptions