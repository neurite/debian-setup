### NVIDIA Graphics Driver

```bash
sudo apt-get install nvidia-driver
```

The `nvidia-driver` metapackage has `nvidia-kernel-dkms`, which should be installed and uninstalled together with other NVIDIA packages.

In the end, restart to replace nouveau with nvidia. You will be prompted during installation if a reboot is needed.

### CUDA Toolkit

```bash
sudo apt-get install nvidia-cuda-toolkit
```

You can also install the CUDA toolkit from Debian. Note this is how far you can go with the Debian repo. The cuDNN package is from NVIDIA only. If you need it, you are on the wrong page and should follow [a different path](0302-cuda-nvidia.md).

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

CUDA toolkit installed from Debian does not seem to have [CUDA samples](http://docs.nvidia.com/cuda/cuda-samples/)?

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
