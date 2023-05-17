@echo off

set BUILD_TYPE=Release

:windows_x64
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -S . -B build\win-x64 -A x64
cmake --build build\win-x64 --config %BUILD_TYPE%
mkdir Llama.cpp.Runtime/win-x64
copy build/win-x64/bin/Release/llama.dll Llama.cpp.Runtime/win-x64/libllama.dll