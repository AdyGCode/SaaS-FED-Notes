# syntax=docker/dockerfile:1

# After IT approval, replace the tag with the approved immutable digest:
# FROM php:8.4-fpm-bookworm@sha256:<approved-digest>
FROM php:8.4-fpm-bookworm

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/tmp/composer

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libcurl4-openssl-dev \
        libicu-dev \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        intl \
        mbstring \
        opcache \
        pcntl \
        pdo_mysql \
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Pin this image by digest after IT approval.
COPY --from=composer:2.10.2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

COPY docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

EXPOSE 9000

CMD ["php-fpm"]
