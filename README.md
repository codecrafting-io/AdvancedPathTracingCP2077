# Advanced Path Tracing for Cyberpunk 2077

This repository is for the development of the [Cyber Engine Tweaks](https://wiki.redmodding.org/cyber-engine-tweaks) based mod for the game [Cyberpunk 2077](https://www.cyberpunk.net/). This mod has key hidden controls for the game, all now available through a native UI thanks to [Native Settings](https://www.nexusmods.com/cyberpunk2077/mods/3518).

**NOTE:** This is **Work In Progress** mod, so things may improve in the future.

![Advanced Path Tracing Menu](/menu.png?raw=true)

## Features

- Control Path Tracing with the following modes:
  - **ReGIR DI/GI**: Reservoir-based Grid Importance Sampling, is a world space light sampling on top of ReSTIR. Often looks and performs better, but can be noisier
  - **ReSTIR GI**: Reservoir SpatioTemporal Importance samples for Global Illumination, is a screen space light sampling used to illuminate secondary surfaces. This is the vanilla mode
  - **ReSTIR DI**: This is the older PT from update 2.0, used for DI only. Allows control of rays per pixel and bounces per ray. Allows control of rays per pixel and bounces per ray
- Control Path Tracing internal settings to set the following levels of quality:
  - **Vanilla**: Default game quality
  - **Performance**: Faster but noisier
  - **Balanced**: Improve on Vanilla quality and increase performance by until 1%
  - **Quality**: Heavy but less noise and higher quality
  - **Psycho**: Flatline your GPU 💀
- Path Tracing Optimizations: Enables small path tracing optimizations internal settings without relevant quality loss
- Control number of rays per pixel and rays per bounce when using **ReSTIR DI** mode
- Enable DLSS ray reconstruction particles in raytracing. By default, the game separates particles for RR, so enable this if it's not raining or it's indoors
- Disable NRD Denoiser helper for Ray Reconstruction. Path Tracing has two main denoisers, RR and NRD, so using RR should disable NRD, but sometimes it enables, this helps to keep NRD disabled over time
- Auto Refresh game when loading and exiting the menu. The game has a tendency to not have "full performance" when loading or exiting menus, this helps to mitigate the problem by pausing the game for a few seconds

## Installation

Just drop the folder in `<path to cyberpunk 2077>\bin\x64\plugins\cyber_engine_tweaks\mods`. Remember to install the requirements.

## Settings

The mod save your preferences in the `settings.json` file.

| name | type | default | description |
| ---- | ---- | ------- | ----------- |
| degug | boolean | false | Enables extra messages on the CET console |
| enableNRDControl | boolean | true | Controls NRD denoiser disable helper state |
| rayNumber | int | 2 | Number of rays per pixel when using ReSTIR DI mode |
| rayBounce | int | 2 | Number of bounces per ray when using ReSTIR DI mode |
| fastTimeout | int | 1.0 | Shortest timeout of a series internal timers |
| slowTimeout | int | 30.0 | Timeout used in enableNRDControl |
| refreshGame | int | true | Wheter or not Auto Refresh Game |
| refreshTimeout | int | 5.0 | Wether or not to Auto Refresh the Game |
| enableDLSSDParticles | boolean | true | Wether or not enable DLSS Ray Reconstruction particles |
| ptModeIndex | int | 1 | Path Tracing mode |
| ptQualityIndex | int | 3 | Path Tracing mode |
| ptQualitySettings | table | table[3] | Multiple set of commands to set quality level |
| ptOptimizationsIndex | int | 2 | Set on 1 disables and 2 enables the PT optimizations |
| ptOptimizationsSettings | table | table[2] | Multiple set of commands to set the optimizations |

## Credits

- [Ultra Plus Control](https://www.nexusmods.com/cyberpunk2077/mods/10490)
- [Weathermancer](https://www.nexusmods.com/cyberpunk2077/mods/9805)
- [betterHeadlights](https://www.nexusmods.com/cyberpunk2077/mods/5013)

Thanks for inspiration to create this mod
