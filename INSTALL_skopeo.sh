#!/bin/bash
set -e
apt update -y \
  &&  apt install -y uidmap fuse-overlayfs curl wget
wget http://ftp.gwdg.de/pub/opensuse/repositories/home:/alvistack/xUbuntu_22.04/amd64/skopeo_1.20.0-1_amd64.deb
dpkg -X skopeo_1.20.0-1_amd64.deb  extract
cp extract/usr/bin/skopeo /usr/local/bin/skopeo
rm -rf skopeo_1.20.0-1_amd64.deb
skopeo --version