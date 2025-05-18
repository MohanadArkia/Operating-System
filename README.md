Text based operating system

nasm -f bin kernel/kernel.asm -o build/kernel.bin
./build.sh
qemu-system-i386 -fda build/os.img
