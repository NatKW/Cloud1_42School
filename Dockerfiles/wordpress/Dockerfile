FROM	alpine:3.15

RUN		apk update && apk upgrade && apk add --no-cache \
		mariadb-client \
		wget \
		vim \
		php7 php7-cli php7-fpm php7-json \
		php7-common php7-mysqli php7-zip \
		php7-gd php7-mbstring php7-xml php-phar\
		php7-xml php7-pear php7-openssl php7-bcmath \	
RUN		rm -rf /var/lib/apt/lists/*

# Php config
RUN		adduser -S nginx &&	addgroup -S nginx
COPY	/php-fpm.conf /etc/php7/php-fpm.conf
COPY	/www.conf /etc/php7/php-fpm.d/www.conf
RUN     mkdir -p /var/www/html/
RUN 	chmod 755 /var/www/html/

#Download and Setup
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		php wp-cli.phar --info
RUN		chmod +x wp-cli.phar
RUN 	mv wp-cli.phar /usr/local/bin/wp
RUN		chown -R nginx:nginx /usr/local/bin/wp

WORKDIR /var/www/html/
COPY 	/start.sh /tmp/start.sh

EXPOSE 9000

ENTRYPOINT [ "sh", "/tmp/start.sh" ]
