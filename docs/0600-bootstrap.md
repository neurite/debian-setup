### Overview

The basic bootstrapping for development environment includes,

1. Installing packages commonly used in a Linux dev environment.
2. Installing and configurating a text editor, my favourite is [vim](0601-vim.md).
3. Installing and configuration source control, it has to be [git](0603-git.md).

Other aspects of development such as [Java](0700-java.md), [Python](0800-python.md), virualization, machine learning, deep learning are covered in separate topics.

### Common Dev Packages

Please check out [the dev bootstrap script](https://github.com/neurite/debian-setup/blob/master/scripts/dev-bootstrap.sh) for the list of packages.

You can run the script directly to install the packages,

1. Install git `sudo apt-get install git`
2. Clone [this repository](https://github.com/neurite/debian-setup.git)
```bash
mkdir -p ~/Workspace
cd ~/Workspace
git clone https://github.com/neurite/debian-setup.git
```
3. Execute the script, In the end, it will reboot
```bash
sudo su
bash /<path>/<to>/<usr>/<Workspace>/debian-setup/scripts/dev-bootstrap.sh
```

Now it is time to configure [vim](0601-vim.md) and [git](0603-git.md).
