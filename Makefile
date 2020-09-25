build:
	docker build -t ndthuan/php:7.3-apache-alpine .
push:
	docker push ndthuan/php:7.3-apache-alpine
test:
	docker run \
    -v `pwd`:/var/www/html \
    -p 60000:80 \
    -e NUPHP_UPLOAD_MAX_FILESIZE=100M \
    -e NUPHP_POST_MAX_FILESIZE=106M \
    ndthuan/php:7.3-apache-alpine
