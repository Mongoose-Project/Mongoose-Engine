#!/bin/bash

set -e

cmake -S . -B build \
  -DCMAKE_SYSTEM_NAME=Windows \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres \
  -DCMAKE_C_FLAGS="--target=x86_64-w64-windows-gnu" \
  -DCMAKE_CXX_FLAGS="--target=x86_64-w64-windows-gnu" \
  -G Ninja

cmake --build build
