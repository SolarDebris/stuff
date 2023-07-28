#!/bin/bash

# This script will extract an ipsw using blacktop's ipsw tool and 
# organize it into folders. It will also open binary ninja headless
# and analyze a list of macho binaries. Will also use dyldex 
# to extract all dyld files. 


if [$# -ne 2]; then
    echo "Usage: ./extract_ipsw.sh (ipsw) (binary_file_list)"
    exit 1
fi


#mv $1 ~/vr/ios/ 
cd ~/vr/ios/

build_id=$(echo $1 | cut -d "_" -f 3)

echo "Build ID: $build_id"


# Extract ipsw into own folder
mkdir $build_id
mv $1 $build_id
cd $build_id

7z x $1
mkdir binary_db

ipsw extract -d $1

kernelcache=$(find . -name "kernelcache.release*" -type f | cut -d "/" -f 2)
ipsw kernel dec $kernelcache

dec_kernelcache="$kernelcache.decompressed"
mkdir kexts 
mv $dec_kernelcache kexts && ipsw kernel extract -a kexts/$dec_kernelcache  


dyld_folder=$(find . -name "$build_id*" -type d)

echo $dyld_folder
mv $dyld_folder dyld

ulimit -n 50000
dyldex_all "dyld/dyld_shared_cache_arm64e" 

