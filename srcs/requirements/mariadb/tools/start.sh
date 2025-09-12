#!/bin/sh
set -e

DATADIR="/var/lib/mysql"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql
rm -f /run/mysqld/mysqld.sock

if [ ! -d "$DATADIR/mysql" ]; then
    mariadb-install-db --user=mysql --datadir="$DATADIR" > /dev/null
fi

mysqld --user=mysql --skip-networking &
pid="$!"

until mysqladmin ping -u"${MYSQL_ADMIN}" -p"${MYSQL_ADMIN_PASSWORD}" --silent; do
    echo "waiting for mariadb"
    sleep 1
done

mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
CREATE USER IF NOT EXISTS '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

mysqladmin -u root shutdown || kill "$pid"

echo "mariadb up"

exec mysqld --user=mysql --bind-address=0.0.0.0 --port=3306 --skip-networking=0
