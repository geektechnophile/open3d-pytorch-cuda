# ⚡ Quickstart Guide

Welcome to the **Open3D + PyTorch CUDA 13 Docker Environment** 🚀
This guide gets you **GPU-ready in under 2 minutes**.

---

## 🚀 1. Pull the Prebuilt Image (GHCR)

```bash
docker pull ghcr.io/geektechnophile/open3d-pytorch-cuda:1.0
```

> ✅ Hosted on **GitHub Container Registry**
> ✅ No system CUDA required on the host

---

## 🚀 2. Run with GPU Enabled

```bash
docker run --gpus all -it \
  -v $(pwd):/workspace \
  ghcr.io/geektechnophile/open3d-pytorch-cuda:1.0 \
  bash
```

📁 Your current directory is mounted inside the container at `/workspace`.

---

## 🐍 3. Activate the Micromamba Environment

```bash
micromamba activate open3d-pytorch-env
```

This activates:

* Python **3.11**
* Open3D **0.18.0**
* PyTorch **2.9.0 + CUDA 13**

---

## 🔍 4. Verify Installation

### 🧊 Open3D

```bash
python -c "import open3d as o3d; print('Open3D:', o3d.__version__)"
python -c "import open3d as o3d; print('CUDA available:', o3d.core.cuda.is_available())"
```

### 🔥 PyTorch

```bash
python -c "import torch; print('PyTorch:', torch.__version__)"
python -c "print('CUDA available:', torch.cuda.is_available())"
python -c "print('GPU:', torch.cuda.get_device_name(0))"
```

✔ If CUDA is available, your GPU is working correctly.

---

## 📁 Mounting Your Own Workspace (Optional)

### Using `.env`

```env
WORKSPACE=./my-local-project
```

### Run via helper script

```bash
./scripts/run.sh
```

Your project will be available inside the container at:

```text
/workspace
```

---

## 🎉 You’re Ready!

You now have a **fully GPU-accelerated environment** with:

* 🧊 Open3D (GPU-enabled)
* 🔥 PyTorch + CUDA 13
* 🐍 Python 3.11
* 🧪 Jupyter support
* 🧱 Clean Micromamba isolation

Happy hacking 🚀
