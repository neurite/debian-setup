## fonts

1. [Anonymous Pro](https://packages.debian.org/buster/fonts/ttf-anonymous-pro): coding
2. [Inconsolata](https://packages.debian.org/buster/fonts-inconsolata): terminal
3. [Source Code Pro](https://github.com/adobe-fonts/source-code-pro): coding

### Install Source Code Pro

1. `cd ~/Workspace`
2. `git clone https://github.com/adobe-fonts/source-code-pro.git`, note the default branch is `release`
3. `sudo mkdir -p /usr/local/share/fonts/source-code-pro`
4. `sudo cp source-code-pro/OTF/*otf /usr/local/share/fonts/source-code-pro/`, `otf` files are newer format than `ttf` files
5. `fc-cache -fv`, force font build
6. `fc-list`, list available fonts

Fonts are in `/usr/share/fonts` or `/usr/local/share/fonts`. We can check the organization of the font files already in the system at `/usr/share/fonts`. We should install our own fonts into `/usr/local/share/fonts`.
