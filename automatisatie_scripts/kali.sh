#!/bin/bash

# Maak de VM aan
VBoxManage createvm --name "Kali_Linux_VM" --ostype "Debian_64" --register --basefolder "D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation"

# Stel geheugen en CPU-kernen in
VBoxManage modifyvm "Kali_Linux_VM" --memory 4096 --cpus 2

# Voeg een SATA-controller toe
VBoxManage storagectl "Kali_Linux_VM" --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage storageattach "Kali_Linux_VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\Kali Linux 2023.4 (64bit).vdi"

# Start de VM
VBoxManage startvm "Kali_Linux_VM"

