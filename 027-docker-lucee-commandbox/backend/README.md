# CFML Docker BE

## Development Mode (live update file CFML)

```
docker compose up --build -d
```

- Secara otomatis akan membaca docker-compose.yml + docker-compose.override.yml
- Perubahan file di ./app langsung terlihat di browser

## Production Mode (tanpa mount, file di dalam image)

```
docker compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d
```

- Hanya file dari dalam image yang dijalankan.
- Aman untuk deploy ke server/registry.

## Membersihkan Container dan Volumes (opsional)

```
docker compose down -v
```
