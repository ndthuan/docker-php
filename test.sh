#!/bin/sh

docker run \
    -v `pwd`:/var/www/html \
    -p60000:80 \
    -e NEW_WWW_DATA_UID=$UID \
    -e NUPHP_UPLOAD_MAX_FILESIZE=100M \
    -e NUPHP_POST_MAX_FILESIZE=106M \
    -e NUPHP_DATE_TIMEZONE=Asia/Ho_Chi_Minh \
    ndthuan/php:5.6-apache-alpine
