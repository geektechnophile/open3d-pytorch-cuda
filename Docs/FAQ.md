# Frequently Asked Questions

---

### ❓ **1. Is GPU required?**

Yes. The image is built for GPU acceleration using CUDA 13.0.
Tested on **NVIDIA RTX 4070 (Ada Lovelace)**.

---

### ❓ **2. The container can't detect my GPU — what should I check?**

Ensure:

```bash
nvidia-smi
```

works on the host.

Also confirm:

* NVIDIA drivers installed
* NVIDIA Container Toolkit installed
* Docker Engine ≥ 23.0

---

### ❓ **3. Where is my project folder inside the container?**

Inside `/workspace`.

Set via `.env`:

```env
WORKSPACE=./your-folder
```

---

### ❓ **4. Does PyTorch definitely support CUDA 13.0?**

Yes — this image uses official CUDA 13.0 builds:

* `torch==2.9.0`
* `torchvision==0.24.0`
* `torchaudio==2.9.0`

---

### ❓ **5. Does Open3D have GPU support enabled?**

Yes. Confirm with:

```bash
python3 -c "import open3d as o3d; print(o3d.core.cuda.is_available())"
```

---

### ❓ **6. Can I install additional Python packages?**

Yes. After activating micromamba:

```bash
micromamba install numpy scipy matplotlib -y
```

---

### ❓ **7. How do I reduce image size?**

Run:

```bash
micromamba clean --all --yes
```

---