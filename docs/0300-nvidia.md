## NVIDIA

### Table of Contents

   * [Packages](#packages)
   * [Sources](#sources)
   * [Installation](#installation)
       1. [Linux headers](#1-linux-headers)
       2. [dkms](#2-dkms)
       3. [Graphics drivers](#3-graphics-drivers)
       4. [CUDA](#4-cuda)
       5. [Fix gcc, g++ compilers](#5-fix-gcc-g-compilers)
       6. [Verify CUDA](#6-verify-cuda-installation)
       7. [cuDNN](#7-cudnn)
   * Conda Option for CUDA and cuDNN (to be written)

### Packages

We have 4 tiers of packages to install. They are tiered because a particular tier depends on packages of previous tiers. Depending on the need, the last 2 tiers can be optional. Here is the landscape of the package tiers:

1. Linux headers
    1. [Debian](https://packages.debian.org/stretch/linux-headers-amd64)
2. NVIDIA graphics driver
    1. [Debian](https://packages.debian.org/stretch/nvidia-driver)
    2. [NVIDIA](http://www.nvidia.com/object/unix.html) (also included in the CUDA toolkit installation below)
3. NVIDIA CUDA toolkit
    1. [Debian](https://packages.debian.org/stretch/nvidia-cuda-toolkit)
    2. [NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) (includes the graphics driver installation)
4. cuDNN
    1. [NVIDIA](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/)
    2. [Conda](https://anaconda.org/anaconda/cudnn)

Other NVIDIA deep learning packages, such as [TensorRT](https://developer.nvidia.com/tensorrt) and [NCCL](https://developer.nvidia.com/nccl), are not covered here.

### Sources

Debian has older versions of the NVIDIA packages. But installation is a breeze. As of this moment, Debian repositories do not have cuDNN. Be aware that, most deep learning frameworks, such as Tensorflow, MXNet, PyTorch, require cuDNN to provide GPU support.

NVIDIA provides the latest versions. NVIDIA has good documentation on [CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/), which describes the installation of both the graphics drivers and the CUDA toolkit. NVIDIA also has detailed documention on [cuDNN installation](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/). Note you must register with NVIDIA to download and install cuDNN. In the cuDNN documentation, you can clearly see the 2 prerequisites: graphics drivers and CUDA.

Packages installed via NVIDIA has a unique challenge for Debian systems -- Debian is **not** an officially supported Linux variant via NVIDA. The closest one to Debian Stretch is Ubuntu 17.04. I tried the CUDA 9.1 installation, which failed due to missing dependencies to Ubuntu packages. There may be hacks to mix in these packages from Ubuntu. However, it looks to me like a treacherous path ahead.

After experimenting different versions, different sources of the packages, here is a viable yet relatively easy path:

| packages                | version       | source            |
|-------------------------|---------------|-------------------|
| linux headers, dkms     | 4.9.0-5-amd64 | stretch           |
| nvidia graphics drivers | 375.82        | stretch           |
| nvidia cuda toolkit     | 8.0.44        | stretch           |
| nvidia cudnn            | 7.0.5         | nvidia            |

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
sudo apt-get install nvidia-driver
```

Note `nvidia-driver` version 384.111 from the backports is not compatible with the cuda toolkit version 8.0.44. As of now, there is no cuda toolkit in the backports.

The `nvidia-driver` metapackage has `nvidia-kernel-dkms`, which should be installed and uninstalled together with other NVIDIA packages.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if a reboot is needed.

#### 4. CUDA

```bash
sudo apt-get install nvidia-cuda-toolkit
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

#### 5. Fix gcc, g++ compilers

The `nvcc` compiler is available from `/usr/bin/nvcc`. There is also a `nvcc` executable via `/usr/lib/nvidia-cuda-toolkit/bin/nvcc`. In the same folder, there are also `/usr/lib/nvidia-cuda-toolkit/bin/gcc` and `/usr/lib/nvidia-cuda-toolkit/bin/g++`. If they are broken, for example:

```bash
$ /usr/lib/nvidia-cuda-toolkit/bin/gcc --version

ERROR: No supported gcc/g++ host compiler found, but clang-3.8 is avialable
```

It turns out to be caused by missing dependency to `gcc-5` and `g++-5`. If they are not fixed, they cause problems down the road. They are avaible from Debian unstable. To install them, we need to add Debian testing and Debian unstable. Then they need to be pinned. Here is how:

Add Debian testing and unstable to `/etc/apt/sources.list`:

```bash
deb http://ftp.us.debian.org/debian/ testing main contrib non-free
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free
```

Set up [apt pinning](https://wiki.debian.org/AptPreferences), add file `/etc/apt/preferences`:

```bash
Package: *
Pin: release a=stable
Pin-Priority: 900

Package: *
Pin: release a=testing
Pin-Priority: 800

Package: *
Pin: release a=unstable
Pin-Priority: 700
```

It simply means packages have the highest priority from stable. If we do not pin them like the above, they will update and upgrade to unstable versions, including the kernel.

```bash
sudo apt-get update
sudo apt-get -t unstable install gcc-5 g++-5
```

The packages `gcc-5` and `g++-5` are only available in unstable. Even without specifing the port, they will fall through to unstable. The reason for `-t unstable` is because dependencies such as `binutils`. Their compatible versions are only available in unstable. We also want to "pin" them.

Now `/usr/lib/nvidia-cuda-toolkit/bin/gcc --version` should show gcc-5. Whereas `gcc` via `/usr/bin/gcc`, a different name from `gcc-5`, still runs gcc 6.

#### 6. Verify CUDA Installation

CUDA toolkit installed from Debian does not seem to have [CUDA samples](http://docs.nvidia.com/cuda/cuda-samples/)?

1. Verify graphics driver
    * `cat /proc/driver/nvidia/version`
    * `nvidia-smi`

2. Verify the CUDA compiler
    * `nvcc --version`

#### 7. cuDNN

Download [cuDNN](https://developer.nvidia.com/rdp/cudnn-download) from NVIDIA. You must login to download.

Download cuDNN v7.0.5 for CUDA 8.0 with the following files:

* cuDNN v7.0.5 Runtime Library for Ubuntu16.04 (Deb)
* cuDNN v7.0.5 Developer Library for Ubuntu16.04 (Deb)
* cuDNN v7.0.5 Code Samples and User Guide for Ubuntu16.04 (Deb)

Install:

```bash
sudo dpkg -i Packages/libcudnn7_7.0.5.15-1+cuda8.0_amd64.deb 
sudo dpkg -i Packages/libcudnn7-dev_7.0.5.15-1+cuda8.0_amd64.deb 
sudo dpkg -i Packages/libcudnn7-doc_7.0.5.15-1+cuda8.0_amd64.deb 
```

Verify:

Copy the samples to a temporary folder:

```bash
mkdir ~/Temporary
cp -r /usr/src/cudnn_samples_v7/ ~/Temporary/
```

Go to the MNIST sample folder:

```bash
cd ~/Temporary/cudnn_samples_v7/mnistCUDNN/
```

Note the Makefile points to the wrong location for the compilers. Fix it:

```bash
CUDA_PATH ?= /usr/lib/nvidia-cuda-toolkit
```

Test the sample:

```bash
make clean && make
./mnistCUDNN
```

Verify with pytorch. Create a conda environment and activate it. Install pytorch for CUDA 8:

```bash
conda install pytorch torchvision -c pytorch
```

```python
>>> import torch
>>> torch.cuda.is_available()
True
```

### Conda for CUDA and cuDNN

`sudo apt-get install nvidia-cuda-dev`

`conda install cudatoolkit cudnn`

Verify with TensorFlow:

`conda install tensorflow-gpu keras`

Then in Python:

```python
import tensorflow as tf

sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))
```

3. Numba
    1. [Install miniconda](https://conda.io/miniconda.html)
    2. [Create a conda environment](https://conda.io/docs/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands) for testing numba
    3. [Activate the environment](https://conda.io/docs/user-guide/tasks/manage-environments.html#activating-an-environment), then
        ```bash
        conda install cudatoolkit
        conda install numba
        ```
    4. Launch the python REPL in the active numba environment, the following indicates CUDA installation failure,
       ```
       >>> from numba import cuda
       >>> 
       >>> cuda.detect()
       ```
       It should list the CUDA devices, e.g. 'GeForce GTX 1080 Ti'. Otherwise, you will see an error:
       ```
       numba.cuda.cudadrv.error.CudaSupportError: Error at driver init:
       CUDA driver library cannot be found.
       ```
