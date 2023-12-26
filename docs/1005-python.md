### Conda

Conda is the preferred approach for installing Python packages.

#### Install miniconda

If you have gone through [the bootstrap step](0301-bootstrap.md), conda should have already installed. The bootstrap script adds the conda deb repo to the sources list and installs miniconda from there.

In order to run the `conda` command in terminal, add `source /opt/conda/etc/profile.d/conda.sh` to `~/.bashrc`. This is mentioned in [the cleanup step](0305-cleanup.md).

Alternatively, you can install miniconda manually. Note this installs miniconda in your user home by default:

1. Download [the miniconda installation script](https://docs.conda.io/en/latest/miniconda.html).
2. Run the install script `bash Miniconda3-latest-Linux-x86_64.sh`. **IMPORTANT: Do NOT sudo it.**
3. Follow the instructions on screen. During the process it will inform you it will install in your home directory and will prepend the binary to $PATH in your .bashrc. Accept it with "yes".
4. Verify
    * `source ~/.bashrc`
    * `conda env list` lists the envs, should see the ROOT environment
    * `conda list` lists the packages in the ROOT environment
    * `conda update conda` updates conda
    * `conda update --all` updates all the packages in the ROOT environment

#### Create environments

A conda environment not only creates an isolated, self-contained space for installing packages, but also makes it portable across hosts of the same architecture. There are several ways to create an environment.

Create a Python 3.9 environment with the `--name` option:

```bash
conda create --name coffeemug python=3.9
```

The above command creates a Python 3.9 environment called `coffeemug`. It is located in the user home by default.

Another way, using the `--prefix` option, creates an environment at a specific location. The following command, *running from the project folder*, creates a Python 3.9 environment within the project's `envs/coffeemug` folder:

```bash
conda create --prefix envs/coffeemug python=3.9
```

The directories of the project `coffeemug` look like below:

```bash

~/Workspace/coffeemug               # project root
                |
                |-- coffeemug       # source code for the coffee-mug module
                |
                |-- envs            # managed envs for the project
                    |
                    |-- coffeemug   # the default env by the same name

```

This way, each project has its own envs located within its own folder and each project can have multiple envs. The principle is such that relevant stuff are physically close to each other and/or are contained within.

Next, how do we duplicate the environment across machines?

Activate the environment and then install packages in it. Once the packages are installed, the list of packages can be exported to a text file like so:

```bash
conda list --explicit > package-specs-linux-64.txt
```

Then the same environment can be recreated for *the same OS and architecture*:

```bash
conda create --name coffeemug --file package-specs-linux-64.txt
```

Or at the `coffeemug` project root:

```bash
conda create --prefix envs/coffeemug --file package-specs-linux-64.txt
```

Alternatively, `conda env export` (or `conda env export --prefix <prefix>`) outputs package versions and build numbers without the OS or architecture but includes the environment's name and prefix. We do not use this approach for duplicating environments across platforms for 2 reasons. First, a package of a particular version and build number may not available on a different platform. Second, the output includes the absolute file path for the prefix. A file path like `/home/neurite/Workspace/coffeemug/envs/coffeemug` is not portable. The solution is to include a script that creates the project environment in the source control. In the script, lock down the versions of important packages. The same script is used to create environments across different platforms. Then each platform has its own specs file.

#### Install packages

The essential concept of conda is that Python packages are installed in a **managed** environment.

##### 1. `conda install <pkg>`

The first choice for installing a package is `conda install <package>` in the activated conda environment. This installs the package version from the default anaconda channel. By the way, you can search packages in [the anaconda repo](https://anaconda.org/anaconda/repo).

##### 2. `conda install <pkg> -c conda-forge` or a 3rd-party channel

If a package is not provided in the default "anaconda" channel, you may choose a second-tier channel such as "conda-forge". The command would be `conda install <package> -c conda-forge `. This would be your second choice.

Another example is the "pytorch" channel. Pytorch is typically installed via `conda install pytorch -c pytorch`.

If you have used multiple channels in your environment, the upgrade command `conda update --all` automatically takes care of the packages from different channels. Basically, channels have priorities where the default channel has the highest priority. If a package of the same or higher version becomes available in the default channel during upgrade, it will supercede the other channels.

##### 3. `pip install <pkg>`

Lastly, if a package is not managed by conda yet, you can use `pip` to install it. Make sure to **use the pip within the activated conda environment**. The command to install and upgrade is `pip install <package> --upgrade`. When you list the packages using `conda list`, you will see which packages are installed via pip. They are listed under the channel "pypi".

##### 4. Install from source code

Sometimes you want the latest code that hasn't been distributed in conda or PyPI yet.

If the source has a conda build file, `conda build conda-build.yaml`. Then the created `tar.gz` package can be installed via `conda install --use-local`.

Or, if the project has the `setup.py` file, use the `pip` in the conda environment to install. Install from the setup file `pip install -e path/to/setup.py`. When specifying the path, do not include `setup.py` in the path string.

Or, install from git, `pip install git+<repository-url>@<branch-or-tag>`. For example, `pip install git+https://github.com/pytube/pytube.git@11.0.2`.

Packags installed from the source code will be listed under the "<develop>" channel.

##### 5. Lock down the versions of the target packages

Recommend locking down the versions for the target packages. For example, if the project is to use Scrapy to crawl websites, lock down Scrapy `conda install scrapy=2.6.1` or `pip install scrapy==2.6.1`.


### IDEs

#### PyCharm

Note PyCharm is a Java app. We set it up like other Java apps.

1. Download the PyCharm community version.
2. Unpack into `~/Applications`.
3. Add to `~/.bashrc` the following lines:

```
export PYCHARM_HOME="${HOME}/Applications/pycharm-community-2021.3.3"
PATH="${PYCHARM_HOME}/bin:${PATH}"
```

Next, add a desktop shortcut. Files with .desktop extension are desktop entries for applications. By putting `.desktop` files into `/usr/share/applications` (for system-wide) or `.local/share/applications` (for the current user only), Linux will recognize them and show the app icons for launching from start menu. Here is the `pycharm.desktop` file:

```
[Desktop Entry]
Name=PyCharm
GenericName=Python IDE
Comment=Python IDE
Exec=/home/neurite/Applications/pycharm-community-2021.3.3/bin/pycharm.sh
Icon=/home/neurite/Applications/pycharm-community-2021.3.3/bin/pycharm.png
Terminal=false
Type=Application
Categories=Development;IDE;
StartupNotify=true
StartupWMClass=jetbrains-pycharm-ce
```

See [this thread](https://askubuntu.com/questions/367396/what-does-the-startupwmclass-field-of-a-desktop-file-represent) for what `StartupWMClass` does for Java apps.

To set up a PyCharm project that is in harmony with command-line, set up the project in command-line first. Then open PyCharm:

1. Projects -> New Project.
2. Location -> Select Base Directory. Choose the project folder.
3. Python Interpreter -> Previously Configured Interpreter -> Add Python Interpreter. Choose the Python interpreter in the conda environment in `<project-folder>/envs/<project-name>`.
4. Uncheck "Create a main.py" if it is not needed.
5. Create from Existing Sources.
6. Right-click the project module folder directly under the project folder. The module folder usually has the same name as the project. Mark the project module as Sources Root.
7. Add the `.idea/` PyCharm folder to `.gitignore`.

#### Visual Studio Code

1. Download the .deb file from [Visual Studio Code](https://code.visualstudio.com/download).
2. `sudo dpkg --install <path to the downloaded VSC deb file>`.
3. Install the Python extension managed by Microsoft (ms-python.python).

Integrate with conda:

1. Edit Preferences -> Settings.
2. There are 3 sets of settings. The default settings, the user settings, and the workspace settings. You should edit only the user settings and the workspace settings.
3. The user settings are stored in the folder `~/.config/Code/`. This is the place I edited the font and the font size.
4. The workspace settings are actually project specific. If you opened the folder `~/Workspace/<project>`, this file should be `~/Workspace/<project>/.vscode/settings.json`. This is where you integrate with the project-specific conda environment.
5. Point the Python interpreter to `<project-folder>/envs/<project-name>/bin/python`.
6. Restart Visual Studio Code.


### Debian Python Packages

Debian has Python packages the OS level. The core Python packages include `python`, `python3`, `python-pip`, `python3-pip`, and `python3-venv`.

**Never run `pip` directly. Run `pip` only in virtual environments and run `pip` as a Python module.** Always run as Python modules to make sure they are from the same distribution as the Python interpreter. For example, create a virtual environment called `coffeemug` and install `numpy` in it:

```bash
python3 -m venv coffeemug
source coffeemug/bin/activate
python -m pip install numpy
```

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

### Jupyter

[Stackoverflow question](https://stackoverflow.com/questions/58068818/how-to-use-jupyter-notebooks-in-a-conda-environment). Look at the accepted answer. We are following option 2 in the accepted answer.

##### Jupyter Lab environment

```
conda create -n jupyter python=3.11
conda activate jupyter
conda install jupyterlab
```

##### Project environment

In the project environment, `conda install ipykernel`.

Then `ipython kernel install --user --name=project-name`. This will create a kernel configuration in `~/.local/share/jupyter/kernels`.

As of this writing, we have 50 less packages from installing `ipykernel` only vs installing `jupyter`.

##### Run the project kernel

Go to the project root, activate the jupyter environment, launch `jupyter lab`, then choose the project kernel from the dropdown list.
