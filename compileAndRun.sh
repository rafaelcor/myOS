#!/bin/sh

fasm boot.asm boot.bin
fasm kernel.asm kernel.bin
dd if=/dev/zero of=OS.img bs=512 count=65
dd if=boot.bin of=OS.img bs=512 count=1 conv=notrunc
dd if=kernel.bin of=OS.img bs=512 conv=notrunc seek=1
qemu-system-x86_64 OS.img -d in_asm,exec -D log

rm boot.bin
rm kernel.bin
