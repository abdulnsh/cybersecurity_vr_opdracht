# Set variables
$VM_NAME = "windows10victim"
$OS_TYPE = "Windows10_64"
$MEMORY_SIZE = 2048
$CPU_COUNT = 2
$VRAM_SIZE = 128
$HDD_FILE = "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\windows10victim.vdi"
$ISO_FILE = "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\Win10_1909_English_x64.iso"

# Create the VM
VBoxManage.exe createvm --name $VM_NAME --ostype $OS_TYPE --register --basefolder "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation"

# Set memory and CPU cores
VBoxManage.exe modifyvm $VM_NAME --memory $MEMORY_SIZE --cpus $CPU_COUNT

# Set video memory and graphics controller
VBoxManage.exe modifyvm $VM_NAME --vram $VRAM_SIZE --graphicscontroller vmsvga

# Create a SATA controller
VBoxManage.exe storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAhci

# Create a 50GB virtual disk and attach it
VBoxManage.exe createmedium disk --filename $HDD_FILE --size 51200 --format VDI
VBoxManage.exe storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $HDD_FILE

# Attach the Windows 10 installation ISO
VBoxManage.exe storageattach $VM_NAME --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium $ISO_FILE

# Configure network settings for Bridged Adapter using the correct adapter name
VBoxManage.exe modifyvm $VM_NAME --nic1 bridged --bridgeadapter1 "Realtek Gaming 2.5GbE Family Controller"

# Start the VM
VBoxManage.exe startvm $VM_NAME
