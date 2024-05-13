#!/bin/bash

# variabelen
ISO_PATH="D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation/SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO"
VM_NAME="Windows10"

# vm aanmaken
VBoxManage createvm --name "$VM_NAME" --ostype "Windows10_64" --register --basefolder "D:/HOGENT/TI Netwerken/Semester 2/Cybersecurity & Virtualisation"
VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2

VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium "$ISO_PATH"

# vm opstarten
VBoxManage startvm "$VM_NAME"
