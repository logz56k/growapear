# growapear
Welcome to the brattiest bootloader you never asked for. Yes, you guessed it – this thing boots your machine with all the glitter of Kesha and the attitude of Charli XCX.

It splashes a loud ASCII banner on screen and treats your PC speaker to a tiny rendition of "Grow a Pear". Earplugs not included.

## Building
Run `nasm -f bin bootloader.asm -o bootloader.bin` to conjure the boot sector.
Then launch `bootloader.bin` in your favourite emulator (`qemu-system-i386` does nicely) and revel in the brattitude.

## Flashing
Compile the flasher with `gcc flasher.c -o flasher`.
To permanently (and irresponsibly) apply this vibe to a device, run:

```
./flasher bootloader.bin /dev/sdX
```

Swap `/dev/sdX` with your target disk or image path. May your hardware forgive you.
