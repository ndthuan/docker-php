#!/bin/sh

docker run \
    -v `pwd`:/var/www/html \
    -p8080:80 \
    -e NEW_WWW_DATA_UID=$UID \
    -e NUPHP_UPLOAD_MAX_FILESIZE=100M \
    -e NUPHP_POST_MAX_FILESIZE=106M \
    -e NGINX_REWRITE_MODE=framework \
    ndthuan/php:7.2-fpm-nginx-alpine
