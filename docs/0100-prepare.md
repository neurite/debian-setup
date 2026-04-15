## Preparation

### Bootable USB Flash Drive

1. Download [the latest, stable image file](http://www.debian.org/CD/http-ftp/#stable). Only the ISO file is needed. If there are multiple ISO files, only the first ISO is needed for installation with internet connection.
2. Write the downloaded image to a USB flash drive. It is important the USB drive is _not_ mounted. Run `lsblk` or `diskutil list` to make sure the drive is not mounted. If there is a mount point, `umount` or `diskutil unmount` the drive first. Note: Replace `/dev/sdx` or `/dev/diskx` in the commands with the USB drive you want to write the image to. **Double check the device letter or number is correct**.
    1. Linux
        1. `lsblk`
        2. `umount /dev/sdx`, unmount the USB drive
        3. `sudo dd if=/path/to/iso of=/dev/sdx bs=4096`, this step can take 10~30 min
        4. `eject /dev/sdx`
    2. Mac
        1. `diskutil list`
        2. `diskutil unmountDisk /dev/diskx`, unmount the USB drive
        3. `sudo dd if=/path/to/iso of=/dev/diskx bs=4096`, this step can take 10~30 min
        4. `diskutil eject /dev/diskx`

### Firmware

**For Debian 11 (Bullseye) and older only**. As of Debian 12 (Bookworm), firmware is included in the normal Debian installer images.

The type of hardware that needs firmware during installation includes wireless network cards. Debian has a [firmware wiki](https://wiki.debian.org/Firmware) with detailed instructions. You can [download](http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/) and unpack the non-free firmware into a `firmware` folder under the root on a storage device such as a separate USB flash drive. The installer automatically finds and installs the required firmware.

### UEFI

In the motherboard BIOS, **CSM (or BIOS legacy mode) should be disabled in UEFI** to guarantee that it always boots into UEFI. One reason for the need of UEFI is the GPT partitioning scheme. If not sure if UEFI is engaged, the Debian bootable image, onced loaded, should display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard. For more information about UEFI, check [the Debian wiki](https://wiki.debian.org/UEFI). 


**Next step: [Installation](0200-install.md)**
