#!/bin/sh

set -ex

if [ ! -z "$NEW_WWW_DATA_UID" ]; then
    usermod -u $NEW_WWW_DATA_UID www-data
fi

if [ ! -z "$NEW_WWW_DATA_GID" ]; then
    groupmod -g $NEW_WWW_DATA_GID www-data
fi

confd -onetime -backend env

exec "$@"