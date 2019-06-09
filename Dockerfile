FROM alpine:3.9

RUN apk update --no-cache && \
    apk add --no-cache php7-apache2 php7-pgsql php7-zip php7-xmlrpc php7-imap php7-zlib php7-calendar \
    php7-mysqli php7-soap php7-cli php7-bz2 php7-sockets php7-pdo_mysql php7-iconv php7-dev php7-ftp php7-gettext \
    php7-mcrypt php7-exif php7-xmlreader php7-xmlwriter php7-gd php7-xml php7-pcntl php7-pdo_pgsql php7-phar \
    php7-ctype php7-intl php7-sqlite3 \
    php7-pdo php7-openssl php7-pdo_sqlite php7-dom php7-curl php7-xsl php7-ldap php7-json php7-bcmath php7-opcache \
    php7-pecl-redis php7-pecl-yaml php7-pecl-memcached php7-pecl-amqp php7-pecl-mongodb php7-pecl-imagick \
    apache2 ssmtp shadow && \
    ln -sf /proc/self/fd/2 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/2 /var/log/apache2/error.log && \
    adduser -S -s /sbin/nologin -G www-data -h /var/www/html www-data

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "httpd", "-DFOREGROUND" ]

WORKDIR /var/www/html
