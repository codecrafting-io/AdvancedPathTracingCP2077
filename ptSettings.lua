return {
    preset = {
        --Vanilla
        [1] = {
            ptMode              = 2,
            ptQuality           = 1,
            sharc               = true,
            ptOptimizations     = false,
            rayNumber           = 2,
            rayBounce           = 2,
            selfReflection      = false,
            dlssdParticles      = false
        },
        --Very Low
        [2] = {
            ptMode              = 1,
            ptQuality           = 2,
            sharc               = true,
            ptOptimizations     = true,
            rayNumber           = 2,
            rayBounce           = 1,
            selfReflection      = false,
            dlssdParticles      = false
        },
        --Low
        [3] = {
            ptMode              = 1,
            ptQuality           = 3,
            sharc               = true,
            ptOptimizations     = true,
            rayNumber           = 2,
            rayBounce           = 1,
            selfReflection      = true,
            dlssdParticles      = true
        },
        --Medium
        [4] = {
            ptMode              = 2,
            ptQuality           = 3,
            sharc               = false,
            ptOptimizations     = true,
            rayNumber           = 2,
            rayBounce           = 2,
            selfReflection      = true,
            dlssdParticles      = true
        },
        --High
        [5] = {
            ptMode              = 2,
            ptQuality           = 4,
            sharc               = false,
            ptOptimizations     = true,
            rayNumber           = 2,
            rayBounce           = 2,
            selfReflection      = true,
            dlssdParticles      = true
        },
        --Ultra
        [6] = {
            ptMode              = 3,
            ptQuality           = 4,
            sharc               = false,
            ptOptimizations     = true,
            rayNumber           = 2,
            rayBounce           = 2,
            selfReflection      = true,
            dlssdParticles      = true
        },
        --Psycho
        [7] = {
            ptMode              = 1,
            ptQuality           = 5,
            sharc               = false,
            ptOptimizations     = true,
            rayNumber           = 4,
            rayBounce           = 6,
            selfReflection      = true,
            dlssdParticles      = true
        }
    },
    quality = {
        --Vanilla
        [1] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "8"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "128"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "4"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "2"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "2"
            },

            --RTXDI
            {
                category    = "Editor/RTXDI",
                name        = "BiasCorrectionMode",
                value       = "2"
            },
            {
                category    = "Editor/RTXDI",
                name        = "NumInitialSamples",
                value       = "8"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "8"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },

            --SHARC
            --[[
            {
                category    = "Editor/SHARC",
                name        = "Enable",
                value       = "true"
            },
            --]]
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "4"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "5"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "50.0"
            }
        },

        --Performance
        [2] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "8"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "128"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "3"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "16"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "20.0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "2"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "2"
            },

            --RTXDI
            {
                category    = "Editor/RTXDI",
                name        = "BiasCorrectionMode",
                value       = "2"
            },
            {
                category    = "Editor/RTXDI",
                name        = "NumInitialSamples",
                value       = "6"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "4"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "16.0"
            },

            --SHARC
            --[[
            {
                category    = "Editor/SHARC",
                name        = "Enable",
                value       = "true"
            },
            --]]
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "1"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "30"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "35.0"
            }
        },

        --Balanced
        [3] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "8"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "256"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "6"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "24"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "16"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "6"
            },

            --RTXDI
            {
                category    = "Editor/RTXDI",
                name        = "BiasCorrectionMode",
                value       = "2"
            },
            {
                category    = "Editor/RTXDI",
                name        = "NumInitialSamples",
                value       = "12"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "20"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },

            --SHARC
            --[[
            {
                category    = "Editor/SHARC",
                name        = "Enable",
                value       = "true"
            },
            --]]
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "2"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "30"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "40.0"
            }
        },

        --Quality
        [4] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "8"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "384"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "10"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "24"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "16"
            },

            --RTXDI
            {
                category    = "Editor/RTXDI",
                name        = "BiasCorrectionMode",
                value       = "1"
            },
            {
                category    = "Editor/RTXDI",
                name        = "NumInitialSamples",
                value       = "20"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "24"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "48.0"
            },

            --SHARC
            --[[
            {
                category    = "Editor/SHARC",
                name        = "Enable",
                value       = "false"
            },
            --]]
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "4"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "30"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "60.0"
            }
        },

        --Psycho
        [5] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "12"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "512"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "24"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "6"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "32"
            },

            --RTXDI
            {
                category    = "Editor/RTXDI",
                name        = "BiasCorrectionMode",
                value       = "1"
            },
            {
                category    = "Editor/RTXDI",
                name        = "NumInitialSamples",
                value       = "48"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "32"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "64.0"
            },

            --SHARC
            --[[
            {
                category    = "Editor/SHARC",
                name        = "Enable",
                value       = "false"
            },
            --]]
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "8"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "30"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "100.0"
            }
        }
    },
    optimizations = {
        --Off
        [false] = {
            {
                category    = "Editor/Denoising/NRD",
                name        = "DisocclusionThreshold",
                value       = "0.005"
            },
            {
                category    = "Editor/PathTracing",
                name        = "UseScreenSpaceData",
                value       = "false"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableBoilingFilter",
                value       = "false"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "BoilingFilterStrength",
                value       = "0.4"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableFallbackSampling",
                value       = "false"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "UseTemporalRGS",
                value       = "false"
            },
            {
                category    = "Editor/RTXDI",
                name        = "BoilingFilterStrength",
                value       = "0.5"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EmissiveDistanceThreshold",
                value       = "0.5"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableApproximateTargetPDF",
                value       = "false"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableEmissiveProxyLightRejection",
                value       = "false"
            },
            --[[
            {
                category    = "Editor/RTXDI",
                name        = "EnableGradients",
                value       = "false"
            },
            --]]
            {
                category    = "Editor/RTXDI",
                name        = "EnableLocalLightImportanceSampling",
                value       = "false"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableSeparateDenoising",
                value       = "true"
            },
            {
                category    = "Editor/RTXDI",
                name        = "ForcedShadowLightSourceRadius",
                value       = "0.1"
            },
            {
                category    = "Editor/RTXDI",
                name        = "MaxHistoryLength",
                value       = "20"
            },
            {
                category    = "Editor/SHARC",
                name        = "UseRTXDIAtPrimary",
                value       = "false"
            },
            {
                category    = "RayTracing",
                name        = "EnableImportanceSampling",
                value       = "true"
            },
            {
                category    = "RayTracing",
                name        = "InstanceFlagForceOMM2StateOnLODXAndAbove",
                value       = "2"
            },
            {
                category    = "RayTracing",
                name        = "TransparentReflectionEnvironmentBlendFactor",
                value       = "1.0"
            },
            {
                category    = "RayTracing/Reflection",
                name        = "EnableHalfResolutionTracing",
                value       = "1"
            }
        },

        --On
        [true] = {
            {
                category    = "Editor/Denoising/NRD",
                name        = "DisocclusionThreshold",
                value       = "0.002"
            },
            {
                category    = "Editor/PathTracing",
                name        = "UseScreenSpaceData",
                value       = "true"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableBoilingFilter",
                value       = "true"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "BoilingFilterStrength",
                value       = "0.2"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableFallbackSampling",
                value       = "true"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "UseTemporalRGS",
                value       = "true"
            },
            {
                category    = "Editor/RTXDI",
                name        = "BoilingFilterStrength",
                value       = "0.15"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EmissiveDistanceThreshold",
                value       = "0.67"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableApproximateTargetPDF",
                value       = "true"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableEmissiveProxyLightRejection",
                value       = "true"
            },
            --[[
            {
                category    = "Editor/RTXDI",
                name        = "EnableGradients",
                value       = "true"
            },
            --]]
            {
                category    = "Editor/RTXDI",
                name        = "EnableLocalLightImportanceSampling",
                value       = "false"
            },
            {
                category    = "Editor/RTXDI",
                name        = "EnableSeparateDenoising",
                value       = "true"
            },
            {
                category    = "Editor/RTXDI",
                name        = "ForcedShadowLightSourceRadius",
                value       = "0.25"
            },
            {
                category    = "Editor/RTXDI",
                name        = "MaxHistoryLength",
                value       = "0"
            },
            {
                category    = "Editor/SHARC",
                name        = "UseRTXDIAtPrimary",
                value       = "true"
            },
            {
                category    = "RayTracing",
                name        = "EnableImportanceSampling",
                value       = "false"
            },
            --[[
            {
                category    = "RayTracing",
                name        = "InstanceFlagForceOMM2StateOnLODXAndAbove",
                value       = "3"
            },
            --]]
            {
                category    = "RayTracing",
                name        = "TransparentReflectionEnvironmentBlendFactor",
                value       = "0.8"
            },
            {
                category    = "RayTracing/Reflection",
                name        = "EnableHalfResolutionTracing",
                value       = "0"
            }
        }
    }
}
