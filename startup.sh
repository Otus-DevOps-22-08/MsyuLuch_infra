#!/bin/bash

sudo apt-get update
sudo apt-get install -y ruby-full ruby-bundler build-essential

##wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo bash -c "apt-key add -"
##sudo bash -c "echo deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse > /etc/apt/sources.list.d/mongodb-org-4.2.list"

sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

sudo apt-get update
sudo apt-get install -y mongodb-org

sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install

puma -d
