# growapear
Kesha x Charli XCX themed bootloader with colorful visuals.
The bootloader also plays a short PC speaker rendition of
"Grow a Pear" by Kesha.

## Building
Run `nasm -f bin bootloader.asm -o bootloader.bin` to build the boot sector.
Then boot `bootloader.bin` with an emulator such as `qemu-system-i386`.

## Flashing
Compile the flashing utility with `gcc flasher.c -o flasher`.
Run `./flasher bootloader.bin /path/to/device` to write the bootloader to
a disk image or device (e.g. `/dev/sdX`).
