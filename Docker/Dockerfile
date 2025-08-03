FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required tools
RUN apt-get update && apt-get install -y \
    clang \
    clang-format \
    cmake \
    ninja-build \
    mingw-w64 \
    zip \
    git \
    build-essential \
    lld \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Ensure build folder exists
RUN mkdir -p build