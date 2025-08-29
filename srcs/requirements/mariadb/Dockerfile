FROM alpine:3.22.0

RUN mkdir -p /var/lib/mysql /run/mysqld

RUN apk update --no-cache && \
apk add --no-cache mariadb mariadb-client gettext && \
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY ./tools/init.sql /tools/init.sql
COPY ./tools/start.sh /tools/start.sh

RUN chmod +x /tools/init.sql /tools/start.sh

USER mysql

CMD [ "/tools/start.sh" ]