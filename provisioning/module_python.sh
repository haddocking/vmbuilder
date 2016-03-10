#!/usr/bin/env bash

#
# Provisioning for Python2.6 libraries
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: Libraries for OS default Python"

# Python libs for default python of OS (e.g. for Lubuntu 10.04 it's python2.6)
apt-get -qq install -y --no-install-recommends python-dev python-numpy python-matplotlib python-scipy python-pip > /dev/null
