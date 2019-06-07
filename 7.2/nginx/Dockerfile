FROM php:7.2-fpm

RUN apt-get update

RUN apt-get install -y libjpeg-dev libpng-dev libxml2-dev libbz2-dev libzip-dev ssmtp nginx \
     && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/zzz-mail.ini

RUN docker-php-ext-install bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip

RUN apt-get clean

RUN sed -i 's/# server_tokens off;/server_tokens off;/g' /etc/nginx/nginx.conf \
    && sed -i 's#access_log /var/log/nginx/access.log;#access_log /proc/self/fd/2;#g' /etc/nginx/nginx.conf \
    && sed -i 's#error_log /var/log/nginx/error.log;#error_log /proc/self/fd/2;#g' /etc/nginx/nginx.conf

ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

ADD resources/confd /etc/confd
ADD resources/confd-fpm-nginx/conf.d /etc/confd/conf.d
ADD resources/confd-fpm-nginx/templates /etc/confd/templates

ADD resources/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

COPY --from=composer /usr/bin/composer /usr/bin/composer

CMD php-fpm && nginx -g "daemon off;"
