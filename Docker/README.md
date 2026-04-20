# Docker

## Création d'un conteneur

### Utilisation d'une image déjà faite

```bash
docker pull <nom de l'image>
docker run -it <nom de l'image>
```

### Dockerfile.yaml

Permet de créer son image 

**Exemple**
```yaml
FROM debian:9	# Image d'origine => même depuis un docker partagé => FROM <nom partage>/<dossier>

RUN apt-get update -yq \	# Commandes à lancer
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y

ADD . /app/	# Permet de copier ou de télécharger des fichiers dans l'image. Dans notre cas, nous l'utilisons pour ajouter les sources de notre application locale dans le dossier /app/ de l'image.
WORKDIR /app	# Permet de modifier le répertoire courant
RUN npm install	# Permet d'installer le package du projet Node.js

EXPOSE 2368		# permet d'indiquer le port sur lequel votre application écoute. 
VOLUME /app/logs	# permet d'indiquer quel répertoire vous voulez partager avec votre host.

CMD npm run start	# Celle-ci permet à notre conteneur de savoir quelle commande il doit exécuter lors de son démarrage.
```

**Commande à exécuter une fois le fichier créé :**
```bash
docker build -t <nom du conteneur> <chemin vers le dockerfile>
```

### Docker.compose.yaml

Permet de démarrer plusieurs conteneur en un fichier de conf.

**Exemple UrBackup**
```yaml
version: '3'

services:
  urbackup:
    image: uroni/urbackup-server:latest
    container_name: urbackup # À définir
    restart: unless-stopped
    environment:
      - PUID=1000 # Enter the UID of the user who should own the files here
      - PGID=100  # Enter the GID of the user who should own the files here
      - TZ=Europe/Berlin # Enter your timezone
      # Uncomment the next lines if you want to set the ZFS datasets via ENV variables instead of mounting /etc/urbackup/dataset*
      #- ZFS_IMAGE=tank/images
      #- ZFS_FILES=tank/files
    volumes:
      - /path/to/your/database/folder:/var/urbackup
      - /path/to/your/backup/folder:/backups
      # Uncomment the next line if you want to bind-mount the www-folder
      #- /path/to/wwwfolder:/usr/share/urbackup
    network_mode: "host"
    # Uncomment the following two lines if you're using BTRFS support
    #cap_add:
    #  - SYS_ADMIN
    # Uncomment the following two lines if you're using ZFS support
    #devices:
    #  - /dev/zfs:/dev/zfs
    
  nginx:
    image: nginx:latest
    container_name: nginx-reverse-proxy
    restart: unless-stopped
    volumes:
      - /path/to/your/database/folder/nginxdefault.conf:/etc/nginx/conf.d/default.conf # Rapport entre dossier NAS et fichier docker (à créer)
      - /path/to/your/database/folder/certs:/etc/nginx/certs # Rapport entre dossier NAS et dossier docker
    ports:
      - "55416:55416" # Port souhaité pour l'interface web
    depends_on:
      - urbackup # Dépends du conteneur urbackup
    networks:
         - proxy
networks:
  proxy:
    driver: bridge
```

**Commande à exécuter une fois le fichier créé :**
```bash
docker compose up # -d si il doit être lancé en arrière plan
```

## Commande diverses 

```bash
docker exec -it <ID du conteneur> bash # Permet de rentrer dans le conteneur
# Si la commande si dessus ne fonctionne pas, il est possible de remplacer bash par sh

docker run # Initialise le conteneur
docker logs # Permet d'avoir les logs
docker ps # Liste les conteneurs actifs
docker image list # Permet de voir les images

docker commit <ID du conteneur> <nom de l'image>:<tag> # Permet de créer une image sur la base d'un conteneur qui fonctionne

docker system prune # Supprime tout les volumes, conteneurs et images non utilisés
docker rm # Supprime un conteneur
docker rmi # Supprime une image
```

## Mapper un dossier ou un fichier

### Mapper un volume

Si ce n'est pas fait dans le docker compose.
```bash
docker run -it -v (comme volume) <chemin dossier physique>:<chemin du dossier du conteneur> <nom image>
```

## Manager un volume

Il se comporte de la façon suivante :

- volume vide + dossier conteneur plein => fichiers du conteneur vont dans volume
- volume plein + dossier conteneur vide => fichiers du volume vont dans le dossier du conteneur
- volume plein + dossier conteneur plein => fichiers du volume écrase dossier du conteneur

### Manager 

```bash
docker volume create <nom du volume>	# permet de créé le volume
docker volume ls	# permet de lister tous les volumes
docker volume inspect <nom du volume>	# permet d'avoir des informations sur le volume notement là où il est stocker (sous /var/lib/docker)
docker volume rm <nom du volume>	# permet de supprimer un volume
docker volume -o # permet de mettre des options comme un mot de passe
```

### Monter sur le conteneur

```bash
docker run -it -v <nom du volume docker>:<dossier du conteneur à monter> <nom de l'image>	=> commande courte pour monter un volume
docker run -d --name <nom du conteneur> --mount source=<nom du volume>,taget=<chemin dossier> <nom de l'image>
```

## Tagger une image 

```bash
docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
# Si la source est dans le cloud docker, la target aura cette forme :
# docker.io/<nomutilisateur/<dossier si il y en a un>/<nom de l'image>:tag

# Si la source est dans le cloud github, la target aura cette forme :
# ghcr.io/<nomutilisateur/<dossier> si il y en a un /<nom de l'image>:tag
```

## Utilisation d'un clou

### Connexion au cloud

```bash
docker login --username <username> --password <Se créer un token d'authentification pour ne pas utiliser le mot de passe> ghcr.io (si github sinon laisser vide pour docker.io))
```

### Envoi d'une image dans le cloud

Pour pouvoir faire cet envoi il faut plusieurs paramètres : 

- Avoir une image taggée ou nommée dans le cloud approprié.
- Être connecté au cloud.
- Utiliser la commande suivante :

```bash
docker push <docker.io ou ghcr.io>/<nom d'utilisateur>/<nom de dossier si présent>/<nom de l'image>:<tag>
```

## Docker swarm

### Initialisation

Permet l'orchestration de plusieurs conteneurs :
- Managers (mini 1) -> maitres
- Workers (mini 2) -> esclaves

1. Initialiser l'essaim : `docker swarm init --advertise-addr <MANAGER-IP>`
2. Ajouter des workers avec commande indiquée : `docker swarm join-token manager`

Visualiser l'essaim 
```bash
# État de la swarm
docker swarm info

# Voir les nodes de la swarm 
docker node ls
```

### Déployer service 

**Exemple**
```bash
# Exemple avec le service Nginx 
docker service create --name nginx -p 80:80 nginx:latest # --replicat pour l'ajouter à plusieurs node directement

# Cette commande permet de le repliquer sur plusieurs nodes 4 fois supplémentaires
docker service scale nginx=5

# Mise à jours d'un service 
docker service update --image nginx:1.19 nginx

# Liste de tous les services
docker service ls

# Liste des tâches pour un service spécifique
docker service ps nginx

# Publier un service en dehors de l'essaim (mode routing mesh)
docker service create \
  --name <SERVICE-NAME> \
  --publish published=<PUBLISHED-PORT>,target=<CONTAINER-PORT> \
  <IMAGE>
```

### Inéragir avec les noeuds

Les noeuds ont 3 états :

- `active` : Le nœud est disponible pour recevoir de nouvelles tâches.
- `pause` : Le nœud ne recevra pas de nouvelles tâches, mais les tâches existantes continueront de s'exécuter.
- `drain` : Le nœud ne recevra pas de nouvelles tâches, et les tâches existantes seront migrées vers d'autres nœuds.

```bash
# Changer état node
docker node update --availability <ETAT> <NODE-ID>

# Promouvoir ou retrograder un node 
docker node promote <NODE-ID>
docker node demote <NODE-ID>

# Voir les tâche sur les nodes 
docker node ps
```