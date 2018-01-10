### Lean GNOME

`sudo apt-get install gdm3 gnome-session gnome-shell gnome-shell-extensions gnome-keyring gnome-control-center network-manager-gnome gnome-terminal`

There is the [gnome-core](https://packages.debian.org/stretch/gnome-core) metapackage. But it does not look like lean enough. So these packages are hand-picked from the list:

* [gdm3](https://packages.debian.org/stretch/gdm3) -- The GNOME display manager
* [gnome-session](https://packages.debian.org/stretch/gnome-session) -- The GNOME session manager
* [gnome-shell](https://packages.debian.org/stretch/gnome-shell) -- This points to [Mutter](https://packages.debian.org/stretch/mutter), the GTK+ window manager 
* [gnome-shell-extensions](https://packages.debian.org/stretch/gnome-shell-extensions)
* [gnome-keyring](https://packages.debian.org/stretch/gnome-keyring)
* [gnome-control-center](https://packages.debian.org/stretch/gnome-control-center) -- The "Settings"
* [gnome-terminal](https://packages.debian.org/stretch/gnome-terminal) -- The GNOME terminal emulator
* [network-mananger-gnome](https://packages.debian.org/stretch/network-manager-gnome)
* [pulseaudio](https://packages.debian.org/stretch/pulseaudio)

### Network Manager

To let Network Manager also manager wired connections, edit `/etc/NetworkManager/NetworkManager.conf`. Change to `true`:
```
[ifupdown]
managed=true
```

Wireless has no internet connection. Again edit `/etc/NetworkManager/NetworkManager.conf` and comment out the following like so:
```
# The primary network interface
# allow-hotplug eth0
# iface eth0 inet dhcp
```

### VPN

`sudo apt-get install network-manager-openvpn network-manager-openvpn-gnome`
