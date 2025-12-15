# Reso Lib Optimizer
This is a build script that recompiles native libraries that Resonite uses, optimized for your local system.

Even though Resonite is written primarily in C# - which optimizes itself for your system during runtime - there's still a handful of native libraries Resonite uses that are compiled generically. This isn't bad per say, but it leaves a lot of room for performance gains. That's what this script aims to achieve.

## What libraries are affected

### Affected Libraries
- [assimp](<https://github.com/Yellow-Dog-Man/assimp>) - Improves asset importing speeds, primarily for 3D models.
- [brotli](<https://github.com/Yellow-Dog-Man/brotli>) - Improves bson compression and decompression, which can make syncing to the cloud faster.
- [crunch](<https://github.com/Yellow-Dog-Man/crunch>) - Improves crunch compression speed, allowing for faster crunch compressed texture generation as well as faster loading for crunch compressed textures.
- [mikktspace](<https://github.com/Yellow-Dog-Man/Mikktspace.NET>) - Improves mikktspace calculation speed, making tangents and blendshape tangets calculate faster.
- [miniaudio](<https://github.com/LSXPrime/SoundFlow>) - Improves efficiency for the miniaudio backend used by SoundFlow, reducing resource usage for audio processing.
- [msdfgen](<https://github.com/Yellow-Dog-Man/msdfgen>) - Improves text generation and rendering speed.
- [opus](<https://github.com/Yellow-Dog-Man/opus>) - Improves opus encode and decode speeds, primarily beneficial for user voices and audio streams.
- [rnnoise](<https://github.com/Yellow-Dog-Man/rnnoise>) - Improves efficiency for noise suppressionm, this only effects your voice.

### Unaffected Libraries
- [compressonator](<https://github.com/Yellow-Dog-Man/compressonator>) - Unable to compile, should improve encode and decode speeds for non crunch compressed textures.
- [FreeImage](<https://github.com/Yellow-Dog-Man/FreeImage>) - Unable to compile, should improve speed for image encoding, decoding, and modifications.
- [onnxruntime](<https://github.com/microsoft/onnxruntime>) - Unable to configure, should reduce resource usage for viseme generation.

## Warnings
- The script expects the default install location for Resonite, you can change that directory at the top of the script if you installed Resonite elsewhere.
- This is only tested on Arch Linux systems, there is no guarantee it will work on other distros.
- Absolutely no checks are done for if you have the right dependancies for compiling everything, for now that is on you.
- This has no way to undo the script, but each file is managed by Steam, so validating files will undo everything this script does
- Windows is not supported, nor do I use Windows. If you would like to submit a script for windows that replicates the Linux script, feel free to open a pull request.

## Basic Usage
```
git clone --depth=1 https://github.com/Raidriar796/Reso-Lib-Optimizer
cd Reso-Lib-Optimizer
chmod +x ResoLibOptimizer.sh
./ResoLibOptimizer.sh
```
