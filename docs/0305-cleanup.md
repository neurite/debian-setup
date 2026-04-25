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

The variant [vim-nox](https://packages.debian.org/trixie/vim-nox) is a non-GUI vim that suppors Python 3 scripting.

### Network Manager

To let Network Manager manage wired connections, edit `/etc/NetworkManager/NetworkManager.conf`. Change to `true`

```
[ifupdown]
managed=true
```

```bash
sudo systemctl restart NetworkManager
```

Wireless has no internet connection. Again edit `/etc/NetworkManager/NetworkManager.conf` and comment out the following like so:

```
# The primary network interface
# allow-hotplug eth0
# iface eth0 inet dhcp
```

```bash
sudo systemctl restart NetworkManager
```

To configure VPN, install the following:

`sudo apt-get install network-manager-openvpn network-manager-openvpn-gnome`
