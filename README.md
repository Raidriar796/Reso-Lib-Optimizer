# Reso Lib Optimizer
This is a build script that recompiles native libraries that [Resonite](<https://resonite.com/>) uses, but optimized for your local system.

Even though Resonite is written primarily in C# - which optimizes itself for your system during runtime - there's still a handful of native libraries Resonite uses that are compiled generically. This isn't bad per say, but it leaves a lot of room for performance gains. That's what this script aims to achieve.

## What libraries are affected

### Affected Libraries
- [assimp](<https://github.com/Yellow-Dog-Man/assimp>) - Improves asset importing speeds, primarily for 3D models.
- [brotli](<https://github.com/Yellow-Dog-Man/brotli>) - Improves bson compression and decompression, which can make syncing to the cloud faster.
- [compressonator](<https://github.com/Yellow-Dog-Man/compressonator>) - Improves BCn texture compression speed, speeding up non crunch compressed texture encoding, such as with reflection probes.
- [crunch](<https://github.com/Yellow-Dog-Man/crunch>) - Improves crunch compression speed, allowing for faster crunch compressed texture generation as well as faster loading for crunch compressed textures.
- [FreeImage](<https://github.com/Yellow-Dog-Man/FreeImage>) - Improves speed for image encoding, decoding, and modifications.
- [mikktspace](<https://github.com/Yellow-Dog-Man/Mikktspace.NET>) - Improves mikktspace calculation speed, making tangents and blendshape tangets calculate faster.
- [miniaudio](<https://github.com/LSXPrime/SoundFlow>) - Improves efficiency for the miniaudio backend used by SoundFlow, reducing resource usage for audio processing.
- [msdfgen](<https://github.com/Yellow-Dog-Man/msdfgen>) - Improves text generation and rendering speed.
- [opus](<https://github.com/Yellow-Dog-Man/opus>) - Improves opus encode and decode speeds, primarily beneficial for user voices and audio streams.
- [rnnoise](<https://github.com/Yellow-Dog-Man/rnnoise>) - Improves efficiency for noise suppression, this only effects your voice.

### Unaffected Libraries
- [glfw](<https://github.com/glfw/glfw>) - Originally used for OpenGL rendering on the old native Linux build. Currently unused.
- [onnxruntime](<https://github.com/microsoft/onnxruntime>) - Compilation successful in testing, but not yet implemented. Should reduce resource usage for viseme processing.
- [phonon](<https://github.com/ValveSoftware/steam-audio>) - Not researched yet. Used for audio spatialization.
- [resonite-clipboard-rs](<https://github.com/Yellow-Dog-Man/resonite-clipboard-rs>) - It's for the clipboard, there's practically no benefit to optimizing this. I may do it anyway if I run out of libraries to do because it's funny or something.
- [SDL](<https://github.com/Yellow-Dog-Man/SDL>) - Originally used for audio on Linux. Currently unused.
- [soundpipe](<https://github.com/Yellow-Dog-Man/soundpipe>) - soundpipe was implemented but is currently unused. May be used in the future.
- [SteamWorks](<https://partner.steamgames.com/doc/sdk/api>) - Used for steam integration. Source unavailable.

## Warnings
- The script expects the default install location for Resonite, you can change that directory at the top of the script if you installed Resonite elsewhere.
- This is only tested on Arch Linux systems, there is no guarantee it will work on other distros.
- Absolutely no checks are done for if you have the right dependancies for compiling everything, for now that is on you.
- This has no way to undo the script, but each file is managed by Steam, so validating files will undo everything this script does.
- If the script fails or is cancelled while compiling compressonator and do not get a successful compilation of compressonator afterwards, you may need to reinstall imath.
- If you run into issues with the related libraries, first validate they are not present with the vanilla files before reporting them to Resonite directly.
- Windows is not supported, nor do I use Windows. If you would like to submit a script for windows that replicates the Linux script, feel free to open a pull request.

## Basic Usage
```
git clone --depth=1 https://github.com/Raidriar796/Reso-Lib-Optimizer
cd Reso-Lib-Optimizer
chmod +x ResoLibOptimizer.sh
./ResoLibOptimizer.sh
```

## Alternatives
- [ResoniteBC7EncMod](<https://git.unix.dog/yosh/ResoniteBC7EncMod>) - Mod that replaces compressonator with [bc7enc_rdo](<https://github.com/richgel999/bc7enc_rdo>) (compressonator is still used for BC6H though), which is significantly faster and will be more beneficial to use over even an optimized compressonator build.
- [Resovips](<https://git.unix.dog/yosh/Resovips>) - Mod that replaces FreeImage with [libvips](<https://github.com/libvips/libvips>), which is generally faster but other bottlenecks are present like the database, limiting performance gains.
