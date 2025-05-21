#!/bin/bash
cd app
box install
cd ../
echo "=== Membersihkan folder compiled ==="
rm -rf compiled

echo "=== Menyalin folder app ke compiled ==="
cp -r app compiled

echo "=== Menjalankan CommandBox cfcompile ==="
box cfcompile sourcePath=./app destPath=./compiled cfengine=lucee@6.2.0

echo "=== Menjalankan Docker Compose ==="
docker compose up --build -d
