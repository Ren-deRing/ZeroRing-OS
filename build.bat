@echo off
nasm -f bin boot.asm -o boot.bin
nasm -f bin kernel.asm -o kernel.bin

copy /b boot.bin + kernel.bin disk.img