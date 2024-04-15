# script
```
#!/bin/bash
MACHINENAME=$1

#Download Kali Linux ISO
if [ ! -f ./kali-linux.iso ]; then
    wget https://cdimage.kali.org/kali-rolling/amd64/iso/kali-linux-rolling-amd64.iso -O kali-linux.iso
fi

#Create VM
VBoxManage createvm --name $MACHINENAME --ostype "Linux_64" --register --basefolder pwd
#Set memory and network
VBoxManage modifyvm $MACHINENAME --ioapic on
VBoxManage modifyvm $MACHINENAME --memory 2048 --vram 128  # Increased memory for Kali Linux
VBoxManage modifyvm $MACHINENAME --nic1 nat
#Create Disk and connect Kali Linux ISO
VBoxManage createhd --filename pwd/$MACHINENAME/$MACHINENAME_DISK.vdi --size 80000 --format VDI
VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  pwd/$MACHINENAME/$MACHINENAME_DISK.vdi
VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium pwd/kali-linux.iso
VBoxManage modifyvm $MACHINENAME --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
VBoxManage modifyvm $MACHINENAME --vrde on
VBoxManage modifyvm $MACHINENAME --vrdemulticon on --vrdeport 10001

#Start the VM
VBoxHeadless --startvm $MACHINENAME
```