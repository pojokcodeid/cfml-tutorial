@echo off
echo === Membersihkan folder compiled ===
rmdir /s /q compiled

echo === Menyalin folder app ke compiled ===
xcopy app compiled /E /I /H

echo === Menjalankan CommandBox cfcompile ===
box cfcompile sourcePath=./app destPath=./compiled cfengine=lucee@6.2.0

echo === Menjalankan Docker Compose ===
docker compose up --build -d
