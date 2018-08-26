FROM php:7.2-apache

RUN apt-get update

RUN apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev

RUN docker-php-ext-install bz2 gd intl mbstring mysqli pcntl pdo_mysql soap sockets zip

ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD confd /etc/confd
ADD bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint
