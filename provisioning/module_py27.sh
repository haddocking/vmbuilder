#!/usr/bin/env bash

#
# Installs Python2.7 in /opt/
# Makes it available and default to the haddocker user
#

## Avoid errors here and there
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764
sed -i -e '/^mesg n/d' /root/.profile

# Dependencies
(apt-get -qq install -y --no-install-recommends libreadline-gplv2-dev libncursesw5-dev libssl-dev \
                                                libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev ) > /dev/null

PYVER="2.7.11"

# Download Python from PSF website
echo "[++] Downloading & installing Python $PYVER"
wget -q -O /opt/Python-${PYVER}.tgz https://www.python.org/ftp/python/${PYVER}/Python-${PYVER}.tgz > /dev/null

if [ ! -e /opt/Python-${PYVER}.tgz ]; then
  echo "Failed to download Python $PYVER from python.org" 1>&2
  exit 1
fi

( cd /opt/ && tar -xzf Python-${PYVER}.tgz && cd Python-${PYVER}/ && ./configure && make && make altinstall ) > /dev/null
rm -rf /opt/Python-${PYVER} /opt/Python-${PYVER}.tgz

# Download and install pip
wget -q --no-check-certificate -O /opt/get-pip.py https://bootstrap.pypa.io/get-pip.py > /dev/null
python2.7 /opt/get-pip.py > /dev/null

# Install Python libraries via pip
pip2.7 -q install numpy matplotlib > /dev/null
