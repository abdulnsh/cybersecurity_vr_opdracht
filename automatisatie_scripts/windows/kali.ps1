# Find active Ethernet adapters
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.InterfaceDescription -notlike "*Wi-Fi*" -and $_.InterfaceDescription -notlike "*Bluetooth*" } | Select-Object -First 1

# Check if we found an adapter
if ($adapter -eq $null) {
    Write-Host "No active Ethernet adapter found. Exiting..."
    exit
}

# Set variables
$VM_NAME = "Kali_Linux_VM_1"
$VDI_PATH = "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation\Kali Linux 2023.4 (64bit).vdi"
$HOST_ADAPTER_NAME = $adapter.Name

# Create the VM
VBoxManage.exe createvm --name $VM_NAME --ostype "Debian_64" --register --basefolder "D:\HOGENT\TI Netwerken\Semester 2\Cybersecurity & Virtualisation"

# Set memory and CPU cores
VBoxManage.exe modifyvm $VM_NAME --memory 4096 --cpus 2

# Add a SATA controller
VBoxManage.exe storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAhci

# Attach the VDI to the VM
VBoxManage.exe storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VDI_PATH

# Configure network settings for Bridged Adapter
VBoxManage.exe modifyvm $VM_NAME --nic1 bridged --bridgeadapter1 $HOST_ADAPTER_NAME

# Start the VM
VBoxManage.exe startvm $VM_NAME
