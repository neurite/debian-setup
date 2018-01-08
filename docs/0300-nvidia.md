### What to install

There are two sources for the NVIDIA packages. One is the package repository managed by Debian and the other is NVIDIA.

NVIDIA provides the latest versions. Since the end target is CUDA, installing CUDA essentially installs all the packages. NVIDIA has [excellent documentation on CUDA installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/).

Alternatively, Debian has slightly older version of NVIDIA packages. But installation is a breeze. Debian has [documention on NVIDIA graphic drivers](https://wiki.debian.org/NvidiaGraphicsDrivers). The individual packages to install are:

1. [Linux headers](https://packages.debian.org/stretch/linux-headers-amd64)
2. [NVIDIA kernel and driver](https://packages.debian.org/stretch/nvidia-driver)
3. [NVIDIA CUDA toolkit](https://packages.debian.org/stretch/nvidia-cuda-toolkit)

Note nvidia-cuda-toolkit is not in stretch backports. Otherwise, we could upgrade the Linux kernel via the backports. Backports would provide newer versions of the packages.

### Verify

* Verify NVIDIA graphics is installed and recognized in the system `lspci | grep -i nvidia`
* Verify Linux kernel `uname -r` and architecture `uname -m`

### Linux headers

NVIDIA installs into the kernel tree. In order to do that, Linux headers are needed.

It is important we install the exact version of Linux headers. Thus this better be done manually.

`sudo apt-get install linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')`

The command `uname -r | sed 's/[^-]*-[^-]*-//'` output `amd64`. The package `linux-headers-amd64` is the architecture-specific meta package. The package manager points it to the correct package, for example, `linux-headers-4.9.0-5-amd64`.

So in the list of packages to be installed, double check there is `linux-headers-4.9.0-5-amd64` where `4.9.0-5-amd64` should match the kernel.

### NVIDIA kernel and driver

`sudo apt-get install dkms nvidia-kernel-dkms nvidia-driver`

Must restart to replace nouveau with nvidia.

### CUDA

`sudo apt-get install nvidia-cuda-toolkit`
