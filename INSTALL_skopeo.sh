#!/bin/bash
set -e
apt update -y \
  && apt install -y uidmap fuse-overlayfs curl wget skopeo
skopeo --version

curl https://gosspublic.alicdn.com/ossutil/install.sh | bash
