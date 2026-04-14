## NVIDIA


### Table of Contents

  * [Package Versions](#package-versions)
    * [Package tiers](#package-tiers)
    * [Other sources](#other-sources)
    * [Compatible hardware](#compatible-hardware)
  * [Installation](#installation)
    * [Linux headers](#1-linux-headers)
    * [DKMS](#2-dkms)
    * [Graphics drivers](#3-graphics-drivers)
    * [CUDA toolkit](#4-cuda-toolkit)
  * [Conda for CUDA and cuDNN](#conda-for-cuda-and-cudnn)


### Package Versions

#### Package tiers

There are 4 tiers of packages to install, each serving a distinct purpose and building on the tiers before it. Depending on your environment — [uv](https://docs.astral.sh/uv/), conda, or bare-metal Python — the final 2 tiers may be optional when installing on Debian. The package tier landscape is as follows:

1. Linux headers
    1. [linux-headers-amd64 6.19 (trixie-backports)](https://packages.debian.org/trixie-backports/linux-headers-amd64)
    2. [linux-headers-amd64 6.12 (trixie)](https://packages.debian.org/trixie/linux-headers-amd64)
    3. [linux-headers-amd64 6.12 (bookworm-backports)](https://packages.debian.org/bookworm-backports/linux-headers-amd64)
    4. [linux-headers-amd64 6.1 (bookworm)](https://packages.debian.org/bookworm/linux-headers-amd64)
    5. [linux-headers-amd64 5.10 (bullseye)](https://packages.debian.org/bullseye/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [nvidia-driver 550.163.01 (trixie-backports)](https://packages.debian.org/trixie-backports/nvidia-driver)
    2. [nvidia-driver 550.163.01 (trixie)](https://packages.debian.org/trixie/nvidia-driver)
    3. [nvidia-driver 535.216.03 (bookworm-backports)](https://packages.debian.org/bookworm-backports/nvidia-driver)
    4. [nvidia-driver 535.261.03 (bookworm)](https://packages.debian.org/bookworm/nvidia-driver)
    5. [nvidia-driver 470.256.02 (bullseye)](https://packages.debian.org/bullseye/nvidia-driver)
3. CUDA toolkit - the development toolkit for GPU computing
    1. [nvidia-cuda-toolkit 12.4.131 (trixie)](https://packages.debian.org/trixie/nvidia-cuda-toolkit)
    2. [nvidia-cuda-toolkit 11.8.89 (bookworm)](https://packages.debian.org/bookworm/nvidia-cuda-toolkit)
    3. [nvidia-cuda-toolkit 11.2.2 (bullseye)](https://packages.debian.org/bullseye/nvidia-cuda-toolkit)
4. cuDNN - the Deep Neural Network library
    1. [nvidia-cudnn 9.0.0 (trixie)](https://packages.debian.org/trixie/nvidia-cudnn)
    2. [nvidia-cudnn 8.5.0 (bookworm)](https://packages.debian.org/bookworm/nvidia-cudnn)

#### Other Sources

##### NVIDIA

NVIDIA provides the latest versions.

Here is the [NVIDIA graphics driver list for UNIX](https://www.nvidia.com/en-us/drivers/unix/).

NVIDIA has a good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of the graphics driver and the CUDA toolkit.

NVIDIA also has detailed documention on [cuDNN installation](https://docs.nvidia.com/deeplearning/cudnn/installation/latest/index.html). In the cuDNN documentation, you can clearly see the 2 prerequisites: graphics drivers and CUDA.

##### Conda

Conda provides CUDA toolkit and cuDNN. Note they requires compatible versions of the graphics driver to function. In fact, conda has multiple channels providing CUDA toolkit and cuDNN. The default anaconda channel has [cudatoolkit](https://anaconda.org/anaconda/cudatoolkit) and [cudnn](https://anaconda.org/anaconda/cudnn). The conda-forge channel has newer versions of [cudatoolkit](https://anaconda.org/conda-forge/cudatoolkit) and [cudnn](https://anaconda.org/conda-forge/cudnn). The NVIDIA channel has the most up-to-date [cuda](https://anaconda.org/nvidia/cuda) and [cudnn](https://anaconda.org/nvidia/cudnn).

#### Compatible Hardware

First, choose the version of the graphics driver that is compatible with the GPUs at hand. For example, for 2070 Super, the graphics driver from `buster-backports` or later is needed. For 3080 TI, `bullseye` or later is needed.

| Debian Release     | NVIDIA graphics driver | Supported GPUs | Note |
|--------------------|------------------------|----------------|------|
| trixie-backports   | [nvidia-driver 550.163.01](https://packages.debian.org/trixie-backports/nvidia-driver)    | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/550.163.01/README/supportedchips.html)  | Geforce RTX 40xx          |
| trixie             | [nvidia-driver 550.163.01](https://packages.debian.org/trixie/nvidia-driver)              | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/550.163.01/README/supportedchips.html)  | Geforce RTX 40xx          |
| bookworm-backports | [nvidia-driver 535.216.03](https://packages.debian.org/bookworm-backports/nvidia-driver)  | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/535.216.01/README/supportedchips.html)  | Geforce RTX 40xx          |
| bookworm           | [nvidia-driver 535.261.03](https://packages.debian.org/bookworm/nvidia-driver)            | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/535.261.03/README/supportedchips.html)  | Geforce RTX 40xx          |
| bullseye           | [nvidia-driver 470.256.02](https://packages.debian.org/bullseye/nvidia-driver)            | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/470.256.02/README/supportedchips.html)  | Geforce RTX 30xx          |


Second, it is critical that CUDA is supported by a **compatible graphics driver**. Here is a table copied from NVIDIA's release nots of [CUDA toolkit components](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#major-components):

| CUDA Toolkit                | Linux x86_64 Driver Version | Windows x86_64 Driver Version |
|-----------------------------|-----------------------------|-------------------------------|
| ...                         | ...                         | ...                           |
| CUDA 12.4 Update 1          | >=550.54.15                 | >=551.78                      |
| CUDA 12.4 GA                | >=550.54.14                 | >=551.61                      |
| ...                         | ...                         | ...                           |
| CUDA 11.8 GA                | >=520.61.05                 | >=520.06                      |
| ...                         | ...                         | ...                           |
| CUDA 11.2.2 Update 2        | >=460.32.03                 | >=461.33                      |
| CUDA 11.2.1 Update 1        | >=460.32.03                 | >=461.09                      |
| CUDA 11.2.0 GA              | >=460.27.03                 | >=460.82                      |
| ...                         | ...                         | ...                           |
| CUDA 9.2 (9.2.148 Update 1) | >= 396.37                   | >= 398.26                     |
| CUDA 9.2 (9.2.88)           | >= 396.26                   | >= 397.44                     |
| ...                         | ...                         | ...                           |

When installing CUDA and cuDNN, you might need to lock down the versions to obtain compatibility.

### Installation

#### 1. Linux headers

NVIDIA installs into the kernel tree. In order to do that, Linux headers are needed. **It is important we install the exact version of Linux headers**. Thus this better be done manually and separately.

First do a quick verification before install:

* Verify NVIDIA graphics is installed and is recognized in the system `lspci | grep -i nvidia`
* Verify Linux kernel `uname -r` and architecture `uname -m`

To list the linux-headers packages already installed:

```bash
sudo dpkg -l | grep 'linux-headers'
```

Then to install the Linux headers:

```bash
sudo apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
```

The command `uname -r | sed 's/[^-]*-[^-]*-//'` output `amd64`. The package `linux-headers-amd64` is the architecture-specific meta-package. The package manager points it to the package of the correct kernel version, for example, `linux-headers-4.19.0-10-amd64`. So in the list of packages to be installed, double check there is `linux-headers-4.19.0-10-amd64` where the `4.19.0-10-amd64` part should match the kernel of your system.

#### 2. DKMS

```bash
sudo apt-get install dkms
```

The dkms package is singled out to make it clear that NVIDIA installs into the kernel tree. From the Ubuntu documentation, "This DKMS (Dynamic Kernel Module Support) package provides support for installing supplementary versions of kernel modules. The package compiles and installs into the kernel tree." It turns out this package is also required by other software such as VirtulBox, Docker. Thus locking it down as a manual install.

#### 3. Graphics drivers

Note the package `nvidia-driver` requires non-free software enabled in `/etc/apt/sources.list`.

```bash
# nvidia-driver 470.103
sudo apt-get -t bullseye-backports install nvidia-driver nvidia-smi nvidia-persistenced
```

Or

```bash
# nvidia-driver 460.91
sudo apt-get install nvidia-driver nvidia-smi nvidia-persistenced
```

The `nvidia-driver` metapackage has `nvidia-kernel-dkms`, which should be installed and uninstalled together with other NVIDIA packages. That is to say, do not install `nvidia-kernel-dkms` by itself.

The `nvidia-driver` metapackage has a hard dependency to `xserver-xorg-video-nvidia` which in turn depends on `xserver-xorg-core`. Installing `nvidia-driver` pulls in the X server. However, just `xserver-xorg-core` is incomplete; it is missing the input drivers. This is addressed at the step of installing [Gnome](0303-gnome.md) by installing the meta package `xserver-xorg`.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if a reboot is needed.

To verify, `nvidia-smi`.

#### 4. CUDA toolkit

This step is optional as CUDA toolkit can be provided by anaconda.

```bash
# nvidia-cuda-toolkit 11.2.2
sudo apt-get install nvidia-cuda-toolkit
```

Alternatively, without installing the nvcc compiler (which is included in `nvidia-cuda-toolkit`):

```bash
# nvidia-cuda-dev 11.2.2
sudo apt-get install nvidia-cuda-dev
```

Here is the CUDA toolkit package tree:

```
    nvidia-cuda-toolkit
            |
            |-----> nvidia-cuda-dev
            |           |
            |           |-----> libcudart: CUDA runtime
            |           |
            |           |-----> libcublas: cuBLAS
            |           |
            |           |-----> libnvblas: nvBLAS
            |           |
            |           |-----> libcufft: cuFFT
            |           |
            |           |-----> libcufftw: cuFFTW
            |           |
            |           |-----> libcurand: cuRAND
            |           |
            |           |-----> libcusolver: cuSOLVER, LAPACK-like functions
            |           |
            |           |-----> libcusparse8.0: cuSPARSE
            |           |
            |           |=====> libcuda1 (already a hard dependency)
            |           |           |
            |           |           |=====> nvidia-cuda-mps (not installed)
            |           |
            |           |-----> libnvvm3 (library used by NVCC)
            |
            |-----> libnvvm3
            |
            |-----> nvidia-opencl-dev
            |
            |-----> nvidia-profiler
            |
            |=====> nvidia-cuda-gdb
            |
            |=====> nvidia-cuda-doc
```

To verify, `nvcc --version` should display the CUDA version.

### Conda for CUDA and cuDNN

1. Install [miniconda](https://conda.io/miniconda.html) if `conda` is not alreay installed
2. Verify
    1. Verify with Numba
        1. `conda create --name numba python=3.9`
        2. `conda activate numba`
        3. `conda install cudatoolkit cudnn numba`
        4. Launch Python
            ```python
            from numba import cuda
            cuda.detect()
            ```
            It should list the CUDA devices, e.g. 'GeForce GTX 3080 Ti'.
    2. Verify with Tensorflow
        1. `conda create --name tf python=3.9`
        2. `conda activate tf`
        3. `conda install tensorflow-gpu`
        4. Launch Python
            ```python
            import tensorflow as tf
            tf.config.list_physical_devices()
            ```
    3. Verify with PyTorch
        1. `conda create --name torch python=3.9`
        2. `conda activate torch`
        3. `conda install pytorch cudatoolkit=10.2 -c pytorch`
        4. Launch Python
            ```python
            import torch
            torch.cuda.is_available()
            ```

**Next step: [Gnome](0303-gnome.md)**
