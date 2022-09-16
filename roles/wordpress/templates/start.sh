
#!/bin/sh

# wait for mysql
while ! mariadb -h$WORDPRESS_DB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null; do
    echo wait && sleep 3
done

if [ ! -f "/var/www/html/index.php" ]; then

    wp core download --allow-root
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN --title=$WORDPRESS_DB_TITLE --admin_user=$WORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PWD --admin_email=$WORDPRESS_DB_ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
    wp plugin update --all --allow-root

fi

/usr/sbin/php-fpm7 -F -R