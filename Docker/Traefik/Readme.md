# Introduction

Traefik est un reverse proxy se basant sur le nom d'hôte pour donner accès aux ressources se trouvant "derrière". Pour ma config je n'ai pas acheté de nom de domaine, les certificats seront autosignés.

# Étapes de création

- Création du certificat

```
mkdir -p certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/nomkey.key -out certs/nomcert.crt \
  -subj "/CN=*.nom.de.domaine"
```

- Création des information

```
sudo apt install apache2-utils # Permet d'utiliser htpasswd
sudo htpasswd -nb admin "Password" | sed -e 's/\$/\$\$/g' # mot de passe en clair dans le prompt
sudo htpasswd -n admin | sed -e 's/\$/\$\$/g' # mot de passe caché
```

- Docker compose -> Le fichier se trouve dans le repo.
  - Fichier tls.yaml -> fichier qui pointe vers les certificats (changement automatique)
  - Fichier docker en lui même

# Documentation 

La majorité de la documentation se trouve sur le site sur le site de [Traefik](https://doc.traefik.io/traefik).
