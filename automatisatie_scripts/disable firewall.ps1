# Run PowerShell as Administrator

# Disable Firewall for all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Check the status of all profiles
Get-NetFirewallProfile | Select-Object Name, Enabled
