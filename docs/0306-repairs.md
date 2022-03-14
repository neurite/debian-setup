## Repairs

### Rescue Mode

1. Reboot the machine via the USB drive
2. Advanced options... Rescue mode
3. Follow the same steps of installation until the step to mount the root file system
4. Visit the [partition map](0201-partitions.md), choose the partition where `/` is mounted
5. Mount separate /boot/efi partition... yes
6. Execute a shell the partition
7. May need to mount `/var`, `/tmp`, `/opt`, `/usr/local` manually to install/repair packages
