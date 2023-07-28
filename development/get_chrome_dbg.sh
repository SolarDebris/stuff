#!/bin/bash
# This script will download the specfic version of chromium and git checkout the exact commit, then it will build it

# Check if depot tools is installed 
# If not install

cd ~/build/
mkdir ~/build/chrome_tools
cd ~/build/chrome_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

gclient 

cd ~/src/
mkdir v8
fetch v8 
cd v8 
./build/install-build-deps.sh

# Prompt for checkout version
git checkout $checkout 
git apply $patch
gclient sync

cd ./build/v8
gn gen out/release --args='is_debug=false target_cpu="x64" v8_enable_sandbox=true v8_expose_memory_corruption_api=true'
autoninja -C out/release d8
