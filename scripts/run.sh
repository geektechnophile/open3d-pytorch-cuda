#!/bin/bash
# run.sh - Run the Open3D + PyTorch container using .env variables

# Load environment variables from .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Default values
WORKSPACE=${WORKSPACE:-$(pwd)}
IMAGE_TAG=${IMAGE_VERSION:-latest}

docker run --gpus all -it --rm \
    -v "$WORKSPACE":/workspace \
    ${IMAGE_REPO}/${IMAGE_NAME}:$IMAGE_TAG
