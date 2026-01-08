## Bootstrap

### Overview

1. Web tools (curl, wget)
2. Security tools (openssl, gnupg)
3. git
4. Monospaced fonts
5. CJK fonts - optional
6. Build tools (C/C++/fortran compilers, make, check)
7. Debugging tools
8. Linear algebra libraries
9. vim with Python 3 support
10. OpenJDK - optional
11. conda - opitonal

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

Options
```bash
    --add-cjk-fonts     Install CJK (Chinese, Japanese, Korean) fonts
    --add-jdk           Install the recommended version of JDK
    --add-conda         Install conda
    -h, --help          Show this help message
```

### Verify

1. `git --version`
2. `gcc --version`
3. `g++ --version`
4. `vim --version`, check for Python 3 support
5. `conda --version`
6. `java -version`, note the non-standard way of the java command, 1 dash only
7. `fc-list`

**Next step: [nvidia](0302-nvidia.md)**


