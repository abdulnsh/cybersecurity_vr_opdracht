#!/bin/bash
MACHINENAME=$1

# Download Windows 10 1909 ISO if not already downloaded
if [ ! -f ./Win10_1909.iso ]; then
    echo "Downloading Windows 10 1909 ISO..."
    # Replace the download link with the appropriate link for Windows 10 1909 ISO
    wget https://archive.org/download/win-10-1909-english-x-64
fi

# Create VM
VBoxManage createvm --name $MACHINENAME --ostype "Windows10_64" --register --basefolder $PWD

# Set memory and network
VBoxManage modifyvm $MACHINENAME --ioapic on
VBoxManage modifyvm $MACHINENAME --memory 4096 --vram 128  # Adjust memory as needed
VBoxManage modifyvm $MACHINENAME --nic1 nat

# Create Disk and connect Windows 10 ISO
VBoxManage createhd --filename $PWD/$MACHINENAME/$MACHINENAME_DISK.vdi --size 80000 --format VDI
VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $PWD/$MACHINENAME/$MACHINENAME_DISK.vdi
VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $PWD/Win10_1909.iso

# Start the VM
VBoxHeadless --startvm $MACHINENAME