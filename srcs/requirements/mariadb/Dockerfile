FROM alpine:3.22.0

WORKDIR /etc/mysql

RUN apk update && \
apk add --no-cache mysql

EXPOSE 3306

CMD [ "mariadbd" ]