#!/usr/bin/env bash

### Check preconditions

echo "About to check preconditions..."
sleep 3s

# This should be run by the root user
if [[ "${EUID}" -ne 0 ]]; then
    echo "[ERROR] This script must run as root." 1>&2
    exit 1
fi

echo "Done checking preconditions."

### Non-interactive

export DEBIAN_FRONTEND=noninteractive

### Update and upgrade

echo "About to update and upgrade the system..."
sleep 3s

apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

echo "Done updating and upgrading the system."

### Various packages, tools for development

echo "About to install various packages, tools for development..."
sleep 3s

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

# Handy command-line tool for handling CSV files based on OCaml
apt-get -q -y install csvtool

apt-get -q -y install ruby-dev ruby

echo "Done installing packages, tools for development."

## Git

echo "About to install git..."
sleep 3s

apt-get -q -y install git
apt-get -q -y install libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring/
make
cd
# /etc/gitconfig
git config --system credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

echo "Done installing git."

### java

echo "About to install java..."
sleep 3s

echo "Installing open jdk 7 and 8."
apt-get -q -y install openjdk-7-jdk openjdk-7-source
apt-get -q -y -t jessie-backports install openjdk-8-jdk openjdk-8-source

echo "Done installing java."

### Clean up

apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

reboot
