FROM alpine:3.22.0

RUN mkdir /var/lib/mysql /run/mysqld && \
chmod 777 /var/lib/mysql /run/mysqld

RUN apk update --no-cache && \
apk add --no-cache mariadb mariadb-client && \
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

USER mysql

CMD [ "mariadbd" ]