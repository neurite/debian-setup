### GNOME Core Reduced

```bash
sudo apt-get install \
        gdm3 \
        gnome-session \
        gnome-shell \
        gnome-keyring libpam-gnome-keyring \
        gnome-control-center \
        network-manager-gnome \
        gnome-terminal
```

There is the [gnome-core](https://packages.debian.org/stretch/gnome-core) metapackage. But it does not look lean enough. So the following packages are hand-picked from the gnome-core list instead:

* [gdm3](https://packages.debian.org/stretch/gdm3) -- The display manager
* [gnome-session](https://packages.debian.org/stretch/gnome-session) -- The session manager
* [gnome-shell](https://packages.debian.org/stretch/gnome-shell) -- This points to [Mutter](https://packages.debian.org/stretch/mutter), the GTK+ window manager
* [gnome-keyring](https://packages.debian.org/stretch/gnome-keyring), [libpam-gnome-keyring](https://packages.debian.org/stretch/libpam-gnome-keyring) -- [The GNOM keyring packages](https://wiki.archlinux.org/index.php/GNOME/Keyring)
* [gnome-control-center](https://packages.debian.org/stretch/gnome-control-center) -- The "Settings"
* [gnome-terminal](https://packages.debian.org/stretch/gnome-terminal) -- The terminal emulator
* [network-mananger-gnome](https://packages.debian.org/stretch/network-manager-gnome)
* [pulseaudio](https://packages.debian.org/stretch/pulseaudio) (optional, if you want audio)

Alternatively,

```
sudo apt-get --no-install-recommends install gnome-core
```

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
