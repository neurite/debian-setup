
## Deep Learning Frameworks

### TensorFlow

CPU package: `tensorflow`. GPU package: `tensorflow-gpu`. The GPU package will be covered in the NVidia section.

#### Option 1

    conda install tensorflow

This installs tensorflow from the default channel. Note for some OS conda installs older versions of tensorflow. For example, as this is being written, conda installs tensorflow version 1.1.0 for osx-64 whereas the current stable version of tensorflow is 1.3.0. The older version of tensorflow also downgrades its dependencies such as numpy and mkl. For linux-64, conda installs the latest version of tensorflow though. Again double check the versions of the packages to be installed.

#### Option 2

    conda install -c conda-forge tensorflow

If you need newer versions of tensorflow which are not available from the default channel, you can use the conda-forge channel.

### [PyTorch](https://github.com/pytorch/pytorch)

Developed by Facebook. Good for research use.

On Linux:

```bash
conda install pytorch torchvision
```

On Mac, or for newer version on Linux:

```bash
conda install pytorch torchvision -c pytorch
```

It is worth noting that it automatically pulls in dependencies for GPU support:

```
libgcc-ng 7.2.0
libgfortran-ng 7.2.0
libstdcxx-ng 7.2.0
cudatoolkit 8.0-3
cudnn 7.0.5
nccl 1.3.4
```

The following for linear algebra on CPU:

```bash
intel-openmp 2018.0.0
mkl 2018.0.1
```

### [Caffe2](https://github.com/caffe2/caffe2)

Caffe was developed by BVLC of UC Berkeley. Caffe2 was adopted and developed by Facebook. Good for industrial (production) use.

[Caffe2 model zoo](https://caffe2.ai/docs/zoo.html).

[Gloo](https://github.com/facebookincubator/gloo) for distributed GPU training.

### [MXNet](https://github.com/apache/incubator-mxnet)

Started in UW. Adopted by Apache. This is the default deep learning framework adopted by AWS.

[Example notebooks](https://github.com/dmlc/mxnet-notebooks).

[MXNet model zoo](https://mxnet.incubator.apache.org/model_zoo).

Follow these steps to install MXNet in conda,

1. Create a conda environment `conda create --name mxnet`
2. Activate the conda environment `source activate mxnet`
3. Install numpy via conda `conda install numpy`
4. Install mxnet via pip `pip install mxnet graphviz`

Note, if mxnet is installed using pip *without* installing numpy first using conda, numpy will be pulled in as a dependency of mxnet. On my MacBook, numpy installed via pip is linked against the OS X Accelerate framework. Whereas conda's numpy is linked against a locally installed MKL library. The package graphviz is a dependency on top of mxnet.

### [CNTK](https://github.com/Microsoft/CNTK)

Microsoft deep learning toolkit.

### [Keras](https://github.com/fchollet/keras)

Deep learning API on top of TensorFlow, CNTK, or Theano.

### [DMTK](https://github.com/Microsoft/DMTK)

Microsoft distributed learning toolkit.

### [XGBoost](https://github.com/dmlc/xgboost)

Boosted trees. Well this is not deep learning. But it has been used a lot in competitions.
