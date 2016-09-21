Caffe-Android-Lib
===============
## Goal
* Porting [caffe](https://github.com/BVLC/caffe) to android platform
* Porting ML-related libraries, eg. clBLAS, to android platform

### Support
* Up-to-date caffe ([d91572d](https://github.com/BVLC/caffe/commit/d91572da2ea5e63c9eaacaf013dfbcbc0ada5f67))
* CPU only for caffe
* Without support for some IO libs (leveldb and hdf5)

## Build
Tested with Android NDK r11c/r12b and cmake 3.2.2/3.3.2 on Ubuntu 14.04

```shell
git clone --recursive https://github.com/Davidleeh/caffe-android-lib.git
cd caffe-android-lib
export ANDROID_ABI="x86" # Optional, see the note below
./build.sh <path/to/ndk>
```

### NOTE: BLAS Supports
- clBLAS
  - clBLAS is a supported BLAS choice now for android platform. It uses OpenCL backend.

- OpenBLAS
  - OpenBLAS is also a supported BLAS choice, and the supported ABIs are the following:
    - `armeabi`
    - `armeabi-v7a-hard-softfp with NEON`
    - `arm64-v8a` 
    - `x86` (default)
    - `x86_64`

## Issues

Any comments, issues or PRs are welcomed.
Thanks.

## TODO
- [ ] integrate using CMake's ExternalProject
- [ ] add IO dependency support (i.e., leveldb and hdf5)
- [ ] OpenCL support
- [ ] CUDA suuport

## Optional
`.envrc` files are for [direnv](http://direnv.net/)
> direnv is an environment variable manager for your shell. It knows how to hook into bash, zsh and fish shell to load or unload environment variables depending on your current directory. This allows to have project-specific environment variables and not clutter the "~/.profile" file.
