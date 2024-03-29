## Docker

[The Debian Wiki about Docker](https://wiki.debian.org/Docker). Notice the warning about the `docker` user group. The [Docker post-installation doc](https://docs.docker.com/engine/install/linux-postinstall/) has a similar warning.

### Install from the Docker repository

To install the newest version of Docker, follow [this excellent document](https://docs.docker.com/engine/installation/linux/docker-ce/debian/). Here is a quick summary of what I did,

```bash
sudo apt-get remove docker docker-engine docker.io

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

# docker-ce also depends on dkms and linux-headers
sudo apt-get install docker-ce

# verify
sudo docker version
sudo docker run hello-world
```

### Install from the Debian repository

Docker can be installed from the Debian package repository. The Docker provided by Debian will be an older version of Docker.

```bash
sudo apt-get install docker.io
```

To verify,

```bash
docker version
sudo docker run hello-world
```

### Add user to the docker group

WARN: See [Debian Docker Wiki](https://wiki.debian.org/Docker) and [Docker Post-installation Doc](https://docs.docker.com/engine/install/linux-postinstall/) about the danger.

Applies to both the Docker installation and the Debian installation.

Add user to the `docker` group so that the user can access the docker daemon without `sudo`.

```bash
# Add the docker group if it doesn't already exist.
$ sudo groupadd docker

# Add the connected user "${USER}" to the docker group.
# You may have to logout and log back in again for this to take effect.
$ sudo gpasswd -a ${USER} docker

# Restart the Docker daemon.
$ sudo service docker restart
```

If `docker version` without sudo still gets you an error, restart the machine.

### Create a Clean Debian Image

The instructions below are ways to create your own Docker image of Debian.

**IMPORTANT** both options require the disk partition is set `exec` and `dev`. This is only possible with the `/` root partition.  Partitions `/home`, `/usr/local`, `/opt`, `/var`, `/tmp` are out of the question. To keep the host safe, create the images on a Debian virtual machine (e.g. [VirtualBox](https://wiki.debian.org/VirtualBox)).

Both options require debootstrap. Debootstrap "is a tool which will install a Debian base system into a subdirectory of another, already installed system." On a Debian running on VirtualBox, install docker and debootstrap.

```bash
sudo apt-get install debootstrap
```

#### Option 1

Follow [the debian-docker repository](https://github.com/jmtd/debian-docker) at GitHub.

1. Dependencies include `debootstrap` (`sudo apt-get install debootstrap`), `make`, and `docker`.
2. At the project root, run `sudo make prefix=<your docker user name>`. Optionally can set the mirror to your favorite one, e.g.  `mirror=http://mirrors.ocf.berkeley.edu/debian/`.
3. Run `sudo docker images` to verify.

#### Option 2

Alternatively use Docker's `mkimage.sh`.

Depending on how Docker is installed, run either of the commands below,

* `sudo /usr/share/docker-engine/contrib/mkimage.sh -t <your docker user name>/minbase debootstrap --variant=minbase stable`
* `sudo /usr/share/docker.io/contrib/mkimage.sh -t <your docker user name>/minbase debootstrap --variant=minbase stable`
* `sudo /usr/share/docker-ce/contrib/mkimage.sh -t <your docker user name>/minbase debootstrap --variant=minbase stable`

