### GNOME

`sudo apt-get install gnome-core`

If you want a typical yet basic desktop based on the very popular GNOME, install the metapackage [gnome-core](https://packages.debian.org/stretch/gnome-core).

### VPN

`sudo apt-get install network-manager-openvpn network-manager-openvpn-gnome`

Note installing `gnome-core` should have already installed network manager.

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
