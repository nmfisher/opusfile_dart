# Dart bindings for opusfile

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


