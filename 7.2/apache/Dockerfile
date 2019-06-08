FROM php:7.2-apache

RUN apt-get update

RUN apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev libmemcached-dev ssmtp \
    && pecl install memcached-3.1.3 \
    && echo 'extension=memcached.so' >> /usr/local/etc/php/conf.d/memcached.ini \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/zzz-mail.ini \
    && docker-php-ext-install bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip

RUN apt-get clean

ADD resources/bin/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD resources/confd /etc/confd
ADD resources/confd-apache/conf.d /etc/confd/conf.d
ADD resources/confd-apache/templates /etc/confd/templates

ADD resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

RUN a2enmod headers rewrite

COPY --from=composer /usr/bin/composer /usr/bin/composer
