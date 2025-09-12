#!/bin/sh
set -e

WWW_DIR="/var/www/html"
PHP_FPM_CONF="/tmp/php-fpm.conf"

until mariadb-admin ping -h "${MYSQL_HOST:-mariadb}" -u"$MYSQL_USER" -p"$MYSQL_USER_PASSWORD" --silent; do
    sleep 2
done

cat > "$WWW_DIR/wp-config.php" <<EOF
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${MYSQL_USER_PASSWORD}');
define('DB_HOST', '${MYSQL_HOST:-mariadb}');
define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', true);
\$table_prefix = 'wp_';
if (!defined('ABSPATH')) define('ABSPATH', __DIR__ . '/');
require_once ABSPATH . 'wp-settings.php';
EOF

chown -R www:www "$WWW_DIR"

if ! wp core is-installed --path="$WWW_DIR" --allow-root; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="My WordPress Site" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --path="$WWW_DIR" \
        --allow-root
fi

wp user update "$WORDPRESS_ADMIN_USER" --user_pass="$WORDPRESS_ADMIN_PASS" --allow-root

if ! wp user get "$WORDPRESS_USER" --path="$WWW_DIR" --allow-root >/dev/null 2>&1; then
    wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
        --role=subscriber \
        --user_pass="$WORDPRESS_USER_PASS" \
        --path="$WWW_DIR" \
        --allow-root
fi

cat > "$PHP_FPM_CONF" <<EOF
[global]
pid = /tmp/php-fpm.pid
error_log = /proc/self/fd/2
daemonize = no

[www]
user = www
group = www
listen = 0.0.0.0:9000
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF

exec php-fpm84 -F -y "$PHP_FPM_CONF"
