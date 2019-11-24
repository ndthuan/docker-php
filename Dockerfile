FROM alpine:3.7 AS builder

RUN apk update --no-cache && \
    apk add --no-cache libmemcached-dev rabbitmq-c-dev zlib-dev autoconf build-base pkgconf php5-dev php5-pear php5-openssl curl && \
    ln -sf /usr/bin/php5 /usr/bin/php && \
    ln -sf /usr/bin/phpize5 /usr/bin/phpize && \
    ln -sf /usr/bin/php-config5 /usr/bin/php-config && \
    pecl install memcached-2.2.0 redis amqp

FROM alpine:3.7

ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data

RUN apk update --no-cache && \
    apk add --no-cache php5-apache2 php5-pgsql php5-zip php5-xmlrpc php5-mysql php5-imap php5-zlib php5-calendar \
    php5-mysqli php5-soap php5-cli php5-bz2 php5-sockets php5-pdo_mysql php5-iconv php5-dev php5-ftp php5-gettext \
    php5-mcrypt php5-exif php5-xmlreader php5-gd php5-xml php5-pcntl php5-pdo_pgsql php5-phar php5-ctype php5-intl \
    php5-pdo php5-openssl php5-pdo_sqlite php5-dom php5-curl php5-xsl php5-ldap php5-json php5-bcmath php5-opcache \
    php5-sqlite3 apache2 ssmtp shadow libmemcached rabbitmq-c && \
    ln -sf /usr/bin/php5 /usr/bin/php && \
    ln -sf /usr/bin/phpize5 /usr/bin/phpize && \
    ln -sf /usr/bin/php-config5 /usr/bin/php-config && \
    ln -sf /proc/self/fd/2 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/2 /var/log/apache2/error.log && \
    adduser -S -s /sbin/nologin -G www-data -h /var/www/html www-data

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=builder /usr/lib/php5/modules/* /usr/lib/php5/modules/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "httpd", "-DFOREGROUND" ]

WORKDIR /var/www/html
EXPOSE 80

# HEALTHCHECK CMD curl --silent --fail http://localhost || exit 1
