# docker-php

PHP image packaged with commonly used extensions: `bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip`.

Example: 
```bash
docker run -p 8080:80 \
-e NEW_WWW_DATA_UID=$UID \
-e NUPHP_POST_MAX_FILESIZE=106M \
-e NUPHP_UPLOAD_MAX_FILESIZE=100M \
-v $(pwd):/var/www/html \
ndthuan/php:7.3-apache
```

Available tags:
* 5.6-apache
* 7.2-apache
* 7.2-fpm-nginx - Alpine based
* 7.3-apache
* 7.3-fpm-nginx - Alpine based

# Supported env vars

* **PHP settings**
  * NUPHP_UPLOAD_MAX_FILESIZE (default: 2M)
  * NUPHP_POST_MAX_FILESIZE (default: 8M)
  * NUPHP_MEMORY_LIMIT (default: 128M)
  * NUPHP_EXPOSE_VERSION (default: Off)
  * NUPHP_SESSION_COOKIE_HTTPONLY (default: On)
  * NUPHP_SESSION_COOKIE_SECURE (default: Off)
  * NUPHP_SESSION_NAME (default: PHPSESSID)
  * NUPHP_SESSION_SAVE_HANDLER (default: files)
  * NUPHP_SESSION_SAVE_PATH (default: _empty_)
* **Apache2 settings**
  * APACHE_SERVER_TOKENS (default: Prod)
  * APACHE_SERVER_SIGNATURE (default: Off)
  * VHOST_SERVER_ADMIN (default: webmaster@localhost)
  * WWW_DIR_ALLOW_OVERRIDE (default: "None")
  * WWW_DIR_OPTIONS (default: "-Indexes")
* **PHP-FPM settings** (only effective in *-fpm-nginx images)
  * FPM_MAX_CHILDREN (default: 10)
  * FPM_START_SERVERS (default: 2)
  * FPM_MIN_SPARE_SERVERS (default: 1)
  * FPM_MAX_SPARE_SERVERS (default: 3)
  * FPM_MAX_REQUESTS (default: 500)
* Modify **www-data** UID and GID by supplying:
  * NEW_WWW_DATA_UID
  * NEW_WWW_DATA_GID
* **sSMTP settings**
  * SSMTP_ROOT_EMAIL (default: root)
  * SSMTP_MAILHUB (default: localhost:25)
  * SSMTP_REWRITE_DOMAIN (default: empty)
  * SSMTP_HOSTNAME (default: localhost.localdomain)
  * SSMTP_FROM_LINE_OVERRIDE (default: YES)
  * SSMTP_AUTH_USER (default: empty)
  * SSMTP_AUTH_PASS (default: empty)
  * SSMTP_AUTH_METHOD (default: LOGIN)
  * SSMTP_USE_TLS (default: NO)
  * SSMTP_USE_STARTTLS (default: NO)
