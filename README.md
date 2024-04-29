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
mkdir build && cd build
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=$OPUSFILE_DART_DIR/native/ios.toolchain.cmake  -DPLATFORM=OS64
cmake --build . --config Release
cp Release-iphoneos/libopus.a $OPUSFILE_DART_DIR/native/lib/ios 
```

opus
```
git clone https://github.com/xiph/opus.git
cd opus
git checkout dfd4175a90a7c0fbd67799b9e3ad93611027c904
mkdir build && cd build
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=$OPUSFILE_DART_DIR/native/ios.toolchain.cmake   -DOPUS_BUILD_PROGRAMS=OFF -DPLATFORM=OS64
cmake --build .

```

opusfile
```
git clone https://github.com/xiph/opusfile.git
cd opusfile
mkdir build && cd build
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=/Users/nickfisher/Documents/polyvox/flutter/opusfile_dart/native/ios.toolchain.cmake  -DPLATFORM=OS64 -DOP_DISABLE_EXAMPLES=ON
cmake --build . --config Release
cp Release-iphoneos/libopusfile.a ~/Documents/polyvox/flutter/opusfile_dart/native/lib/ios 
```

