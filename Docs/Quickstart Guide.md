# Quickstart Guide

Welcome to the **Open3D + PyTorch CUDA 13.0 Docker Environment**!
This guide helps you get started in minutes.

---

## 🚀 1. Pull the Prebuilt Image

```bash
docker pull geektechnophile/open3d-pytorch-cuda:latest
```

---

## 🚀 2. Run with GPU Enabled

```bash
docker run --gpus all -it \
  -v $(pwd):/workspace \
  geektechnophile/open3d-pytorch-cuda:latest \
  bash
```

---

## 🚀 3. Activate the Environment

```bash
micromamba activate open3d-pytorch-env
```

---

## 🔍 4. Check Open3D & PyTorch

### Open3D

```bash
python3 -c "import open3d as o3d; print(o3d.__version__)"
python3 -c "import open3d as o3d; print(o3d.core.cuda.is_available())"
```

### PyTorch

```bash
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
python3 -c "import torch; print(torch.cuda.get_device_name(0))"
```

---

## 📁 Mounting Your Own Workspace

Set in your `.env`:

```env
WORKSPACE=./my-local-project
```

Run via script:

```bash
./scripts/run.sh
```

---

## 🎉 You're Ready!

You now have a fully GPU-accelerated environment with Open3D + PyTorch + CUDA 13.0.
