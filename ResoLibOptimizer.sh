#!/bin/bash

ResoDir="$HOME/.steam/steam/steamapps/common/Resonite"
OptimizedFlags="-march=native -O3 -pipe -fno-semantic-interposition -flto -ffat-lto-objects"

set -exuo pipefail

# Setup work dir and remove if existing
rm -rf /tmp/ResoLibOptimizer
mkdir /tmp/ResoLibOptimizer
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized assimp
git clone --depth=1 https://github.com/Yellow-Dog-Man/assimp
cd assimp
cmake CMakeLists.txt -DASSIMP_WARNINGS_AS_ERRORS=OFF -DCMAKE_C_FLAGS="${OptimizedFlags}" -DCMAKE_CXX_FLAGS="${OptimizedFlags}" 
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
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=./installed -DCMAKE_C_FLAGS=" ${OptimizedFlags}" ..
cmake --build . --config Release -j$(nproc)

# Replace Resonite's brotli files
rm "${ResoDir}/brolib_x64.so"
rm "${ResoDir}/runtimes/linux/native/brolib_x64.so"
cp "/tmp/ResoLibOptimizer/brotli/out/libbrolib.so" "${ResoDir}/runtimes/linux/native/brolib_x64.so"
ln "${ResoDir}/runtimes/linux/native/brolib_x64.so" "${ResoDir}/brolib_x64.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized compressonator
git clone --depth=1 https://github.com/Yellow-Dog-Man/compressonator
cd compressonator
cmake -DOPTION_ENABLE_ALL_APPS=OFF -DOPTION_BUILD_CMP_SDK=ON -DOPTION_CMP_QT=OFF -DOPTION_BUILD_KTX2=ON -DOPTION_BUILD_EXR=ON -DOPTION_BUILD_GUI=OFF -DBUILD_SHARED_LIBS=ON -DCMAKE_C_FLAGS="${OptimizedFlags}" -DCMAKE_CXX_FLAGS="${OptimizedFlags}" .
sed -i '33i\#include <cstdint>\' ./applications/_plugins/common/pluginbase.h
sed -i -e 's/knl/x86-64-v4/g' ./build/sdk/cmp_core/CMakeLists.txt
sed -i -e 's/knl/x86-64-v4/g' ./cmp_core/CMakeLists.txt
sudo sed -i 's/using half = IMATH_INTERNAL_NAMESPACE::half;//g' /usr/include/Imath/half.h
CPLUS_INCLUDE_PATH=/usr/include/opencv4 cmake --build . -j$(nproc)
sudo sed -i '989i\using half = IMATH_INTERNAL_NAMESPACE::half;\' /usr/include/Imath/half.h
sudo sed -i '990d' /usr/include/Imath/half.h

# Replace Resonite's compressonator files
rm "${ResoDir}/libCMP_Compressonator.so"
rm "${ResoDir}/libCMP_Framework.so"
rm "${ResoDir}/runtimes/linux-x64/native/libCMP_Compressonator.so"
rm "${ResoDir}/runtimes/linux-x64/native/libCMP_Framework.so"
cp "/tmp/ResoLibOptimizer/compressonator/lib/libCMP_Compressonator.so" "${ResoDir}/runtimes/linux-x64/native/libCMP_Compressonator.so"
cp "/tmp/ResoLibOptimizer/compressonator/lib/libCMP_Framework.so" "${ResoDir}/runtimes/linux-x64/native/libCMP_Framework.so"
ln "${ResoDir}/runtimes/linux-x64/native/libCMP_Compressonator.so" "${ResoDir}/libCMP_Compressonator.so"
ln "${ResoDir}/runtimes/linux-x64/native/libCMP_Framework.so" "${ResoDir}/libCMP_Framework.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized crunch
git clone --depth=1 https://github.com/Yellow-Dog-Man/crunch
cd crunch
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="${OptimizedFlags}" -DCMAKE_CXX_FLAGS="${OptimizedFlags}" -DCMAKE_POLICY_VERSION_MINIMUM=3.5 .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's crunch files
rm "${ResoDir}/libcrnlib.so"
rm "${ResoDir}/runtimes/linux-x64/native/libcrnlib.so"
cp "/tmp/ResoLibOptimizer/crunch/out/libcrnlib.so" "${ResoDir}/runtimes/linux-x64/native/libcrnlib.so"
ln "${ResoDir}/runtimes/linux-x64/native/libcrnlib.so" "${ResoDir}/libcrnlib.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized mikktspace
git clone --depth=1 https://github.com/Yellow-Dog-Man/Mikktspace.NET
cd Mikktspace.NET/Native
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="${OptimizedFlags}" -DCMAKE_POLICY_VERSION_MINIMUM=3.5 .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's mikktspace files
rm "${ResoDir}/runtimes/linux-x64/native/libmikktspace.so"
cp "/tmp/ResoLibOptimizer/Mikktspace.NET/Native/out/libmikktspace.so" "${ResoDir}/runtimes/linux-x64/native/libmikktspace.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized miniaudio
git clone --depth=1 --recurse-submodules https://github.com/LSXPrime/SoundFlow
cd SoundFlow/Native/miniaudio-backend
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="${OptimizedFlags}" .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's miniaudio files
rm "${ResoDir}/runtimes/linux-x64/native/libminiaudio.so"
cp "/tmp/ResoLibOptimizer/SoundFlow/Native/miniaudio-backend/out/libminiaudio.so" "${ResoDir}/runtimes/linux-x64/native/libminiaudio.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized msdfgen
git clone --depth=1 https://github.com/Yellow-Dog-Man/msdfgen
cd msdfgen
cmake -DCMAKE_BUILD_TYPE=Release -DMSDFGEN_BUILD_STANDALONE=OFF -DMSDFGEN_BUILD_SHARED_LIBRARY=ON -DCMAKE_CXX_FLAGS="${OptimizedFlags}" .
cmake --build . --config Release -j$(nproc)

# Replace Resonite's msdfgen files
rm "${ResoDir}/libmsdfgen.so"
rm "${ResoDir}/runtimes/linux-x64/native/libmsdfgen.so"
cp "/tmp/ResoLibOptimizer/msdfgen/out/libmsdfgen.so" "${ResoDir}/runtimes/linux-x64/native/libmsdfgen.so"
ln "${ResoDir}/runtimes/linux-x64/native/libmsdfgen.so" "${ResoDir}/libmsdfgen.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized opus
git clone --depth=1 https://github.com/Yellow-Dog-Man/opus
cd opus
./autogen.sh
mkdir out && cd out
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="${OptimizedFlags}" .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's opus files
rm "${ResoDir}/libopus.so"
rm "${ResoDir}/runtimes/linux-x64/native/libopus.so"
cp "/tmp/ResoLibOptimizer/opus/out/libopus.so.0.10.1" "${ResoDir}/runtimes/linux-x64/native/libopus.so"
ln "${ResoDir}/runtimes/linux-x64/native/libopus.so" "${ResoDir}/libopus.so"

# Reset
cd /tmp/ResoLibOptimizer

# Clone and compile an optimized rrnoise
git clone --depth=1 https://github.com/Yellow-Dog-Man/rnnoise
cd rnnoise
mkdir out && cd out
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="${OptimizedFlags}" .. 
cmake --build . --config Release -j$(nproc)

# Replace Resonite's rnnoise files
rm "${ResoDir}/librnnoise.so"
rm "${ResoDir}/runtimes/linux-x64/native/librnnoise.so"
cp "/tmp/ResoLibOptimizer/rnnoise/out/librnnoise.so" "${ResoDir}/runtimes/linux-x64/native/librnnoise.so"
ln "${ResoDir}/runtimes/linux-x64/native/librnnoise.so" "${ResoDir}/librnnoise.so"

rm -rf /tmp/ResoLibOptimizer
