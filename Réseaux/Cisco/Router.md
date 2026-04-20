# Routeur

---

## Table des matières

- [Routeur](#routeur)
  - [Table des matières](#table-des-matières)
  - [Commandes de base](#commandes-de-base)
    - [Passer en mode privilégié](#passer-en-mode-privilégié)
    - [Mode configuration globale](#mode-configuration-globale)
    - [Nom d'hôte et bannière](#nom-dhôte-et-bannière)
    - [Sauvegarde et effacement](#sauvegarde-et-effacement)
    - [Services de base](#services-de-base)
    - [Date, heure et NTP](#date-heure-et-ntp)
  - [Sécurisation de base](#sécurisation-de-base)
    - [Accès console et VTY](#accès-console-et-vty)
    - [Comptes locaux, Telnet et SSH](#comptes-locaux-telnet-et-ssh)
    - [Sécurité générique](#sécurité-générique)
  - [Configuration réseau](#configuration-réseau)
    - [Interfaces IPv4 et IPv6](#interfaces-ipv4-et-ipv6)
    - [CDP / LLDP](#cdp--lldp)
    - [Routage statique IPv4/IPv6](#routage-statique-ipv4ipv6)
    - [Routes flottantes](#routes-flottantes)
    - [Routage inter-VLAN (Router-on-a-Stick)](#routage-inter-vlan-router-on-a-stick)
    - [OSPF (IPv4)](#ospf-ipv4)
  - [DHCP sur routeur](#dhcp-sur-routeur)
    - [DHCPv4 serveur](#dhcpv4-serveur)
    - [DHCPv6](#dhcpv6)
    - [FHRP (HSRP v2 exemple)](#fhrp-hsrp-v2-exemple)
    - [ACL](#acl)
  - [NAT / PAT](#nat--pat)
    - [NAT statique](#nat-statique)
    - [NAT dynamique](#nat-dynamique)
    - [PAT (surcharge)](#pat-surcharge)
  - [IPv6 divers](#ipv6-divers)
  - [Debug et journaux](#debug-et-journaux)
  - [Sauvegarder et restaurer la configuration](#sauvegarder-et-restaurer-la-configuration)
    - [Sur serveur TFTP](#sur-serveur-tftp)
    - [Sur clé USB](#sur-clé-usb)

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

### Nom d'hôte et bannière

```cisco
hostname ROUTER
banner motd "message"
banner motd #
```

### Sauvegarde et effacement

```cisco
write
write erase
```

### Services de base

```cisco
no service dhcp
no ip domain-lookup
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
ntp master 4
```

---

## Sécurisation de base

### Accès console et VTY

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

### Sécurité générique

```cisco
security passwords min-length 8
login block-for 120 attempts 3 within 60
no ip http server
```

---

## Configuration réseau

### Interfaces IPv4 et IPv6

```cisco
interface G0/0
 ip address 192.168.10.254 255.255.255.0
 no shutdown
 ipv6 address 2001:db8:10::1/64
```

---

### CDP / LLDP

```cisco
cdp run
lldp run
```

---

### Routage statique IPv4/IPv6

```cisco
ip route 0.0.0.0 0.0.0.0 192.0.2.2
ipv6 route ::/0 2001:db8::2
```

---

### Routes flottantes

```cisco
ip route 10.10.20.0 255.255.255.0 198.51.100.2 5
```

---

### Routage inter-VLAN (Router-on-a-Stick)

```cisco
interface G0/0.30
 encapsulation dot1Q 30
```

---

### OSPF (IPv4)

```cisco
router ospf 1
 router-id 1.1.1.1
```

---

## DHCP sur routeur

### DHCPv4 serveur

```cisco
ip dhcp pool VLAN30
```

---

### DHCPv6

```cisco
ipv6 dhcp pool V6POOL
```

---

### FHRP (HSRP v2 exemple)

```cisco
standby 10 ip 192.168.30.254
```

---

### ACL

```cisco
ip access-list extended WEB_ONLY
```

---

## NAT / PAT

### NAT statique

```cisco
ip nat inside source static
```

---

### NAT dynamique

```cisco
ip nat pool POOL1
```

---

### PAT (surcharge)

```cisco
overload
```

---

## IPv6 divers

```cisco
ipv6 unicast-routing
```

---

## Debug et journaux

```cisco
debug ip icmp
```

---

## Sauvegarder et restaurer la configuration

### Sur serveur TFTP

```cisco
copy running-config tftp:
```

---

### Sur clé USB

```cisco
copy running-config usbflash0:
```
