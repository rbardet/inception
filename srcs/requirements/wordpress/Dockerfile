FROM alpine:3.22.0

RUN apk update --no-cache && \
    apk add --no-cache php84 php84-fpm php84-mysqli mariadb-client \
    wget tar

RUN wget https://wordpress.org/latest.tar.gz -P /var/www && \
    mkdir -p /var/www/html && \
    cd /var/www && \
    tar -xf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress

RUN adduser -D -g 'www' www && chown -R www:www /var/www/html

EXPOSE 9000

COPY tools/start.sh /tools/start.sh

RUN chmod +x /tools/start.sh

WORKDIR /var/www/html

CMD ["/tools/start.sh"]
