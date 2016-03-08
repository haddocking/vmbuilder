#!/usr/bin/env bash

#
# Provisioning for the Molecular Dynamics module
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: Molecular Dynamics module (Legacy)"

# GROMACS
echo "[++] Downloading & installing GROMACS"
echo "     Go grab a drink (or three)..."
# sudo apt-get -qq -y install gromacs > /dev/null
wget -q -O /opt/software/gromacs-4.5.4.tar.gz ftp://ftp.gromacs.org/pub/gromacs/gromacs-4.5.4.tar.gz > /dev/null

if [ -d /opt/software/gromacs ]
then
	rm -rf /opt/software/gromacs
fi

(cd /opt/software && tar -xzf gromacs-4.5.4.tar.gz && cd gromacs-4.5.4/ && \
 ./configure --prefix=/opt/software/gromacs && make && make install ) > /dev/null

rm -rf /opt/software/gromacs-4.5.4 /opt/software/gromacs-4.5.4.tar.gz

ln -sf /opt/software/gromacs/bin/GMXRC /opt/bin
