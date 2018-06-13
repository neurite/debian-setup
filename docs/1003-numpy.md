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

### Python Packages

Install and run Python via miniconda. See [the note](https://github.com/neurite/debian-setup/wiki/Python) on installing miniconda. Alternatively, anaconda bundles in more packages. I prefer miniconda and handpick packages for individual conda environment.

IDE

* jupyter -- Browser-based IDE

Data I/O

* sqlite -- Database, data I/O
* requests -- HTTP client, data I/O
* pandas -- Data I/O, data munging
* h5py, pytables (> 3.2) -- HDF5
* fastparquet, python-snappy -- Parquet

Scientific computing

* numpy -- "The fundamental package for scientific computing"
* scipy -- "The core package for scientific computing"

Visualization

* matplotlib -- Data plotting
* seaborn -- Statistical data visualization
* plotly (bokeh) -- Interactive visualization

Machine learning

* scikit-learn -- Machine learning
* scikit-image -- Image processing

Natural language processing

* nltk
* gensim
* spacy

Web scraping, HTML/XML parsing

* [scrapy](https://scrapy.org/)
* [beautifulsoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)

Miscellaneous

* [networkx](https://networkx.github.io) -- Graph algorithms
* [datasketch](https://ekzhu.github.io/datasketch/) -- Probalistic data structures, hashing, available via pip
* [beautiful soup](https://www.crummy.com/software/BeautifulSoup/) -- Web page scraping
* scrapy -- Web crawlers
* boto3 -- AWS S3 client
* dask -- parallel, distributed computation

All the packages above, unless noted otherwise, can be installed via `conda install <package-name>`.

It's worth noting the SciPy Stack which is now obsolete. But even today a typical Python ML/DL environment includes jupyter, numpy, scipy, pandas, matplotlib, seaborn. Other packages such as scikit-learn, or tensorflow, or mxnet, are added on top of them.
