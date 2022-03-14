## NVIDIA

### Table of Contents

   * [Package Tiers](#package-tiers)
   * [Package Versions](#package-versions)
       * [Sources](#sources)
       * [Compatible Versions](#compatible-versions)
   * [Installation](#installation)
       1. [Linux headers](#1-linux-headers)
       2. [DKMS](#2-dkms)
       3. [Graphics drivers](#3-graphics-drivers)
       4. [CUDA toolkit](#4-cuda-toolkit)
   * [Conda for CUDA and cuDNN](#conda-for-cuda-and-cudnn)


### Package Tiers

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiers can be optional. Here is the landscape of the package tiers:

1. Linux headers
    1. [linux-headers-amd64 5.15 (bullseye-backports)](https://packages.debian.org/bullseye-backports/linux-headers-amd64)
    2. [linux-headers-amd64 5.10 (bullseye)](https://packages.debian.org/bullseye/linux-headers-amd64)
    3. [linux-headers-amd64 5.10 (buster-backports)](https://packages.debian.org/buster-backports/linux-headers-amd64)
    4. [linux-headers-amd64 4.19 (buster)](https://packages.debian.org/buster/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [nvidia-driver 470.103 (bullseye-backports)](https://packages.debian.org/bullseye-backports/nvidia-driver)
    2. [nvidia-driver 460.91 (bullseye)](https://packages.debian.org/bullseye/nvidia-driver)
    3. [nvidia-driver 460.73 (buster-backports)](https://packages.debian.org/buster-backports/nvidia-driver)
    4. [nvidia-driver 418.211 (buster)](https://packages.debian.org/buster/nvidia-driver)
    5. [NVIDIA list](http://www.nvidia.com/object/unix.html)
3. NVIDIA CUDA toolkit
    1. [nvidia-cuda-toolkit 11.2.2 (bullseye)](https://packages.debian.org/bullseye/nvidia-cuda-toolkit)
    2. [nvidia-cuda-toolkit 11.2.2 (buster-backports)](https://packages.debian.org/buster-backports/nvidia-cuda-toolkit)
    3. [nvidia-cuda-toolkit 9.2.148 (buster)](https://packages.debian.org/buster/nvidia-cuda-toolkit)
    4. [anaconda cudatoolkit](https://anaconda.org/anaconda/cudatoolkit)
    5. [NVIDIA doc](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
4. cuDNN
    1. [anaconda cudnn](https://anaconda.org/anaconda/cudnn)
    2. [NVIDIA doc](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/)

Other NVIDIA deep learning packages, such as [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl), are not covered here.

### Package Versions

#### Sources

##### 1. Debian

Debian has older versions of the NVIDIA packages. But installation is a breeze. As of Debian Bullseye, there is no cuDNN. The package [nvidia-cudnn](https://packages.debian.org/bookworm/nvidia-cudnn) is being tested. 

##### 2. NVIDIA

NVIDIA provides the latest versions. NVIDIA has good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN. In the cuDNN documentation, you can clearly see the 2 prerequisites: graphics drivers and CUDA.

NVIDIA installation supports Debian Bullseye 11.2 (kernel 5.10).

##### 3. Conda

Conda provides CUDA toolkit and cuDNN. Note they requires compatible versions of the graphics driver to function. In fact, conda has multiple channels providing CUDA toolkit and cuDNN. The default channel has [cudatoolkit](https://anaconda.org/anaconda/cudatoolkit) and [cudnn](https://anaconda.org/anaconda/cudnn). The conda-forge channel has newer versions of [cudatoolkit](https://anaconda.org/conda-forge/cudatoolkit) and [cudnn](https://anaconda.org/conda-forge/cudnn). The NVIDIA channel has [cuda](https://anaconda.org/nvidia/cuda) and [cudnn](https://anaconda.org/nvidia/cudnn).

#### Compatible Versions

First, choose the version of the graphics driver that is compatible with the GPUs at hand. For example, for 2070 Super, the graphics driver from `buster-backports` or later is needed. For 3080 TI, `bullseye` or later is needed.

| Debian Release     | NVIDIA graphics driver | Supported GPUs | Note |
|--------------------|------------------------|----------------|------|
| bullseye-backports | [nvidia-driver 470.103.01](https://packages.debian.org/bullseye-backports/nvidia-driver) | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/470.103.01/README/supportedchips.html) |                           |
| bullseye           | [nvidia-driver 460.91.03](https://packages.debian.org/bullseye/nvidia-driver)            | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/460.91.03/README/supportedchips.html)  | 3070 ti, 3080 ti          |
| buster-backports   | [nvidia-driver 460.73.01 ](https://packages.debian.org/buster-backports/nvidia-driver)   | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/460.73.01/README/supportedchips.html)  | 20xx super, 30xx, 3060 ti |
| buster             | [nvidia-driver 418.211 ](https://packages.debian.org/buster/nvidia-driver)               | [supported devices](https://us.download.nvidia.com/XFree86/Linux-x86_64/418.113/README/supportedchips.html)    | 20xx, 20xx ti             |

Second, it is critical that CUDA is supported by a **compatible graphics driver**. Here is a table copied from NVIDIA's release nots of [CUDA toolkit components](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#major-components):

| CUDA Toolkit                | Linux x86_64 Driver Version | Windows x86_64 Driver Version |
|-----------------------------|-----------------------------|-------------------------------|
| CUDA 11.6 Update 1          | >=510.47.03                 | >=511.65                      |
| CUDA 11.6 GA                | >=510.39.01                 | >=511.23                      |
| CUDA 11.5 Update 2          | >=495.29.05                 | >=496.13                      |
| CUDA 11.5 Update 1          | >=495.29.05                 | >=496.13                      |
| CUDA 11.5 GA                | >=495.29.05                 | >=496.04                      |
| CUDA 11.4 Update 4          | >=470.82.01                 | >=472.50                      |
| CUDA 11.4 Update 3          | >=470.82.01                 | >=472.50                      |
| CUDA 11.4 Update 2          | >=470.57.02                 | >=471.41                      |
| CUDA 11.4 Update 1          | >=470.57.02                 | >=471.41                      |
| CUDA 11.4.0 GA.             | >=470.42.01                 | >=471.11                      |
| CUDA 11.3.1 Update 1        | >=465.19.01                 | >=465.89                      |
| CUDA 11.3.0 GA              | >=465.19.01                 | >=465.89                      |
| CUDA 11.2.2 Update 2        | >=460.32.03                 | >=461.33                      |
| CUDA 11.2.1 Update 1        | >=460.32.03                 | >=461.09                      |
| CUDA 11.2.0 GA              | >=460.27.03                 | >=460.82                      |
| CUDA 11.1.1 Update 1        | >= 455.32                   | >= 456.81                     |
| CUDA 11.1 GA                | >= 455.23                   | >= 456.38                     |
| CUDA 11.0.3 Update 1        | >= 450.51.06                | >= 451.82                     |
| CUDA 11.0.2 GA              | >= 450.51.05                | >= 451.48                     |
| CUDA 11.0.1 RC              | >= 450.36.06                | >= 451.22                     |
| CUDA 10.2.89                | >= 440.33                   | >= 441.22                     |
| CUDA 10.1.105               | >= 418.39                   | >= 418.96                     |
| CUDA 10.0.130               | >= 410.48                   | >= 411.31                     |
| CUDA 9.2 (9.2.148 Update 1) | >= 396.37                   | >= 398.26                     |
| CUDA 9.2 (9.2.88)           | >= 396.26                   | >= 397.44                     |
| CUDA 9.1 (9.1.85)           | >= 390.46                   | >= 391.29                     |
| CUDA 9.0 (9.0.76)           | >= 384.81                   | >= 385.54                     |
| CUDA 8.0 (8.0.61 GA2)       | >= 375.26                   | >= 376.51                     |
| CUDA 8.0 (8.0.44)           | >= 367.48                   | >= 369.30                     |
| CUDA 7.5 (7.5.16)           | >= 352.31                   | >= 353.66                     |
| CUDA 7.0 (7.0.28)           | >= 346.46                   | >= 347.62                     |

When installing CUDA and cuDNN, you may need to lock down the versions to obtain compatibility.

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
