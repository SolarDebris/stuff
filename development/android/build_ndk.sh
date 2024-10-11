#!/bin/bash

# File that downloads and makes standard toolchain for android

cd ~/build
curl https://dl.google.com/android/repository/android-ndk-r25c-linux.zip --output ndk.zip
7z x ndk.zip

python3 ~/build/android-ndk-r25c-linux/build/tools/make_standalone_toolchain.py --arch arm64 --install -dir ~/build/android_toolchain

echo "export PATH=$PATH:~/build/android_toolchain/bin" >> ~/.bashrc
