#!/bin/bash

[ -f "/usr/bin/dnf" ] && PKG_BIN=dnf || PKG_BIN=yum
sudo $PKG_BIN -y update
sudo $PKG_BIN -y install git ansible dmidecode cryptsetup borgbackup

sudo mkdir /media/backups
sudo mount /dev/sda1 /media/backups
mkdir ~/.borg
borg mount /media/backups/rhel ~/.borg --last 1

rsync -a ~/.borg/*/home/cjeanner/ ~/
borg umount ~/.borg

pushd ~/work/workstation
ansible-playbook desktop.yaml
