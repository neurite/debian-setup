#!/usr/bin/env bash

# A companion hardening directive
# IFS - Internal Field Separator
# It removes space as a word delimiter from the original IFS.
IFS=$'\n\t'

### Set up error handling

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

### Set non-interactive
export DEBIAN_FRONTEND=noninteractive

### Parse command-line arguments

ADD_CJK=false
ADD_JDK=false

# Note $0 is the script name itself
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --add-cjk   Install CJK (Chinese, Japanese, Korean) fonts"
    echo "  --add-jdk   Install the recommended version of JDK"
    echo "  -h, --help  Show this help message"
    echo ""
}

# Loop through the arguments
# $# Count of arguments
# $0  The script name itself
# $1  First argument
while [[ $# -gt 0 ]]; do
    case $1 in
        --add-cjk)
            ADD_CJK=true
            shift  # Remove first argument, $# decreases by 1
            ;;
        --add-jdk)
            ADD_JDK=true
            shift  # Remove first argument, $# decreases by 1
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

### Update apt

echo "About to update the repositories..."
sleep 3s

apt-get -q -y update

echo "Done updating the repositories."

### Various packages, tools for development

echo "About to install packages..."
sleep 3s

# Tools for downloading
# ======================
apt-get -q -y install curl wget

# Security tools
# ======================
# openssl: OpenSSL's implementation of SSL and TLS
# ca-certificates: certificate authorities shipped with Mozilla's browser
# gnupg: the full suite of GnuPG tools for cryptographic communications and data storage
apt-get -q -y install openssl ca-certificates gnupg

# File transfer tools
# ======================
# Example, rsync -avP "/path/to/source-folder/" <username>@<hostname>:"/path/to/destination-folder/"
apt-get -q -y install openssh-server rsync

# git
# ======================
apt-get -q -y install git

# Fonts
# ======================

# To use commands like fc-cache later
apt-get -q -y install fontconfig

# Monospaced fonts
apt-get -q -y install fonts-anonymous-pro fonts-inconsolata

# Monospaced Source Code Pro from Adobe
# Note the default branch is release which is what we want
if [[ ! -d "source-code-pro" ]]; then
    git clone --depth 1 https://github.com/adobe-fonts/source-code-pro.git
fi
mkdir -p /usr/local/share/fonts/adobe/source-code-pro
# The otf files are a newer format than ttf files
cp source-code-pro/OTF/*otf /usr/local/share/fonts/adobe/source-code-pro/
# Force font cache build
fc-cache -fv
# Clean up
rm -r source-code-pro

# CJK fonts - optional
# In bash, everything is a string. So we check the string value "true" or "false" directly
if [[ "$ADD_CJK" == true ]]; then
    echo "Installing CJK fonts..."
    apt-get -q -y install fonts-noto-cjk \
                          fonts-noto-cjk-extra \
                          fonts-ipaexfont \
                          fonts-nanum \
                          fonts-nanum-extra
    # Monospaced CJK - Source Han Mono from Adobe
    if [[ ! -d "source-han-mono" ]]; then
        git clone --depth 1 https://github.com/adobe-fonts/source-han-mono.git
    fi
    mkdir -p /usr/local/share/fonts/adobe/source-han-mono
    find source-han-mono -name "*.otf" -print0 | xargs -0 cp -t /usr/local/share/fonts/adobe/source-han-mono
    fc-cache -fv
    rm -r source-han-mono
    echo "CJK fonts installed."
else
    echo "Skipping CJK fonts (use --add-cjk to install)."
fi

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
# Install the OpenBLAS implementation
# ======================================
apt-get -q -y install libopenblas-dev

# dkms
# ==================
# From the Ubuntu documentation:
# "This DKMS (Dynamic Kernel Module Support) package provides support for
# installing supplementary versions of kernel modules. The package compiles
# and installs into the kernel tree."
apt-get -q -y install dkms

# vim
# ==================
#
# If you don't actually need the GTK3 GUI but do want Python 3 scripting support
# (e.g. for plugins like YouCompleteMe or others), vim-nox is a lighter alternative.
#
# * Syntax highlighting for Python 3 files is handled by Vim's runtime files —
#   specifically, the vim-runtime package, which contains language-specific syntax
#   highlighting rules. This works regardless of which vim binary you install,
#   and yes, the plain vim package pulls in vim-runtime and will highlight .py files
#   just fine.
# * Python 3 scripting support (the +python3 compile flag) means Vim itself can execute
#   Python 3 code — used by certain plugins (like YouCompleteMe, UltiSnips, etc.) that
#   embed Python logic inside Vim. This is what requires vim-gtk3 or vim-nox.
apt-get -q -y purge vim
apt-get -q -y purge vim-tiny
apt-get -q -y install vim-nox

# Java
# ==================
if [[ "$ADD_JDK" == true ]]; then
    echo "Installing JDK..."
    apt-get -q -y install default-jdk
    echo "JDK installed."
else
    echo "Skipping JDK (use --add-jdk to install)."
fi

echo "Done. System will reboot in 30 seconds."
echo "Press Ctrl+C to cancel the reboot."
sleep 30
reboot
