#!/usr/bin/env bash

#
# Installs packages for Python 2.6 (default system)
#

## Avoid errors here and there
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764
sed -i -e '/^mesg n/d' /root/.profile

# Python libs
apt-get -qq install -y --no-install-recommends python-numpy python-matplotlib \
                                               python-dev > /dev/null
