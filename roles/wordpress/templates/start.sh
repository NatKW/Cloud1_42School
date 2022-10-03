
#!/bin/sh

# wait for mysql
while ! mariadb -h$CLOUD1_DB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $CLOUD1_DB_NAME &>/dev/null; do
    echo wait && sleep 3
done

if [ ! -f "/var/www/html/index.php" ]; then

    wp core download --allow-root
    wp config create --dbname=$CLOUD1_DB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=$CLOUD1_DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN --title=$CLOUD1_DB_TITLE --admin_user=$CLOUD1_DB_ADMIN --admin_password=$CLOUD1_DB_ADMIN_PWD --admin_email=$CLOUD1_DB_ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
    wp plugin update --all --allow-root

fi

/usr/sbin/php-fpm7 -F -R