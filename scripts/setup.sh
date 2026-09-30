#!/bin/bash

set -e

echo "======================================"
echo "Nexvion Environment Setup Check"
echo "======================================"

check_command() {
    if command -v "$1" > /dev/null 2>&1; then
        echo "OK: $1 is installed."
    else
        echo "ERROR: $1 is not installed."
        exit 1
    fi
}

echo "Checking required tools..."

check_command git
check_command docker
check_command curl
check_command tar

echo
echo "Checking Docker service..."

if docker info > /dev/null 2>&1; then
    echo "OK: Docker is running."
else
    echo "ERROR: Docker is installed but not running."
    exit 1
fi

echo
echo "Checking required Nexvion files..."

for file in index.html style.css script.js Dockerfile; do
    if [ -f "$file" ]; then
        echo "OK: $file found."
    else
        echo "ERROR: $file not found."
        exit 1
    fi
done

echo
echo "======================================"
echo "Nexvion environment is ready."
echo "======================================"