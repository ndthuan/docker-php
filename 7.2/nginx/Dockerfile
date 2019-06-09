FROM php:7.2-fpm-alpine as builder

RUN apk update --no-cache \
    && apk add libmemcached-dev zlib-dev autoconf build-base pkgconf \
    && pecl install memcached-3.1.3

FROM php:7.2-fpm-alpine

RUN apk update --no-cache \
    && apk add bzip2-dev jpeg-dev libpng-dev icu-dev libxml2-dev libzip-dev libmemcached-dev ssmtp nginx \
    && docker-php-ext-install bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/zzz-mail.ini \
    && echo 'extension=memcached.so' >> /usr/local/etc/php/conf.d/memcached.ini \
    && apk del gcc g++ perl

COPY --from=builder /usr/local/lib/php/extensions/no-debug-non-zts-20170718/memcached.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/
COPY --from=composer /usr/bin/composer /usr/bin/composer

ADD resources/bin/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD resources/confd /etc/confd
ADD resources/confd-fpm-nginx/conf.d /etc/confd/conf.d
ADD resources/confd-fpm-nginx/templates /etc/confd/templates

ADD resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

CMD php-fpm && nginx -g "daemon off;"
