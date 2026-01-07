#!/usr/bin/env bash

# A companion hardening directive
# IFS - Internal Field Separator
# It removes space as a word delimiter from the original IFS.
IFS=$'\n\t'

### Error handling

# Create transaction-grade execution semantics.
# set -E: Enable errtrace
#    Inherit ERR traps everywhere in addition to direct statments such as functions.
# set -e: Exit on Error
#    Immediately terminates the script if any command returns a non-zero exit status.
# set -u: Treat Unset Variables as Errors
#    Any reference to an undefined variable immediately terminates the script.
# set -o: pipefail
#    A pipeline fails if any command inside the pipeline fails
set -Eeuo pipefail

# Add cleanup trap
# This is where you would:
# - Remove temporary files
# - Release locks
# - Stop background processes
# - Roll back partial operations
# Note ERR is fired when set -e
cleanup() {
    echo "Script failed at line $1"
}
trap 'cleanup $LINENO' ERR

### Check preconditions

echo "About to check preconditions..."
sleep 3s

# This should be run by the root user
if [[ "${EUID}" -ne 0 ]]; then
    echo "[ERROR] This script must run as root." 1>&2
    exit 1
fi

# Check for network before starting
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    echo "[ERROR] No network connectivity detected"
    exit 1
fi

echo "Done checking preconditions."

### Non-interactive

export DEBIAN_FRONTEND=noninteractive

### Update apt

echo "About to update the repositories..."
sleep 3s

apt-get -q -y update

echo "Done updating the repositories."

### Various packages, tools for development

echo "About to install packages..."
sleep 3s

# For commandline downloading
apt-get -q -y install curl wget

# Security tools
# ==================
# openssl: OpenSSL's implementation of SSL and TLS
# ca-certificates: certificate authorities shipped with Mozilla's browser
# gnupg: the full suite of GnuPG tools for cryptographic communications and data storage
apt-get -q -y install openssl ca-certificates gnupg

# git
# ==================
apt-get -q -y install git

# Fonts
# ==================

# Monospaced fonts
apt-get -q -y install ttf-anonymous-pro fonts-inconsolata

# Monospaced Source Code Pro from Adobe
# Note the default branch is release which is what we want
git clone https://github.com/adobe-fonts/source-code-pro.git
mkdir -p /usr/local/share/fonts/adobe/source-code-pro
# The otf files are a newer format than ttf files
cp source-code-pro/OTF/*otf /usr/local/share/fonts/adobe/source-code-pro/
# Force font cache build
fc-cache -fv
# Clean up
rm -r source-code-pro

# CJK fonts
# TODO: Make CJK fonts optional with a switch to turn it on --add-cjk-fonts
apt-get -q -y install fonts-arphic-ukai \
                      fonts-arphic-uming \
                      fonts-ipafont-mincho \
                      fonts-ipafont-gothic \
                      fonts-unfonts-core

# Monospaced CJK from Adobe
git clone https://github.com/adobe-fonts/source-han-mono.git
mkdir -p /usr/local/share/fonts/adobe/source-han-mono
find source-han-mono -name "*.otf" -print0 | xargs -0 cp -t /usr/local/share/fonts/adobe/source-han-mono
fc-cache -fv
rm -r source-han-mono

# Build tools
# ==================
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
# ==================
apt-get -q -y install dstat htop strace lsof

# Optimized linear algebra libraries
# ======================================
apt-get -q -y install libopenblas-base libopenblas-dev

# dkms
# ==================
# From the Ubuntu documentation:
# "This DKMS (Dynamic Kernel Module Support) package provides support for
# installing supplementary versions of kernel modules. The package compiles
# and installs into the kernel tree."
apt-get -q -y install dkms

# vim
# ==================
apt-get -q -y purge vim
apt-get -q -y purge vim-tiny
apt-get -q -y install vim-gtk3

# Java
# ==================

# To see and choose the default Java commands:
#   sudo update-alternatives --config java
#   sudo update-alternatives --config javac
#   sudo update-alternatives --config jar

# Default JDK for Debian bookworm (see package default-jdk)
apt-get -q -y install openjdk-17-jdk openjdk-17-source
# Default JDK for Debian trixie (see package default-jdk)
apt-get -q -y install openjdk-21-jdk openjdk-21-source
# Latest JDK available on Debian trixie
apt-get -q -y install openjdk-25-jdk openjdk-25-source

# conda
# ==================
# Installs miniconda via the repository
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

echo "Done. Rebooting..."
sleep 3s

reboot
