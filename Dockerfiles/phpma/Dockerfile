FROM	alpine:3.15

RUN	apk update && apk upgrade && apk add --no-cache \
    wget vim tar openssl \
	php7 php7-fpm php7-opcache \
	php7 php7-cli php7-fpm php7-json \
	php7-common php7-mysqli php7-zip \
	php7-gd php7-mbstring php7-xml php7-phar\
	php7-xml php7-pear php7-openssl php7-bcmath
RUN rm -rf /var/cache/apk/*

RUN	adduser -S nginx &&	addgroup -S nginx

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-english.tar.gz -O /tmp/phpMyAdmin.tar.gz
RUN tar -xvzf /tmp/phpMyAdmin.tar.gz -C /tmp
RUN mkdir -p /var/www/phpmyadmin
RUN mkdir /var/www/phpmyadmin/tmp && chmod 0777 /var/www/phpmyadmin/tmp
RUN cp -r /tmp/phpMyAdmin-5.2.0-english/* /var/www/phpmyadmin

COPY ./www.conf /etc/php7/php-fpm.d/www.conf
COPY ./config.inc.php /var/www/phpmyadmin/config.inc.php
RUN	echo "\$cfg['blowfish_secret'] = '$(openssl rand -base64 32)';" >> /var/www/phpmyadmin/config.inc.php

RUN mkdir /run/php/
RUN touch /var/log/php7/error.log \
	&& chmod a+rwx /var/log/php7/error.log
RUN chown -R nginx:nginx /var/www/phpmyadmin /run/php /var/log/php7/error.log \
	/etc/php7/php-fpm.d/www.conf

USER nginx

ENTRYPOINT [ "php-fpm7", "--nodaemonize" ]