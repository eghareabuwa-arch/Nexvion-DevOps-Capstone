#!/bin/bash

set -e

IMAGE_NAME="nexvion"
IMAGE_TAG="v1"
CONTAINER_NAME="nexvion-container"
HOST_PORT="8083"
CONTAINER_PORT="80"

echo "======================================"
echo "Deploying Nexvion"
echo "======================================"

echo "Step 1: Building Docker image..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo "Step 2: Removing previous container if it exists..."
docker rm -f ${CONTAINER_NAME} 2>/dev/null || true

echo "Step 3: Starting new container..."
docker run -d \
  --name ${CONTAINER_NAME} \
  -p ${HOST_PORT}:${CONTAINER_PORT} \
  ${IMAGE_NAME}:${IMAGE_TAG}

echo "Step 4: Waiting for application to start..."
sleep 3

echo "Step 5: Running health check..."
./scripts/health-check.sh

echo "======================================"
echo "Nexvion deployment completed."
echo "======================================"