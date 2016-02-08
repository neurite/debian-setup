#!/usr/bin/env bash

echo "Checking preconditions..."

# This should be run by the root user
if [[ "${EUID}" -ne 0 ]]; then
    echo "[ERROR] This script must run as root." 1>&2
    exit 1
fi

echo "Done checking preconditions."

cd

export DEBIAN_FRONTEND=noninteractive

# Add '/usr/local/bin' to root's $PATH variable.
export PATH="${PATH}:/usr/local/bin"

# Upgrade
echo "Updating and upgrading system."
apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

echo "Installing basic packages."

# Additional fonts
apt-get -q -y install fonts-droid fonts-inconsolata

# gcc -- The GNU C compiler
# g++ -- The GNU C++ compiler, a fairly portable optimizing compiler for C++
# gfortran -- The GNU Fortran 95 compiler
# make -- GNU Make
# check -- A simple interface for defining unit tests
apt-get -q -y install gcc g++ gfortran make check

# From the Ubuntu documentation:
# "This DKMS (Dynamic Kernel Module Support) package provides support for
# installing supplementary versions of kernel modules. The package compiles
# and installs into the kernel tree."
apt-get -q -y install dkms

apt-get -q -y install openssl

apt-get -q -y install curl wget

apt-get -q -y install vim

apt-get -q -y install git
apt-get -q -y install libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring/
make
cd

# Handy command-line tool for handling CSV files based on OCaml
apt-get -q -y install csvtool

apt-get -q -y install ruby-dev ruby

echo "Installing python packages."
# Python header files
apt-get -q -y install python-dev python3-dev
# Linear algebra packages needed by numpy and scipy
# These depedencies do not need to be installed explicitly if the
# Debian packages, python-numpy or python-scipy, are installed.
# If numpy or scipy are installed only in virtualenvs, these linear
# algebra packages must be installed explicitly. The same can be
# said for other Python dependencies.
apt-get -q -y install libblas3 libblas-dev liblapack3 liblapack-dev
# FreeType libraries needed by matplotlib
apt-get -q -y install libfreetype6 libfreetype6-dev
# Dependencies needed by cryptography
apt-get -q -y install libffi-dev libssl-dev
# Needed by Qt?
# apt-get -q -y install libcanberra-gtk-module
# Core python packages
apt-get -q -y install python python3
# pip
# Note only use pip in virtual envs
apt-get -q -y install python-pip python3-pip
# virtualenv
apt-get -q -y install virtualenv
# SciPy stack for Python 2
# apt-get -q -y install ipython ipython-notebook
# apt-get -q -y install python-numpy python-matplotlib python-scipy
# apt-get -q -y install python-pandas python-sklearn python-sympy
# Scipy stack for Python 3
# Note for jessie this is incomplete missing sympy and sklearn
# apt-get -q -y install ipython3 ipython3-notebook
# apt-get -q -y install python3-numpy python3-matplotlib python3-scipy
# apt-get -q -y install python3-pandas
apt-get -q -y install awscli

# java
echo "Installing open jdk 7 and 8."
apt-get -q -y install openjdk-7-jdk openjdk-7-source
apt-get -q -y -t jessie-backports install openjdk-8-jdk openjdk-8-source

# clean up
echo "Cleaning up."
apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

reboot
