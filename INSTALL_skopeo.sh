#!/bin/bash
set -e
sudo apt update -y \
  && sudo apt install -y uidmap fuse-overlayfs podman
URL="https://github.com/labring/sealos/releases/download/v5.1.1/sealos_5.1.1_linux_amd64.tar.gz"
curl -sfL $URL | sudo tar zx -C /usr/local/bin/ sealos
sudo chmod a+x /usr/local/bin/sealos
sudo sealos version
sudo apt purge buildah golang-github-containers-common podman skopeo -y
sudo apt autoremove --purge  -y
sudo sh -c "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list"
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/Release.key -o Release.key
sudo apt-key add Release.key
sudo apt update -y
sudo apt-get install skopeo -y
rm -f Release.key