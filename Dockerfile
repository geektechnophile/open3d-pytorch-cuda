# ---------------------------------------------------------
# BASE IMAGE micromamba
# ---------------------------------------------------------
FROM mambaorg/micromamba:latest

# -----------------------
# Build Arguments
# -----------------------
ARG IMAGE_NAME=open3d-pytorch-cuda
ARG IMAGE_REPO=geektechnophile
ARG IMAGE_VERSION=1.0

# -----------------------
# Prevent prompts during installs
# -----------------------
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------
# Metadata
# -----------------------
LABEL maintainer="geektechnophile@gmail.com"
LABEL description="Docker image with Open3D & PyTorch(CUDA12.5) on micromamba as base image"
LABEL version="1.0"
LABEL gpu.required="true"
LABEL gpu.compute_capability="8.6"
LABEL gpu.memory="8GB"
  
# ---------------------------------------------------------
# Create micromamba environment
# ---------------------------------------------------------
RUN micromamba create -n open3d-pytorch-env python=3.11 -y

# ---------------------------------------------------------
# Install Open3D + Pytorch CUDA13 + NVIDIA wheels
# ---------------------------------------------------------
RUN micromamba run -n open3d-pytorch-env \
    pip install --no-cache \
        open3d==0.18.0 \
        && micromamba clean --all --yes

RUN micromamba run -n open3d-pytorch-env \
    pip install --no-cache \
        torch==2.9.0 \
        torchvision==0.24.0 \
        torchaudio==2.9.0 \        
        --index-url https://download.pytorch.org/whl/cu130 \
    && micromamba clean --all --yes

RUN micromamba run -n open3d-pytorch-env \
    pip install --no-cache \
    notebook jupyterlab \
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
