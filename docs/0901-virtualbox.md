### Table of Contents

1. [Prerequisites](#prerequisites)
    1. [DKMS](#dkms)
    2. [Evince (optional)](#evince-optional)
2. [VirtualBox](#virtualbox)
3. [Guest System](#guest-system)
    1. [Hard disk type](#hard-disk-type)
    2. [Guest additions](#guest-additions)

### Prerequisites

#### DKMS

DKMS is recommended for VirtualBox. "Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade." It should have already been installed (also needed for installing the NVIDIA drivers).

#### Evince (optional)

Note that if VirtualBox is installed directly from Debian using `apt-get`, a PDF viewer is not needed.

Basically needs to install a PDF viewer as required by the VirtualBox package sourced from virtualbox.org. By default, installing VirtualBox will pull in mupdf. Run `sudo apt-get install evince` to install Evince. Another light-weight option is `xpdf`, which installs the same number of new packages as Evince.

### VirtualBox

`sudo apt-get -t stretch-backports install virtualbox`

Or for the newest VirtualBox package, install it from virtualbox.org. Please follow [VirtualBox instructions](https://www.virtualbox.org/wiki/Linux_Downloads)

Here is the note:

1. Download [the Oracle public key](https://www.virtualbox.org/download/oracle_vbox_2016.asc) for apt-secure and install the key `sudo apt-key add oracle_vbox_2016.asc`. The key file can be removed after being added to apt.
2. Add a new file `virtualbox.list` to `/etc/apt/sources.list.d/`.
3. Add this line `deb http://download.virtualbox.org/virtualbox/debian stretch contrib` to the `virtualbox.list` file.
4. Update with the Oracle VirtualBox packages `sudo apt-get update`.
5. Install VirtualBox `sudo apt-get install virtualbox-5.2`.
6. Fix the `vboxusers` user group for accessing USB devices. Note that installing VirtualBox will add the user group `vboxusers`. The documentation says, "VirtualBox accesses USB devices through special files in the file system. When VirtualBox is installed, these are made available to all users in the `vboxusers` system group. In order to be able to access USB from guest systems, make sure that you are a member of this group."
    1. To view the list of groups `groups <user>` (or `id <user>`)
    2. If not in the group, add to the group `sudo gpasswd -a <user> vboxusers` (or `sudo usermod -a -G vboxusers <user>`)
7. Customize VirtualBox
    1. `mkdir ~/VirtualBoxVMs`
    2. Start VirtualBox. File -> Preferences -> General. Set the Default Machine Folder to `/home/<user>/VirtualBoxVMs`.

### Guest System

#### Hard disk type

VDI, VHD, or VMDK? See this [excellent discussion](https://superuser.com/questions/360517/what-disk-image-should-i-use-with-virtualbox-vdi-vmdk-vhd-or-hdd). Choose VMDK for compatibility.

#### Guest additions

Create a Debian virtual machine, install a basic Debian, install a minimal desktop (like gnome-core). Then in the guest system, the virtual machine, make sure to install the guest additions for better screen resolution,

`sudo apt-get install virtualbox-guest-dkms virtualbox-guest-x11`
