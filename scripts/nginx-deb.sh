#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get -q update && apt-get -qy install nginx
echo -e "<h1>It Works</h1>" > /var/www/html/index*.html