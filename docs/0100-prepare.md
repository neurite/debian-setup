### Bootable USB drive

1. Download [the latest, stable image file](http://www.debian.org/CD/http-ftp/#stable). Only the first ISO is needed for installation with internet connection. Or, if you have a fast internet connection, download the much smaller [network install image](https://www.debian.org/distrib/netinst).
2. Write the image to a USB drive.
    1. Make sure the drive is _not_ mounted. Run `lsblk` and make sure there is no mount point for the device. Otherwise, `umount` the drive first. For example, `umount /media/usb0`, where `/media/usb0` is the mount point of the USB drive.
    2. Write the image `dd if=/path/to/iso of=/dev/sdx bs=4096` where `/dev/sdx` is the USB drive. The `x` in `/dev/sdx` can be any letter; **double check you are writing to the correct drive**.
    3. When done (may take > 30 min), `eject /dev/sdx`.
    4. On Mac OS X, the command to list block devices is `diskutil list`, the mounted volumes are in `/Volumes`, and the command to unmount is `diskutil unmountDisk`. To eject, `diskutil eject`.
3. Some of the non-free firmware may be needed during installation. The type of hardware that needs firmware during installation includes wireless network cards. Debian has a [firmware wiki](https://wiki.debian.org/Firmware) with detailed instructions. You can [download](http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/) and unpack the non-free firmware in a `firmware` folder on a separate USB drive. This USB drive may be needed during the installing process.

### UEFI

In the motherboard BIOS, make sure **CSM (or BIOS legacy mode) is disabled in UEFI**, to guarantee it always boots into UEFI. One reason for UEFI is the GPT partitioning scheme. If not sure if UEFI is engaged, the Debian bootable image, onced loaded, will display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard. More information about UEFI in [the Debian wiki](https://wiki.debian.org/UEFI). 
