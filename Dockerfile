# -----------------------
# Base Image
# -----------------------
FROM debian:bookworm-slim


# -----------------------
# Build Arguments (Versioning)
# -----------------------
ARG IMAGE_NAME=open3d_pytorch_cuda
ARG IMAGE_REPO=geektechnophile/open3d_pytorch_cuda
ARG IMAGE_VERSION=1.0

# -----------------------
# Prevent prompts during installs
# -----------------------
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------
# Metadata
# -----------------------
LABEL maintainer="geektechnophile@outlook.com"
LABEL description="Open3D with CUDA support for RTX 4070"
LABEL version="1.0"
LABEL gpu.required="true"
LABEL gpu.compute_capability="8.6"
LABEL gpu.memory="8GB"

# -----------------------
# CUDA architecture for RTX 4070 (Ada Lovelace)
# -----------------------
ARG CUDA_ARCHITECTURES=86

# -----------------------
# Install dependencies & CUDA toolkit
# -----------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        curl \
        ca-certificates \
        gnupg \
        lsb-release \
        libgl1 \
        libglib2.0-0 \
        pciutils \
        software-properties-common \
        python3 \
        python3-distutils \
        python3-venv \
        python3-pip \
    && curl -s -L https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub \
        | gpg --dearmor -o /usr/share/keyrings/nvidia-cuda-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/nvidia-cuda-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" \
        > /etc/apt/sources.list.d/cuda.list \
    && apt-get update && apt-get install -y --no-install-recommends cuda-toolkit \
    && rm -rf /var/lib/apt/lists/*

# -----------------------
# Install Micromamba
# -----------------------
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest \
        | tar -xvj bin/micromamba \
    && mv bin/micromamba /usr/local/bin/ \
    && chmod +x /usr/local/bin/micromamba \
    && micromamba --version

# -----------------------
# Set Micromamba root
# -----------------------
ENV MAMBA_ROOT_PREFIX=/root/micromamba
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# -----------------------
# Create Open3D + PyTorch environment
# -----------------------
RUN micromamba create -n open3d_pytorch_env python=3.11 -y \
    && micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
        open3d==0.18.0 \
    && micromamba clean --all --yes

RUN micromamba run -n open3d_pytorch_env pip install --no-cache-dir \
        torch==2.9.0 torchvision==0.24.0 torchaudio==2.9.0 --index-url https://download.pytorch.org/whl/cu130 \
    && micromamba clean --all --yes
    
# -----------------------
# Add open3d_pytorch_env to PATH
# -----------------------
ENV PATH=$MAMBA_ROOT_PREFIX/envs/open3d_pytorch_env/bin:$PATH

# -----------------------
# Set working directory
# -----------------------
WORKDIR /workspace

# -----------------------
# Default shell
# -----------------------
CMD ["/bin/bash"]