#!/bin/bash
# Create an empty 1.44MB floppy image
dd if=/dev/zero of=build/os.img bs=512 count=2880

# Write the bootloader to the first sector
dd if=build/boot.bin of=build/os.img conv=notrunc bs=512 count=1

# Write the kernel to the second sector
dd if=build/kernel.bin of=build/os.img conv=notrunc bs=512 seek=1
