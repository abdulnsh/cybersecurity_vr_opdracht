#!/bin/bash

# Variabelen voor de VM
VM_NAME="Kali_Linux_VM"
ISO_URL="https://www.osboxes.org/kali-linux/#kali-linux-2024-1-vbox"
DISK_SIZE_MB=30000
MEMORY_MB=4096

# Download de ISO
wget -O kali-linux.iso $ISO_URL

# Maak de VM aan
VBoxManage createvm --name $VM_NAME --ostype "Debian_64" --register

# Stel geheugen en CPU-kernen in
VBoxManage modifyvm $VM_NAME --memory $MEMORY_MB --cpus 2

# Voeg een SATA-controller toe
VBoxManage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAhci

# Maak een virtuele harde schijf aan
VBoxManage createmedium disk --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size $DISK_SIZE_MB

# Koppel de ISO aan de VM
VBoxManage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium "kali-linux.iso"

# Start de VM
VBoxManage startvm $VM_NAME

