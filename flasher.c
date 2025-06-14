#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s bootloader.bin /dev/sdX\n", argv[0]);
        return 1;
    }

    const char *boot_path = argv[1];
    const char *dev_path = argv[2];

    FILE *boot = fopen(boot_path, "rb");
    if (!boot) {
        perror("fopen bootloader");
        return 1;
    }

    FILE *dev = fopen(dev_path, "r+b");
    if (!dev) {
        perror("fopen device");
        fclose(boot);
        return 1;
    }

    uint8_t buffer[512];
    size_t read_bytes = fread(buffer, 1, sizeof(buffer), boot);
    if (read_bytes != sizeof(buffer)) {
        fprintf(stderr, "Bootloader must be exactly 512 bytes\n");
        fclose(boot);
        fclose(dev);
        return 1;
    }

    if (fseek(dev, 0, SEEK_SET) != 0) {
        perror("fseek");
        fclose(boot);
        fclose(dev);
        return 1;
    }

    size_t written = fwrite(buffer, 1, sizeof(buffer), dev);
    if (written != sizeof(buffer)) {
        perror("fwrite");
        fclose(boot);
        fclose(dev);
        return 1;
    }

    fflush(dev);
    fclose(boot);
    fclose(dev);

    printf("Flashed bootloader to %s\n", dev_path);
    return 0;
}
