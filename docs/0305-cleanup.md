## Cleanup


### Package Source File

If not done alreay, edit package sources `sudo vim /etc/apt/sources.list`, comment out the line that starts with `deb cdrom:[Debian GNU/Linux ...`.


### Single-User Mode

Disable single-user mode to lock down the box.

1. Edit `/etc/default/grub`
2. Uncomment the line `GRUB_DISABLE_RECOVERY="true"`
3. `sudo update-grub`


### Shell Profile

`cp ~/Workspace/debian-setup/scripts/.bash_profile ~/`

The emulated terminals, [GNOME terminal](https://packages.debian.org/stretch/gnome-terminal) or [LXTerminal](https://packages.debian.org/stretch/lxterminal), are **non-login** shells. The start-up script is `~/.bashrc`, not `~/.bash_profile`. If we want to modify the `PATH` variable for the emulated GNOME terminal, for example, it should be modified in `~/.bashrc`.

On the other hand, `~/.bash_profile` is read by login shells. To go to a login shell, type Ctrl+Alt+F1 to swich to tty1, for example. The desktop usually runs at tty3, you can switch back by Ctrl+Alt+F3.

There is also `~/.profile`, which is for the generic shell `sh` (`bash` is a specific implementation of `sh`). Its documentation says "~/.profile: executed by the command interpreter for login shells. This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists."

To get a consistent environment across the login shells and the non-login shells, include `~/.bashrc` in `~/.bash_profile`. Also include `~/.profile` in `~/.bash_profile`. Here is what `~/.bash_profile` looks like:

```bash
if [ -r "${HOME}/.profile" ]; then
    . "${HOME}/.profile"
fi

if [ -r "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi
```

See [Debian Wiki of Environment Variables](https://wiki.debian.org/EnvironmentVariables) for more details.


### Vim

`cp ~/Workspace/debian-setup/scripts/.vimrc ~/`

There are 3 types of vim packages:

1. [vim-tiny](https://packages.debian.org/stretch/vim-tiny)
2. [vim](https://packages.debian.org/stretch/vim)
3. [vim-gtk3](https://packages.debian.org/stretch/vim-gtk3)

The package vim-tiny installs the `vi` binary.

Vim is improved vi. The package vim installs a vanilla `vim` without GUI.

The package vim-gtk3 installs vim with the GTK3 GUI and many other features. The feature I want is the syntax highlighting of Python 3 among other languages.

If you run `vi --version` or `vim --version`, you will see a list of enabled, disabled features. For example, the one below shows python3 is not enabled:
```
...
-cryptv         -libcall        -python         -viminfo
-cscope         -linebreak      -python3        -vreplace
-cursorbind     -lispindent     -quickfix       +wildignore
...
```

If the ones you want are not enabled, upgrade to the vim package with more features.

The dev bootstrap script esstentially installs the vim-gtk3 package:

```bash
sudo apt-get purge   vim
sudo apt-get purge   vim-tiny
sudo apt-get install vim-gtk3
```


### Conda

`echo "source /opt/conda/etc/profile.d/conda.sh" > ~/.bashrc`

To make `conda activate` available.


### Network Manager

To let Network Manager manage wired connections, edit `/etc/NetworkManager/NetworkManager.conf`. Change to `true`

```
[ifupdown]
managed=true
```

```bash
sudo service NetworkManager restart
```

Wireless has no internet connection. Again edit `/etc/NetworkManager/NetworkManager.conf` and comment out the following like so:

```
# The primary network interface
# allow-hotplug eth0
# iface eth0 inet dhcp
```

```bash
sudo service NetworkManager restart
```

To configure VPN, install the following:

`sudo apt-get install network-manager-openvpn network-manager-openvpn-gnome`


### Upgrade Kernel via Backports (optional)

Kernel upgrade better be done at a early stage of the installation. The earlier the better. Otherwise, recommend backing up the system before the upgrade.

If you want newer versions of NVIDIA software, you may want to upgrade the kernel, as NVIDIA installs into the kernel tree. But double-check NVIDIA does have the compatible versions for the upgraded kernel.

1. `sudo apt-get update`
2. `sudo apt-get -t bullseye-backport upgrade`

Or, more aggressively, do `dist-upgrade` which replaces old dependencies with new ones.

1. `sudo apt-get update`
2. `sudo apt-get -t bullseye-backport dist-upgrade`


### Tune SSD (optional)

* I/O scheduler (optional, especially the hard disk letter sequence `sdx` is not 100% reliable)
    1. `cat /sys/block/sda/queue/scheduler` should show `CFQ` as the scheduler
    2. `sudo vi /etc/rc.local` and add this line `echo noop > /sys/block/sda/queue/scheduler`
* swappiness (only if we are swapping on the SSD; even better set up swap on a spinning disk)
    1. `cat /proc/sys/vm/swappiness` should show the default value of 60
    2. `cat /proc/sys/vm/vfs_cache_pressure` should show the default value of 100
    3. Edit `/etc/sysctl.conf` and set `vm.swappiness=30` and `vm.vfs_cache_pressure=50`
