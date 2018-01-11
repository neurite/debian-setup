### Overview

There are two sources for the NVIDIA packages. One is NVIDIA and the other is the Debian repository.

NVIDIA provides the latest versions. NVIDIA has [excellent documentation on CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which also describes the installation of graphics drivers.

Alternatively, Debian has slightly older version of NVIDIA packages. But installation is a breeze. Debian has [documention on NVIDIA graphic drivers](https://wiki.debian.org/NvidiaGraphicsDrivers).

Concretely the packages to install are:

1. [Linux headers](https://packages.debian.org/stretch/linux-headers-amd64)
2. [NVIDIA kernel and driver](https://packages.debian.org/stretch/nvidia-driver)
3. [NVIDIA CUDA toolkit](https://packages.debian.org/stretch/nvidia-cuda-toolkit)
4. [cuDNN](https://developer.nvidia.com/cudnn)

Note that nvidia-cuda-toolkit currently is not in stretch backports. A newer version would be in the next major release of Debian.

The package [cuDNN](https://developer.nvidia.com/cudnn) is a library for deep neural networks. It is only available from NVIDIA. Certain deep learning frameworks, such as Tensorflow, require cuDNN.

Other NVIDIA deep learning packages, not in the CUDA toolkit, include [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl). They are for production deployment of deep neural nets. They are not covered here.

### Linux Headers

First do quick verification before install:

* Verify NVIDIA graphics is installed and is recognized in the system `lspci | grep -i nvidia`
* Verify Linux kernel `uname -r` and architecture `uname -m`

Then install the Linux headers:

`sudo apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')`

NVIDIA installs into the kernel tree. In order to do that, Linux headers are needed. It is important we install the exact version of Linux headers. Thus this better be done manually and separately.

The command `uname -r | sed 's/[^-]*-[^-]*-//'` output `amd64`. The package `linux-headers-amd64` is the architecture-specific meta-package. The package manager points it to the package of correct kernel version, for example, `linux-headers-4.9.0-5-amd64`.

So in the list of packages to be installed, double check there is `linux-headers-4.9.0-5-amd64` where `4.9.0-5-amd64` should match the kernel of your system.

### NVIDIA Kernel and Driver

`sudo apt-get install dkms nvidia-kernel-dkms nvidia-driver`

The dkms packages are singled out to make it clear that NVIDIA installs into the kernel tree. They are actually hard dependencies of the `nvidia-driver` metapackage.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if that is the case.

### CUDA Toolkit

`sudo apt-get install nvidia-cuda-toolkit`

Here is the CUDA toolkit package tree:

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
            |                       |
            |                       |=====> nvidia-cuda-mps
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

(TODO: Verify CUDA toolkit installation -- NVIDIA CUDA samples? Numba, PyTorch)

### cuDNN

(TODO: Download from NVIDIA)
