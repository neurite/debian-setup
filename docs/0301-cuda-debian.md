### NVIDIA graphics Driver

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
    5. TODO: How about PyTorch?

### cuDNN

TODOs:

1. Download from NVIDIA
2. Compatible versions (toolkit 8.0) (cuDNN 5.1, 6.0) (compute version)
3. Install path
4. Verify (torch.cuda.is_available())

