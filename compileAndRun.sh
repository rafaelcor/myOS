#!/bin/sh

fasm $1 $1.bin
qemu-system-x86_64 $1.bin
