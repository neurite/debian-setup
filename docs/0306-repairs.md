## Repairs

### Rescue Mode

1. Advanced options... Rescue mode
2. Follow the same steps of installation until the step to mount the root file system
3. Visit the [partition map](0201-partitions.md), choose the partition where `/` is mounted
4. Mount separate /boot/efi partition... yes
5. Execute a shell the partition
6. May need to mount `/var`, `/tmp`, `/opt`, `/usr/local` manually to install/repair packages
