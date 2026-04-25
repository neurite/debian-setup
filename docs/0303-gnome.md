### GNOME Core Reduced

There is the [gnome-core](https://packages.debian.org/bullseye/gnome-core) metapackage that can be installed.

```bash
sudo apt-get --no-install-recommends install gnome-core
```

If `gnome-core` does not look lean enough, the following packages are hand-picked from the gnome-core list:

```bash
sudo apt-get install \
        xserver-xorg \
        gdm3 \
        gnome-session \
        gnome-shell \
        gnome-keyring libpam-gnome-keyring \
        gnome-control-center \
        ptyxis \
        network-manager-gnome \
        pipewire-audio
```

* [xserver-xorg](https://packages.debian.org/trixie/xserver-xorg) -- The X server, input drivers, video drivers
* [gdm3](https://packages.debian.org/trixie/gdm3) -- The display manager
* [gnome-session](https://packages.debian.org/trixie/gnome-session) -- The session manager
* [gnome-shell](https://packages.debian.org/trixie/gnome-shell) -- This points to [Mutter](https://packages.debian.org/trixie/mutter)
* [gnome-keyring](https://packages.debian.org/trixie/gnome-keyring), [libpam-gnome-keyring](https://packages.debian.org/trixie/libpam-gnome-keyring) -- [The GNOM keyring packages](https://wiki.archlinux.org/index.php/GNOME/Keyring)
* [gnome-control-center](https://packages.debian.org/trixie/gnome-control-center) -- The "Settings"
* [ptyxis](https://packages.debian.org/trixie/ptyxis) -- The terminal emulator
* [network-mananger-gnome](https://packages.debian.org/trixie/network-manager-gnome) -- Optional, if you want to manage network
* [pipewire-audio](https://packages.debian.org/trixie/pulseaudio) -- Optional, if you want audio

**Next step: [Browsers](0304-browsers.md)**
