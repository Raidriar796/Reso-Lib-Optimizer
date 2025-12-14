#!/bin/bash

set -exuo pipefail

ResoDir="$HOME/.steam/steam/steamapps/common/Resonite"

# Setup work dir and remove if existing
rm -rf /tmp/ResoLibOptimizer
mkdir /tmp/ResoLibOptimizer
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized assimp
git clone --depth=1 https://github.com/Yellow-Dog-Man/assimp
cd assimp
cmake CMakeLists.txt -DASSIMP_WARNINGS_AS_ERRORS=OFF -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS -O3 -march=native" -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -O3 -march=native" 
cmake --build . -j4

# Replace Resonite's assimp files
rm "${ResoDir}/runtimes/linux-x64/native/libassimp.so"
cp "/tmp/ResoLibOptimizer/assimp/bin/libassimp.so.5.3.0" "${ResoDir}/runtimes/linux-x64/native/libassimp.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized brotli
git clone --depth=1 https://github.com/Yellow-Dog-Man/brotli
cd brotli
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=./installed -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS -O3 -march=native" ..
cmake --build . --config Release -j$(nproc)

# Replace Resonite's brotli files
rm "${ResoDir}/brolib_x64.so"
rm "${ResoDir}/runtimes/linux/native/brolib_x64.so"
cp "/tmp/ResoLibOptimizer/brotli/out/libbrolib.so" "${ResoDir}/brolib_x64.so"
cp "/tmp/ResoLibOptimizer/brotli/out/libbrolib.so" "${ResoDir}/runtimes/linux/native/brolib_x64.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized crunch
git clone --depth=1 https://github.com/Yellow-Dog-Man/crunch
cd crunch
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS -O3 -march=native" -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -O3 -march=native" -DCMAKE_POLICY_VERSION_MINIMUM=3.5 .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's crunch files
rm "${ResoDir}/libcrnlib.so"
rm "${ResoDir}/runtimes/linux-x64/native/libcrnlib.so"
cp "/tmp/ResoLibOptimizer/crunch/out/libcrnlib.so" "${ResoDir}/libcrnlib.so"
cp "/tmp/ResoLibOptimizer/crunch/out/libcrnlib.so" "${ResoDir}/runtimes/linux-x64/native/libcrnlib.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized rrnoise
git clone --depth=1 https://github.com/Yellow-Dog-Man/rnnoise
cd rnnoise
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS -O3 -march=native" .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's rnnoise files
rm "${ResoDir}/librnnoise.so"
rm "${ResoDir}/runtimes/linux-x64/native/librnnoise.so"
cp "/tmp/ResoLibOptimizer/rnnoise/out/librnnoise.so" "${ResoDir}/librnnoise.so"
cp "/tmp/ResoLibOptimizer/rnnoise/out/librnnoise.so" "${ResoDir}/runtimes/linux-x64/native/librnnoise.so"

rm -rf /tmp/ResoLibOptimizer
