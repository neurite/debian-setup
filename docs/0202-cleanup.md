## Cleanup

### Package Source File

Edit package sources `sudo vi /etc/apt/sources.list`. Since we are not using the USB disk any more for updates, comment out the line that starts with `deb cdrom:[Debian GNU/Linux ...`.

### Upgrade Kernel via Backports (optional)

If you want newer version of NVIDIA software, you may want to upgrade the kernel, as NVIDIA installs into the kernel tree. But double-check NVIDIA does have the compatible versions for the upgraded kernel.

1. `sudo apt-get update`.
2. `sudo apt-get dist-upgrade`. Note, if using the backports here, it will likely upgrade the kernel `linux-image-(blah, blah)-amd64`.

### Single-User Mode

Disable single-user mode to lock down the box.

1. Edit `/etc/default/grub`
2. Uncomment the line `GRUB_DISABLE_RECOVERY="true"`
3. `sudo update-grub`

### Tune SSD (optional)

* I/O scheduler (optional, especially the hard disk letter sequence `sdx` is not 100% reliable)
    1. `cat /sys/block/sda/queue/scheduler` should show `CFQ` as the scheduler
    2. `sudo vi /etc/rc.local` and add this line `echo noop > /sys/block/sda/queue/scheduler`
* swappiness (only if we are swapping on the SSD; even better set up swap on a spinning disk)
    1. `cat /proc/sys/vm/swappiness` should show the default value of 60
    2. `cat /proc/sys/vm/vfs_cache_pressure` should show the default value of 100
    3. Edit `/etc/sysctl.conf` and set `vm.swappiness=30` and `vm.vfs_cache_pressure=50`
