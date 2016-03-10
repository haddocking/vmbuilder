#!/usr/bin/env bash

#
# Provisioning for the PowerFit and DisVis module
#
export DEBIAN_FRONTEND=noninteractive # StackOverflow 500764

echo "[+] Provisioning: PowerFit and DisVis module"

echo "[++] Downloading PowerFit & DisVis dependencies including fftw for multiple CPU usage "
apt-get install	-y libfftw3-dev cython > /dev/null
apt-get install -y python-dev > /dev/null
pip2.7 -q install --upgrade pip > /dev/null
pip2.7 -q install --upgrade virtualenv > /dev/null
apt-get install -y libatlas-base-dev gfortran > /dev/null
pip2.7 -q install numpy > /dev/null
pip2.7 -q install matplotlib > /dev/null
pip2.7 -q install scipy > /dev/null
pip2.7 -q install pyfftw > /dev/null

# PowerFit
echo "[++] Downloading & installing PowerFit"

git clone https://github.com/haddocking/powerfit.git /opt/software/powerfit
(cd /opt/software/powerfit && python2.7 setup.py install) > /dev/null

#DisVis
echo "[++] Downloading & installing DisVis"

git clone https://github.com/haddocking/disvis.git /opt/software/disvis
(cd /opt/software/disvis && python2.7 setup.py install) > /dev/null

echo "[++] Downloading & installing PowerFit tutorial"
git clone https://github.com/haddocking/powerfit-tutorial.git /opt/powerfit-tutorial
(cd /opt/powerfit-tutorial && g++ contact-chainID.cpp -o contact-chainID) > /dev/null
ln -sf /opt/powerfit-tutorial/contact-chainID /opt/bin/
