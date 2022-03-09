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

# git
apt-get -q -y install git

# Mono-space fonts for coding
apt-get -q -y install ttf-anonymous-pro fonts-inconsolata

# Source Code Pro from Adobe
# The default branch is release which is what we want
git clone https://github.com/adobe-fonts/source-code-pro.git
mkdir -p /usr/local/share/fonts/source-code-pro
# Note otf files are newer format than ttf files
cp source-code-pro/OTF/*otf /usr/local/share/fonts/source-code-pro/
# Force font cache build
fc-cache -fv
# Clean up
rm -r source-code-pro/

# CJK fonts
apt-get -q -y install \
                    # Chinese
                    fonts-arphic-ukai \
                    fonts-arphic-uming \
                    # Japanese
                    fonts-ipafont-mincho \
                    fonts-ipafont-gothic \
                    # Korean
                    fonts-unfonts-core

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

# Debugging tools
dstat htop strace lsof

# Optimized linear algebra libraries
apt-get -q -y install libopenblas-base libopenblas-dev

# From the Ubuntu documentation:
# "This DKMS (Dynamic Kernel Module Support) package provides support for
# installing supplementary versions of kernel modules. The package compiles
# and installs into the kernel tree."
apt-get -q -y install dkms

# Security utils
apt-get -q -y install openssl gnupg gnupg2 dirmngr

apt-get -q -y install curl wget

# vim
apt-get -q -y purge vim
apt-get -q -y purge vim-tiny
apt-get -q -y install vim-gtk3

# Java
apt-get -q -y install openjdk-17-jdk openjdk-17-source

# Conda
# Install our public GPG key to trusted store
curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
rm conda.gpg

# Check whether fingerprint is correct (will output an error message otherwise)
gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring \
    --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

# Add our Debian repo
DEB_CONDA="deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg]"
DEB_CONDA+=" https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main"
echo "${DEB_CONDA}" > /etc/apt/sources.list.d/conda.list

# Install conda
apt-get -q -y update
apt-get -q -y install conda

# Init conda at login
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

echo "Done installing. Cleaning up..."

### Clean up

apt-get -q -y update
apt-get -q -y dist-upgrade
apt-get -q -y autoremove
apt-get -q -y autoclean

echo "Done. Rebooting..."
sleep 3s

reboot
