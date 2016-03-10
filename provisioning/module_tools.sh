#!/usr/bin/env bash

#
# Provisioning for pdb-tools and haddock-tools
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: pdb-tools and haddock-tools"

# Git repositories
echo "[++] Downloading & installing pdb-tools"
if [ -d /opt/software/pdb-tools ]
then
	cd /opt/software/pdb-tools
	git pull origin master
else
	git clone https://github.com/haddocking/pdb-tools /opt/software/pdb-tools > /dev/null
fi
ln -sf /opt/software/pdb-tools/*py /opt/bin

echo "[++] Downloading & installing haddock-tools"
if [ -d /opt/software/haddock-tools ]
then
	cd /opt/software/haddock-tools
	git pull origin master
else
	git clone https://github.com/haddocking/haddock-tools /opt/software/haddock-tools > /dev/null
fi
ln -sf /opt/software/haddock-tools/* /opt/bin
