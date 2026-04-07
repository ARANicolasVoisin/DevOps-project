# Introduction

**Bind9** est un DNS gratuit qui vous permet de commencer votre infra sur un service essenciel.

---

# Configuration

## Fichiers de configuration 

- docker-compose.yml -> fichier essentiel pour initialiser le conteneur
- fichiers de zone (inverse et classique) -> permettent de renseigner les différents postes

## Distribution Ubuntu

Si vous être sur une distribution Ubuntu, vous devez décommenter la ligne **DNSStubListener** dans le fichier **/etc/systemd/resolved.conf**. Autrement vous aurez un message d'erreur.