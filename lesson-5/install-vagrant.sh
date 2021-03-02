#!/bin/bash

# Updating the package list
sudo apt update

# Download and install vagrant
wget -P ~/Downloads https://releases.hashicorp.com/vagrant/2.2.14/vagrant_2.2.14_x86_64.deb
sudo apt install ~/Downloads/vagrant_2.2.14_x86_64.deb

# Remove installation package
rm ~/Downloads/vagrant_2.2.14_x86_64.deb

# Download and up to date centos7 box 
vagrant box add centos/7
vagrant box update --box centos/7

cd ~/workdir/devops-crash/lesson-5

# Initialization, run and provisioning VM
vagrant init centos/7

cp -f ~/workdir/Vagrantfile ~/workdir/devops-crash/lesson-5/Vagrantfile

vagrant up
vagrant provision



