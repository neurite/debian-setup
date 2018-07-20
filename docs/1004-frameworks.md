
## Deep Learning Frameworks

### [TensorFlow](https://github.com/tensorflow/tensorflow)

For CPU `tensorflow`

```bash
conda install tensorflow
```

Or, for GPU `tensorflow-gpu`

```bash
conda install tensorflow-gpu
```

Note that the GPU tensorflow automatically pulls in dependencies for GPU support:

```
cudatoolkit 8.0-3
cudnn 7.0.5
```

If you want newer version, install from the `conda-forge` channel.

### [PyTorch](https://github.com/pytorch/pytorch)

CPU:

```bash
conda install pytorch -c pytorch
```

GPU:

```bash
conda install pytorch cuda91 -c pytorch
```

It is worth noting that it automatically pulls in dependencies for GPU support:

```
cudatoolkit 8.0-3
cudnn 7.0.5
nccl 1.3.4
```

### [Caffe2](https://github.com/caffe2/caffe2)

Caffe was developed by BVLC of UC Berkeley. Caffe2 was adopted and developed by Facebook. Good for industrial (production) use.

[Caffe2 model zoo](https://caffe2.ai/docs/zoo.html).

[Gloo](https://github.com/facebookincubator/gloo) for distributed GPU training.

### [MXNet](https://github.com/apache/incubator-mxnet)

Started in UW. Adopted by Apache. This is the default deep learning framework for AWS.

[Example notebooks](https://github.com/dmlc/mxnet-notebooks).

[MXNet model zoo](https://mxnet.incubator.apache.org/model_zoo).

Option 1 via conda

```bash
conda install mxnet
```

Option 2 via pip within a conda environment

```bash
conda install numpy
pip install mxnet graphviz
```

pip provides newer versions of MXNet.

Note, if mxnet is installed using pip *without* installing numpy first using conda, numpy will be pulled in as a dependency of mxnet. On my MacBook, numpy installed via pip is linked against the OS X Accelerate framework. Whereas conda's numpy is linked against a locally installed MKL library. The package graphviz is a dependency on top of mxnet.

As this is being written, MXNet with GPU support requires CUDA 9.0. I did not try it. MXNet has [instructions](https://mxnet.apache.org/install/index.html).

### [CNTK](https://github.com/Microsoft/CNTK)

Microsoft deep learning toolkit.

### [Keras](https://github.com/fchollet/keras)

Deep learning API on top of TensorFlow, CNTK, or Theano.

### [DMTK](https://github.com/Microsoft/DMTK)

Microsoft distributed learning toolkit.

### [XGBoost](https://github.com/dmlc/xgboost)

Boosted trees. Well this is not deep learning. But it has been used a lot in competitions.

Within a conda environment:

```bash
pip install xgboost
```
