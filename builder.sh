#!/usr/bin/env bash

# Builder script to provision the VM and export as as .ova

if [ $# -ne 2 ]; then
    cat <<_EoS
Builder script to provision the VM and export it as a .ova file for VirtualBox.
The script is quite rude. It will replace any existing box coming from the selected
Vagrantfile, deleting the previous one(s) in the process.

Usage: ${0} <Vagrantfile> <Box Name>

Examples:
  ${0} vagrantfiles/Vagrantfile.molmod molmod
_EoS
exit 1
fi

if [ ! -e $1 ]; then
    echo "Vagrantfile not found: $1"
    exit 1
fi

if [ -e $2 ]; then
    echo ".ova file already exists: $1"
    exit 1
fi

# Clean up previous log files
\rm -f vagrant.up.log vagrant.destroy.log vboxmanage.export.log

echo "> Building..."
echo "> Vagrantfile: $1"
echo "> Box Name: $2"

if [ -e 'Vagrantfile' ]; then
    \rm -f Vagrantfile
fi

ln -s $1 Vagrantfile

# Check if machine was already started. Delete if so.
vm_name=$( egrep 'vb.name' Vagrantfile | cut -d'=' -f 2 | sed -e 's/[" ]//g' )
vm_exists=$( vboxmanage list vms | awk '{ print $1 }' | sed -e 's/[" ]//g' | egrep $vm_name )
if [ ! -z "$vm_exists" ]; then
    echo "  machine already exists. Deleting.."
    vagrant destroy -f >& vagrant.destroy.log
    if [ $? -ne 0 ]; then
        echo "  [ Error ] Something went wrong.. check the 'vagrant.destroy.log' file"
        exit 1
    else
        \rm -f vagrant.destroy.log
    fi
fi

# Run Vagrant
echo "  downloading and provisioning box..."
vagrant up &> vagrant.up.log
if [ $? -ne 0 ]; then
    echo "[ Error ] Something went wrong.. check the 'vagrant.up.log' file"
    exit 1
else
  echo "  box successfully provisioned. Halting machine.."
  \rm -f vagrant.up.log
  vagrant halt >& /dev/null
fi

# Package .ova
echo "  packaging box to ova file: ${2}.ova"
vboxmanage export $vm_name -o ${2}.ova &> vboxmanage.export.log
if [ $? -ne 0 ]; then
    echo "[ Error ] Something went wrong.. check the 'vboxmanage.export.log' file"
    exit 1
else
  echo "  appliance successfully created. Cleaning up.."
  \rm -f vboxmanage.export.log
  vagrant destroy -f >& /dev/null
  \rm -f Vagrantfile
fi

echo "> Done."
