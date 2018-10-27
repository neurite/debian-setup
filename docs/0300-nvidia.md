## NVIDIA

### Table of Contents

   * [Package Tiers](#package-tiers)
   * [Package Versions](#package-versions)
       * [Sources](#sources)
       * [Versions](#versions)
   * [Installation](#installation)
       1. [Linux headers](#1-linux-headers)
       2. [dkms](#2-dkms)
       3. [Graphics drivers](#3-graphics-drivers)
       4. [CUDA toolkit](#4-cuda-toolkit)
   * [Conda for CUDA and cuDNN](#conda-for-cuda-and-cudnn)

### Package Tiers

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiers can be optional. Here is the landscape of the package tiers:

1. Linux headers
    1. [Stretch](https://packages.debian.org/stretch/linux-headers-amd64) ([Stretch Backports](https://packages.debian.org/stretch-backports/linux-headers-amd64))
2. NVIDIA graphics driver
    1. [Stretch](https://packages.debian.org/stretch/nvidia-driver) ([Stretch Backports](https://packages.debian.org/stretch-backports/nvidia-driver))
    2. [NVIDIA](http://www.nvidia.com/object/unix.html) (also included in the CUDA toolkit installation below)
3. NVIDIA CUDA toolkit
    1. [Stretch](https://packages.debian.org/stretch/nvidia-cuda-toolkit) ([Stretch Backports](https://packages.debian.org/stretch-backports/nvidia-cuda-toolkit))
    2. [NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) (includes the graphics driver installation)
    3. [Conda](https://anaconda.org/anaconda/cudatoolkit)
4. cuDNN
    1. [NVIDIA](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/)
    2. [Conda](https://anaconda.org/anaconda/cudnn)

Other NVIDIA deep learning packages, such as [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl), are not covered here.

### Package Versions

#### Sources

1. Debian

Debian has older versions of the NVIDIA packages. But installation is a breeze. As of this moment, Debian repositories do not have cuDNN. Be aware that, most deep learning frameworks, such as Tensorflow, MXNet, PyTorch, require cuDNN to provide GPU support.

2. NVIDIA

NVIDIA provides the latest versions. NVIDIA has good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN. In the cuDNN documentation, you can clearly see the 2 prerequisites: graphics drivers and CUDA.

Packages installed via NVIDIA has a unique challenge for Debian systems -- Debian is **not** an officially supported Linux variant via NVIDA. The closest one to Debian Stretch is Ubuntu 17.04. I tried the CUDA 9.1 installation, which failed due to missing dependencies to Ubuntu packages. There may be hacks to mix in these packages from Ubuntu. However, it looks to me like a treacherous path ahead.

3. Conda

Conda provides CUDA toolkit and cuDNN. However, it requires compatible versions of the graphics driver (see discussion below).

#### Versions

It is **important** that the CUDA toolkit is supported by a compatible graphics driver. Here is a table copied from NVIDIA's release nots of [CUDA toolkit components](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#major-components):

| CUDA Toolkit                | Linux x86_64 Driver Version | Windows x86_64 Driver Version |
|-----------------------------|-----------------------------|-------------------------------|
| CUDA 10.0.130               | >= 410.48                   | >= 411.31                     |
| CUDA 9.2 (9.2.148 Update 1) | >= 396.37                   | >= 398.26                     |
| CUDA 9.2 (9.2.88)           | >= 396.26                   | >= 397.44                     |
| CUDA 9.1 (9.1.85)           | >= 390.46                   | >= 391.29                     |
| CUDA 9.0 (9.0.76)           | >= 384.81                   | >= 385.54                     |
| CUDA 8.0 (8.0.61 GA2)       | >= 375.26                   | >= 376.51                     |
| CUDA 8.0 (8.0.44)           | >= 367.48                   | >= 369.30                     |
| CUDA 7.5 (7.5.16)           | >= 352.31                   | >= 353.66                     |
| CUDA 7.0 (7.0.28)           | >= 346.46                   | >= 347.62                     |

After experimenting different versions, different sources of the packages, here is a viable yet relatively easy path:

| packages                | version       | source            |
|-------------------------|---------------|-------------------|
| linux headers, dkms     | 4.9+80+deb9u6 | stretch           |
| nvidia graphics drivers | 390.87        | stretch-backports |
| nvidia cuda toolkit     | 9.1.85        | stretch-backports |
| nvidia cudnn            | 7.2.1         | conda             |

### Installation

#### 1. Linux headers

NVIDIA installs into the kernel tree. In order to do that, Linux headers are needed. **It is important we install the exact version of Linux headers**. Thus this better be done manually and separately.

First do a quick verification before install:

* Verify NVIDIA graphics is installed and is recognized in the system `lspci | grep -i nvidia`
* Verify Linux kernel `uname -r` and architecture `uname -m`

Then install the Linux headers:

```bash
sudo apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
```

The command `uname -r | sed 's/[^-]*-[^-]*-//'` output `amd64`. The package `linux-headers-amd64` is the architecture-specific meta-package. The package manager points it to the package of the correct kernel version, for example, `linux-headers-4.9.0-5-amd64`. So in the list of packages to be installed, double check there is `linux-headers-4.9.0-5-amd64` where the `4.9.0-5-amd64` part should match the kernel of your system.

To list the linux-headers packages already installed:

```bash
sudo dpkg -l | grep 'linux-headers'
```

#### 2. dkms

```bash
sudo apt-get install dkms
```

The dkms package is singled out to make it clear that NVIDIA installs into the kernel tree. From the Ubuntu documentation, "This DKMS (Dynamic Kernel Module Support) package provides support for installing supplementary versions of kernel modules. The package compiles and installs into the kernel tree." It turns out this package is also required by other software such as VirtulBox, Docker. Thus locking it down as a manual install.

#### 3. Graphics drivers

Note the package `nvidia-driver` requires non-free software enabled in `/etc/apt/sources.list`.

```bash
sudo apt-get install nvidia-driver -t stretch-backports
```

The `nvidia-driver` metapackage has `nvidia-kernel-dkms`, which should be installed and uninstalled together with other NVIDIA packages.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if a reboot is needed.

#### 4. CUDA toolkit

```bash
sudo apt-get install nvidia-cuda-toolkit -t stretch-backports
```

Alternatively without installing the nvcc compiler:

```bash
sudo apt-get install nvidia-cuda-dev -t stretch-backports
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

`sudo apt-get install nvidia-cuda-dev`

`conda install cudatoolkit cudnn`

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
        3. `conda install tensorflow-gpu`
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
