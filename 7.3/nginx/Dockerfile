FROM php:7.3-fpm-alpine

RUN apk update --no-cache

RUN apk add bzip2-dev jpeg-dev libpng-dev icu-dev libxml2-dev libzip-dev ssmtp nginx \
     && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/zzz-mail.ini

RUN docker-php-ext-install bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip

ADD resources/bin/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD resources/confd /etc/confd
ADD resources/confd-fpm-nginx/conf.d /etc/confd/conf.d
ADD resources/confd-fpm-nginx/templates /etc/confd/templates

ADD resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

COPY --from=composer /usr/bin/composer /usr/bin/composer

CMD php-fpm && nginx -g "daemon off;"
