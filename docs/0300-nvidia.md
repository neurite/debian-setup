## NVIDIA

### Table of Contents

   * [Package Tiers](#package-tiers)
   * [Package Versions](#package-versions)
       * [Sources](#sources)
       * [Versions](#versions)
   * [Installation](#installation)
       1. [Linux headers](#1-linux-headers)
       2. [DKMS](#2-dkms)
       3. [Graphics drivers](#3-graphics-drivers)
       4. [CUDA toolkit](#4-cuda-toolkit)
   * [Conda for CUDA and cuDNN](#conda-for-cuda-and-cudnn)
   * [PyTorch](#pytorch)

### Package Tiers

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiers can be optional. Here is the landscape of the package tiers:

1. Linux headers
    1. [linux-headers-amd64 4.19 (buster)](https://packages.debian.org/buster/linux-headers-amd64)
    2. [linux-headers-amd64 4.19 (stretch-backports)](https://packages.debian.org/stretch-backports/linux-headers-amd64)
    3. [linux-headers-amd64 4.9 (stretch)](https://packages.debian.org/stretch/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [nvidia-driver 450 (buster-backports)](https://packages.debian.org/buster-backports/nvidia-driver)
    2. [nvidia-driver 418 (buster)](https://packages.debian.org/buster/nvidia-driver)
    3. [nvidia-driver 418 (stretch-backports)](https://packages.debian.org/stretch-backports/nvidia-driver))
    4. [nvidia-driver 390 (stretch)](https://packages.debian.org/stretch/nvidia-driver) 
    5. [NVIDIA list](http://www.nvidia.com/object/unix.html)
3. NVIDIA CUDA toolkit
    1. [nvidia-cuda-toolkit 10.1 (buster-backports)](https://packages.debian.org/buster-backports/nvidia-cuda-toolkit)
    2. [nvidia-cuda-toolkit 9.2 (buster)](https://packages.debian.org/buster/nvidia-cuda-toolkit)
    3. [nvidia-cuda-toolkit 9.1 (stretch-backports)](https://packages.debian.org/stretch-backports/nvidia-cuda-toolkit)
    4. [nvidia-cuda-toolkit 8.0 (stretch)](https://packages.debian.org/stretch/nvidia-cuda-toolkit)
    5. [NVIDIA doc](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
    6. [conda cudatoolkit](https://anaconda.org/anaconda/cudatoolkit)
4. cuDNN
    1. [NVIDIA doc](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/)
    2. [conda cudnn](https://anaconda.org/anaconda/cudnn)

Other NVIDIA deep learning packages, such as [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl), are not covered here.

### Package Versions

#### Sources

##### 1. Debian

Debian has older versions of the NVIDIA packages. But installation is a breeze. As of this moment, Debian repositories do not have cuDNN. Be aware that, most deep learning frameworks, such as Tensorflow, MXNet, PyTorch, require cuDNN to provide GPU support.

##### 2. NVIDIA

NVIDIA provides the latest versions. NVIDIA has good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN. In the cuDNN documentation, you can clearly see the 2 prerequisites: graphics drivers and CUDA.

Packages installed via NVIDIA has a unique challenge for Debian systems -- Debian is **not** an officially supported Linux variant via NVIDA. The closest one to Debian Stretch is Ubuntu 17.04. I tried the CUDA 9.1 installation, which failed due to missing dependencies to Ubuntu packages. There may be hacks to mix in these packages from Ubuntu. However, it looks to me like a treacherous path ahead.

##### 3. Conda

Conda provides CUDA toolkit and cuDNN. However, it requires compatible versions of the graphics driver (see discussion below).

#### Versions

It is critical that CUDA is supported by **a compatible graphics driver**. Here is a table copied from NVIDIA's release nots of [CUDA toolkit components](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#major-components):

| CUDA Toolkit                | Linux x86_64 Driver Version | Windows x86_64 Driver Version |
|-----------------------------|-----------------------------|-------------------------------|
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

Choose the version of the driver that is compatible with the hardware. Note newer cards such as 2070 super, 2080 super are only supported by nvidia-driver >= 440 and thus has to be installed via `buster-backports`.

1. [nvidia-driver 450 (buster-backports)](https://packages.debian.org/buster-backports/nvidia-driver) [supported devices](http://us.download.nvidia.com/XFree86/Linux-x86_64/450.66/README/supportedchips.html)
2. [nvidia-driver 418 (buster)](https://packages.debian.org/buster/nvidia-driver) [supported devices](http://us.download.nvidia.com/XFree86/Linux-x86_64/418.113/README/supportedchips.html)
3. [nvidia-driver 418 (stretch-backports)](https://packages.debian.org/stretch-backports/nvidia-driver)) [supported devices](http://us.download.nvidia.com/XFree86/Linux-x86_64/418.113/README/supportedchips.html)
4. [nvidia-driver 390 (stretch)](https://packages.debian.org/stretch/nvidia-driver) [supported devices](http://us.download.nvidia.com/XFree86/Linux-x86_64/390.132/README/supportedchips.html)

```bash
# nvidia-driver 450
sudo apt-get -t buster-backports install nvidia-driver nvidia-smi
```

Or

```bash
# nvidia-driver 418
sudo apt-get install nvidia-driver nvidia-smi
```

The `nvidia-driver` metapackage has `nvidia-kernel-dkms`, which should be installed and uninstalled together with other NVIDIA packages.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if a reboot is needed.

To verify, `nvidia-smi`.

#### 4. CUDA toolkit

```bash
# nvidia-cuda-toolkit 10.1.243
sudo apt-get -t buster-backports install nvidia-cuda-toolkit
```

Or

```bash
# nvidia-cuda-toolkit 9.2.148
sudo apt-get install nvidia-cuda-toolkit
```

Alternatively, without installing the nvcc compiler:

```bash
sudo apt-get -t buster-backports install nvidia-cuda-dev
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

### Conda for CUDA and cuDNN

1. [Install miniconda](https://conda.io/miniconda.html)
2. Verify
    1. Verify with Numba
        1. `conda create --name cuda-numba python=3.6`
        2. `source activate cuda-numba`
        3. `conda install cudatoolkit cudnn numba`
        4. Launch Python
            ```python
            from numba import cuda
            cuda.detect()
            ```
            It should list the CUDA devices, e.g. 'GeForce GTX 1080 Ti'.
    2. Verify with Tensorflow
        1. `conda create --name cuda-tf python=3.6`
        2. `source activate cuda-tf`
        3. `conda install cudatoolkit cudnn tensorflow-gpu`
        4. Launch Python
            ```python
            import tensorflow as tf
            sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))
            ```
    3. Verify with PyTorch
        1. `conda create --name cuda-torch python=3.6`
        2. `source activate cuda-torch`
        3. `conda install pytorch`
        4. Launch Python
            ```python
            import torch
            torch.cuda.is_available()
            ```
