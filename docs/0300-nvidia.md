### Overview

#### Sources

There are two sources for the NVIDIA packages, one is Debian, the other is NVIDIA.

Debian has older versions of the NVIDIA packages. But installation is a breeze. Debian has [documention on NVIDIA graphic drivers](https://wiki.debian.org/NvidiaGraphicsDrivers). As of this moment, the repository for Debian Stretch does not have cuDNN. Be aware that, most deep learning frameworks, such as Tensorflow, MXNet, PyTorch, require cuDNN for GPU support.

NVIDIA provides the latest versions. NVIDIA has excellent documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN.

#### Packages

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiears can be optional. Here is the landscape of the package tiers:

1. Linux headers
    1. [Debian only](https://packages.debian.org/stretch/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [Debian](https://packages.debian.org/stretch/nvidia-driver)
    2. [NVIDIA](http://www.nvidia.com/object/unix.html) (also included in the CUDA toolkit installation below)
3. NVIDIA CUDA toolkit
    1. [Debian](https://packages.debian.org/stretch/nvidia-cuda-toolkit)
    2. [NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) (includes the graphics driver installation)
4. cuDNN
    1. [NVIDIA only](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/)

Other NVIDIA deep learning packages include [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl). They are not covered here.

### Linux Headers

NVIDIA installs into the kernel tree. In order to do that, Linux headers are needed. **It is important we install the exact version of Linux headers**. Thus this better be done manually and separately.

First do a quick verification before install:

* Verify NVIDIA graphics is installed and is recognized in the system `lspci | grep -i nvidia`
* Verify Linux kernel `uname -r` and architecture `uname -m`

Then install the Linux headers:

`sudo apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')`

The command `uname -r | sed 's/[^-]*-[^-]*-//'` output `amd64`. The package `linux-headers-amd64` is the architecture-specific meta-package. The package manager points it to the package of the correct kernel version, for example, `linux-headers-4.9.0-5-amd64`. So in the list of packages to be installed, double check there is `linux-headers-4.9.0-5-amd64` where the `4.9.0-5-amd64` part should match the kernel of your system.

From here, we will part into two paths:

### CUDA

* [Install CUDA using the Debian repository](0301-cuda-debian.md)
* [Install CUDA from NVIDIA](0302-cuda-nvidia.md)
