### Overview

The basic bootstrapping for development environment includes,

1. Installing packages commonly used in a Linux dev environment.
2. Installing and configurating a text editor, my favourite is [vim](0601-vim.md).
3. Configuring the shell, my favourite is [bash](0602-bash.md).
4. Installing and configuration source control, it has to be [git](0603-git.md).

Other aspects of development such as Java, Python, virualization, machine learning, deep learning are covered in separate topics.

### Common dev packages

Please check out [the dev bootstrap script](https://github.com/neurite/debian-setup/blob/master/scripts/dev-bootstrap.sh).

You can git clone this repository and run the script like the following,
```bash
sudo su -
bash /path/to/dev-bootstrap.sh
```

In the end, it will reboot automatically.
