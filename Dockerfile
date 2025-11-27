# ---------------------------------------------------------
# LAYER 0: BASE WITH CUDA
# ---------------------------------------------------------
FROM debian:bookworm-slim AS base

ARG IMAGE_NAME=open3d-pytorch-cuda
ARG IMAGE_REPO=geektechnophile/open3d-pytorch-cuda
ARG IMAGE_VERSION=1.0
ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="geektechnophile@gmail.com"
LABEL description="Optimized Docker image with Open3D & PyTorch(CUDA13.0) using micromamba."
LABEL version="1.0"

# ---------------------------------------------------------
# Install basic tools + add CUDA repo + install CUDA libs
# ---------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gnupg libgomp1 libgl1 && \
    curl -s -L https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub \
       | gpg --dearmor -o /usr/share/keyrings/nvidia-cuda-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nvidia-cuda-keyring.gpg] \
       https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" \
       > /etc/apt/sources.list.d/cuda.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    cuda-compiler-12-5 \
    libcublas-12-5 \
    libcufft-12-5 \
    libcurand-12-5 \
    && rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------------
# MICROMAMBA IMAGE
# ---------------------------------------------------------
FROM mambaorg/micromamba:latest AS final

# ---------------------------------------------------------
# Create micromamba environment
# ---------------------------------------------------------
RUN micromamba create -n open3d-pytorch-env python=3.11 -y

# ---------------------------------------------------------
# Install Open3D + Pytorch CUDA13 + NVIDIA wheels
# ---------------------------------------------------------
RUN micromamba run -n open3d-pytorch-env \
    pip install \
        open3d==0.18.0 \
        && micromamba clean --all --yes

RUN micromamba run -n open3d-pytorch-env \
    pip install \
        torch==2.9.0 \
        torchvision==0.24.0 \
        torchaudio==2.9.0 \        
        --index-url https://download.pytorch.org/whl/cu130 \
    && micromamba clean --all --yes

# -------------------
# Switch back to root
# -------------------
USER root

# -----------------------
# BASE IMAGE DEPENDENCES
# -----------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 libgl1 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

SHELL ["/bin/bash", "-c"]
