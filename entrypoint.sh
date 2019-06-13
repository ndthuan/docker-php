#!/bin/sh

set -ex

if [ ! -z "$NEW_WWW_DATA_UID" ]; then
    usermod -u $NEW_WWW_DATA_UID www-data
fi

if [ ! -z "$NEW_WWW_DATA_GID" ]; then
    groupmod -g $NEW_WWW_DATA_GID www-data
fi

cat > /etc/php5/conf.d/zzz-nuphp.ini <<EOF
extension=amqp.so
extension=redis.so
extension=memcached.so

short_open_tag=On

date.timezone=${NUPHP_DATE_TIMEZONE:-UTC}
upload_max_filesize=${NUPHP_UPLOAD_MAX_FILESIZE:-2M}
post_max_size=${NUPHP_POST_MAX_FILESIZE:-8M}
memory_limit=${NUPHP_MEMORY_LIMIT:-128M}
expose_php=${NUPHP_EXPOSE_VERSION:-Off}
session.cookie_httponly=${NUPHP_SESSION_COOKIE_HTTPONLY:-On}
session.cookie_secure=${NUPHP_SESSION_COOKIE_SECURE:-Off}
session.cookie_lifetime=${NUPHP_SESSION_COOKIE_LIFETIME:-0}
session.name=${NUPHP_SESSION_NAME:-PHPSESSID}
session.save_handler=${NUPHP_SESSION_SAVE_HANDLER:-files}
session.save_path=${NUPHP_SESSION_SAVE_PATH:-}
session.serialize_handler=${NUPHP_SESSION_SERIALIZE_HANDLER:-php}
session.gc_maxlifetime=${NUPHP_SESSION_GC_MAXLIFETIME:-1440}
session.auto_start=${NUPHP_SESSION_AUTO_START:-Off}

sendmail_path = "/usr/sbin/ssmtp -t"
EOF

cat > /etc/ssmtp/ssmtp.conf <<EOF
root=${SSMTP_ROOT_EMAIL:-root}
mailhub=${SSMTP_MAILHUB:-localhost:25}
rewriteDomain=${SSMTP_REWRITE_DOMAIN:-}
hostname=${SSMTP_HOSTNAME:-localhost.localdomain}
FromLineOverride=${SSMTP_FROM_LINE_OVERRIDE:-YES}
AuthUser=${SSMTP_AUTH_USER:-}
AuthPass=${SSMTP_AUTH_PASS:-}
AuthMethod=${SSMTP_AUTH_METHOD:-LOGIN}
UseTLS=${SSMTP_USE_TLS:-NO}
UseSTARTTLS=${SSMTP_USE_STARTTLS:-NO}
EOF

cat > /etc/apache2/conf.d/zzz-docker.conf <<EOF
LoadModule deflate_module modules/mod_deflate.so
LoadModule rewrite_module modules/mod_rewrite.so

User www-data
Group www-data

ServerAdmin ${VHOST_SERVER_ADMIN:-webmaster@localhost}
ServerTokens ${APACHE_SERVER_TOKENS:-Prod}
ServerSignature ${APACHE_SERVER_SIGNATURE:-Off}
DocumentRoot "${VHOST_PUBLIC_ROOT:=/var/www/html}"

<Directory ${VHOST_PUBLIC_ROOT}>
    Options ${WWW_DIR_OPTIONS:--Indexes}
    AllowOverride ${WWW_DIR_ALLOW_OVERRIDE:-None}
    Require all granted
	FallbackResource ${VHOST_FALLBACK_RESOURCE:-/index.php}
</Directory>

<IfModule !mpm_netware_module>
    PidFile "/run/httpd.pid"
</IfModule>

<IfModule mpm_prefork_module>
	StartServers		    ${PREFORK_START_SERVERS:-5}
	MinSpareServers		    ${PREFORK_MIN_SPARE_SERVERS:-5}
	MaxSpareServers		    ${PREFORK_MAX_SPARE_SERVERS:-10}
	MaxRequestWorkers	    ${PREFORK_MAX_REQUEST_WORKERS:-150}
	MaxConnectionsPerChild  ${PREFORK_MAX_CONNECTIONS_PER_CHILD:-0}
</IfModule>

<IfModule mod_headers.c>
	Header unset ETag

	Header set X-Hostname $HOSTNAME

	<filesMatch "\.(ico|jpe?g|png|gif|swf)$">
		Header set Cache-Control "max-age=2592000, public"
	</filesMatch>
	<filesMatch "\.(css)$">
		Header set Cache-Control "max-age=604800, public"
	</filesMatch>
	<filesMatch "\.(js)$">
		Header set Cache-Control "max-age=216000, private"
	</filesMatch>
	<filesMatch "\.(x?html?|php)$">
		Header set Cache-Control "max-age=420, private, must-revalidate"
	</filesMatch>
</IfModule>
FileETag None

AddOutputFilterByType DEFLATE text/plain
AddOutputFilterByType DEFLATE text/html
AddOutputFilterByType DEFLATE text/xml
AddOutputFilterByType DEFLATE text/css
AddOutputFilterByType DEFLATE application/xml
AddOutputFilterByType DEFLATE application/xhtml+xml
AddOutputFilterByType DEFLATE application/rss+xml
AddOutputFilterByType DEFLATE application/javascript
AddOutputFilterByType DEFLATE application/x-javascript

EOF

exec "$@"

