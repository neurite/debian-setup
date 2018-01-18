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

