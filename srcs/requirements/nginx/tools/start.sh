#!/bin/sh
set -e

CERT_DIR="/etc/nginx/cert"

if [ ! -f "$CERT_DIR/ssl_certificate.crt" ] || [ ! -f "$CERT_DIR/ssl_key.crt" ]; then
    echo "🔑 Génération du certificat auto-signé..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$CERT_DIR/ssl_key.crt" \
        -out "$CERT_DIR/ssl_certificate.crt" \
        -subj "/C=FR/ST=Normandie/L=Le Havre/O=42/OU=Student/CN=rbardet.42.fr"
fi

mkdir -p /var/www/html

nginx -g "daemon off;"
