FROM alpine:3.22.0

WORKDIR /app/nginx

COPY ./conf /etc/nginx/conf/nginx.conf

RUN mkdir /etc/nginx/cert

RUN apk add --no-cache nginx && \
apk add --no-cache openssl && \
openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/cert/private_key.crt \
    -x509 -days 365 \
    -out /etc/nginx/cert/public_certificate.crt \
    -subj "/C=FR/ST=Normandie/L=Le Havre/O=42/OU=Student/CN=rbardet-.42.fr"

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]