# CFML DOCKER FTP ENCRIPT FILER EXCEL

## Jalankan

```bash
docker-compose up --build
```

## Samle Data

```sql
CREATE TABLE `user` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `nik` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_uca1400_ai_ci',
    `name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_uca1400_ai_ci',
    `email` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_uca1400_ai_ci',
    `age` INT(11) NULL DEFAULT NULL,
    `dob` DATE NULL DEFAULT NULL,
    `jam` TIME NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13;

INSERT INTO
    `user` (id,nik,name,email, age,dob,jam)
VALUES (1,'00123456789','Coba 1','asep@coba.com',20,'2000-01-01','12:00:00' );

INSERT INTO
   `user` (id,nik,name,email, age,dob,jam)
VALUES (2,'00987654321','Pojok Code','pojok@asep.com',24,'2001-01-01','15:00:00');

INSERT INTO
    `user` (id,nik,name,email, age,dob,jam)
VALUES ( 3,'00123456789','Coba 2','coba2@asep.com',32,'2024-01-01','10:00:00');

INSERT INTO
    `user` (id,nik,name,email, age,dob,jam)
VALUES (12,'000001','Coba Upload','asep@coba.com',20,'2000-01-01','12:00:00');
```
