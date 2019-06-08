# docker-php

PHP image packaged with commonly used extensions: `bz2 gd intl mbstring mysqli opcache pcntl pdo_mysql soap sockets zip`.

**Examples:**

For Open source apps that put everything in public root directory such as phpBB, WordPress...:
```bash
docker run -p 8080:80 \
-e NEW_WWW_DATA_UID=$UID \
-e NUPHP_POST_MAX_FILESIZE=106M \
-e NUPHP_UPLOAD_MAX_FILESIZE=100M \
-v $(pwd):/var/www/html \
ndthuan/php:7.3-apache
```

For apps using Laravel/Symfony/Zend, etc...
```bash
docker run -p 8080:80 \
-e NEW_WWW_DATA_UID=$UID \
-e NUPHP_POST_MAX_FILESIZE=106M \
-e NUPHP_UPLOAD_MAX_FILESIZE=100M \
-e NGINX_REWRITE_MODE=framework
-e VHOST_PUBLIC_ROOT=/app/public
-v $(pwd):/app \
ndthuan/php:7.3-fpm-nginx
```

Available tags:
* 5.6-apache
* 7.2-apache
* 7.2-fpm-nginx - Alpine based
* 7.3-apache
* 7.3-fpm-nginx - Alpine based

# About php-fpm and nginx in the same image

Some people might argue that this defeats the philosophy of containers that multiple services should not be running in the same container.

But since php-fpm itself cannot serve HTTP, we need a web server to act as its frontend. These two services come together to serve the same concern so it's valid to put them in the same image.  

Also, if you have tens of web apps, this helps you quickly launch a container without touching a configuration file.

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
  * VHOST_PUBLIC_ROOT (default: /var/www/html)
* **PHP-FPM settings**
  * FPM_MAX_CHILDREN (default: 10)
  * FPM_START_SERVERS (default: 2)
  * FPM_MIN_SPARE_SERVERS (default: 1)
  * FPM_MAX_SPARE_SERVERS (default: 3)
  * FPM_MAX_REQUESTS (default: 500)
* **Nginx** settings
  * NGINX_REWRITE_MODE (default: empty) set to `framework` to enable the rewrite rule `try_files $uri $uri/ /index.php$is_args$args;`. This works for frameworks such as Laravel/Symfony/Zend.
  * VHOST_PUBLIC_ROOT (default: /var/www/html) 
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
