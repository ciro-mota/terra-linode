#!/bin/bash

if [ -f /etc/debian_version ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -q update && apt-get -qy install ansible
elif [ -f /etc/redhat-release ]; then
  dnf install -y ansible-core firewalld

  firewallrule() {
    systemctl start firewalld && \
    systemctl enable firewalld && \
    firewall-cmd --permanent --zone=public --add-port=80/tcp && \
    firewall-cmd --permanent --zone=public --add-port=443/tcp && \
    firewall-cmd --reload
    }

  firewallrule
else
  echo "Unsuported Distro."
fi

tee -a requirements.yml <<'EOF'
---
roles:
  - name: geerlingguy.nginx
    version: "3.2.0"

collections:
  - name: community.general
    version: ">=10.3.1"
  
  - name: devsec.hardening
    version: ">=10.2.0"
EOF

tee -a playbook.yml <<'EOF'
---
- hosts: localhost
  become: true
  gather_facts: true
  vars:
    ssh_kex:
    - sntrup761x25519-sha512@openssh.com
    - curve25519-sha256@libssh.org
    - diffie-hellman-group-exchange-sha256
    ssh_server_ports: ['22']
    ssh_permit_root_login: "without-password"
    ssh_use_pam: "true"
    sshd_authenticationmethods: "publickey"
    ssh_authorized_keys_file: ".ssh/authorized_keys"
  tasks:
    - name: Install Nginx
      include_role:
        name: geerlingguy.nginx

    - name: SSH Hardening
      include_role:
        name: devsec.hardening.ssh_hardening

    - name: Copy index.html.j2 to Debian systems using template
      template:
        src: /tmp/index.html.j2
        dest: /var/www/html/index.html
      when: ansible_os_family == "Debian"

    - name: Copy index.html.j2 to RedHat systems using template
      template:
        src: /tmp/index.html.j2
        dest: /usr/share/nginx/html/index.html
        owner: nginx
        group: nginx
        mode: '0644'
      when: ansible_os_family == "RedHat"

  handlers:
    - name: start nginx
      service:
        name: nginx
        state: started
EOF

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml