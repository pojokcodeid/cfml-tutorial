# Lucee Rest API

## Untuk Menjalankan

```bash
box install
box server start
```

## Untuk Menghentikan

```bash
box server stop
```

## Untuk melakukan restart

```bash
box server restart
```

## Menhapus Lucee Server

```bash
box server forget
```

## export import cfconfig

```bash
box cfconfig export to=.cfconfig.json
box server stop lucee-rest-api
box server forget lucee-rest-api
box server start
box cfconfig import from=.cfconfig.json
box server restart
```

# Contoh acess

```
http://localhost:8888/rest/em/user/say
http://localhost:8888/rest/em/user/login
```

# Craste Tabel

```sql
CREATE TABLE `personal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `status` int(11) DEFAULT 0,
  `personal_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `personal_id` (`personal_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```
