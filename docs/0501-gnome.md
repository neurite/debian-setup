### GNOME Core Reduced

There is the [gnome-core](https://packages.debian.org/bullseye/gnome-core) metapackage that can be installed.

```bash
sudo apt-get --no-install-recommends install gnome-core
```

If `gnome-core` does not look lean enough, the following packages are hand-picked from the gnome-core list:

```bash
sudo apt-get --no-install-recommends install \
        xserver-xorg \
        gdm3 \
        gnome-session \
        gnome-shell \
        gnome-keyring libpam-gnome-keyring \
        gnome-control-center \
        gnome-terminal \
        network-manager-gnome \
        pulseaudio
```

* [xserver-xorg](https://packages.debian.org/bullseye/xserver-xorg) -- The X server, input drivers, video drivers
* [gdm3](https://packages.debian.org/bullseye/gdm3) -- The display manager
* [gnome-session](https://packages.debian.org/bullseye/gnome-session) -- The session manager
* [gnome-shell](https://packages.debian.org/bullseye/gnome-shell) -- This points to [Mutter](https://packages.debian.org/bullseye/mutter), the GTK+ window manager
* [gnome-keyring](https://packages.debian.org/bullseye/gnome-keyring), [libpam-gnome-keyring](https://packages.debian.org/bullseye/libpam-gnome-keyring) -- [The GNOM keyring packages](https://wiki.archlinux.org/index.php/GNOME/Keyring)
* [gnome-control-center](https://packages.debian.org/bullseye/gnome-control-center) -- The "Settings"
* [gnome-terminal](https://packages.debian.org/bullseye/gnome-terminal) -- The terminal emulator
* [network-mananger-gnome](https://packages.debian.org/bullseye/network-manager-gnome) -- Optional, if you want to manage network
* [pulseaudio](https://packages.debian.org/bullseye/pulseaudio) -- Optional, if you want audio


### Network Manager & VPN

To let Network Manager manage wired connections, edit `/etc/NetworkManager/NetworkManager.conf`. Change to `true`
```
[ifupdown]
managed=true
```
```bash
sudo /etc/init.d/network-manager restart
```

Wireless has no internet connection. Again edit `/etc/NetworkManager/NetworkManager.conf` and comment out the following like so:
```
# The primary network interface
# allow-hotplug eth0
# iface eth0 inet dhcp
```
```bash
sudo /etc/init.d/network-manager restart
```

To configure VPN, install the following:

`sudo apt-get install network-manager-openvpn network-manager-openvpn-gnome`
