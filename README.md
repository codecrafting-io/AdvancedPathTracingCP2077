# Advanced Path Tracing for Cyberpunk 2077

[![GitHub Release](https://img.shields.io/github/v/tag/codecrafting-io/AdvancedPathTracingCP2077?label=version)](https://github.com/codecrafting-io/AdvancedPathTracingCP2077/releases)
[![Github All Releases](https://img.shields.io/github/downloads/codecrafting-io/AdvancedPathTracingCP2077/total?color=blueviolet)](https://github.com/codecrafting-io/AdvancedPathTracingCP2077/releases)
[![Issues](https://img.shields.io/github/issues/codecrafting-io/AdvancedPathTracingCP2077)](https://github.com/codecrafting-io/AdvancedPathTracingCP2077/issues)

This repository is for the development of the `Advanced Path Tracing` mod for the game [Cyberpunk 2077](https://www.cyberpunk.net/). The mod is based on [Cyber Engine Tweaks](https://wiki.redmodding.org/cyber-engine-tweaks) and enables key advanced controls for Path Tracing, all now available through a native UI thanks to [Native Settings](https://www.nexusmods.com/cyberpunk2077/mods/3518).

**NOTE:** This is a **Work In Progress** mod, so things may improve in the future.

**NOTE:** For NVIDIA documentation about Path Tracing terms check [this link](https://github.com/NVIDIAGameWorks/RTXDI/blob/main/doc/Integration.md)

![Advanced Path Tracing Menu](/menu.png?raw=true)

## Features

- Global Preset:
  - **Vanilla**: Is the game's default mode.
  - **Very Low**: Is the lowest quality that makes some sense to still enable PT, but you can go lower
  - **Low**: Increases very low quality to not be as noisy.
  - **Medium**: Switches to ReSTIR DI/GI with better quality.
  - **High**: Increase quality and disables SHARC since it can be noisier, but it aids with above tertiary bounces in dark areas.
  - **Ultra**: Changes to ReGIR which can look better, but also noiser (specially with RR), so results vary.
  - **Psycho**: Flatlines your GPU 💀 🥵. Changes back to ReSTIR DI to have the cleanest image between all modes, with less noise. Acts more like offline rendering, although can look too bright or miss some contact shadows.
- Path Tracing Modes:
  - **ReSTIR DI + ReGIR GI**: Uses the Reservoir-based Grid Importance Sampling, for a world space light sampling on top of ReSTIR, but only for GI. Can look better but with some extra noise when using Ray Reconstruction.
  - **ReGIR DI/GI**: Uses ReGIR for both GI and DI. DI may lose specular detail on some surfaces.
  - **ReSTIR DI/GI**: Reservoir SpatioTemporal Importance samples for Global Illumination, is a screen space light sampling used to illuminate secondary surfaces. This is the vanilla mode
  - **ReSTIR DI**: This is the older PT from update 2.0, used for DI only. Allows control of rays per pixel and bounces per ray
- Path Tracing Quality:
  - **Vanilla**: Default game quality
  - **Performance**: Faster but noisier
  - **Balanced**: Improve on Vanilla quality and increase performance by up to 1%
  - **Quality**: Heavy but less noise and higher quality
  - **Psycho**: Flatline your GPU 💀
- Path Tracing Optimizations: Enables the following optimizations:
  - Adds missing PT Reflections through Screen Space Reflections
  - Reduce noise on some scenarios. Some scenes may appear a little darker
  - Use PDF (Probability Density Function) for minor performance boost
  - Minor reflections improvement on transparent surfaces
  - Minor GI/DI light behavior optimizations
- NVIDIA SHARC: Enable NVIDIA's Spatial Hash Radiance Cache (SHARC) for light bounces. According to NVIDIA, this is designed to improve signal quality and performance and works in world space. This is the vanilla mode, but **won't be enabled with ReGIR** because it can cause noise problems. This may result in slight differences in light bounce, shadows and performance may vary. Scales with path tracing quality.
- Rays per Pixel: Number of and rays per pixel **when using ReSTIR DI** mode
- Bounces per Ray: Number of and bounces per ray **when using ReSTIR DI** mode
- Self Reflection: Enable V self reflection without the head (game limitation😅🤷‍♂️). You are able to add the head by using the [Appearance Menu Mod](https://www.nexusmods.com/cyberpunk2077/mods/790). For showing the sleeves use the [Sleves](https://www.nexusmods.com/cyberpunk2077/mods/3309?tab=files) or [third person mod](https://www.nexusmods.com/cyberpunk2077/mods/669).
- DLSS Ray Reconstruction Particles: By default, the game separates particles for RR, so enable this if it's not raining or it's indoors
- NRD Disable Helper: Path Tracing has two main denoisers, Ray Reconstruction (RR) and NVIDIA Real Time Denoiser (NRD). When using RR the NRD should be disabled, but sometimes it enables, this helps to keep NRD disabled over time.
- Refresh Game: The game has a tendency to not have "full performance" when loading or exiting menus, this helps to mitigate the problem by pausing the game (no camera or player movement and no combat) for a few seconds. The refresh is done according to the "Refresh Game Interval" setting. The mod will skip the refresh if a limited gameplay scene is detected. Disabled by default.
- Refresh Game Interval: The amount of time in minutes to wait for the next refresh. Zero will refresh every time.

**NOTE:** ReGIR has implementation issues, such as flickering light bounces, not activating correctly sometimes (mostly "fixed" now), noise breakup when using ray reconstruction (especially when using SHARC) in some scenarios. Also, performance can take up to 30s to stabilize if not, you can use the "Refresh Game" or entering and exiting Photo Mode. Reload the save or restart the game may also fix this.

**NOTE:** This mod is designed for Path Tracing (PT), not normal Ray Tracing (RT), so quality levels, optimizations are mostly for PT not RT.

## Requirements

- [Cyber Engine Tweaks (>= v1.30.1)](https://www.nexusmods.com/cyberpunk2077/mods/107)
- [Native Settings UI (>= 1.96)](https://www.nexusmods.com/cyberpunk2077/mods/3518)

## Compatibility

This mod is not compatible with [Ultra Plus Control (sammilucia)](https://www.nexusmods.com/cyberpunk2077/mods/10490) due to some overlapping settings and differences in behavior. If you want to use the ULTRA+ fixes and VRAM settings, I suggest you import those settings into an ini file and load them separately from the RT/PT settings.

Advanced Path Tracing does not use the same settings and values as ULTRA+ Control for RT/PT, but most of the behavior can be replicated. To do this, use the `ptQuality.lua` file to apply the same values in ULTRA+ Control.

## Installation

Extract the zip and paste the `bin` folder to `<path to cyberpunk 2077>`. Note that the end result should be:

`<path to cyberpunk 2077>\bin\x64\plugins\cyber_engine_tweaks\mods\AdvancedPathTracing`

Remember to install the requirements.

## Settings

The mod save your preferences in the `settings.json` file.

| name | type | default | description |
| ---- | ---- | ------- | ----------- |
| debug | boolean | false | Enables extra log messages |
| enableNRDControl | boolean | true | Controls NRD denoiser disable helper state |
| rayNumber | int | 2 | Number of rays per pixel when using ReSTIR DI mode |
| rayBounce | int | 2 | Number of bounces per ray when using ReSTIR DI mode |
| sharc | boolean | false | Wheter or not to enable NVIDIA's SHARC |
| fastTimeout | float | 1.0 | Shortest timeout of a series internal timers |
| slowTimeout | float | 30.0 | Timeout used in enableNRDControl |
| refreshGame | int | false | Wheter or not Auto Refresh Game |
| refreshPauseTimeout | float | 5.0 | The Auto Refresh Timeout |
| refreshInterval | int | 30 | Amount of time in minutes to wait for the next refresh. Zero will refresh every time |
| selfReflection | boolean | false | Whether or not to enable V's self-reflection. Head won't appear due to game limitation. |
| enableDLSSDParticles | boolean | true | Whether or not enable DLSS Ray Reconstruction particles |
| ptPreset | int | 4 | Path Tracing global preset. <br> 1 - Vanilla <br> 2 - Very Low <br> 3 - Low <br> 4 - Medium <br> 5 - High <br> 6 - Ultra <br> 7 - Psycho |
| ptModeIndex | int | 2 | Path Tracing mode. <br>1 - ReSTIR DI <br>2 - ReSTIR DI/GI <br> 3 - ReSTIR DI + ReGIR GI <br> 4 - ReGIR DI/GI |
| ptQualityIndex | int | 3 | Path Tracing quality setting. <br>1 - Vanilla <br>2 - Performance <br>3 - Balanced <br>4 - Quality <br>5 - Psycho |
| ptOptimizations | boolean | true | Whether or not to enable PT Optimizations |

## Credits

- [Ultra Plus Control (sammilucia)](https://www.nexusmods.com/cyberpunk2077/mods/10490): The initial game engine settings reference
- [Freefly (keanuWheeze)](https://www.nexusmods.com/cyberpunk2077/mods/9805): TweaksDB status effect reference and time pause
- [betterHeadlights (keanuWheeze)](https://www.nexusmods.com/cyberpunk2077/mods/5013): Additional NativeSettings reference
- [JB - TPP MOD WIP third person (Jelle Bakker)](https://www.nexusmods.com/cyberpunk2077/mods/669): Reference for TweaksDB head self reflections (not used)
- [Lua Kit for CET (Pavel Siberx)](https://github.com/psiberx/cp2077-cet-kit): Cron, GameHUD and GameUI
- [Native Settings UI (keanuWheeze)](https://www.nexusmods.com/cyberpunk2077/mods/3518): Native Settings UI
- [Cyber Engine Tweaks (yamashi)](https://www.nexusmods.com/cyberpunk2077/mods/107): Cyber Engine Tweaks
