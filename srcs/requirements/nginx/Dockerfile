FROM alpine:3.22.0

RUN apk update --no-cache && apk add --no-cache nginx openssl bash

RUN mkdir -p /etc/nginx/cert /var/www/html /etc/nginx/conf.d

COPY ./tools/start.sh /tools/start.sh

RUN chmod +x /tools/start.sh

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["/tools/start.sh"]
