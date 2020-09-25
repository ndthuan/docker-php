FROM alpine:3.9 AS builder

ARG phpver=php-7.3.21

RUN apk update --no-cache && \
    apk add --no-cache build-base apache2-dev bzip2-dev curl-dev gettext-dev imap-dev libedit-dev libpng-dev readline-dev \
    libxml2-dev libmemcached-dev libzip-dev rabbitmq-c-dev wget apache2 icu-dev libmcrypt-dev yaml-dev imagemagick-dev openldap-dev \
    autoconf libxslt-dev openldap-dev curl && \
    cd /tmp && \
    wget https://www.php.net/distributions/${phpver}.tar.gz && \
    tar xzf ${phpver}.tar.gz && \
    cd ${phpver} && \
    mkdir -p /etc/php.d && \
    ./configure \
        --prefix=/usr \
        --with-openssl \
        --with-apxs2 \
        --with-config-file-path=/etc \
        --with-config-file-scan-dir=/etc/php.d \
        --disable-cgi \
        --with-zlib \
        --enable-bcmath \
        --with-bz2 \
        --enable-calendar \
        --with-curl \
        --enable-exif \
        --enable-ftp \
        --with-gd \
        --with-gettext \
        --with-mhash \
        --with-imap \
        --with-imap-ssl \
        --enable-intl \
        --enable-mbstring \
        --with-mysqli \
        --enable-pcntl \
        --with-pdo-mysql=mysqlnd \
        --with-pdo-pgsql \
        --with-pgsql \
        --with-libedit \
        --with-readline \
        --enable-soap \
        --enable-sockets \
        --with-xmlrpc \
        --enable-zip \
        --enable-mysqlnd \
        --with-xsl \
        --with-ldap \
        --with-ldap-sasl \
        --enable-opcache && \
    make && make install && \
    pecl install memcached redis amqp mcrypt-1.0.2 yaml mongodb imagick igbinary

FROM alpine:3.9

ARG phpver=php-7.3.21

RUN apk update --no-cache && \
    apk add --no-cache apache2 libedit libpq readline libxml2 libmemcached libzip libbz2 libcurl libxslt yaml \
    icu-libs libpng gettext-libs imap c-client shadow ssmtp rabbitmq-c libmcrypt imagemagick-libs curl && \
    ln -sf /proc/self/fd/2 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/2 /var/log/apache2/error.log && \
    adduser -S -s /sbin/nologin -G www-data -h /var/www/html www-data && \
    mkdir -p /etc/php.d

COPY --from=builder /tmp/${phpver}/php.ini-production /etc/php.ini
COPY --from=builder /usr/bin/php* /usr/bin/
COPY --from=builder /usr/lib/php /usr/lib/php
COPY --from=builder /usr/include/php /usr/include/php
COPY --from=builder /usr/bin/pecl /usr/bin/
COPY --from=builder /usr/lib/apache2/libphp7.so /usr/lib/apache2/
COPY --from=builder /usr/lib/php/extensions/no-debug-non-zts-20180731/* /usr/lib/php/extensions/no-debug-non-zts-20180731/
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh && \
    echo $'LoadModule php7_module /usr/lib/apache2/libphp7.so\n \
<FilesMatch \.php$> \n\
    SetHandler application/x-httpd-php \n\
</FilesMatch> \n\
' >> /etc/apache2/httpd.conf

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "httpd", "-DFOREGROUND" ]

WORKDIR /var/www/html
