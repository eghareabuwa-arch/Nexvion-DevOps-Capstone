#!/bin/bash

set -e

echo "======================================"
echo "Nexvion Docker Cleanup"
echo "======================================"

echo "Removing dangling Docker images..."
docker image prune -f

echo "Removing unused Docker build cache..."
docker builder prune -f

echo "======================================"
echo "Cleanup completed successfully."
echo "======================================"