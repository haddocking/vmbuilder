## Bonvin Lab VM Builder Environment

This repository contains the Vagrantfiles, provisioners, and assets required to build the several VMs managed by the lab (educational, tutorials, etc).

### What is this repository and why should you learn how to use it?
If you want to have a .ova file to distribute to students, this is where you should start looking. The repository is organized for simplicity:

```
vmbuilder/
    assets/
    provisioning/
    vagrantfiles/
    builder.sh
    README.md
```

* *assets*: contains several scripts accessible to the machines and the provisioners (e.g. bashrc). Use this to store files that you want copied to the machine. If the files are extremely specific to the machine, e.g. some software binary, consider creating an external repository and cloning that repository via a provisioner. See the `molmod` machine Vagrantfile and provisioners for a good example.
* *provisioning*: contains the provisioners themselves. The Vagrantfile should be able to access them directly. Keep them simple and modular, to encourage reutilization.
* *vagrantfiles*: contains the Vagrantfiles. It would be good to follow a naming convention, such as `Vagrantfile.<box>` where `<box>` is either the box name or a shorthand name.
* *builder.sh*: automated builder script. Use it *after* you have tested and debugged your machine to generate a distributable `.ova` Virtualbox appliance.
* *README.md*: this file.

### Software Requirements
* [VirtualBox 5.0+](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Git](https://git-scm.com/)

### How to package my box?
After you have tested and debugged your image, i.e. you've run `vagrant up` and all your provisioners run perfectly, copy-paste your Vagrantfile, provisioners, and assets to the right folders. Then, just call the `builder.sh` accordingly:

```bash
  ./builder vagrantfile/Vagrantfile.dummy dummy # creates dummy.ova
```

That simple. If you want to complicate things, do so on your own fork first. You're welcome to submit pull requests to change the builder script as well, but bear in mind that the script must be able to generate **all** machines, not just yours.

#### Shared Folders
Vagrant automatically sets up the folder containing the VagrantFile as a shared folder and
mounts it under `/vagrant` inside the image. This is extremely handy to develop scripts and
whatnot, so use it and abuse it. If you need more shared folders, read the VagrantFile and
the Documentation; there is also an easy way of setting them up automatically.

#### Vagrant Basic Usage
For a complete list of the available commands and their descriptions, read the [Vagrant Documentation](http://docs.vagrantup.com/v2/).

This VM works just like any other VirtualBox image. Opening the VirtualBox application after
running `vagrant up` will show the newly created machine. Starting with version 5.0, VirtualBox
allows connections to a running (headless) machine, but any version will allow any sort of
control over the machine, e.g. stopping, deleting, exporting.

Importantly, when running `vagrant up` for the first time, what is called the Vagrant box,
the machine image and hard drive, will be downloaded to specific folder. This will be copied
to wherever necessary to create a new machine. So, even if all machines are destroyed, there
will still be a copy of this image lying around.

Nonetheless, if you prefer to use Vagrant to manage the machine:
* `vagrant ssh`: connects to the machine via SSH.
* `vagrant reload (--provision)`: restarts the machine (and re-runs the provisioners).
* `vagrant suspend`: saves the current machine state and stops execution.
* `vagrant resume`: restarts a machine from the last saved state.
* `vagrant halt`: shutdown the machine.
* `vagrant destroy`: shutdown and _delete_ the machine.
* `vagrant box list`: list all the installed boxes (e.g. courseVM).
* `vagrant box remove <box name>`: removes a particular box permanently.
