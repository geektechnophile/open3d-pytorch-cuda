# Open3D + PyTorch Docker Image

**(debian:bookworm-slim + CUDA 13.0)**

This Docker image provides a **fully GPU-accelerated development environment** featuring **Open3D** and **PyTorch** built with **CUDA 13.0** support—ideal for 3D data processing, visualization, and deep-learning workflows.
Tested and tuned for **NVIDIA RTX 4070** (Ada Lovelace, compute capability 8.6).

---

## 🚀 Key Features

* **Minimal & fast base:** `debian:bookworm-slim`
* **CUDA 13.0 Toolkit** with GPU acceleration
* **Open3D 0.18.0** compiled with **full GPU support**
* **PyTorch 2.9.0**, **torchvision 0.24.0**, **torchaudio 2.9.0** (CUDA 13.0 builds)
* **Micromamba-based environments** for clean, isolated dependencies
* **Dynamic workspace mounting** via `.env`
* **Compatible with Docker CLI & Docker Compose**
* **Ready-to-use GPU access** via NVIDIA Container Toolkit

---

## 🔧 GPU Requirements

* NVIDIA GPU (tested on **RTX 4070**)
* Minimum **8 GB VRAM**
* **NVIDIA Container Toolkit** must be installed on the host
* Supports compute capability **8.6** and above

---

## ⚙️ `.env` Configuration

Create a `.env` file at the project root to customize behavior:

* `WORKSPACE` → Host directory mounted as `/workspace`
* `IMAGE_NAME` → Docker image name
* `IMAGE_REPO` → Docker Hub repository
* `IMAGE_VERSION` → Image version tag

This lets you version, name, and organize images effortlessly.

---

## 📦 Usage Options

### **Option 1 — Pull Prebuilt Docker Hub Image (Recommended)**

**Latest version:**

```bash
docker pull geektechnophile/open3d-pytorch-cuda:latest
```

**Specific version:**

```bash
docker pull geektechnophile/open3d-pytorch-cuda:1.0
```

**Run with GPU enabled:**

```bash
docker run --gpus all -it \
  -v $(pwd):/workspace \
  geektechnophile/open3d-pytorch-cuda:latest \
  bash
```

---

### **Option 2 — Build via Docker CLI**

**Build image from `.env`:**

```bash
./scripts/build.sh
```

**Run container:**

```bash
./scripts/run.sh
```

This automatically mounts your workspace and exposes GPU resources.

---

### **Option 3 — Use Docker Compose**

**Build + Run:**

```bash
docker compose up --build
```

**Run without rebuilding:**

```bash
docker compose up
```

**Detached (background) mode:**

```bash
docker compose up -d
```

**Open container shell:**

```bash
docker exec -it open3d-pytorch-container /bin/bash
```

**Stop containers:**

```bash
docker compose down
```

---

## 🐍 Micromamba Environments

**Activate environment:**

```bash
micromamba activate open3d-pytorch-env
```

**Verify Open3D installation:**

```bash
python3 -c "import open3d as o3d; print('Open3D version:', o3d.__version__)"
python3 -c "import open3d as o3d; print('Open3D CUDA available:', o3d.core.cuda.is_available())"
```

**Verify PyTorch installation:**

```bash
python3 -c "import torch; print('PyTorch version:', torch.__version__)"
python3 -c "import torch; print('CUDA available:', torch.cuda.is_available())"
python3 -c "import torch; print(torch.cuda.get_device_name(0))"
```

---

## 📚 Included Packages

* **Open3D:** 0.18.0 (GPU-enabled)
* **PyTorch:** 2.9.0 (CUDA 13.0)
* **Torchvision:** 0.24.0 (CUDA 13.0)
* **Torchaudio:** 2.9.0 (CUDA 13.0)

---

## 📝 Notes

* Optimized for **Ubuntu 22.04 LTS** + Docker ≥ 23.0
* Build efficiency improved via Micromamba
* Reduce image size using:

  ```bash
  micromamba clean --all --yes
  ```
* Any host directory can be mounted into `/workspace`
* Works seamlessly with both **CLI** and **Compose** workflows

---

## 🔖 Build & Versioning

Build using the version specified in `.env`:

```bash
./build.sh
```

Images are auto-tagged as:

```bash
${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_VERSION}
${IMAGE_REPO}/${IMAGE_NAME}:latest
```
