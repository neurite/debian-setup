### Overview

There are two sources for the NVIDIA packages, one is Debian, the other is NVIDIA.

Debian has older versions of the NVIDIA packages. But installation is a breeze. Debian has [documention on NVIDIA graphic drivers](https://wiki.debian.org/NvidiaGraphicsDrivers). As of this moment, the repository for Debian Stretch does not have cuDNN. Be aware that, certain deep learning frameworks, such as Tensorflow, MXNet, require cuDNN for GPU support.

NVIDIA provides the latest versions. NVIDIA has excellent documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit.

Here is the landscape of the packages to install:

1. [Linux headers](https://packages.debian.org/stretch/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [Available from Debian](https://packages.debian.org/stretch/nvidia-driver)
    2. [Available from NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
3. NVIDIA CUDA toolkit
    1. [Available from Debian](https://packages.debian.org/stretch/nvidia-cuda-toolkit)
    2. [Available from NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
4. cuDNN
    1. [Available from NVIDIA only](https://developer.nvidia.com/cudnn)

Other NVIDIA deep learning packages include [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl). They are for production deployment of deep neural nets. They are not covered here.

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
            |                       |
            |                       |=====> nvidia-cuda-mps (not installed)
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

### Verify CUDA Installation

CUDA toolkit installed from Debian does seem to have [CUDA samples](http://docs.nvidia.com/cuda/cuda-samples/)?

1. Verify graphics driver
    * `cat /proc/driver/nvidia/version`
    * `nvidia-smi`

2. Verify the CUDA compiler
    * `nvcc --version`

3. Numba
    1. [Install miniconda](https://conda.io/miniconda.html)
    2. [Create a conda environment](https://conda.io/docs/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands) for testing numba
    3. [Activate the environment](https://conda.io/docs/user-guide/tasks/manage-environments.html#activating-an-environment), then
        ```bash
        conda install numba
        conda install cudatoolkit
        ```
    4. Launch the python REPL in the active numba environment, the following indicates CUDA installation failure,
       ```
       >>> from numba import cuda
       >>> 
       >>> cuda.detect()
       ```
       ```
       numba.cuda.cudadrv.error.CudaSupportError: Error at driver init:
       CUDA driver library cannot be found.
       ```

### cuDNN

(TODO: Download from NVIDIA)
