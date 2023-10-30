#!/bin/bash
inst() {
    dnf update -y &&
    dnf install -y nginx
}

firewallrule() {
    firewall-cmd --permanent --zone=public --add-service=http &&
    firewall-cmd --permanent --zone=public --add-port=80/tcp &&
    firewall-cmd --permanent --zone=public --add-port=443/tcp &&
    firewall-cmd --reload
}

mods() {
    groupadd www
    sudo adduser -G nginx -g www -d /usr/share/nginx/html www --system --shell=/bin/false
    echo -e "<h1>It Works</h1>" >/usr/share/nginx/html/index.html
}

servs() {
    systemctl enable --now nginx
    systemctl start nginx
}

inst
firewallrule
mods
servs
