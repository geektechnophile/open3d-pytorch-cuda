<div align="center">

# 🚀 Open3D + PyTorch (CUDA 13) Docker Image

### ⚡ GPU-Accelerated • 🐍 Python 3.11 • 🧠 Deep Learning • 🧊 3D Processing

<br/>

**A clean, reproducible, CUDA-enabled Docker environment for Open3D & PyTorch**
Built with **Micromamba**, powered by **CUDA 13.0 Python wheels**, and optimized for **modern NVIDIA GPUs**

<br/>

<img src="https://img.shields.io/badge/CUDA-13.0-green?style=for-the-badge"/>
<img src="https://img.shields.io/badge/PyTorch-2.9.0-red?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Open3D-0.18.0-blue?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Python-3.11-yellow?style=for-the-badge"/>
<img src="https://img.shields.io/badge/GHCR-Ready-black?style=for-the-badge"/>

</div>

---

## ✨ Why This Image?

> **No system CUDA. No bloated base image. No magic.**
> Just **explicit CUDA wheels**, **clean layers**, and **reproducible builds**.

✔ Ideal for:

* 3D vision & geometry processing
* Point clouds & mesh pipelines
* GPU-accelerated deep learning
* Research, prototyping, and production

✔ Tested on **NVIDIA RTX 4070 (Ada Lovelace, SM 8.6)**

---

## 🧱 Architecture Overview

```text
┌────────────────────────────┐
│ mambaorg/micromamba        │
│  └── Python 3.11 env       │
│       ├── Open3D 0.18.0    │
│       ├── PyTorch 2.9.0   │
│       ├── CUDA 13 Wheels  │
│       └── JupyterLab      │
└────────────────────────────┘
```

🔹 CUDA is provided **entirely via PyTorch wheels**
🔹 Each CUDA component is installed in its **own Docker layer**
🔹 Smaller, cleaner, and easier to debug than toolkit-based images

---

## 🚀 Key Features

### 🧊 Base & Environment

* **Micromamba base image**
* **Python 3.11 isolated environment**
* Fast dependency resolution & clean layering

### ⚡ GPU Acceleration

* **CUDA 13.0 runtime (wheel-based)**
* cuDNN, cuBLAS, cuFFT, cuRAND, cuSOLVER
* NCCL, NVRTC, NVTX, cuFile, cuSPARSELt

### 🧠 ML & 3D Stack

* **Open3D 0.18.0** (GPU enabled)
* **PyTorch 2.9.0 + cu130**
* **Triton 3.5.0**

### 🧪 Developer Ready

* Jupyter Notebook
* JupyterLab
* Workspace mounting
* Docker Compose support

---

## 🖥️ GPU Requirements

| Requirement              | Status         |
| ------------------------ | -------------- |
| NVIDIA GPU               | ✅ Required     |
| VRAM                     | ≥ 8 GB         |
| CUDA on host             | ❌ Not required |
| NVIDIA Container Toolkit | ✅ Required     |
| Compute capability       | ≥ 8.6          |

---

## 📦 Get the Image (GHCR)

### 🔹 Pull from GitHub Container Registry

```bash
docker pull ghcr.io/geektechnophile/open3d-pytorch-cuda:1.0
```

### 🔹 Run with GPU enabled

```bash
docker run --gpus all -it \
  -v $(pwd):/workspace \
  ghcr.io/geektechnophile/open3d-pytorch-cuda:1.0 \
  bash
```

---

## ⚙️ Optional `.env` Configuration

```env
WORKSPACE=/absolute/path/to/project
IMAGE_REPO=ghcr.io/geektechnophile
IMAGE_NAME=open3d-pytorch-cuda
IMAGE_VERSION=1.0
```

📁 Host directory → `/workspace`
🏷️ Clean image versioning & tagging

---

## 🐍 Activate Environment

```bash
micromamba activate open3d-pytorch-env
```

---

## ✅ Verify Installation

### 🧊 Open3D

```bash
python -c "import open3d as o3d; print(o3d.__version__)"
python -c "import open3d as o3d; print(o3d.core.cuda.is_available())"
```

### 🔥 PyTorch

```bash
python -c "import torch; print(torch.__version__)"
python -c "print(torch.cuda.is_available())"
python -c "print(torch.cuda.get_device_name(0))"
```

---

## 📚 Included Software

### Core

* Python **3.11**
* Open3D **0.18.0**
* PyTorch **2.9.0 + cu130**
* Triton **3.5.0**

### CUDA Libraries (Wheel-based)

* cuDNN 9.x
* cuBLAS
* cuFFT
* cuRAND
* cuSOLVER
* cuSPARSE / cuSPARSELt
* NCCL
* NVRTC / NVTX
* cuFile

### Tools

* Jupyter Notebook
* JupyterLab

---

## 🧹 Image Optimization

```bash
micromamba clean --all --yes
```

✔ Removes cache
✔ Keeps runtime lean
✔ Improves layer reuse

---

## 🔖 Build & Tagging

```bash
./build.sh
```

Generated tags:

```text
ghcr.io/geektechnophile/open3d-pytorch-cuda:1.0
ghcr.io/geektechnophile/open3d-pytorch-cuda:latest
```

---

## 💡 Design Philosophy

> **Explicit > Implicit**
> **Reproducible > Convenient**
> **Lean > Bloated**

This image avoids:

* System CUDA toolkits
* Monolithic installs
* Hidden dependencies

---

## 🧭 Roadmap (Optional)

* 🔹 Slim runtime-only image
* 🔹 Multi-GPU NCCL tuning
* 🔹 CI-based GHCR publishing
* 🔹 Layer size breakdown

---

<div align="center">

### ⭐ If this image helps you, give the repo a star

Built with ❤️ for GPU-heavy workflows

</div>

 
