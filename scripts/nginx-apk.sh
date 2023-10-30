#!/bin/sh

install() {
    apk update
    apk add nginx
}

usrconf() {
    adduser -D -g 'www' www
    mkdir /www
    chown -R www:www /var/lib/nginx/html/
    chown -R www:www /www
}

appconf() {
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
    tee -a /etc/nginx/nginx.conf <<'EOF'
user                            www;
worker_processes                auto; # it will be determinate automatically by the number of core

error_log                       /var/log/nginx/error.log warn;
#pid                             /var/run/nginx/nginx.pid; # it permit you to use /etc/init.d/nginx reload|restart|stop|start

events {
    worker_connections          1024;
}

http {
    include                     /etc/nginx/mime.types;
    default_type                application/octet-stream;
    sendfile                    on;
    access_log                  /var/log/nginx/access.log;
    keepalive_timeout           3000;
    server {
        listen                  80;
        root                    /www;
        index                   index.html index.htm;
        server_name             localhost;
        client_max_body_size    32m;
        error_page              500 502 503 504  /50x.html;
        location = /50x.html {
              root              /var/lib/nginx/html;
        }
    }
}
EOF
    printf "<h1>It Works</h1>" >/www/index.html
}

svcconf() {
    rc-service nginx start
    rc-service nginx reload
}

install
usrconf
appconf
svcconf
