FROM nginx:debian-last

WORKDIR /app/nginx

COPY ./conf /etc/nginx/conf/nginx.conf

RUN sudo apt update -y && \
sudo apt install nginx

EXPOSE 443

USER rbardet-

CMD [ "nginx" ]