#!/bin/bash
# This script will make a C++ binja plugin from the binaryninja
# api guide.


mkdir $1
cd $1
git clone https://github.com/Vector35/binaryninja-api
git submodule update --init --recursive
cmake -S . -B build # (additional arguments go here if needed)
cmake --build build -j8
