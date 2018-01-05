## Introduction

So why expert, manual install?

The main reason is the manual disk partitions with the aim for data security, safety, and performance. A typical setup of one SSD disk and one spinning disk is listed with partition details. There is also short note of software RAID and how to keep data across system installs.

To a lesser extent, this step paves way for adding a minimal desktop on top. There are separates notes for [[Minimal LXDE]] or a [[Minimal GNOME]].

## Preparation

1. Download [the latest, stable image file](http://www.debian.org/CD/http-ftp/#stable). Only the first ISO is needed for installation with internet connection. Or, if you have a fast internet connection, download the much smaller [network install image](https://www.debian.org/distrib/netinst).
2. Write the image to a USB drive.
    1. Make sure the drive is _not_ mounted. Run `lsblk` and make sure there is no mount point for the device. Otherwise, `umount` the drive first. For example, `umount /media/usb0`, where `/media/usb0` is the mount point of the USB drive.
    2. Write the image `dd if=/path/to/iso of=/dev/sdx bs=4096`. `/dev/sdx` is the USB drive where `x` can be any letter. **Double check you are writing to the correct drive**.
    3. When done (may take > 30 min), `eject /dev/sdx`.
    4. On Mac OS X, the command to list block devices is `diskutil list`, the mounted volumes are in `/Volumes`, and the command to unmount is `diskutil unmountDisk`. To eject, `diskutil eject`.
3. Some of the non-free firmware may be needed during installation. Debian has a [firmware wiki](https://wiki.debian.org/Firmware) with detailed instructions. You can [download](http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/) and unpack the non-free firmware in a `firmware` folder on a separate USB drive.

## Installation

1. On the motherboard setup, make sure **CSM (or BIOS legacy mode) is disabled in UEFI**. This is to guarantee it boots into the UEFI mode.
2. Boot to the USB disk. The screen should display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard.
3. `Advanced options ...`, then `Expert install`
    * Note, **do not hit Enter yet**, if you want to set up [Serial ATA RAID](https://wiki.debian.org/DebianInstaller/SataRaid).
    * I _used to_ have SATA RAID. But this feature does not seem to be well supported. I have since switched to software RAID.
4. `Choose language`, locale `en_US.UTF-8`
5. `Configure the keyboard`: `American English`
6. `Detect and mount CD-ROM`. This should recognize the USB drive with the Debian ISO as the CD-ROM.
7. `Load installer components from CD`: Choose none.
8. `Detect network hardware`
9. `Configure the network`. Auto-configure `yes` as we are using DHCP. Specify the host name. Leave the domain name empty.
10. `Set up users and passwords`
    * `Enable shadow passwords`: `Yes`
    * `Allow login as root`: `No`
11. `Configure the clock`
    * `Set the clock using NTP`: `Yes`
12. `Detect disks`
13. `Partition disks`. Partitioning method: `Manual`.
    * I use a combination of one SSD and one spinning drive. Please see the tables below for an example of the partitions.
    * Note that, if you have set up RAID in the BIOS and have correctly edited the command `Expert install`, the RAID should appear here as a single disk. Partition it as if it is a single disk.
    * If you prefer software RAID, there is an option here `Configure software RAID`. Once set, the RAID will appear as a single disk.
    * If you have a previously set software RAID, as the RAID configuration is written on the disks, it should show up here as a single device. For example, mine shows up as `RAID10 device #0`. You do NOT need to re-configure it.
    * You can keep the data already on the RAID disk. Here is how: Select the partition (not the disk) on the RAID disk. Flip `Use as: do not use` to `Use as: Ext4 journaling file system` and `Format the partition: no, keep existing data`. Set up the mount point and mounting options (see the table below).
14. Set up the partitions
    1. Select the disk to create an empty partition table.
    2. Partition table type: **gpt**.
    3. Select the free space to set up the following partitions.

    | Drive               | Mount Point | Type | Size   | Mount Options                    | Other     |
    |---------------------|-------------|------|--------|----------------------------------|-----------|
    | sda (256 GB SSD)    |             | EFI  | 256 MB |                                  | Bootable  |
    |                     | /           | EXT4 | 90 GB  | discard, relatime                |           |
    |                     | /usr/local  | EXT4 | 30 GB  | discard, relatime, nodev         |           |
    |                     | /opt        | EXT4 | 30 GB  | discard, relatime, nodev         |           | 
    |                     | /home       | EXT4 | 100 GB | discard, relatime, nodev, nosuid |           |
    | sdb (1 TB spinning) |             | SWAP | 64 GB  |                                  |           |
    |                     | /var        | EXT4 | 128 GB | relatime, nodev, nosuid          |           |
    |                     | /tmp        | EXT4 | 128 GB | relatime, nodev, nosuid, noexec  |           |
    |                     | /stash      | EXT4 | 512 GB | relatime, nodev, nosuid, noexec  |           |
    | RAID10              | /samba      | EXT4 | 4 TB   | relatime, nodev, nosuid, noexec  | largefile |
    
    4. Installing over existing partitions
        * If we are installing over an existing system, it will show the existing partition as `do not use`.
        * Flip `do not use` to the correct file system (e.g. `ext4`), an option will show up `Format the partition`.
        * You can choose to either `yes, format it` or `no, keep existing data` depending on the planned use of the partition.
        * Even if we keep the existing data, we still need to mount the partition and set the mount options (see the above table).
        * The exception is the swap partition. It is already marked as `F` (format it) and nothing needs to be done for it.
        * The notes here also applies to RAID (both SATA-RAID and software RAID).
15. `Install the base system`
    * kernel: `linux-image-amd-64` (this installs the same version but free to upgrade to newer kernel versions)
    * initrd (initial ram disk): `generic (all available drivers)`
16. `Configure the package manager`
    * User network mirror: Yes
    * Protocol: https
    * Country: US
    * Mirror: (choose a good one that is near to you, e.g. `mirrors.ocf.berkeley.edu`)
    * Use non-free software: Yes (which implies also using contrib software and can skip the next one), if you need to install NVIDIA packages for example
    * Use contrib software: Yes
    * Enable source repositories in APT: Yes, to use the `/etc/apt/sources.list` file
    * Services to use: `security updates`, `release updates`, and also check `backported software`
17. `Select and install software`
    * Package usage survey: No
    * Should man and mandb be installed 'setuid man': No
    * Choose only `standard system utilities`, which includes bzip2, dpkg, perl, python, openssl, etc.
    * If you want to install a minimal desktop, make sure do not select any desktop environment. We will install a [[Minimal LXDE]] or a [[Minimal GNOME]] at a later stage.
18. `Install the GRUB boot loader`
    * Force GRUB installation to the EFI removable media path: yes
19. Finish and reboot
    * Set the system clock to UTC: Yes
    * Reboot

## Post-Installation

1. Nvidia problem
    1. Symptom: Boot hangs on normal startup.
    2. Reboot the system using the USB disk. On the Debian boot screen, choose `Advanced Options` --> `Recovery Mode`. The last output on the screen is "fb: switching to nouveaufb from simple" indicating a problem with nouveau.
    3. Reboot the system from the USB disk. `Advanced options ...` --> `Rescue mode`.
    4. After the quick setup in the rescue mode, choose the root file system `/dev/sda2` (the partition that is mounted as `/`). Execute a shell there as the root.
    5. Move `/etc/modprobe.conf` to backup, if present.
    6. `vi /etc/modprobe.d/nouveau.conf` and add the following 2 lines:
    
    ```bash
    blacklist nouveau
    blacklist lbm-nouveau
    ```
    
    7. Exit and reboot from the hard disk.
2. Package sources `sudo vi /etc/apt/sources.list`
    1. Since we are not using iso images any more for updates, comment out the line that starts with `deb cdrom:[Debian GNU/Linux ...`.
    2. Upgrade kernel via backports (optional)
        1. `sudo apt-get update`.
        2. `sudo apt-get -t stretch-backports dist-upgrade`. Note this command should upgrade a package `linux-image-(blah, blah)-amd64` which is the kernel.
3. Disable single-user mode
    1. Edit `/etc/default/grub`
    2. Uncomment the line `GRUB_DISABLE_RECOVERY="true"`
    3. `sudo update-grub`
4. Tune SSD (optional)
    * I/O scheduler (optional, especially the hard disk letter sequence `sdx` is not 100% reliable)
        1. `cat /sys/block/sda/queue/scheduler` should show `CFQ` as the scheduler
        2. `sudo vi /etc/rc.local` and add this line `echo noop > /sys/block/sda/queue/scheduler`
    * swappiness (only if we are swapping on the SSD; even better set up swap on a spinning disk)
        1. `cat /proc/sys/vm/swappiness` should show the default value of 60
        2. `cat /proc/sys/vm/vfs_cache_pressure` should show the default value of 100
        3. Edit `/etc/sysctl.conf` and set `vm.swappiness=30` and `vm.vfs_cache_pressure=50`

## Partitioning Notes

1. Useful information online
    * [Partitioning - Arch Linux Wiki](https://wiki.archlinux.org/index.php/Partitioning)
    * [The importance of Linux partitions](http://www.cyberciti.biz/tips/the-importance-of-linux-partitions.html)
    * [Partitioning Your Hard Drive](http://www.skorks.com/2009/08/partitioning-your-hard-drive-during-a-linux-install/)
    * [Recommended Partitioning Scheme - fedora 19](https://docs.fedoraproject.org/en-US/Fedora/19/html/Installation_Guide/s2-diskpartrecommend-x86.html)
    * [Recommended Partitioning Scheme - fedora 25](https://docs.fedoraproject.org/en-US/Fedora/25/html/Installation_Guide/sect-installation-gui-manual-partitioning-recommended.html)
2. What should NOT be on separate partitions
    * The root `/` has `/bin`, `/etc`, `/lib` and they should be kept on the same partition.
    * Also avoid mounting `/usr` on a separate partition. Nowadays, the `/usr` directory has most of the system installed binaries, kernel source tree (e.g. Arch Build Tree), documentations.
3. Recommended partitions
    * `/usr/local` installs packages, built by the user (via `make install`), outside the system's package manager.
    * `/opt` installs self-contained packages.
    * `/var` package cache (note that packages may be executed here, so do not set the `no exec` flag), spool (for mail, printing), logs.
4. Useful commands
    * `fdisk -l` or `gdisk -l` to list partitions.
    * `mkfs` to build a Linux file system on a hard disk partition.
    * `lsblk` to list block devices. It reads the `sysfs` file to gather the information.
    * `less /etc/fstab` to view the file system tabs.

## SSD Notes

1. https://wiki.archlinux.org/index.php/Solid_State_Drives
2. http://apcmag.com/how-to-maximise-ssd-performance-with-linux.htm
