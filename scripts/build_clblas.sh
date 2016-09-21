#!/usr/bin/env sh
set -e

if [ -z "$NDK_ROOT" ] && [ "$#" -eq 0 ]; then
    echo 'Either $NDK_ROOT should be set or provided as argument'
    echo "e.g., 'export NDK_ROOT=/path/to/ndk' or"
    echo "      '${0} /path/to/ndk'"exit 1
else
    NDK_ROOT="${1:-${NDK_ROOT}}"
fi

ANDROID_ABI=${ANDROID_ABI:-"x86"}
WD=$(readlink -f "`dirname $0`/..")
CLBLAS_ROOT=${WD}/clBLAS
OPENCL_DIR=${WD}/opencl/intel_CHT/
BUILD_DIR=${CLBLAS_ROOT}/build
ANDROID_LIB_ROOT=${WD}/android_lib
INSTALL_DIR=${WD}/android_lib
NDK_PY=${NDK_ROOT}/prebuilt/linux-x86_64
N_JOBS=${N_JOBS:-4}

cd "${CLBLAS_ROOT}"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

cmake -DCMAKE_TOOLCHAIN_FILE="${WD}/android-cmake/android.toolchain.cmake" \
      -DANDROID_NDK="${NDK_ROOT}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DANDROID_ABI="${ANDROID_ABI}" \
      -DANDROID_NATIVE_API_LEVEL=19 \
      -DADDITIONAL_FIND_PATH="${ANDROID_LIB_ROOT}" \
      -DPYTHON_EXECUTABLE="${NDK_PY}/bin/python" \
      -DOPENCL_INCLUDE_DIRS="${OPENCL_DIR}/include" \
      -DOPENCL_LIBRARIES="${OPENCL_DIR}/libOpenCL.so" \
      -DBUILD_TEST=OFF \
      -DBUILD_SAMPLE=ON \
      -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/clblas" \
      ../src

make -j${N_JOBS}
rm -rf "$INSTALL_DIR/clblas"
make install

cd "${WD}"
rm -rf "${BUILD_DIR}"
