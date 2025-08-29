envsubst < /tools/init.sql > /tools/init.sql

exec mysqld --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock --console
