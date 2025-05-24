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

## Tabel Schema

```sql
CREATE TABLE `personal` (
  `personal_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Create Time',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Updated Time',
  PRIMARY KEY (`personal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT 0,
  `personal_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Create Time',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Updated Time',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `personal_id` (`personal_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`personal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci
```
