FROM --platform=linux/amd64 ubuntu:18.04

ENV LC_CTYPE C.UTF-8

RUN apt-get update -y
RUN apt-get install -y curl \
    gcc \
    cmake \
    make \ 
    git \
    vim \
    gdb \
    clang \ 
    llvm \
    lld \
    llvm-dev \
    libstdc++ \
    automake \
    autoconf \
    flex \
    bison \
    build-essential \
    python3 \
    python3-pip \
    ninja-build

# Install AFL++
