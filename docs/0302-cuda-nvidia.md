Package manager installation

Download from [NVIDIA](https://developer.nvidia.com/cuda-downloads). Choose Linux -> x86_64 -> Ubuntun -> 17.04 -> deb (network). Here is the command to download from the console:

```bash
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/cuda-repo-ubuntu1704_9.1.85-1_amd64.deb
```

Since we are downloading from HTTP not HTTPS, make sure to check the md5 hash.

```bash
sudo dpkg -i cuda-repo-<distro>_<version>_<architecture>.deb
```

```bash
sudo apt-get install dirmngr
```

Need other dependencies. Might as well install a desktop.


**Require Ubuntu packages not available in Debian**

## Revert the above installs

```bash
sudo apt-get -t stretch-backports install nvidia-driver
```

The target is CUDA 8.0 then cuDNN 7.0.5. According to cuDNN's documentation, NVIDIA graphics driver 384.81 or newer is required. The backports installs driver 384.111

```bash
sudo apt-get -t stretch-backports install nvidia-cuda-toolkit
```

CUDA 8.0.44

cuDNN 7.0.5 for CUDA 8.0



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

