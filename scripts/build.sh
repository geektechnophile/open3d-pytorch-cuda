#!/bin/bash
# build.sh - Build the Open3D + PyTorch GPU Docker image using .env variables (buildx)

# Load environment variables from .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Default version if not set in .env
VERSION=${IMAGE_VERSION:-latest}

# Build Docker image using Buildx
docker buildx build --load \
    --build-arg IMAGE_VERSION=$VERSION \
    -t ${IMAGE_REPO}/${IMAGE_NAME}:$VERSION \
    -t ${IMAGE_REPO}/${IMAGE_NAME}:latest .

echo "Docker image built (buildx): ${IMAGE_REPO}/${IMAGE_NAME}:$VERSION"