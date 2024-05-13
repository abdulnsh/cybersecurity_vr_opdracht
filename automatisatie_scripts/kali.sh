#!/bin/bash

# variabelen
VDI="D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\64bit\Kali Linux 2024.1 (64bit).vdi"
VM_NAME="Kali"

# vm aanmaken
VBoxManage createvm --name "$VM_NAME" --ostype "Debian_64" --register --basefolder "D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation"

VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VDI"

# vm opstarten
VBoxManage startvm "$VM_NAME"
