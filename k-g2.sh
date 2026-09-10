#!/bin/sh

OUT_DIR=${PWD}
READELF_BIN=aarch64-linux-gnu-readelf
PADDR_KIMG=0x40080000
VADDR_KIMG=$(grep "\<_text\>" ${OUT_DIR}/System.map | head -1 |awk '{print "0x"$1}')
VOFFSET=$(python3 -c "print(hex($VADDR_KIMG - $PADDR_KIMG))")

SEC_HEAD_TEXT=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.head\.text ' |cut -c 10- |awk '{print "0x"$3}')
SEC_INIT_TEXT=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.init\.text ' |cut -c 10- |awk '{print "0x"$3}')
SEC_INIT_DATA=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.init\.data ' |cut -c 10- |awk '{print "0x"$3}')
SEC_DATA=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.data ' |cut -c 10- |awk '{print "0x"$3}')
SEC_ALT=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.altinstructions ' |cut -c 10- |awk '{print "0x"$3}')
SEC_RODATA=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.rodata ' |cut -c 10- |awk '{print "0x"$3}')
SEC_DATA_PERCPU=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.data\.\.percpu ' |cut -c 10- |awk '{print "0x"$3}')
SEC_BSS=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep ' \.bss ' |cut -c 10- |awk '{print "0x"$3}')
SEC_TEXT=$(${READELF_BIN} -S ${OUT_DIR}/vmlinux | grep -w ' \.text ' |cut -c 10- |awk '{print "0x"$3}')


# echo "SEC_INIT_TEXT: ${SEC_INIT_TEXT}"
# echo "SEC_INIT_DATA: ${SEC_INIT_DATA}"
# echo "SEC_DATA: ${SEC_DATA}"
# echo "SEC_ALT: ${SEC_ALT}"

P_HEAD_TEXT=$(python3 -c "print(hex(${SEC_HEAD_TEXT} - ${VOFFSET}))")
P_INIT_TEXT=$(python3 -c "print(hex(${SEC_INIT_TEXT} - ${VOFFSET}))")
P_INIT_DATA=$(python3 -c "print(hex(${SEC_INIT_DATA} - ${VOFFSET}))")
P_DATA=$(python3 -c "print(hex(${SEC_DATA} - ${VOFFSET}))")
P_ALT=$(python3 -c "print(hex(${SEC_ALT} - ${VOFFSET}))")
P_RODATA=$(python3 -c "print(hex(${SEC_RODATA} - ${VOFFSET}))")
P_DATA_PERCPU=$(python3 -c "print(hex(${SEC_DATA_PERCPU} - ${VOFFSET}))")
P_BSS=$(python3 -c "print(hex(${SEC_BSS} - ${VOFFSET}))")
P_TEXT=$(python3 -c "print(hex(${SEC_TEXT} - ${VOFFSET}))")

echo "P_HEAD_TEXT: ${P_HEAD_TEXT}"
echo "P_INIT_TEXT: ${P_INIT_TEXT}"
echo "P_INIT_DATA: ${P_INIT_DATA}"
echo "P_DATA: ${P_DATA}"
echo "P_ALT: ${P_ALT}"
echo "P_RODATA: ${P_RODATA}"
echo "P_DATA_PERCPU: ${P_DATA_PERCPU}"

# -machine dumpdtb="cortex-a57.dtb" \
qemu-system-aarch64 \
	-S \
    -machine virt \
    -cpu cortex-a57 \
    -machine type=virt \
    -nographic \
    -smp 4 \
    -m 4096 \
	-kernel ${OUT_DIR}/arch/arm64/boot/Image \
    --append "console=ttyAMA0 nokaslr" \
    -s &

QEMU_PID=$!

sleep 3

echo gdb start...
aarch64-linux-gnu-gdb -ex "layout asm" \
	-ex "layout reg" \
	-ex "target remote localhost:1234" \
	-ex "add-symbol-file ${OUT_DIR}/vmlinux \
	-s .head.text ${P_HEAD_TEXT} \
	-s .init.text ${P_INIT_TEXT} \
	-s .init.data ${P_INIT_DATA} \
	-s .data ${P_DATA} \
	-s .rodata ${P_RODATA} \
	-s .data..percpu ${P_DATA_PERCPU} \
	-s .bss ${P_BSS} \
	-s .text ${P_TEXT} \
	-s .altinstructions ${P_ALT} "\
	-ex "b *${PADDR_KIMG}"
# ${OUT_DIR}/vmlinux

kill -9 ${QEMU_PID}
