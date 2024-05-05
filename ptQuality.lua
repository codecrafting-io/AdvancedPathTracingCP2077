local ptQuality = {
    settings = {
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
                name        = "MaxReservoirAge",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "8"
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
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
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
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "24"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "2"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "1"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "12.0"
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
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "1"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "7"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "25.0"
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
                value       = "128"
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
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "16"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "3"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "24.0"
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
                value       = "16"
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
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "2"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "7"
            },
            {
                category    = "Editor/SHARC",
                name        = "SceneScale",
                value       = "35.0"
            }
        },

        --Quality
        [4] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "16"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "256"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "16"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "10"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "20"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "8"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "32"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "4"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
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
                value       = "24"
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
                value       = "60.0"
            }
        },

        --Psycho
        [5] = {
            --ReGIR
            {
                category    = "Editor/ReGIR",
                name        = "BuildCandidatesCount",
                value       = "32"
            },
            {
                category    = "Editor/ReGIR",
                name        = "LightSlotsCount",
                value       = "384"
            },
            {
                category    = "Editor/ReGIR",
                name        = "ShadingCandidatesCount",
                value       = "32"
            },

            --ReSTIR
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxHistoryLength",
                value       = "10"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "MaxReservoirAge",
                value       = "24"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "TargetHistoryLength",
                value       = "10"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumDisocclusionBoostSamples",
                value       = "64"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialNumSamples",
                value       = "16"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "SpatialSamplingRadius",
                value       = "32.0"
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
                value       = "128"
            },
            {
                category    = "Editor/RTXDI",
                name        = "SpatialSamplingRadius",
                value       = "64.0"
            },

            --SHARC
            {
                category    = "Editor/SHARC",
                name        = "Bounces",
                value       = "8"
            },
            {
                category    = "Editor/SHARC",
                name        = "DownscaleFactor",
                value       = "3"
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
        [1] = {
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
                name        = "BoilingFilterStrength",
                value       = "0.4"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableBoilingFilter",
                value       = "false"
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
        [2] = {
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
                name        = "BoilingFilterStrength",
                value       = "0.25"
            },
            {
                category    = "Editor/ReSTIRGI",
                name        = "EnableBoilingFilter",
                value       = "true"
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
            {
                category    = "RayTracing",
                name        = "InstanceFlagForceOMM2StateOnLODXAndAbove",
                value       = "3"
            },
            {
                category    = "RayTracing",
                name        = "TransparentReflectionEnvironmentBlendFactor",
                value       = "0.05"
            },
            {
                category    = "RayTracing/Reflection",
                name        = "EnableHalfResolutionTracing",
                value       = "0"
            }
        }
    }
}

return ptQuality
