FROM php:7.2-apache-stretch

RUN apt update

RUN apt install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev \
                        libmcrypt-dev libreadline-dev libedit-dev libcurl4-openssl-dev \
                        vim

RUN docker-php-ext-install bz2 dom gd intl mbstring mysqli pcntl pdo_mysql soap sockets zip
