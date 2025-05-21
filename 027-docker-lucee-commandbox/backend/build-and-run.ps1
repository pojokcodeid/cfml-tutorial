cd .\app\
box install
cd ../
Write-Host "=== Membersihkan folder compiled ==="
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue compiled

Write-Host "=== Menyalin folder app ke compiled ==="
Copy-Item -Recurse -Force app compiled

Write-Host "=== Menjalankan CommandBox cfcompile ==="
box cfcompile sourcePath=./app destPath=./compiled cfengine=lucee@6.2.0

Write-Host "=== Menjalankan Docker Compose ==="
docker compose up --build -d
