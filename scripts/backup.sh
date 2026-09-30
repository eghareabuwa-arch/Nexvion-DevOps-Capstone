#!/bin/bash

set -e

BACKUP_DIR="$HOME/nexvion-backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/nexvion_$TIMESTAMP.tar.gz"

echo "======================================"
echo "Backing up Nexvion project"
echo "======================================"

mkdir -p "$BACKUP_DIR"

tar \
  --exclude=".git" \
  -czf "$BACKUP_FILE" \
  .

echo "Backup completed successfully."
echo "Backup file: $BACKUP_FILE"