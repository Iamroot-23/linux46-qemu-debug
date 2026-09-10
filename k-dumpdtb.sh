#!/bin/sh

FMT=$(date '+%y%m%d%H%M%S')
qemu-system-aarch64 \
    -machine virt,gic_version=3 \
    -machine virtualization=true \
    -cpu cortex-a72 -machine type=virt \
    -smp 4 -m 4096 -display none \
    -machine dumpdtb=virt-gicv3-${FMT}.dtb

rm -f virt-gicv3.dtb
dtc -I dtb -O dts -f virt-gicv3-${FMT}.dtb -o virt-gicv3-${FMT}.dts
