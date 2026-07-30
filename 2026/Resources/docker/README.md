The equivalent Laravel + MySQL Docker package is ready.

[Download the complete Laravel MySQL Docker package](sandbox:/mnt/data/laravel-mysql-docker.zip)

Individual files:

* [Dockerfile](sandbox:/mnt/data/laravel-mysql-docker/Dockerfile)
* [compose.yaml](sandbox:/mnt/data/laravel-mysql-docker/compose.yaml)
* [Makefile](sandbox:/mnt/data/laravel-mysql-docker/Makefile)
* [README.md](sandbox:/mnt/data/laravel-mysql-docker/README.md)
* [.env.docker.example](sandbox:/mnt/data/laravel-mysql-docker/.env.docker.example)
* [.dockerignore](sandbox:/mnt/data/laravel-mysql-docker/.dockerignore)
* [Nginx configuration](sandbox:/mnt/data/laravel-mysql-docker/docker/nginx/default.conf)
* [PHP OPcache configuration](sandbox:/mnt/data/laravel-mysql-docker/docker/php/opcache.ini)

The stack uses:

```text
php:8.4-fpm-bookworm
mysql:8.4.11-oraclelinux9
nginx:stable-bookworm
composer:2.10.2
```

MySQL 8.4 is the LTS series, and the selected version is an exact official-image tag rather than a floating `mysql:8` or `latest` tag. ([Docker Hub][1]) The other components also use Docker Official Images. ([Docker Hub][2])

## Initial setup

```bash
cp .env.docker.example .env
make up
make install
make key
make migrate
```

Open Laravel at:

```text
http://localhost:8080
```

Useful commands include:

```bash
make mysql-shell
make test
make logs
make migrate-fresh
make down
make reset
```

Before submitting the images for college approval, replace:

```text
REPLACE_WITH_COLLEGE_ORG
```

with the college GitHub organisation name. The final approved image references should also include immutable SHA-256 digests.

[1]: https://hub.docker.com/_/mysql/tags?utm_source=chatgpt.com "mysql Tags | Docker Hub"
[2]: https://hub.docker.com/_/nginx/?utm_source=chatgpt.com "nginx - Official Image | Docker Hub"
