# docker-php

PHP image packaged with commonly used extensions: `bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip`.

Example: `docker run -p 8080:8080 -e NEW_WWW_DATA_UID=$UID -e NUPHP_MEMORY_LIMIT=256M -v $(pwd):/var/www/html ndthuan/php:7.3-apache bash`

Available tags:
* 5.6-apache
* 7.2-apache
* 7.3-apache

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
  * WWW_DIR_OPTIONS (default: "-Indexes FollowSymLinks")
* Modify **www-data** UID and GID by supplying:
  * NEW_WWW_DATA_UID
  * NEW_WWW_DATA_GID
