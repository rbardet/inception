FROM alpine:3.22.0

WORKDIR /etc/nginx

COPY ./conf /etc/nginx/conf

RUN mkdir /etc/nginx/cert

RUN apk update && \
apk add --no-cache nginx openssl && \
openssl req -newkey rsa:2048 -nodes \
    -x509 -days 365 \
    -keyout /etc/nginx/cert/ssl_key.crt \
    -out /etc/nginx/cert/ssl_certificate.crt \
    -subj "/C=FR/ST=Normandie/L=Le Havre/O=42/OU=Student/CN=rbardet-.42.fr"

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]