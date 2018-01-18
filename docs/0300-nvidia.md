### Packages

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiers can be optional. Here is the landscape of the package tiers:

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

Other NVIDIA deep learning packages, such as [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl), are not covered here.

### Sources

As you already see in the above list, there are two sources for the NVIDIA packages. One is Debian, the other is NVIDIA.

Debian has older versions of the NVIDIA packages. But installation is a breeze. Debian has [documention on NVIDIA graphic drivers](https://wiki.debian.org/NvidiaGraphicsDrivers). Debian Stretch has [CUDA 8.0](https://packages.debian.org/stretch/nvidia-cuda-toolkit) while Debian Buster has [CUDA 9.0](https://packages.debian.org/buster/nvidia-cuda-toolkit). As of this moment, Debian repositories do not have cuDNN. Be aware that, most deep learning frameworks, such as Tensorflow, MXNet, PyTorch, require cuDNN to provide GPU support.

NVIDIA provides the latest versions. NVIDIA has good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN.

### Linux Headers

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

### dkms

```bash
sudo apt-get install dkms
```

The dkms package is singled out to make it clear that NVIDIA installs into the kernel tree. From the Ubuntu documentation, "This DKMS (Dynamic Kernel Module Support) package provides support for installing supplementary versions of kernel modules. The package compiles and installs into the kernel tree." It turns out this package is also required by other software such as VirtulBox. Thus locking it down as a manual install.

### Graphics drivers, CUDA, cuDNN

From here, we will part into two paths:

* [Install graphics drivers only using the Debian repository](0301-cuda-debian.md)
* [Install graphics drivers, CUDA, and cuDNN from NVIDIA](0302-cuda-nvidia.md)

As said, Debian Stretch 1) has older versions of graphics drivers and CUDA toolkit, and 2) does not have cuDNN. If you want only the graphics drivers, you can install it from the Debian repo. Otherwise, you should install the rest of NVIDIA packages from NVIDIA.
