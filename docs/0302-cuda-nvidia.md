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
