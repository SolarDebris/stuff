FROM ubuntu:20.04

RUN sudo apt-get update -y
RUN sudo apt-get install binutils-dev libunwind-dev libblocksruntime-dev clang llvm vim

RUN mkdir /root/workspace
WORKDIR /root/workspace

# Install HonggFuzz
RUN git clone https://github.com/google/honggfuzz
RUN cd honggfuzz
RUN make

# Setup Fuzzing Target Here
