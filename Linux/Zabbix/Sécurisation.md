# Sécurisation

## Recommandation

Toutes les bonnes pratiques pour sécuriser un serveur Zabbix se trouve sur le liens suivant : 

[19 Best practices](https://www.zabbix.com/documentation/current/en/manual/best_practices)

---

## Connexion avec agent

### PSK

Pour se faire il suffit de générer une clé avec la commande suivante : 

```bash
openssl rand -base64 64
openssl rand -hex 64 > nomdufichier.psk
```

Une fois cette clé créée, il est nécessaire de la rentrer, avec le nom de la clé, à la création de l’endpoint et à l’installation de l’agent sur le serveur.