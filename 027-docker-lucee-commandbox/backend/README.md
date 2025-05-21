# CFML Docker BE

## Development Mode (live update file CFML)

```

docker compose up --build -d
```

- Secara otomatis akan membaca docker-compose.yml + docker-compose.override.yml
- Perubahan file di ./app langsung terlihat di browser

## Production Mode (tanpa mount, file di dalam image)

```
docker compose -f docker-compose.dev.yml up -d
```

- Hanya file dari dalam image yang dijalankan.
- Aman untuk deploy ke server/registry.

## Membersihkan Container dan Volumes (opsional)

```
docker compose down -v
```

## Compile

https://www.forgebox.io/view/cfml-compiler

- install dan jalankan perintah

```bash
rm -rf compiled && cp -r app compiled && box cfcompile sourcePath=./app destPath=./compiled cfengine=lucee@6.2.0 && docker compose up --build -d
```

## cara menjalankan

- linux

```
chmod +x build-and-run.sh
./build-and-run.sh
```

- Windows

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
./build-and-run.ps1
```
