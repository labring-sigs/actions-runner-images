#!/bin/bash
sudo apt install -y uidmap fuse-overlayfs curl
sudo apt purge buildah golang-github-containers-common podman skopeo -y
sudo apt autoremove --purge  -y
sudo sh -c "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list"
sudo curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/Release.key -o Release.key
sudo apt-key add Release.key
sudo apt-get update -y
sudo apt-get install skopeo -y
skopeo --version
rm -f Release.key