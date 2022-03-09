#!/usr/bin/env bash

# This should be run by the root user
if [[ "${EUID}" -ne 0 ]]; then
    echo "[ERROR] This script must run as root." 1>&2
    exit 1
fi

### Non-interactive
export DEBIAN_FRONTEND=noninteractive

# Docker
# ==================
apt-get -q -y remove docker docker-engine docker.io containerd runc

apt-get -q -y update
apt-get -q -y install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

DEB_DOCKER="deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg]"
DEB_DOCKER+=" https://download.docker.com/linux/debian $(lsb_release -cs) stable"
echo "${DEB_DOCKER}" > /etc/apt/sources.list.d/docker.list

apt-get -q -y update
apt-get -q -y install docker-ce docker-ce-cli containerd.io

apt-get -q -y autoremove
apt-get -q -y autoclean
