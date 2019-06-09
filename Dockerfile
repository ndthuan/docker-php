FROM php:7.3-apache AS builder

RUN apt-get update && \
    apt-get install -y libmemcached-dev zlib1g-dev && \
    pecl install memcached && \
    php -i | grep extension_dir

FROM php:7.3-apache

RUN apt-get update && \
    apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev libmemcached-dev ssmtp && \
    docker-php-ext-install bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip && \
    apt-get clean

COPY resources/bin/confd-0.16.0-linux-amd64 /usr/local/bin/confd
COPY resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
COPY resources/confd /etc/confd
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chmod +x /usr/local/bin/docker-php-entrypoint && \
    chmod +x /usr/local/bin/confd && \
    a2enmod headers rewrite
