#!/bin/bash

apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    ntp \
    ntpdate
service ntp stop
ntpdate -s mickey.lss.emc.com
service ntp start
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt update -y
apt install -y docker-ce
curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose
mkdir /var/lib/paclabs_ && cp /tmp/docker-compose.yml /var/lib/paclabs_
CONCOURSE_EXTERNAL_URL=http://10.4.44.20:8080 docker-compose -f /var/lib/paclabs_/docker-compose.yml up -d
