### Conda

This is the preferred approach.

#### Install Conda

Before running the installation script on the Debian box, try it on a [VirtualBox](0901-virtualbox.md) first.

1. Download [the miniconda installation script](http://conda.pydata.org/miniconda.html). I downloaded the one for Python 3.6 for 64-bit system.
2. If the download URL is not https, make sure to verify the MD5 `md5sum Miniconda3-latest-Linux-x86_64.sh`.
3. Run the install script `bash Miniconda3-latest-Linux-x86_64.sh`. **IMPORTANT: Do NOT sudo it.**
4. Follow the instructions on screen. During the process it will inform you it will install in your home directory and will prepend the binary to $PATH in your .bashrc. Accept it with "yes".
5. Verify
    * `source ~/.bashrc`
    * `conda env list` lists the envs, should see the ROOT environment
    * `conda list` lists the packages in the ROOT environment
    * `conda update conda` updates conda
    * `conda update --all` updates all the packages in the ROOT environment

#### Create environments

```
conda create --name my-env python=3.6
```

The environment not only creates an isolated, self-contained space for installing packages, but also makes it portable across hosts of the same architecture. There are several ways to duplicate an environment.

Clone an environment:

```
conda create --name myclone --clone myenv
```

Create from an evironment file:

```
conda env export > my-env.yml
conda env create --name my-env-copy --file my-env.yml
```

Create from a list of package specifications:

```
conda list --explicit > my-env-package-spec.txt
conda create --name myenv --file my-env-package-spec.txt
```

Sync the environment from an environment file:

```
conda env update -f my-env.yml --prune
```

#### Install Packages

1. `conda install <pkg>`

The essential concept of conda is that Python packages are installed in a **managed** environment. So the first choice for installing a package is `conda install <package>` in an activated conda environment. You can search for packages in [the anaconda repo](https://anaconda.org/anaconda/repo).

2. `conda install <pkg> -c conda-forge`

If a package is not provided in the default "anaconda" channel, you may choose an alternative channel such as "conda-forge". The command would be `conda install -c conda-forge <package>`. This would be your second choice. The upgrade command `conda update --all` automatically takes care of the packages from different channels. Basically channels have priorities and the default channel has the highest priority. If a package of the same or higher version becomes available in the default channel during upgrade, it will supercede other channels. Other similar commands include:
```bash
conda update <pk> -c conda-forge  # upgrade a particular package and its dependencies from the conda-forge channel
conda update --all -c conda-forge # upgrade everything to those in the conda-forge channel
```

3. `pip install <pkg> --upgrade`

Lastly, if a package you want to install is not managed by conda, you can use pip. Make sure to use pip **within the conda environment**. This would be your last choice. The command to install and upgrade is `pip install <package> --upgrade`. When you list the packages using `conda list`, you will see which packages are installed via pip.

### Debian Python Packages

Alternatively, install core Python packages at the OS level and manage Python environments using virtualenv.

**Never run `pip` directly. Run `pip` only in virtual environments.**

The core Python packages include `python`, `python3`, `python-pip`, `python3-pip`, and `virtualenv`.

Certain dependencies, such as `libblas3`, `libblas-dev`, `liblapack3`, `liblapack-dev` needed by the SciPy virtual environment, need to be installed explicitly.

```bash
### Python header files
apt-get -q -y install python-dev python3-dev

#### Linear algebra packages needed by numpy and scipy
# If the Debian packages, python-numpy and python-scipy, were installed,
# these dependencies would be pulled in automatically as transitive dependencies. 
# However, if numpy or scipy are installed only in virtual environments,
# these linear algebra packages must be installed explicitly. The same can be
# said for other Python dependencies.
apt-get -q -y install libblas3 libblas-dev liblapack3 liblapack-dev

### FreeType libraries needed by matplotlib
apt-get -q -y install libfreetype6 libfreetype6-dev

### Dependencies needed by cryptography
apt-get -q -y install libffi-dev libssl-dev

### Core python packages
apt-get -q -y install python python-pip python3 python3-pip virtualenv

### aws command-line
apt-get -q -y install python3-boto awscli

### Uncomment the following if the scipy stack is to be installed natively
# SciPy stack for Python 2
# apt-get -q -y install ipython ipython-notebook
# apt-get -q -y install python-numpy python-matplotlib python-scipy
# apt-get -q -y install python-pandas python-sklearn python-sympy
# Scipy stack for Python 3
# Note for jessie this is incomplete missing sympy and sklearn
# apt-get -q -y install ipython3 ipython3-notebook
# apt-get -q -y install python3-numpy python3-matplotlib python3-scipy
# apt-get -q -y install python3-pandas
```

### IDE

Recommend Visual Studio Code.

#### Install

1. Download the .deb file from [Visual Studio Code](https://code.visualstudio.com/download).
2. `sudo dpkg --install <path to the downloaded VSC deb file>`.
3. Install the Python extension managed by Microsoft (ms-python.python).

#### Integrate with conda

1. Edit Preferences -> Settings.
2. There are 3 sets of settings. The default settings, the user settings, and the workspace settings. You should edit only the user settings and the workspace settings.
3. The user settings are stored in the folder `~/.config/Code/`. This is the place I edited the font and the font size.
4. The workspace settings are actually project specific. If you opened the folder `~/Workspace/<project>`, this file should be `~/Workspace/<project>/.vscode/settings.json`. This is where you integrate with the project-specific conda environment.
5. Point the python path to `~/miniconda3/envs/<environment>/bin/python`.
6. Restart Visual Studio Code.
7. Note IDE dependencies like `pylint` should be installed via conda into the virtual environment.

Why would this work? In the same `~/miniconda3/envs/<environment>/` folder, `lib/<the-python-binary-that-is-linked-to>/site-packages/` has all the installed packages for the environment.
