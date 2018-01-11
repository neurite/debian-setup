# install nvidia-cuda-toolkit into the OS
# conda install numba
# conda install cudatoolkit -- otherwise will error out

import numpy as np
from numba import vectorize
from time import perf_counter

@vectorize(['float32(float32, float32)'], target='cuda')
def add_by_gpu(a, b):
    return a + b

@vectorize(['float32(float32, float32)'], target='cpu')
def add_by_cpu(a, b):
    return a + b

def timeit(func, *args, **kwargs):
    start = perf_counter()
    result = func(*args, **kwargs)
    end = perf_counter()
    return end-start, result

if __name__ == '__main__':
    # Init
    N = (1000, 1000)
    A = np.ones(N, dtype=np.float32)
    B = np.ones(A.shape, dtype=A.dtype)
    C = np.empty_like(A, dtype=A.dtype)
    # CPU
    t, C = timeit(add_by_cpu, A, B)
    print(C)
    print('CPU time', t)
    # GPU
    t, C = timeit(add_by_gpu, A, B)
    print(C)
    print('GPU time', t)

