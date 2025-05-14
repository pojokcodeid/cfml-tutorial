# CFML-DOCKER-COMMANDBOX

## Jalankan docker

```bash
# jalankan saja
docker-compose up

# jalankan di backend
docker-compose up -d

# stop docker compose
docker-compose down
```

## Bersihkan Docker

```bash
# Hentikan semua container yang sedang berjalan
docker stop $(docker ps -aq)

# Hapus semua container
docker rm $(docker ps -aq)

# Hapus semua images
docker rmi $(docker images -q)

# Hapus semua volume
docker volume rm $(docker volume ls -q)

# Hapus semua network yang tidak digunakan
docker network prune -f

# Bersihkan data yang tidak terpakai secara keseluruhan
docker system prune --all --volumes --force
```
