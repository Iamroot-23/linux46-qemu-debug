#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

BUILD_LOG="${PWD}/kbuild_log.txt"

cd ${PWD}

if [ -f .config ]; then
	echo "make oldconfig"
	make oldconfig
else
	echo "make defconfig"
	make defconfig
fi

echo "kernel build"
make -j$(( $(nproc) - 4 )) 2>&1 | tee $BUILD_LOG
# make Image modules dtbs -j$(( $(nproc) - 4 )) 2>&1 | tee $BUILD_LOG
