#!/bin/sh

if [ -f /etc/debian_version ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -q update && apt-get -qy install ansible
elif [ -f /etc/redhat-release ]; then
  dnf update -y && dnf install -y ansible-core

  firewallrule() {
    firewall-cmd --permanent --zone=public --add-port=80/tcp &&
    firewall-cmd --permanent --zone=public --add-port=443/tcp &&
    firewall-cmd --reload
  }
  
  firewallrule
  
  ansible-galaxy collection install community.general
elif [ -f /etc/alpine-release ]; then
 apk update && apk add ansible

else
  echo "Unsuported Distro." 
fi

tee -a requirements.yml <<'EOF'
- src: nginxinc.nginx
EOF

tee -a playbook.yml <<'EOF'
---
- name: "Provision Image"
  hosts: localhost
  become: true
  roles:
    - nginxinc.nginx
EOF

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml

printf "<h1>Linode - It Works</h1>" >/usr/share/nginx/html/index.html
