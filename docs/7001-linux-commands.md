### Dot (.) command

Equavilent to `source`. It "evaluates commands in a computer file in the current execution context."

### locate

`locate train.tsv`

### tar

```bash

tar --help

# gzip
tar cvzf csv.tar.gz  csv/

# bzip2
tar cvjf csv.tar.bz2 csv/

# lzma2, xz
tar cvJf csv.tar.xz  csv/

# Extract
tar xvzf csv.tar.gz
tar xvjf csv.tar.bz2
tar xvJf csv.tar.xz
```

CPU time for storage space. Example, archiving and compressing 626 MB of CSV files:

* 155 MB, gzip
* 101 MB, bzip2
* 89 MB, lzma2

### wget

```bash
# Download
wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz

# Give it a different name
wget -O mnist-train-imgs.gz http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
```
