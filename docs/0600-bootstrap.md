### Overview

The basic bootstrapping for a development environment includes:

1. Installing packages commonly used in a Linux dev environment.
2. Installing and configuring a text editor; my favourite is [vim](0601-vim.md).
3. Installing and configuring source control; it has to be [git](0603-git.md).

Other aspects of development such as [Java](0700-java.md), [Python](0800-python.md), virualization, machine learning, deep learning are covered in separate topics.

### Common Dev Packages

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

Now it is time to configure [vim](0601-vim.md) and [git](0603-git.md).
