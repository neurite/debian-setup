## Preparation

### Bootable USB Drive

1. Download [the latest, stable image file](http://www.debian.org/CD/http-ftp/#stable). Only the first ISO is needed for installation with internet connection.
2. Write the image to a USB drive. Using `/dev/sdx` and `/dev/diskx` below as an example. **Double check that `/dev/sdx` or `/dev/diskx` is the USB drive you want to write the image to**.
    1. Linux
        1. `lsblk`
        2. `umount /dev/sdx` or `umount /media/usbx`, unmount device or directory
        3. `sudo dd if=/path/to/iso of=/dev/sdx bs=4096`, this step can take 10~30 min
        4. `eject /dev/sdx`
    2. Mac
        1. `diskutil list`
        2. `diskutil unmountDisk /dev/diskx`, unmount device or directory
        3. `sudo dd if=/path/to/iso of=/dev/diskx bs=4096`, this step can take 10~30 min
        4. `diskutil eject`

It is important the drive is _not_ mounted. Run `lsblk` or `diskutil list` to make sure there is no mount point for the device. If there is a mount point, `umount` the drive first.

### Firmware

Some of the non-free firmware may be needed during installation. The type of hardware that needs firmware during installation includes wireless network cards. Debian has a [firmware wiki](https://wiki.debian.org/Firmware) with detailed instructions. You can [download](http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/) and unpack the non-free firmware in a `firmware` folder on a separate USB drive. This USB drive may be needed during the installing process.

### UEFI

In the motherboard BIOS, make sure **CSM (or BIOS legacy mode) is disabled in UEFI**, to guarantee it always boots into UEFI. One reason for the need of UEFI is the GPT partitioning scheme. If not sure if UEFI is engaged, the Debian bootable image, onced loaded, should display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard. For more information about UEFI, check [the Debian wiki](https://wiki.debian.org/UEFI). 
