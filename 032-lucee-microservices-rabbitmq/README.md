# CFML Microservice RabbitMQ

## Create Network and run docker

```
docker network create shared-net
docker-compose -f rabbitmq/docker-compose.yml up -d
docker-compose -f employee-service/docker-compose.yml up --build -d
docker-compose -f payroll-service/docker-compose.yml up --build -d
docker-compose -f proxy/docker-compose.yml up -d

```

## Referensi

https://github.com/lmajano/messaging-polyglot
