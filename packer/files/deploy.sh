#!/bin/bash

apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
mv /home/ubuntu/puma.service /etc/systemd/system/puma.service
systemctl daemon-reload && systemctl start puma.service && systemctl enable puma.service && systemctl status puma.service
