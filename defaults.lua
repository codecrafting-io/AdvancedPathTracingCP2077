local defaults = {
    debug = false,
	enableNRDControl = true,
    rayNumber = 2,
    rayBounce = 2,
	fastTimeout = 1.0,
    slowTimeout = 30.0,
    refreshGame = false,
    refreshTimeout = 5.0,
    enableDLSSDParticles = true,
    ptModeIndex = 1,
    ptQualityIndex = 3,
    ptQualitySettings = {
        --Vanilla
        [1] = {
            --ReGIR
            {
                index   = "Editor/ReGIR",
                name    = "BuildCandidatesCount",
                value   = "8"
            },
            {
                index   = "Editor/ReGIR",
                name    = "LightSlotsCount",
                value   = "128"
            },
            {
                index   = "Editor/ReGIR",
                name    = "ShadingCandidatesCount",
                value   = "4"
            },

            --ReSTIR
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxReservoirAge",
                value   = "32"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "TargetHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "2"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumSamples",
                value   = "2"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialSamplingRadius",
                value   = "32.0"
            },

            --RTXDI
            {
                index   = "Editor/RTXDI",
                name    = "BiasCorrectionMode",
                value   = "2"
            },
            {
                index   = "Editor/RTXDI",
                name    = "NumInitialSamples",
                value   = "8"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "8"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialSamplingRadius",
                value   = "32.0"
            },

            --SHARC
            {
                index   = "Editor/SHARC",
                name    = "Bounces",
                value   = "4"
            },
            {
                index   = "Editor/SHARC",
                name    = "DownscaleFactor",
                value   = "5"
            },
            {
                index   = "Editor/SHARC",
                name    = "SceneScale",
                value   = "50.0"
            }
        },

        --Performance
        [2] = {
            --ReGIR
            {
                index   = "Editor/ReGIR",
                name    = "BuildCandidatesCount",
                value   = "8"
            },
            {
                index   = "Editor/ReGIR",
                name    = "LightSlotsCount",
                value   = "128"
            },
            {
                index   = "Editor/ReGIR",
                name    = "ShadingCandidatesCount",
                value   = "6"
            },

            --ReSTIR
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxReservoirAge",
                value   = "24"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "TargetHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "2"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumSamples",
                value   = "1"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialSamplingRadius",
                value   = "12.0"
            },

            --RTXDI
            {
                index   = "Editor/RTXDI",
                name    = "BiasCorrectionMode",
                value   = "2"
            },
            {
                index   = "Editor/RTXDI",
                name    = "NumInitialSamples",
                value   = "6"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "4"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialSamplingRadius",
                value   = "16.0"
            },

            --SHARC
            {
                index   = "Editor/SHARC",
                name    = "Bounces",
                value   = "1"
            },
            {
                index   = "Editor/SHARC",
                name    = "DownscaleFactor",
                value   = "7"
            },
            {
                index   = "Editor/SHARC",
                name    = "SceneScale",
                value   = "25.0"
            }
        },

        --Balanced
        [3] = {
            --ReGIR
            {
                index   = "Editor/ReGIR",
                name    = "BuildCandidatesCount",
                value   = "8"
            },
            {
                index   = "Editor/ReGIR",
                name    = "LightSlotsCount",
                value   = "128"
            },
            {
                index   = "Editor/ReGIR",
                name    = "ShadingCandidatesCount",
                value   = "6"
            },

            --ReSTIR
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxReservoirAge",
                value   = "32"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "TargetHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "16"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumSamples",
                value   = "3"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialSamplingRadius",
                value   = "24.0"
            },

            --RTXDI
            {
                index   = "Editor/RTXDI",
                name    = "BiasCorrectionMode",
                value   = "2"
            },
            {
                index   = "Editor/RTXDI",
                name    = "NumInitialSamples",
                value   = "16"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "24"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialSamplingRadius",
                value   = "48.0"
            },

            --SHARC
            {
                index   = "Editor/SHARC",
                name    = "Bounces",
                value   = "2"
            },
            {
                index   = "Editor/SHARC",
                name    = "DownscaleFactor",
                value   = "7"
            },
            {
                index   = "Editor/SHARC",
                name    = "SceneScale",
                value   = "33.333333333"
            }
        },

        --Quality
        [4] = {
            --ReGIR
            {
                index   = "Editor/ReGIR",
                name    = "BuildCandidatesCount",
                value   = "16"
            },
            {
                index   = "Editor/ReGIR",
                name    = "LightSlotsCount",
                value   = "256"
            },
            {
                index   = "Editor/ReGIR",
                name    = "ShadingCandidatesCount",
                value   = "16"
            },

            --ReSTIR
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxHistoryLength",
                value   = "10"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxReservoirAge",
                value   = "20"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "TargetHistoryLength",
                value   = "8"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "32"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumSamples",
                value   = "4"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialSamplingRadius",
                value   = "32.0"
            },

            --RTXDI
            {
                index   = "Editor/RTXDI",
                name    = "BiasCorrectionMode",
                value   = "1"
            },
            {
                index   = "Editor/RTXDI",
                name    = "NumInitialSamples",
                value   = "24"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "32"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialSamplingRadius",
                value   = "64.0"
            },

            --SHARC
            {
                index   = "Editor/SHARC",
                name    = "Bounces",
                value   = "4"
            },
            {
                index   = "Editor/SHARC",
                name    = "DownscaleFactor",
                value   = "5"
            },
            {
                index   = "Editor/SHARC",
                name    = "SceneScale",
                value   = "60.0"
            }
        },

        --Psycho
        [5] = {
            --ReGIR
            {
                index   = "Editor/ReGIR",
                name    = "BuildCandidatesCount",
                value   = "32"
            },
            {
                index   = "Editor/ReGIR",
                name    = "LightSlotsCount",
                value   = "384"
            },
            {
                index   = "Editor/ReGIR",
                name    = "ShadingCandidatesCount",
                value   = "32"
            },

            --ReSTIR
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxHistoryLength",
                value   = "10"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "MaxReservoirAge",
                value   = "24"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "TargetHistoryLength",
                value   = "10"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "64"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialNumSamples",
                value   = "16"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "SpatialSamplingRadius",
                value   = "32.0"
            },

            --RTXDI
            {
                index   = "Editor/RTXDI",
                name    = "BiasCorrectionMode",
                value   = "1"
            },
            {
                index   = "Editor/RTXDI",
                name    = "NumInitialSamples",
                value   = "48"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialNumDisocclusionBoostSamples",
                value   = "128"
            },
            {
                index   = "Editor/RTXDI",
                name    = "SpatialSamplingRadius",
                value   = "64.0"
            },

            --SHARC
            {
                index   = "Editor/SHARC",
                name    = "Bounces",
                value   = "8"
            },
            {
                index   = "Editor/SHARC",
                name    = "DownscaleFactor",
                value   = "3"
            },
            {
                index   = "Editor/SHARC",
                name    = "SceneScale",
                value   = "100.0"
            }
        }
    },
    ptOptimizationsIndex = 2,
    ptOptimizationsSettings = {
        --Off
        [1] = {
            {
                index   = "Editor/Denoising/NRD",
                name    = "DisocclusionThreshold",
                value   = "0.005"
            },
            {
                index   = "Editor/PathTracing",
                name    = "UseScreenSpaceData",
                value   = "false"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "BoilingFilterStrength",
                value   = "0.4"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "EnableBoilingFilter",
                value   = "false"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "EnableFallbackSampling",
                value   = "false"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "UseTemporalRGS",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "BoilingFilterStrength",
                value   = "0.5"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EmissiveDistanceThreshold",
                value   = "0.5"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableApproximateTargetPDF",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableEmissiveProxyLightRejection",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableLocalLightImportanceSampling",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableSeparateDenoising",
                value   = "true"
            },
            {
                index   = "Editor/RTXDI",
                name    = "ForcedShadowLightSourceRadius",
                value   = "0.1"
            },
            {
                index   = "Editor/RTXDI",
                name    = "MaxHistoryLength",
                value   = "20"
            },
            {
                index   = "Editor/SHARC",
                name    = "UseRTXDIAtPrimary",
                value   = "false"
            },
            {
                index   = "RayTracing",
                name    = "EnableImportanceSampling",
                value   = "true"
            },
            {
                index   = "RayTracing",
                name    = "InstanceFlagForceOMM2StateOnLODXAndAbove",
                value   = "2"
            },
            {
                index   = "RayTracing",
                name    = "TransparentReflectionEnvironmentBlendFactor",
                value   = "1.0"
            },
            {
                index   = "RayTracing/Reflection",
                name    = "EnableHalfResolutionTracing",
                value   = "1"
            }
        },

        --On
        [2] = {
            {
                index   = "Editor/Denoising/NRD",
                name    = "DisocclusionThreshold",
                value   = "0.002"
            },
            {
                index   = "Editor/PathTracing",
                name    = "UseScreenSpaceData",
                value   = "true"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "BoilingFilterStrength",
                value   = "0.2"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "EnableBoilingFilter",
                value   = "true"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "EnableFallbackSampling",
                value   = "true"
            },
            {
                index   = "Editor/ReSTIRGI",
                name    = "UseTemporalRGS",
                value   = "true"
            },
            {
                index   = "Editor/RTXDI",
                name    = "BoilingFilterStrength",
                value   = "0.1"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EmissiveDistanceThreshold",
                value   = "0.7"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableApproximateTargetPDF",
                value   = "true"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableEmissiveProxyLightRejection",
                value   = "true"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableLocalLightImportanceSampling",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "EnableSeparateDenoising",
                value   = "false"
            },
            {
                index   = "Editor/RTXDI",
                name    = "ForcedShadowLightSourceRadius",
                value   = "0.25"
            },
            {
                index   = "Editor/RTXDI",
                name    = "MaxHistoryLength",
                value   = "0"
            },
            {
                index   = "Editor/SHARC",
                name    = "UseRTXDIAtPrimary",
                value   = "true"
            },
            {
                index   = "RayTracing",
                name    = "EnableImportanceSampling",
                value   = "false"
            },
            {
                index   = "RayTracing",
                name    = "InstanceFlagForceOMM2StateOnLODXAndAbove",
                value   = "3"
            },
            {
                index   = "RayTracing",
                name    = "TransparentReflectionEnvironmentBlendFactor",
                value   = "0.06"
            },
            {
                index   = "RayTracing/Reflection",
                name    = "EnableHalfResolutionTracing",
                value   = "0"
            }
        }
    }
}

return defaults
