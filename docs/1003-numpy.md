### Numpy

When numpy is installed, it is build against (or linked with) system's linear algebra packages. Numpy by default will build against Atlas if it is installed.

For details, see [site.cfg](https://github.com/numpy/numpy/blob/master/site.cfg.example)

To display which linear algebra package numpy uses, run

```python
import numpy as np
np.show_config()
```

Also see [system_info.py](https://github.com/numpy/numpy/blob/master/numpy/distutils/system_info.py).

If numpy installed by conda, it likely uses MKL. See [conda's documentation on MKL optimization](https://docs.continuum.io/mkl-optimizations/). Results of `np.show_config()` on my laptop,

```
blas_mkl_info:
    libraries = ['mkl_intel_lp64', 'mkl_intel_thread', 'mkl_core', 'iomp5', 'pthread']
    library_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/include']
blas_opt_info:
    libraries = ['mkl_intel_lp64', 'mkl_intel_thread', 'mkl_core', 'iomp5', 'pthread']
    library_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/include']
lapack_mkl_info:
    libraries = ['mkl_intel_lp64', 'mkl_intel_thread', 'mkl_core', 'iomp5', 'pthread']
    library_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/include']
lapack_opt_info:
    libraries = ['mkl_intel_lp64', 'mkl_intel_thread', 'mkl_core', 'iomp5', 'pthread']
    library_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/Users/neurite/Applications/miniconda3/envs/temp/include']
```

### Packages that depends on numpy

* pandas, h5py, fastparquet
* matplotlib, seaborn, bokeh
* scikit-learn
* tensorflow, pytorch
* gensim, spacy
* dask

A few exceptions include jupyter, nltk, plotly

### The extended list of python packages

Install and run Python via miniconda. See [the note](https://github.com/neurite/debian-setup/wiki/Python) on installing miniconda. Alternatively, anaconda bundles in more packages. I prefer miniconda and handpick packages for individual conda environment.

Develop

* pylint -- Code analysis
* pytest -- Unit tests
* jupyter -- Interactive coding on web UI

I/O

* requests -- HTTP client
* sqlite -- SQL Database

Cloud

* awscli -- AWS Command-Line Tools, can be installed in the base, default conda env `conda install awscli -c conda-forge`

The numpy family

* blas
* intel-openmp
* libgfortran
* mkl
* mkl_fft
* mkl_random
* numpy -- "The fundamental package for scientific computing"
* numpy-base
* scipy -- "The core package for scientific computing"

Data I/O

* pandas -- Data I/O, data munging
* h5py, pytables (> 3.2) -- HDF5
* [fastparquet](https://fastparquet.readthedocs.io/en/latest/), [python-snappy](https://pypi.org/project/python-snappy/) -- Parquet
* [fastavro](https://fastavro.readthedocs.io/en/latest/), [python-snappy](https://pypi.org/project/python-snappy/) -- AVRO

Visualization

* matplotlib -- Data plotting
* seaborn -- Statistical data visualization
* bokeh (or plotly) -- Interactive visualization

Machine learning

* scikit-learn -- Machine learning
* scikit-image -- Image processing

Natural language processing

* [nltk](https://www.nltk.org/)
* [spacy](https://spacy.io/usage/)
* [gensim](https://github.com/RaRe-Technologies/gensim)

Web scraping, HTML/XML parsing

* [scrapy](https://scrapy.org/) -- Web crawl
* [beautifulsoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) -- Web page scraping

Miscellaneous

* [networkx](https://networkx.github.io) -- Graph algorithms
* [datasketch](https://ekzhu.github.io/datasketch/) -- Probalistic data structures, hashing, available via pip
* [boto3](https://github.com/boto/boto3) -- AWS Python client
* [dask](https://dask.pydata.org/) -- parallel, distributed computation

All the packages above, unless noted otherwise, can be installed via `conda install <package-name>`.

It's worth noting the SciPy Stack which is now obsolete. But even today a typical Python ML/DL environment includes jupyter, numpy, scipy, pandas, matplotlib, seaborn. Other packages such as scikit-learn, or tensorflow, or mxnet, are added on top of them.

### Conda package installation tiers

1. `conda install pylint pytest`
2. `conda install requests sqlite`
3. `conda install jupyter`
4. `conda install numpy scipy`
