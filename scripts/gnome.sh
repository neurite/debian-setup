#!/usr/bin/env bash

# This should be run by the root user
if [[ "${EUID}" -ne 0 ]]; then
    echo "[ERROR] This script must run as root." 1>&2
    exit 1
fi

# Non-interactive
export DEBIAN_FRONTEND=noninteractive

apt-get -q -y update
apt-get -q -y --no-install-recommends install \
        xserver-xorg \
        gdm3 \
        gnome-session \
        gnome-shell \
        gnome-keyring libpam-gnome-keyring \
        gnome-control-center \
        gnome-terminal \
        network-manager-gnome \
        pulseaudio

apt-get -q -y autoremove
apt-get -q -y autoclean
