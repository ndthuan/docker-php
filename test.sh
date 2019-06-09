#!/bin/sh

docker run \
    -v `pwd`:/var/www/html \
    -p8080:80 \
    -e NEW_WWW_DATA_UID=$UID \
    -e NUPHP_UPLOAD_MAX_FILESIZE=100M \
    -e NUPHP_POST_MAX_FILESIZE=106M \
    ndthuan/php:5.6-apache-alpine
