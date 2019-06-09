FROM php:7.2-fpm-alpine as builder

RUN apk update --no-cache && \
    apk add --no-cache libmemcached-dev rabbitmq-c-dev zlib-dev autoconf build-base pkgconf && \
    pecl install memcached && \
    pecl install redis && \
    pecl install amqp

FROM php:7.2-fpm-alpine

RUN apk update --no-cache && \
    apk add --no-cache bzip2-dev jpeg-dev libpng-dev gettext-dev icu-dev libxml2-dev libzip-dev libmemcached \
        tidyhtml-dev rabbitmq-c ssmtp nginx shadow && \
    docker-php-ext-install bcmath bz2 calendar exif gd gettext intl mysqli opcache pcntl pdo_mysql soap sockets tidy zip

COPY --from=builder /usr/local/lib/php/extensions/no-debug-non-zts-20170718/* /usr/local/lib/php/extensions/no-debug-non-zts-20170718/

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY resources/bin/confd-0.16.0-linux-amd64 /usr/local/bin/confd
COPY resources/confd /etc/confd
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh && chmod +x /usr/local/bin/confd

ENTRYPOINT [ "/entrypoint.sh" ]

CMD php-fpm && nginx -g "daemon off;"
