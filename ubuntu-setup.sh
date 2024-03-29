#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt update && apt install build-essential -y && apt install apache2 -y && apt install virtualenv -y && apt install libapache2-mod-wsgi python-dev -y && apt -y install nano && apt -y install git && apt install -y wget && apt install zlib1g-dev -y
apt install libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.5 libgdm-dev libdb4o-cil-dev libpcap-dev  -y # need this for pip (ssl download)