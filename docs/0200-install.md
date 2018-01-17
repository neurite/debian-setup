### Why

So why expert, manual install?

Choosing "Expert install" gives us the option of manual disk partitions. When there is only one disk, the simplest configuration is one partition over the entire disk. This however is not ideal as data of `/`, `/home`, `/var`, `/tmp`, swap have different profiles and require different security measures. Splitting them into different partitions and setting different mounting options solve the problems.

My rig is hybrid with one SSD hosting the system binaries, one spinning disk for swap and temporary data, and one RAID10 for backup data. Manual partitions make efficient use of the different disks.

The second reason is about installing a customized, lightweight desktop. Like disk partitions, expert install gives the option for not installing the default desktop, which paves way for adding a customized desktop later on. For example, [a GNOME desktop reduced to the core](0501-gnome.md).

### How

1. First, boot to the USB disk [you just prepared](0100-prepare.md). In order to boot to the USB disk, modify the boot order in the BIOS. Note certain USB ports on the motherboard may not boot. If you suspect that is the case, try a different USB port. Once booted, the screen should display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard.
2. `Advanced options ...`, then `Expert install`
    * Note, **do not hit Enter yet**, if you want to set up [Serial ATA RAID (SATA RAID, hardware RAID)](https://wiki.debian.org/DebianInstaller/SataRaid). I _used to_ have SATA RAID. But this feature does not seem to be well supported. I have since switched to software RAID. Software RAID is set up in [the disk partition step](0201-partitions.md).
3. `Choose language`, locale `en_US.UTF-8`
4. `Configure the keyboard`: `American English`
5. `Detect and mount CD-ROM`. This should recognize the USB drive with the Debian ISO as the CD-ROM.
6. `Load installer components from CD`: Choose none.
7. `Detect network hardware`
8. `Configure the network`. Auto-configure `yes` as we are using DHCP. Specify the host name. Leave the domain name empty.
9. `Set up users and passwords`
    * `Enable shadow passwords`: `Yes`
    * `Allow login as root`: `No`
10. `Configure the clock`
    * `Set the clock using NTP`: `Yes`
11. `Detect disks`
12. `Partition disks`.
    * Choose `Manual` and see [manual disk partitions](0201-partitions.md) for detailed steps and information.
    * Or, for the simple cases such as setting up a VM, choose `Guided - use entire disk`.
13. `Install the base system`
    * kernel: `linux-image-amd-64` (this installs the same version but free to upgrade to newer kernel versions while the other option locks down the kernel to a particular version)
    * initrd (initial ram disk): `generic (all available drivers)`
14. `Configure the package manager`
    * Use network mirror: Yes
    * Protocol: https
    * Country: US
    * Mirror: (choose a good one that is near to you, e.g. `mirrors.ocf.berkeley.edu`)
    * Use non-free software: Yes (which implies also using contrib software and can skip the next one). If you need to install NVIDIA packages, you must say yes to non-free
    * Use contrib software: Yes
    * Enable source repositories in APT: No
    * Services to use: `security updates`, `release updates`, and also check `backported software`
15. `Select and install software`
    * Package usage survey: No
    * Should man and mandb be installed 'setuid man': No
    * Choose only `standard system utilities`, which includes bzip2, dpkg, perl, python, openssl, etc.
    * Note, if you want to install a customized desktop, make sure **do not select any desktop environment**. We can install a lightweight desktop at a later stage. For example, [a GNOME desktop reduced to the core](0501-gnome.md).
16. `Install the GRUB boot loader`
    * Force GRUB installation to the EFI removable media path: Yes
17. Finish and reboot
    * Set the system clock to UTC: Yes
    * Reboot

### Almost done, not yet...

Make sure to read about [cleanup, fixes, issues](0202-cleanup.md)
