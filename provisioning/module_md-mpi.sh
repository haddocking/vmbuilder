#!/usr/bin/env bash

#
# Provisioning for the Molecular Dynamics module
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: Molecular Dynamics module"

# GROMACS
echo "[++] Downloading & installing GROMACS"
echo "     Go grab a drink (or three)..."
sudo apt-get install openmpi-dev > /dev/null
wget -q -O /opt/software/gromacs-5.1.2.tar.gz ftp://ftp.gromacs.org/pub/gromacs/gromacs-5.1.2.tar.gz > /dev/null

if [ -d /opt/software/gromacs ]
then
	rm -rf /opt/software/gromacs
fi

(cd /opt/software && tar -xzf gromacs-5.1.2.tar.gz && cd gromacs-5.1.2 && mkdir build && cd build && \
    cmake ../ -DGMX_BUILD_OWN_FFTW=OFF -DCMAKE_INSTALL_PREFIX=/opt/software/gromacs -DGMX_SIMD=SSE2 -DGMX_USE_RDTSCP=off && make && \
    make install) > /dev/null

rm -rf /opt/software/gromacs-5.1.2 /opt/software/gromacs-5.1.2.tar.gz

ln -sf /opt/software/gromacs/bin/GMXRC /opt/bin
