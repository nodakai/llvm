#!/bin/sh

set -e

find release -name CMakeCache.txt -print | xargs rm -f

mkdir release
cd release
cmake -G Ninja -D CMAKE_BUILD_TYPE=Release \
               -D LIBCXX_CXX_ABI_LIBNAME=libstd++ \
               -D LIBCXX_CXX_ABI_INCLUDE_PATHS="/usr/include/c++/7;/usr/include/x86_64-linux-gnu/c++/7" \
               -D LLVM_ENABLE_RTTI=true \
   ..
ninja
