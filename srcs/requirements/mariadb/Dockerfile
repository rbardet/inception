FROM alpine:3.22.0

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3306

ENTRYPOINT ["/start.sh"]