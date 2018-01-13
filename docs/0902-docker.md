### Install from the Docker repository

To install the newest version of Docker, follow [this excellent document](https://docs.docker.com/engine/installation/linux/docker-ce/debian/). Here is a quick summary of what I did,

1. `sudo apt-get install apt-transport-https ca-certificates`.
2. `sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D`. **Double-check with posted link above that the information is correct**.
3. `sudo vim /etc/apt/sources.list.d/docker.list` and add this line `deb https://apt.dockerproject.org/repo debian-jessie main`.
4. `sudo apt-get update`.
5. `sudo apt-get install docker-engine`.
6. `sudo service docker start`.
7. `sudo docker version` to verify.

### Install from the Debian repository

**This package is not available in Debian Stretch**

Alternatively, Docker can be installed from the Debian package repository. The Docker provided by Debian will be an older version of Docker.

`sudo apt-get -t jessie-backports install docker.io`

Run `sudo docker version` to verify.

### Add user to the docker group

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

# Create a Clean Debian Image

The instructions below are ways to create your own Docker image of Debian.

**IMPORTANT** both options require the disk partition is set `exec` and `dev`. This is only possible with the `/` root partition.  Partitions `/home`, `/usr/local`, `/opt`, `/var`, `/tmp` are out of the question. To keep the host safe, create the images on a Debian virtual machine (see [[VirtualBox]]).

Both options require debootstrap. Debootstrap "is a tool which will install a Debian base system into a subdirectory of another, already installed system." On a Debian running on VirtualBox, install docker and debootstrap.

`sudo apt-get -t jessie-backports install debootstrap`

### Option 1

Follow [the debian-docker repository](https://github.com/jmtd/debian-docker) at GitHub.

1. Dependencies include `debootstrap` (`sudo apt-get -t jessie-backports install debootstrap`), `make`, and `docker`.
2. At the project root, run `sudo make prefix=<your docker user name>`. Optionally can set the mirror to your favorite one, e.g.  `mirror=http://mirrors.ocf.berkeley.edu/debian/`.
3. Run `sudo docker images` to verify.

### Option 2

Alternatively use Docker's `mkimage.sh`.

Depending on how Docker is installed, run either of the commands below,

* `sudo /usr/share/docker-engine/contrib/mkimage.sh -t <your docker user name>/minbase debootstrap --variant=minbase stable`
* `sudo /usr/share/docker.io/contrib/mkimage.sh -t <your docker user name>/minbase debootstrap --variant=minbase stable`
