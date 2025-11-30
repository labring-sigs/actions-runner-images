# syntax=docker/dockerfile:1.7-labs

FROM ghcr.io/actions/actions-runner:latest
LABEL authors="labring-sigs"

USER root

# 支持多架构自动下载 sealos
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

# 安装 podman、curl 等基础工具
RUN apt-get update -y && \
    apt-get install -y uidmap fuse-overlayfs podman curl && \
    rm -rf /var/lib/apt/lists/*

# 安装 sealos（多架构支持）
# 文件名：sealos_5.1.1_linux_amd64.tar.gz or sealos_5.1.1_linux_arm64.tar.gz
RUN curl -sfL "https://github.com/labring/sealos/releases/download/v5.1.1/sealos_5.1.1_linux_${TARGETARCH}.tar.gz" \
    | tar zx -C /usr/local/bin/ sealos && \
    chmod +x /usr/local/bin/sealos

RUN sealos version

# 强制 podman root 模式（避免 rootless）
ENV _CONTAINERS_USERNS_CONFIGURED=1
ENV PODMAN_ALLOW_ROOT=1
ENV REGISTRIES_DIR=/etc/containers/registries.conf.d

# 配置 podman 存储为 vfs（overlay 不适合 buildkit）
RUN printf '[storage]\ndriver="vfs"\n' > /etc/containers/storage.conf

RUN podman --log-level=debug info

# 拉取镜像（buildkit 中 root 模式可稳定运行）
RUN podman pull quay.io/skopeo/stable:latest
