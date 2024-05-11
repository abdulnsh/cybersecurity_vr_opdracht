# Inzicht in de SMBGhost Vulnerability (CVE-2020-0796)

## Inhoudstafel

1. [Inzicht in de SMBGhost Vulnerability (CVE-2020-0796)](#inzicht-in-de-smbghost-vulnerability-cve-2020-0796)
   - [Wat is de kwetsbaarheid?](#wat-is-de-kwetsbaarheid)
   - [Hoe kunnen we onszelf beschermen tegen deze kwetsbaarheid?](#hoe-kunnen-we-onszelf-beschermen-tegen-deze-kwetsbaarheid)
     - [Inkomend en uitgaand SMB-verkeer blokkeren](#inkomend-en-uitgaand-smb-verkeer-blokkeren)
     - [SMBv3-compressie uitschakelen](#smbv3-compressie-uitschakelen)
   - [Conclusie](#conclusie)

## Wat is de kwetsbaarheid?

De SMBGhost vulnerbilaty is een kwetsbaarheid binnen het Microsoft Server Message Block 3.0 protocol.

Dit communicatieprotocol maakt gedeelde toegang mogelijk tot bestanden en gegevens binnen een onderling verbonden computernetwerk.

Deze kwetsbaarheid beïnvloedt de compressiefunctie van SMBv3 (versie 3.1.1) en stelt systemen bloot die **Windows 10 (Versie 1903 en 1909)** en **Windows Server (Versie 1903, 1909)** gebruiken.

Succesvolle exploitatie van de SMBGhost CVE kan leiden tot willekeurige uitvoering op afstand. Door verbinding te maken met een dergelijke kwetsbare Windows-machine met SMBv3 of door een kwetsbaar Windows-systeem een clientverbinding te laten starten met een SMBv3-server, kan een niet-geauthenticeerde aanvaller op afstand willekeurige code uitvoeren met SYSTEM-privileges op een kwetsbaar systeem.

## Hoe kunnen we onszelf beschermen tegen deze kwetsbaarheid?

Naast je systeem altijd up to date houden met de nieuwste Windows versies, zijn er specifieke maatregelen die je kan ondernemen op de kwetsbare versies 1903 en 1909. Deze worden hieronder beschreven:

### Inkomend en uitgaand SMB-verkeer blokkeren

TCP-poort 455 kan verbinding maken met een gecompromitteerde SMB-server. Het blokkeren van deze poort op je firewall beperkt aanvallen van buitenaf.

**Let op: Je kan echter nog steeds kwetsbaar zijn voor aanvallen binnen de omgeving van uw onderneming!**

Daarom kan het implementeren van segmentatie door het blokkeren van 445 poorten op irrelevante bedrijfsmiddelen helpen de laterale bewegingen te stoppen die deze kwetsbaarheden kunnen uitbuiten.

Naast deze workarounds helpen regelmatige audits van uw firewalls, netwerken en eindpunten om potentiële blootstelling aan SMB-exploitanten te identificeren en te voorkomen voordat ze plaatsvinden.

### SMBv3-compressie uitschakelen

Nog een manier om de SMBGhost-kwetsbaarheid te mitigeren, is door compressie uit te schakelen in SMBv3. **Houd er echter rekening mee dat deze oplossing alleen de SMB-server beveiligt en geen bescherming biedt voor eindgebruikers.** Je kunt compressie uitschakelen met het volgende PowerShell-commando:

```
Set-ItemProperty -Path “HKLM:SYSTEMCurrentControlSetServicesLanmanServerParameters” DisableCompression -Type DWORD -Value 1 -Force
```

Om de SMB3 compressie terug aan te zetten moet je volgend commando gebruiken:

```
Set-ItemProperty -Path “HKLM:SYSTEMCurrentControlSetServicesLanmanServerParameters” DisableCompression -Type DWORD -Value 1 -Force
```

## Conclusie

De SMBGhost-kwetsbaarheid (CVE-2020-0796) is een ernstig beveiligingsrisico voor Windows 10 (1903 en 1909) en Windows Server (1903 en 1909). Hoewel het uitschakelen van compressie in SMBv3 en het blokkeren van TCP-poort 445 tijdelijke oplossingen kunnen bieden, is de beste bescherming het regelmatig installeren van beveiligingsupdates van Microsoft.

Wees altijd alert voor nieuwe beveiligingsrisico's en volg beveiligingsadvies van vertrouwde bronnen. Zorg ervoor dat je regelmatig back-ups maakt van kritieke gegevens en zorg voor een robuust beveiligingsbeleid om je netwerk en systemen te beschermen.