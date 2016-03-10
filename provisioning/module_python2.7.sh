#!/usr/bin/env bash

#
# Provisioning for Python2.7.10 libraries required for PowerFit and DisVis modules
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: PowerFit module"

# Install dependencies for PowerFit and DisVis
echo "[++] Downloading & Installing Python 2.7.10"
apt-get install build-essential checkinstall
apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
cd /opt/software
wget -q http://python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar xzf Python-2.7.10.tgz && cd Python-2.7.10 && ./configure && make && make altinstall
rm -rf /opt/software/Python-2.7.10.tgz

echo "[++] Downloading pip for Python2.7.10"
curl -O https://bootstrap.pypa.io/get-pip.py
python2.7 /opt/software/Python-2.7.10/get-pip.py
