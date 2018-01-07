So why expert, manual install?

Choosing "Expert install" gives us the option of manual disk partitions. When there is only one disk, the simplest configuration is one partition over the entire disk. This however is not ideal as data of `/`, `/home`, `/var`, `/tmp`, swap have different profiles and require different security measures. Splitting them into different partitions and setting different mounting options solve the problems.

The second reason is about installing a lightweight desktop. Like disk partitions, this step paves way for adding a minimal desktop on top. For details, see notes about [minimal GNOME](0601-gnome.md) oe [Minimal LXDE](0602-lxde.md).

1. In order to boot to the USB disk, modify the boot order in the BIOS. Note certain USB ports on the motherboard may not boot. If you suspect that is the case, try a different USB port.
2. Now, boot to the USB disk. The screen should display "UEFI Installer" in the title; otherwise revisit the UEFI settings of the motherboard.
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
13. `Partition disks`. 
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
