#!/bin/bash

# Maak de VM aan
VBoxManage createvm --name "Kali_Linux_VM" --ostype "Debian_64" --register --basefolder "D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation"

# Stel geheugen en CPU-kernen in
VBoxManage modifyvm "Kali_Linux_VM" --memory 4096 --cpus 2

# Voeg een SATA-controller toe
VBoxManage storagectl "Kali_Linux_VM" --name "SATA Controller" --add sata --controller IntelAhci

VBoxManage storageattach "Kali_Linux_VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\Kali Linux 2023.4 (64bit).vdi"

# Configureer netwerkinstellingen voor NAT en stel statisch IP-adres in
VBoxManage modifyvm "Kali_Linux_VM" --nic1 nat --macaddress1 "080027000001"
VBoxManage guestproperty set "Kali_Linux_VM" "/VirtualBox/GuestInfo/Net/0/V4/IP" "192.168.1.100"
VBoxManage guestproperty set "Kali_Linux_VM" "/VirtualBox/GuestInfo/Net/0/V4/Netmask" "255.255.255.0"
VBoxManage guestproperty set "Kali_Linux_VM" "/VirtualBox/GuestInfo/Net/0/V4/Gateway" "10.0.2.2"

# Start de VM
VBoxManage startvm "Kali_Linux_VM"

