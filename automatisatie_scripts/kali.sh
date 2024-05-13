#!/bin/bash

# variabelen
VDI="D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\Kali Linux 2023.4 (64bit).vdi"
VM_NAME="Kali"

# vm aanmaken
VBoxManage createvm --name "$VM_NAME" --ostype "Debian_64" --register --basefolder "D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation"

VBoxManage modifyvm "Kali_Linux_VM" --memory 4096 --cpus 2
VBoxManage storagectl "Kali_Linux_VM" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "Kali_Linux_VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VDI"

# bridged adapter
VBoxManage modifyvm "$VM_NAME" --nic1 bridged

# vm opstarten
VBoxManage startvm "Kali_Linux_VM"

