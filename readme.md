# Open3D + PyTorch Docker Image (debian:bookworm-slim + CUDA 13.0)

This Docker image provides **Open3D with GPU support** (for NVIDIA RTX 4070) and **PyTorch with CUDA 13.0** on debian:bookworm-slim. It is designed for 3D data processing, visualization, and deep learning projects.

---

## Features

* debian:bookworm-slim base
* CUDA 13.0 toolkit installed
* Open3D 0.18.0 with GPU support
* PyTorch 2.9.0, torchvision 0.24.0, torchaudio 2.9.0 with CUDA 13.0
* Micromamba environments for isolation
* Custom workspace directory mount (dynamic via `.env`)
* Supports GPU via NVIDIA runtime
* Can be run via Docker CLI or Docker Compose
* Fully configurable using `.env` file

---

## GPU Requirements

* NVIDIA GPU required
* Tested on **RTX 4070 (Ada Lovelace, compute capability 8.6)**
* GPU memory: 8 GB
* Requires **NVIDIA Container Toolkit** installed on host

---

## `.env` Configuration

Create a `.env` file in the project root to customize your setup:

```text
# .env
WORKSPACE=./my_workspace
IMAGE_NAME=open3d_pytorch_cuda
IMAGE_REPO=geektechnophile/ml_environment
IMAGE_VERSION=1.1
```

* `WORKSPACE` – Local folder to mount inside the container as `/workspace`.
* `IMAGE_NAME` – Docker image name.
* `IMAGE_REPO` – Docker Hub repository.
* `IMAGE_VERSION` – Image version tag.

## Usage

### Option 1: Docker CLI

#### Build the image

```bash
./scripts/build.sh
```

This script reads the `.env` file and builds the image with the specified repository, name, and version.

#### Run the container

```bash
.scripts/run.sh
```

* Mounts the workspace folder defined in `.env`.
* Passes GPU to the container automatically.

You can optionally override workspace and version via command line:

```bash
WORKSPACE=/path/to/workspace IMAGE_VERSION=1.0 ./run.sh
```

---

### Option 2: Docker Compose

```bash
docker-compose up --build
```

* Compose file automatically reads `.env` variables.
* To run detached: `docker-compose up -d`
* Access container shell:

```bash
docker exec -it open3d-pytorch-container /bin/bash
```

---

### Access Micromamba Environments

Initialize Micromamba for your shell:

```bash
eval "$(micromamba shell hook --shell bash)"
micromamba shell init --shell bash --root-prefix=~/.local/share
```

Activate environments:

* **Open3D environment:**

```bash
micromamba activate open3d_pytorch_env
python -c "import open3d as o3d; print(o3d.__version__)"
```

* **PyTorch environment:**

```bash
micromamba activate open3d_pytorch_env
python -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"
```

---

## Included Packages

* **Open3D:** 0.18.0
* **PyTorch:** 2.9.0 with CUDA 13.0
* **Torchvision:** 0.24.0 with CUDA 13.0
* **Torchaudio:** 2.9.0 with CUDA 13.0

---

## Notes

* Designed for Ubuntu 22.04LTS with Docker ≥ 23.0
* Micromamba is used for smaller image size and faster builds
* Use `micromamba clean --all --yes` to reduce image size
* Users can mount **any host directory** as `/workspace` dynamically via `.env`
* Supports both **Docker CLI** and **Docker Compose** for GPU-enabled containers

---

## Build & Versioning

Using the `.env` file, you can build any version:

```bash
./build.sh          # Builds version specified in .env
./build.sh 1.0      # Optionally override version
```

Docker images will be tagged as:

```
${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_VERSION}
${IMAGE_REPO}/${IMAGE_NAME}:latest
```

