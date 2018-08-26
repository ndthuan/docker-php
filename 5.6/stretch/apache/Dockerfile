FROM php:5.6-apache-stretch

RUN apt-get update

RUN apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev \
                        libmcrypt-dev libreadline-dev libedit-dev libcurl4-openssl-dev \
                        vim

RUN docker-php-ext-install bz2 curl dom gd iconv intl mbstring mcrypt mysql mysqli pcntl pdo_mysql readline session soap sockets xmlreader zip
