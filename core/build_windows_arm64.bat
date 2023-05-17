@echo off

set BUILD_TYPE=Release

:windows_arm64
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -S . -B build\win-arm64 -A ARM64 -DCMAKE_SYSTEM_PROCESSOR=aarch64
cmake --build build\win-arm64 --config %BUILD_TYPE%
mkdir Llama.cpp.Runtime/win-arm64
copy build/win-arm64/bin/Release/whisper.dll Llama.cpp.Runtime/win-arm64/whisper.dll
