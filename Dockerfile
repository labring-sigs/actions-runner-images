FROM ghcr.io/actions/actions-runner:latest
LABEL authors="labring-sigs"

RUN sudo apt update -y  \
RUN sudo apt install -y uidmap fuse-overlayfs podman
RUN curl -sfL "https://github.com/labring/sealos/releases/download/v5.1.1/sealos_5.1.1_linux_amd64.tar.gz" | sudo tar zx -C /usr/local/bin/ sealos
RUN sudo chmod a+x /usr/local/bin/sealos
RUN sudo sealos version
RUN sudo podman version && sudo podman pull quay.io/skopeo/stable:latest