#!/bin/bash
set -e
apt update -y \
  &&  apt install -y uidmap fuse-overlayfs podman
apt purge buildah golang-github-containers-common podman skopeo -y
apt autoremove --purge  -y
sh -c "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list"
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/Release.key -o Release.key
apt-key add Release.key
apt update -y
apt-get install skopeo -y
rm -f Release.key