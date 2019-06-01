FROM php:5.6-apache

RUN apt-get update

RUN apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev libmcrypt-dev ssmtp \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/zzz-mail.ini

RUN docker-php-ext-install bz2 gd intl mcrypt mysql mysqli pcntl pdo_mysql soap sockets xmlreader zip

ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD resources/confd /etc/confd
ADD resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

RUN a2enmod headers rewrite
