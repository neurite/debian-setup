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
apt-get -q -y install ttf-anonymous-pro fonts-inconsolata

# Build tools
#
# dpkg-dev -- Debian package development tools
# libc6-dev -- GNU C Library: Development Libraries and Header Files
# gcc -- The GNU C compiler
# g++ -- The GNU C++ compiler, a fairly portable optimizing compiler for C++
# gfortran -- The GNU Fortran 95 compiler
# make -- GNU Make
# check -- A simple interface for defining unit tests
#
# Alternatively these build tools can be provided via
# the informational package, build-essential.
apt-get -q -y install dpkg-dev libc6-dev gcc g++ gfortran make check

# Optimized linear algebra libraries
apt-get -q -y install libopenblas-base libopenblas-dev

# From the Ubuntu documentation:
# "This DKMS (Dynamic Kernel Module Support) package provides support for
# installing supplementary versions of kernel modules. The package compiles
# and installs into the kernel tree."
apt-get -q -y install dkms

apt-get -q -y install openssl gnupg gnupg2

apt-get -q -y install curl wget

# Handy command-line tool for handling CSV files based on OCaml
apt-get -q -y install csvtool

# Python
apt-get -q -y install python python-dev python-pip python3 python3-dev python3-pip

# Ruby needed by tools such as the Travis CI command-line client
apt-get -q -y install ruby-dev ruby

# git
apt-get -q -y install git

# vim
apt-get -q -y remove vim
apt-get -q -y remove vim-tiny
apt-get -q -y install vim-gtk3

# Java
apt-get -q -y install openjdk-8-jdk openjdk-8-source

echo "Done installing packages, tools for development."

### Clean up

apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

reboot
