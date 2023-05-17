BUILD_TYPE=Release
VERSION=1.0.2
BUILD_SHARED_LIBS=true
NDK :=
ifeq ($(strip $(NDK_PATH)),)
    ifeq ($(shell test -d $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle && echo -n yes),yes)
        NDK := $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle
    else
        $(error NDK_PATH not defined and NDK not found at default location on Mac.)
    endif
else
    NDK := $(strip $(NDK_PATH))
endif

CMAKE_COMMANDS=-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) 
ifeq ($(BUILD_SHARED_LIBS), true)
	CMAKE_COMMANDS+=-DBUILD_SHARED_LIBS=ON
else
	CMAKE_COMMANDS+=-DBUILD_SHARED_LIBS=OFF
endif

nuget:
	mkdir -p nupkgs
	nuget pack Llama.cpp.Runtime.nuspec -Version $(VERSION) -OutputDirectory ./nupkgs

clean:
	rm -rf nupkgs
	rm -rf build
	rm -rf runtimes

android: android_x86 android_x64 android_arm64-v8a

apple: macos ios ios_64 maccatalyst_x64 maccatalyst_arm64 ios_simulator_x64 ios_simulator_arm64 tvos_simulator_x64 tvos_simulator_arm64 tvos lipo

linux: linux_x64 linux_arm64

linux_x64:
	rm -rf build/linux-x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-x64-musl.cmake -S . -B build/linux-x64
	cmake --build build/linux-x64 --config $(BUILD_TYPE)
	mkdir -p Llama.cpp.Runtime/linux-x64
	cp build/linux-x64/llama.cpp/libllama.so Llama.cpp.Runtime/linux-x64/libllama.so

linux_arm64:
	rm -rf build/linux-arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-arm64-musl.cmake -S . -B build/linux-arm64
	cmake --build build/linux-arm64 --config $(BUILD_TYPE)
	mkdir -p Llama.cpp.Runtime/linux-arm64
	cp build/linux-arm64/llama.cpp/libllama.so Llama.cpp.Runtime/linux-arm64/libllama.so

macos:
	rm -rf build/macos
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=MAC_UNIVERSAL -S . -B build/macos
	cmake --build build/macos
	mkdir -p runtimes/macos
	cp build/macos/llama.cpp/libllama.dylib runtimes/macos/libllama.dylib

ios:
	rm -rf build/ios
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=OS -S . -B build/ios
	cmake --build build/ios
	mkdir -p runtimes/ios
	cp build/ios/llama.cpp/libllama.dylib runtimes/ios/libllama.dylib

ios_64:
	rm -rf build/ios_64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=OS64 -S . -B build/ios_64
	cmake --build build/ios_64
	mkdir -p runtimes/ios_64
	cp build/ios_64/llama.cpp/libllama.dylib runtimes/ios_64/libllama.dylib

maccatalyst_x64:
	rm -rf build/maccatalyst_x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=MAC_CATALYST -S . -B build/maccatalyst_x64
	cmake --build build/maccatalyst_x64
	mkdir -p runtimes/maccatalyst_x64
	cp build/maccatalyst_x64/llama.cpp/libllama.dylib runtimes/maccatalyst_x64/libllama.dylib

maccatalyst_arm64:
	rm -rf build/maccatalyst_arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=MAC_CATALYST_ARM64 -S . -B build/maccatalyst_arm64
	cmake --build build/maccatalyst_arm64
	mkdir -p runtimes/maccatalyst_arm64
	cp build/maccatalyst_arm64/llama.cpp/libllama.dylib runtimes/maccatalyst_arm64/libllama.dylib

ios_simulator_x64:
	rm -rf build/ios_simulator_x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -S . -B build/ios_simulator_x64
	cmake --build build/ios_simulator_x64
	mkdir -p runtimes/ios_simulator_x64
	cp build/ios_simulator_x64/llama.cpp/libllama.dylib runtimes/ios_simulator_x64/libllama.dylib

ios_simulator_arm64:
	rm -rf build/ios_simulator_arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=SIMULATORARM64 -S . -B build/ios_simulator_arm64
	cmake --build build/ios_simulator_arm64
	mkdir -p runtimes/ios_simulator_arm64
	cp build/ios_simulator_arm64/llama.cpp/libllama.dylib runtimes/ios_simulator_arm64/libllama.dylib

tvos_simulator_x64:
	rm -rf build/tvos_simulator_x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=SIMULATOR_TVOS -S . -B build/tvos_simulator_x64
	cmake --build build/tvos_simulator_x64
	mkdir -p runtimes/tvos_simulator_x64
	cp build/tvos_simulator_x64/llama.cpp/libllama.dylib runtimes/tvos_simulator_x64/libllama.dylib

tvos_simulator_arm64:
	rm -rf build/tvos_simulator_arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=SIMULATOR_TVOSARM64 -S . -B build/tvos_simulator_arm64
	cmake --build build/tvos_simulator_arm64
	mkdir -p runtimes/tvos_simulator_arm64
	cp build/tvos_simulator_arm64/llama.cpp/libllama.dylib runtimes/tvos_simulator_arm64/libllama.dylib

tvos:
	rm -rf build/tvos
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake -DPLATFORM=TVOS -S . -B build/tvos
	cmake --build build/tvos
	mkdir -p runtimes/tvos
	cp build/tvos/llama.cpp/libllama.dylib runtimes/tvos/libllama.dylib

lipo:
	mkdir -p Llama.cpp.Runtime/tvos-simulator
	lipo -create runtimes/tvos_simulator_arm64/libllama.dylib -create runtimes/tvos_simulator_x64/libllama.dylib -output Llama.cpp.Runtime/tvos-simulator/libllama.dylib
	mkdir -p Llama.cpp.Runtime/ios-simulator
	lipo -create runtimes/ios_simulator_arm64/libllama.dylib -create runtimes/ios_simulator_x64/libllama.dylib -output Llama.cpp.Runtime/ios-simulator/libllama.dylib
	mkdir -p Llama.cpp.Runtime/ios-device
	cp runtimes/ios/libllama.dylib Llama.cpp.Runtime/ios-device/libllama.dylib
	mkdir -p Llama.cpp.Runtime/maccatalyst
	lipo -create runtimes/maccatalyst_x64/libllama.dylib -create runtimes/maccatalyst_arm64/libllama.dylib -output Llama.cpp.Runtime/maccatalyst/libllama.dylib
	mkdir -p Llama.cpp.Runtime/tvos-device
	cp runtimes/tvos/libllama.dylib Llama.cpp.Runtime/tvos-device/libllama.dylib
	mkdir -p Llama.cpp.Runtime/macos
	cp runtimes/macos/libllama.dylib Llama.cpp.Runtime/macos/libllama.dylib

android_arm64-v8a:
	rm -rf build/android-arm64-v8a
	cmake -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-arm64-v8a
	cmake --build build/android-arm64-v8a
	mkdir -p Llama.cpp.Runtime/android-arm64-v8a
	cp build/android-arm64-v8a/llama.cpp/libllama.so Llama.cpp.Runtime/android-arm64-v8a/libllama.so

android_x86:
	rm -rf build/android-x86
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86
	cmake --build build/android-x86
	mkdir -p Llama.cpp.Runtime/android-x86
	cp build/android-x86/llama.cpp/libllama.so Llama.cpp.Runtime/android-x86/libllama.so

android_x64:
	rm -rf build/android-x86_64
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86_64 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86_64
	cmake --build build/android-x86_64
	mkdir -p Llama.cpp.Runtime/android-x86_64
	cp build/android-x86_64/llama.cpp/libllama.so Llama.cpp.Runtime/android-x86_64/libllama.so

xcframework:
	mkdir -p output/lib
	xcrun xcodebuild -create-xcframework -library Llama.cpp.Runtime/ios-device/libllama.dylib -library Llama.cpp.Runtime/ios-simulator/libllama.dylib -library Llama.cpp.Runtime/tvos-device/libllama.dylib -library Llama.cpp.Runtime/tvos-simulator/libllama.dylib -library Llama.cpp.Runtime/macos/libllama.dylib -library Llama.cpp.Runtime/maccatalyst/libllama.dylib -output output/lib/llama.xcframework