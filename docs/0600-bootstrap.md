## Dev bootstrap

### Overview

#### Tools

1. git
2. C/C++ compilers
3. Debugging utils
4. Linear algebra libraries
5. Security utils
6. Network utils
7. vim-gtk3
8. OpenJDK

#### Fonts

1. [Anonymous Pro](https://packages.debian.org/buster/fonts/ttf-anonymous-pro): coding
2. [Inconsolata](https://packages.debian.org/buster/fonts-inconsolata): terminal
3. [Source Code Pro](https://github.com/adobe-fonts/source-code-pro): coding
4. CJK fonts:

| Language                                | Serif                | Sans serif           |
|-----------------------------------------|----------------------|----------------------|
| Chinese (both Simplified & Traditional) |	fonts-arphic-ukai    | fonts-arphic-uming   |
| Japanese                                |	fonts-ipafont-mincho | fonts-ipafont-gothic |
| Korean                                  |	fonts-unfonts-core                          |

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

**Next step: [nvidia](0300-nvidia.md)**
