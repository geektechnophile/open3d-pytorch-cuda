# ---------------------------------------------------------
# LAYER 0: BASE IMAGE 
# ---------------------------------------------------------
FROM debian:bookworm-slim

# -----------------------
# Build Arguments
# -----------------------
ARG IMAGE_NAME=open3d-pytorch-cuda
ARG IMAGE_REPO=geektechnophile/open3d-pytorch-cuda
ARG IMAGE_VERSION=1.0

# -----------------------
# Prevent prompts during installs
# -----------------------
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------
# Metadata
# -----------------------
LABEL maintainer="geektechnophile@gmail.com"
LABEL description="Docker image with Open3D & PyTorch(CUDA12.5) on Debian slim with micromamba environment."
LABEL version="1.0"
LABEL gpu.required="true"
LABEL gpu.compute_capability="8.6"
LABEL gpu.memory="8GB"

# ---------------------------------------------------------
# LAYER 1: Core Debian tools
# ---------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gnupg && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# CUDA REPO ADDED TO APT
# ---------------------------------------------------------
# LAYER 2:
RUN curl -s -L https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub \
    | gpg --dearmor -o /usr/share/keyrings/nvidia-cuda-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/nvidia-cuda-keyring.gpg] \
    https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" \
    > /etc/apt/sources.list.d/cuda.list
    
# ---------------------------------------------------------
# CUDA RUNTIME PACKAGES ARE SPLIT INTO SMALL LAYERS
# ---------------------------------------------------------
# LAYER 3: CUDA core
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-compiler-12-5 && \
    rm -rf /var/lib/apt/lists/*
# LAYER 4: CUDA libs-1
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcublas-12-5 && \
    rm -rf /var/lib/apt/lists/*
# LAYER 5: CUDA libs-2
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcufft-12-5 && \
    rm -rf /var/lib/apt/lists/*
# LAYER 6: CUDA libs-3
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurand-12-5 && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# setup Micromamba 
# ---------------------------------------------------------
# LAYER 7: official micromamba base image
FROM mambaorg/micromamba:latest

# ---------------------------------------------------------
# Create a micromamba environment with specific Python version
# ---------------------------------------------------------
# LAYER 8: Create empty env
RUN micromamba create -n open3d_pytorch_env python=3.11 -y

# ---------------------------------------------------------
# Open3D split
# ---------------------------------------------------------
# LAYER 9: Open3D core
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir open3d==0.18.0

# -------------------------------
# Install packages from pytorch.org
# -------------------------------
# LAYER 10:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cuda-nvrtc==13.0.48 --index-url https://download.pytorch.org/whl/cu130
# LAYER 11:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cuda-runtime==13.0.48 --index-url https://download.pytorch.org/whl/cu130
# LAYER 12:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cuda-cupti==13.0.48 --index-url https://download.pytorch.org/whl/cu130
# LAYER 13:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cudnn-cu13==9.13.0.50 --index-url https://download.pytorch.org/whl/cu130
# LAYER 14:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cublas==13.0.0.19 --index-url https://download.pytorch.org/whl/cu130
# LAYER 15:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cufft==12.0.0.15 --index-url https://download.pytorch.org/whl/cu130
# LAYER 16:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-curand==10.4.0.35 --index-url https://download.pytorch.org/whl/cu130
# LAYER 17:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cusolver==12.0.3.29 --index-url https://download.pytorch.org/whl/cu130
# LAYER 18:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cusparse==12.6.2.49 --index-url https://download.pytorch.org/whl/cu130
# LAYER 19:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cusparselt-cu13==0.8.0 --index-url https://download.pytorch.org/whl/cu130
# LAYER 20:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-nccl-cu13==2.27.7 --index-url https://download.pytorch.org/whl/cu130
# LAYER 21:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-nvshmem-cu13==3.3.24 --index-url https://download.pytorch.org/whl/cu130
# LAYER 22:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-nvtx==13.0.39 --index-url https://download.pytorch.org/whl/cu130
# LAYER 23:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-nvjitlink==13.0.39 --index-url https://download.pytorch.org/whl/cu130
# LAYER 24:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    nvidia-cufile==1.15.0.42 --index-url https://download.pytorch.org/whl/cu130
# LAYER 25:  
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    torch==2.9.0+cu130 --index-url https://download.pytorch.org/whl/cu130
# LAYER 26: 
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    triton==3.5.0 --index-url https://download.pytorch.org/whl/cu130
# LAYER 27: 
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    triton==3.5.0 --index-url https://download.pytorch.org/whl/cu130

# LAYER 28: 
# -------------------------------
# Non-pytorch-index packages
# -------------------------------
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    filelock \
    fsspec \
    networkx \
    sympy \
    mpmath \
    jinja2

# LAYER 29: 
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    torchvision==0.24.0 --index-url https://download.pytorch.org/whl/cu130

# LAYER 30:
RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
    torchaudio==2.9.0 --index-url https://download.pytorch.org/whl/cu130
RUN micromamba clean --all --yes

# ------------------------------------------
# Switch to root to install system libraries
# ------------------------------------------
USER root

# -----------------------
# BASE IMAGE DEPENDENCES
# -----------------------
# LAYER 31:
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 libgl1 && \
    rm -rf /var/lib/apt/lists/*

# -----------------------
# Set working directory
# -----------------------
WORKDIR /workspace

# Switch back to default shell for following commands
SHELL ["/bin/bash", "-c"]
