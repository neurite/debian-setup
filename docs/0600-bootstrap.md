## Bootstrap

### Overview

##### Tools & libraries

1. git
2. C/C++ compilers
3. Debugging
4. Linear algebra libraries
5. Security tools
6. Network
7. vim-gtk3
8. conda
9. OpenJDK

##### Fonts

1. Monospaced fonts
    1. [Anonymous Pro](https://packages.debian.org/bullseye/fonts/ttf-anonymous-pro)
    2. [Inconsolata](https://packages.debian.org/bullseye/fonts-inconsolata)
    3. [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
    4. [Source Han Mono](https://github.com/adobe-fonts/source-han-mono)
2. CJK fonts:
    1. [fonts-arphic-ukai](https://packages.debian.org/bullseye/fonts-arphic-ukai) (Chinese Serif)
    2. [fonts-arphic-uming](https://packages.debian.org/bullseye/fonts-arphic-uming) (Chinese Sans Serif)
    3. [fonts-ipafont-mincho](https://packages.debian.org/bullseye/fonts-ipafont-mincho) (Japanese Serif)
    4. [fonts-ipafont-gothic](https://packages.debian.org/bullseye/fonts-ipafont-gothic) (Japanese Sans Serif)
    5. [fonts-nanum](https://packages.debian.org/bullseye/fonts-nanum) (Korean)
    6. [fonts-nanum-extra](https://packages.debian.org/bullseye/fonts-nanum-extra) (Korean)

Installed fonts can be listed by `fc-list`. 

### Execute the bootstrap script

Please check out [the dev bootstrap script](https://github.com/neurite/debian-setup/blob/master/scripts/dev-bootstrap.sh) for the list of packages to install.

You can grab and run the script following these steps:

1. Install git `sudo apt-get install git`
2. Clone [this repository](https://github.com/neurite/debian-setup.git)
```bash
mkdir -p ~/Workspace
cd ~/Workspace
git clone https://github.com/neurite/debian-setup.git
```
3. Execute the script, in the end, it will reboot
```bash
sudo su
bash /home/<usr>/Workspace/debian-setup/scripts/dev-bootstrap.sh
```

### Verify

1. `git --version`
2. `gcc --version`
3. `g++ --version`
4. `vim --version`, check for Python 3 support
5. `conda --version`
6. `java -version`, note the non-standard way of the java command, 1 dash only
7. `fc-list`

**Next step: [nvidia](0300-nvidia.md)**
