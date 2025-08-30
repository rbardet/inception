#!/bin/sh
set -e

echo "Waiting for Mariadb to be ready"

while ! mariadb -h mariadb -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1" &>/dev/null; do
    echo "Waiting for mariadb"
    sleep 1
done

echo "Mariadb is ready"

cat > /var/www/html/wp-config.php <<EOF
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${MYSQL_PASSWORD}');
define('DB_HOST', 'mariadb');
EOF

exec /usr/sbin/php-fpm84 -F -R
