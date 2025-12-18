echo [Info] Install QEMU i NASM

echo [Create] bootloader.asm > boot.bin
nasm bootloader.asm - f bin - o boot.bin

echo [Create] kernel.asm > kernel.bin
nasm kernel.asm - f bin - o kernel.bin

echo [Create] boot.bin, kernel.bin > os.img
copy/b boot.bin+kernel.bin os.img

echo [Start]
"C:\Program Files\qemu\qemu-systeem-x86_64.exe" -format dysku=raw,file=os.img
