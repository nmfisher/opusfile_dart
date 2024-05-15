# Dart bindings for opusfile

### MacOS
```
git clone https://github.com/xiph/opus.git
cd opus
git checkout dfd4175a90a7c0fbd67799b9e3ad93611027c904
mkdir build && cd build
cmake .. -DOPUS_BUILD_PROGRAMS=OFF -DOPUS_BUILD_TESTING=OFF -DOPUS_BUILD_SHARED_LIBRARY=ON
cmake --build .
cd ..
git clone https://github.com/xiph/opusfile.git
cd opusfile
mkdir build && cd build
cmake .. -DOPUS_BUILD_PROGRAMS=OFF -DOPUS_BUILD_TESTING=OFF -DOPUS_BUILD_SHARED_LIBRARY=ON
cmake --build .
```

### iOS

Set OPUSFILE_DART_DIR to the path of the opusfile_dart root directory.

ogg
```
git clone https://github.com/xiph/ogg.git
cd ogg
mkdir build_ios && cd build_ios
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=$OPUSFILE_DART_DIR/native/ios.toolchain.cmake  -DPLATFORM=OS64
cmake --build . --config Release
cp Release-iphoneos/libogg.a $OPUSFILE_DART_DIR/native/lib/ios 
cd ..
mkdir build_android && cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=/Users/nickfisher/Library/Android/sdk/ndk/23.1.7779620/build/cmake/android.toolchain.cmake -DOP_DISABLE_HTTP=1 -DOPUS_BUILD_PROGRAMS=OFF -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=30  .. && cmake --build .
cp libogg.a ${OPUSFILE_DART_DIR}/native/lib/android 
```

opus
```
git clone https://github.com/xiph/opus.git
cd opus
git checkout dfd4175a90a7c0fbd67799b9e3ad93611027c904
mkdir build_ios && cd build_ios
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=$OPUSFILE_DART_DIR/native/ios.toolchain.cmake   -DOPUS_BUILD_PROGRAMS=OFF -DPLATFORM=OS64
cmake --build .
cd ..
mkdir build_android && cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=/Users/nickfisher/Library/Android/sdk/ndk/23.1.7779620/build/cmake/android.toolchain.cmake -DOP_DISABLE_HTTP=1 -DOPUS_BUILD_PROGRAMS=OFF -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=30  .. && cmake --build .
cp libopus.a ${OPUSFILE_DART_DIR}/native/lib/android 

```

opusfile
```
git clone https://github.com/xiph/opusfile.git
cd opusfile
mkdir build_ios && cd build_ios
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=/Users/nickfisher/Documents/polyvox/flutter/opusfile_dart/native/ios.toolchain.cmake  -DPLATFORM=OS64 -DOP_DISABLE_EXAMPLES=ON
cmake --build . --config Release
cp Release-iphoneos/libopusfile.a ${OPUSFILE_DART_DIR}/native/lib/ios 
cd ..
mkdir build_android && cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=/Users/nickfisher/Library/Android/sdk/ndk/23.1.7779620/build/cmake/android.toolchain.cmake -DOP_DISABLE_HTTP=1 -DOPUS_BUILD_PROGRAMS=OFF -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=30  .. && cmake --build .
cp libopusfile.a ${OPUSFILE_DART_DIR}/native/lib/android 
```

