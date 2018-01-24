#!/usr/bin/env bash

wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/8.0_20171129/Ubuntu16_04-x64/libcudnn7_7.0.5.15-1+cuda8.0_amd64
wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/8.0_20171129/Ubuntu16_04-x64/libcudnn7-dev_7.0.5.15-1+cuda8.0_amd64
wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/8.0_20171129/Ubuntu16_04-x64/libcudnn7-doc_7.0.5.15-1+cuda8.0_amd64

sudo dpkg -i Packages/libcudnn7_7.0.5.15-1+cuda8.0_amd64.deb 
sudo dpkg -i Packages/libcudnn7-dev_7.0.5.15-1+cuda8.0_amd64.deb 
sudo dpkg -i Packages/libcudnn7-doc_7.0.5.15-1+cuda8.0_amd64.deb 
