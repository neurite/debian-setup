#!/usr/bin/env bash

### SCRIPT_FOLDER
SCRIPT_FOLDER="${HOME}/Workspace/debian-setup"
if [ ! -r "${SCRIPT_FOLDER}" ]; then
    echo "Error reading ${SCRIPT_FOLDER}" 1>&2
    exit 1
fi

### Check that conda is installed
if [[ ! $(which conda) ]]; then
    echo "Cannot find command 'conda'" 1>&2
    echo "Please install anaconda or miniconda" 1>&2
    exit 1
fi

# Check if a conda env already exists
function check_conda_env() {
    if [[ $(conda env list | grep -E ".+/envs/${1}$") ]]; then
        # As bash functions cannot return values, use command substitution
        echo "true"
        return 0
    fi
    return 0
}

### jupyter (ipython)
if [[ ! $(check_conda_env jupyter) ]]; then
    cd
    conda create --yes --name jupyter python=3
    source activate jupyter
    conda install --yes jupyter
    conda install --yes requests
    conda install --yes sqlite
    source deactivate
fi

### scrapy
if [[ ! $(check_conda_env scrapy) ]]; then
    cd
    conda create -y -n scrapy --clone jupyter
    source activate scrapy
    conda install -y beautifulsoup4
    conda install -y scrapy
    source deactivate
fi

### scikit-learn
if [[ ! $(check_conda_env sklearn) ]]; then
    cd
    conda create -y -n sklearn --clone jupyter
    source activate sklearn
    conda install -y numpy
    conda install -y scipy
    conda install -y matplotlib
    conda install -y pandas
    conda install -y sympy
    conda install -y scikit-learn
    conda install -y seaborn
    source deactivate
fi

### scikit-image
if [[ ! $(check_conda_env skimage) ]]; then
    cd
    conda create -y -n skimage --clone sklearn
    source activate skimage
    conda install -y scikit-image
    source deactivate
fi
