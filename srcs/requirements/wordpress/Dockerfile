FROM alpine:3.22.0

RUN apk add --no-cache \
    php84 php84-fpm php84-mysqli php84-mbstring php84-json php84-openssl php84-curl php84-gd php84-xml php84-session php84-phar \
    mariadb-client bash wget tar curl && \
    ln -s /usr/bin/php84 /usr/bin/php

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

RUN wget https://wordpress.org/latest.tar.gz -P /var/www && \
    mkdir -p /var/www/html && \
    tar -xf /var/www/latest.tar.gz -C /var/www && \
    mv /var/www/wordpress/* /var/www/html/ && \
    rm -rf /var/www/latest.tar.gz /var/www/wordpress

RUN adduser -D -g 'www' www && \
    chown -R www:www /var/www/html

COPY tools/start.sh /tools/start.sh
RUN chmod +x /tools/start.sh

EXPOSE 9000

WORKDIR /var/www/html
CMD ["/tools/start.sh"]
