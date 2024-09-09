#!/bin/sh

KERNEL_DIRECTORY="android_kernel_"$1
mkdir -p $KERNEL_DIRECTORY

# install repo
repo init -u https://android.googlesource.com/kernel/manifest -b common-android-mainline
repo sync -c -j8

# Build kernel with bazel
tools/bazel build //common:kernel_aarch64_dist
mkdir -p dist
tools/bazel run //common:kernel_aarch64_dist -- --dist_dir=./dist
