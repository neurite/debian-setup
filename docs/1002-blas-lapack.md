
### Build Tools

As the name suggests these are for building packages. They are needed by Python and MXNet.

```bash
sudo apt-get install dpkg-dev libc6-dev gcc g++ gfortran make check
```
Note these packages are covered by [the root-bootstrap.sh script](https://github.com/neurite/debian-setup/blob/master/root-bootstrap.sh).

You can also check the [`build-essential`](https://packages.debian.org/stretch/build-essential) meta-package which manages a similar list.

### Linear Algebra Libraries

There are various scenarios where these libraries need to be explicitly installed. Such scenarios include:

1. Python packages, such as numpy and scipy, installed in virtual environments
2. Frameworks like MXNet that make their own packages
3. Java packages that utilize JNI for backend computations

In Debian, we have the following options for linear algebra packages:

* [BLAS](https://packages.debian.org/jessie-backports/libblas3) and [LAPACK](https://packages.debian.org/jessie-backports/liblapack3)

BLAS is for Basic Linear Algebra Subroutines. LAPACK is for Linear Algebra Package. The packages `libblas3` and `liblapack3` are the Fortran reference implementations from [netlib](http://www.netlib.org/).

The dev packages are included in the list for building other packages.

```bash
sudo apt-get -t jessie-backports install libblas3 libblas-dev liblapack3 liblapack-dev
```

* [ATLAS](https://packages.debian.org/jessie-backports/libatlas3-base) (recommended)

"Currently ATLAS supplies optimized versions for the complete set of linear algebra kernels known as the Basic Linear Algebra Subroutines (BLAS), and a subset of the linear algebra routines in the LAPACK library."

```bash
sudo apt-get -t jessie-backports install libatlas3-base libatlas-base-dev
```

* [OpenBLAS](https://packages.debian.org/jessie-backports/libopenblas-base) (recommended)

Another optimized BLAS library. "Unlike Atlas, OpenBLAS provides a multiple architecture library. All kernel will be included in the library and dynamically switched to the best architecture at run time (only on x86 arches)." This package includes implementation of LAPACK.

```bash
sudo apt-get -t jessie-backports install libopenblas-base libopenblas-dev
```

* Others

    * [MKL](https://software.intel.com/en-us/mkl) is Math Kernel Library optimized for Intel. Download from Intel.
    * ACML AMD Core Math Library.
    * [Accelerate](https://developer.apple.com/documentation/accelerate) which includes Apple's implementation of BLAS. It's a standard framework of OS X.

Recommend either ATLAS or OpenBLAS. If you have multiple installs, you can choose which linear algebra library to use by `update-alternatives`,

```bash
sudo update-alternatives --config libblas.so.3
sudo update-alternatives --config liblapack.so.3
```

Finally see a similar summary on [Debian's Wiki of linear algebra libraries](https://wiki.debian.org/DebianScience/LinearAlgebraLibraries).
