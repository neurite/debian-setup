
### Package source file

Edit package sources `sudo vi /etc/apt/sources.list`. Since we are not using iso images any more for updates, comment out the line that starts with `deb cdrom:[Debian GNU/Linux ...`.

### Upgrade kernel via backports (optional)

If you want newer version of NVIDIA software, you may want to upgrade the kernel, as NVIDIA installs into the kernel tree. But double-check NVIDIA does have the compatible versions for the upgraded kernel.

1. `sudo apt-get update`.
2. `sudo apt-get -t stretch-backports dist-upgrade`. Note this command should upgrade a package `linux-image-(blah, blah)-amd64` which is the kernel.

### Single-user mode

Disable single-user mode to lock down the box.

1. Edit `/etc/default/grub`
2. Uncomment the line `GRUB_DISABLE_RECOVERY="true"`
3. `sudo update-grub`

### Nvidia problem

Symptom: Boot hangs on normal startup.

1. Reboot the system using the USB disk. On the Debian boot screen, choose `Advanced Options` --> `Recovery Mode`. The last output on the screen is "fb: switching to nouveaufb from simple" indicating a problem with nouveau.
2. Reboot the system from the USB disk. `Advanced options ...` --> `Rescue mode`.
3. After the quick setup in the rescue mode, choose the root file system `/dev/sda2` (the partition that is mounted as `/`). Execute a shell there as the root.
4. Move `/etc/modprobe.conf` to backup, if present.
5. `vi /etc/modprobe.d/nouveau.conf` and add the following 2 lines:
    ```bash
    blacklist nouveau
    blacklist lbm-nouveau
    ```
6. Exit and reboot from the hard disk.

### Tune SSD (optional)

* I/O scheduler (optional, especially the hard disk letter sequence `sdx` is not 100% reliable)
    1. `cat /sys/block/sda/queue/scheduler` should show `CFQ` as the scheduler
    2. `sudo vi /etc/rc.local` and add this line `echo noop > /sys/block/sda/queue/scheduler`
* swappiness (only if we are swapping on the SSD; even better set up swap on a spinning disk)
    1. `cat /proc/sys/vm/swappiness` should show the default value of 60
    2. `cat /proc/sys/vm/vfs_cache_pressure` should show the default value of 100
    3. Edit `/etc/sysctl.conf` and set `vm.swappiness=30` and `vm.vfs_cache_pressure=50`
