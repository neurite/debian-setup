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
