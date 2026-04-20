# Switch

---

## Table des matières

- [Switch](#switch)
  - [Table des matières](#table-des-matières)
  - [Commandes de base](#commandes-de-base)
    - [Passer en mode privilégié](#passer-en-mode-privilégié)
    - [Mode configuration globale](#mode-configuration-globale)
    - [Changer le nom de l'équipement](#changer-le-nom-de-léquipement)
    - [Bannière de connexion](#bannière-de-connexion)
    - [Sauvegarde et effacement](#sauvegarde-et-effacement)
    - [Désactiver le service DHCP local](#désactiver-le-service-dhcp-local)
    - [Date, heure et NTP](#date-heure-et-ntp)
  - [Sécurisation basique](#sécurisation-basique)
    - [Accès console et lignes VTY](#accès-console-et-lignes-vty)
    - [Comptes locaux, Telnet et SSH](#comptes-locaux-telnet-et-ssh)
    - [Affichage de la configuration et des interfaces](#affichage-de-la-configuration-et-des-interfaces)
    - [Sécurité générique](#sécurité-générique)
    - [CDP (Cisco Discovery Protocol)](#cdp-cisco-discovery-protocol)
  - [Configuration niveau 2 et 3](#configuration-niveau-2-et-3)
    - [VLAN et administration du switch](#vlan-et-administration-du-switch)
    - [VTP et DTP](#vtp-et-dtp)
    - [STP et EtherChannel](#stp-et-etherchannel)
    - [Commutation L3 et OSPF](#commutation-l3-et-ospf)
  - [Administration avancée](#administration-avancée)
    - [Sécurité du switch](#sécurité-du-switch)
    - [Debug et journaux](#debug-et-journaux)
    - [Sauvegarder et restaurer la configuration](#sauvegarder-et-restaurer-la-configuration)
    - [Ressources](#ressources)

---

## Commandes de base

### Passer en mode privilégié

```cisco
en
enable
```

### Mode configuration globale

```cisco
conf t
```

### Changer le nom de l'équipement

```cisco
hostname NOM
domain-name EXEMPLE.LOCAL
```

### Bannière de connexion

```cisco
banner motd "message"
banner motd #
```

### Sauvegarde et effacement

```cisco
write
write erase
```

### Désactiver le service DHCP local

```cisco
no service dhcp
```

---

### Date, heure et NTP

```cisco
show clock
show clock detail
clock set HH:MM:SS MON DAY YEAR
ntp server @IP
show ntp associations
show ntp status
```

---

## Sécurisation basique

### Accès console et lignes VTY

```cisco
line console 0
 password MDP
 login
line vty 0 15
 password MDP
 login
```

```cisco
enable password MDP
enable secret MDP
exec-timeout MINUTES
service password-encryption
```

---

### Comptes locaux, Telnet et SSH

```cisco
username NOM password MDP
username NOM secret MDP
```

```cisco
line vty 0 4
 transport input telnet
 login local
```

```cisco
crypto key generate rsa modulus 1024
line vty 0 15
 transport input ssh
 login local
```

---

### Affichage de la configuration et des interfaces

```cisco
show running-config
show ip interface brief
show ip interfaces
```

```cisco
interface Fa0/1
 no shutdown
default interface Fa0/1
```

---

### Sécurité générique

```cisco
security passwords min-length 8
login block-for 120 attempts 3 within 60
no ip http server
show ip port all
```

---

### CDP (Cisco Discovery Protocol)

```cisco
cdp run
no cdp run
```

```cisco
show cdp neighbors
show cdp neighbors detail
show cdp interface
```

---

## Configuration niveau 2 et 3

### VLAN et administration du switch

```cisco
show vlan brief
vlan 10
 name SERVEURS
```

---

### VTP et DTP

```cisco
vtp mode server
vtp domain NOM
show vtp status
```

---

### STP et EtherChannel

```cisco
spanning-tree mode rapid-pvst
```

---

### Commutation L3 et OSPF

```cisco
ip routing
router ospf 1
```

---

## Administration avancée

### Sécurité du switch

```cisco
switchport port-security
```

---

### Debug et journaux

```cisco
debug ip icmp
logging host @IP
```

---

### Sauvegarder et restaurer la configuration

```cisco
copy running-config tftp:
copy running-config usbflash0:
```

---

### Ressources

- Réinitialiser un switch Cisco 2960 : [Ici](https://linux-note.com/cisco-reinitialiser-un-switch-cisco-2960-aux-reglages-dusine-par-defaut/)