# MariaDB + PHPMyAdmin on Alpine Linux + S6 Overlay

# Auto configuration parameters :

- ROOT_PASSWORD=password ( MariaDB ROOT Password )


# Compose file exemple

```

version: '3.1'

services:

  mariadb:
    image: samirkherraz/mariadb
    environment:
      - ROOT_PASSWORD=password
    ports:
      - 3306:3306
      - 80:80
    volumes:
      - mariadb-data:/var/lib/mysql/
      - mariadb-config:/etc/mysql/
    networks:
      default:
    deploy:
      resources:
        limits:
          memory: 256M
      restart_policy:
        condition: on-failure
      mode: global


volumes:
    mariadb-data:
    mariadb-config:

```