#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt -y install mysql-server-5.7 --install-recommends
service mysql start
# remove the fucking password validation plugin
mysql_secure_installation <<EOF
n
secret
secret
y
y
y
y
EOF