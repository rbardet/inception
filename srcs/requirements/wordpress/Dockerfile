FROM alpine:3.22.0

RUN apk update --no-cache && \
    apk add --no-cache wget tar php

RUN wget https://wordpress.org/latest.tar.gz -P /var/www && \
    mkdir -p /var/www/html && \
    cd /var/www && \
    tar -xf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress

CMD [ "executable" ]
