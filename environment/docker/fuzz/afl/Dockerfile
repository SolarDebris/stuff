FROM ubuntu:20.04

RUN sudo apt-get update
sudo apt-get install -y build-essential python3-dev automake cmake vim git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev
# try to install llvm 14 and install the distro default if that fails
sudo apt-get install -y lld-14 llvm-14 llvm-14-dev clang-14 || sudo apt-get install -y lld llvm llvm-dev clang
sudo apt-get install -y gcc-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-plugin-dev libstdc++-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-dev
sudo apt-get install -y ninja-build # for QEMU mode

# Install AFL++

RUN mkdir /root/workspace
WORKDIR /root/workspace

RUN git clone https://github.com/AFLplusplus/AFLplusplus
WORKDIR /root/workspace/AFLplusplus
RUN make distrib
RUN sudo make install

# Insert setup for fuzzing target here
WORKDIR /root/workspace
