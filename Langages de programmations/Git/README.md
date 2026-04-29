# Git

## Introduction

Installation de Git : 

[Git - Install](https://git-scm.com/install/)

Git permet d’échanger entre développeurs et de faire des projets. Il permet de fonctionner avec les site GitHub et GitLab. Il stocke le code, suit ses modification en temps réel et suit ses mises à jour dans le cloud et en local.

---

## Configurer un projet depuis le début

### Configurer git

Dans un premier temps, il est nécessaire de configurer git avant de se lancer dans les configurations. Pour se faire, il faut utiliser les commandes suivantes :

```git
git config # Base de toutes les commandes pour configurer
git config list # Permet de voir toute la configuration

git config --global user.name "<nom>" # Permet de rentrer un prénom => permet de voir un nom sur la modification
git config --global user.email "<mail>" # Comme au dessus ajoute l'adresse mail
gti config --global --list # Permet de voir toute la config global

git config --global alias.i <commande> # Permet de créer un alias pour une commande
```

### Initialiser le projet

Une fois git configuré, il faut initialiser un projet. Pour se faire, il faut se mettre sur le dossier du projet (pour vérifier commande pwd) et utiliser la commande suivante :

```
git init # Créer un dossier caché en .git qui contient les logs et la config
```

### Changer un token de connexion distant

```bash
git remote set-url origin https://username:token@github.com/username/repository.git
```

### État du dépôt git

Ensuite il est possible de voir l’état du dépôt git, il faut utiliser la commande suivante : 

```git
git status
# Permet d'afficher les informations suivantes :
# - Fichiers suivit ou non
# - Modifications prête à être enregistrées
```

### Cloner un dépôt

Par la suite il faut se connecter au dépôt pour pouvoir déposer du code à l’intérieur. 

```python
git clone <URL du dépot auquel on souhaite se connecter>
```

### Ajouter un fichier au projet et sauvegarder

Si le ficher est untracked (non suivit), il faut faire en sorte de l’ajouter pour la prochaine sauvegarde (commit) avec le code suivant : 

```git
git add <nom du fichier> # Ajoute un fichier spécifique au suivit de git
git add . # Ajoute tous les fichiers dans le dossier dans lequel le prompt est
git rm --cached <nom du fichier> # Supprime un fichier ajouté avant commit
git rm --cached -r # Supprime tous les fichiers ajouté avant commit

git commit -m <message pour la sauvegarde> # Permet de lancer la sauvegarde avec commentaire
git push <dossier distant> <nom de la branche> # Permet d'envoyer tous les commits dans le cloud
git pull # Mettre à jour les fichiers locaux avec le cloud
git push -u <branche locale> <branche visée dans le cloud> # Envois les fichiers du commit dans le cloud
# Exemple : git push -u origin main
```

<aside>
💡

Il est nécessaire de ce mettre dans le dossier qui se trouve au même niveau que celui nommé .git

</aside>

### Annuler un ou plusieurs commit

```git
git revert --no-edit HEAD # Annule un commit
git revert --edit HEAD~3 # Mettre un message lors de l'annulation
```

### Tagger une branche

```
git tag -a <tag de la branche> -m "message"
```

### Voir les log

Pour voir les logs des sauvegardes qui ont été effectuée, la commande suivante est indispensable : 

```
git log
git show # Voir historique dossier
git adog # Permet de voir un historique cours du projet
```

### Corrections

Plutôt que de faire une control+Z il est possible de revenir vers le dernier commit si les modifications ne nous plaisent pas :

```git
git restore .
```

Il est possible de modifier le commentaire d’un commit envoyé précédemment : 

```git
git commit --amend -m "message"
```

Rajouter un fichier dans un commit précédent :

```git
git add <nom du fichier>
git commit --amend --no-edit
```

### Mettre une mise à jour en cache

Il est possible de mettre une modification de fichier en cache, elle est supprimé de l’affichage du code mais existe toujours.

```git
git stash # Permet de mettre la modification en cache
git stash list # Liste les modifications en cache
git stash pop # Permet de récupérer les changements en cache
```

## Travailler avec des branches

Il est préférable de ne pas travailler sur la branche principale, celle-ci doit être mise à jour en 

```git
git branch # Voir sur quelle branche je suis
git branch <nom de la branche> # Créer une nouvelle branche
git checkout -b <nom de la branche> # Créer aussi une nouvelle branche

git switch <nom de la branche> # Permet de changer de branche
git push origin <nom de la branche> # Envoi les modifs vers une branche spécifique
git push github # Envois le code vers GitHub
git merge <nom de la branche> # Fusionner la branche dans la commande avec la branche sur laquelle je suis

git branch -d <nom de la branche> # Supprime la branche localement
git push --delete oringin <nom de la branche> # Supprime la branche dans le cloud
```

### Cloner un fichier de Git sur le poste local

Il faut aller dans git sur le dossier que l’on souhaite cloner sur son PC. Puis cliquer sur le bouton Code et copier l’URL. Enfin revenir sur son poste et faire la commande suivante :

```git
git clone <URL>
```

---

## Fichier .gitignore

Permet d’ignorer certain type d’extension dans le dépôt git (comme le fichier .dockerignore) comme des fichiers caché ou encore des miniatures.

Le lien suivant permet d’avoir des templates de ce fichier : 

[gitignore.io](https://www.toptal.com/developers/gitignore/)

Exemples de commandes : 

```git
git help <commande> # Permet d'avoir de l'aide sur une commande
git diff # Permet d'envoyer les fichiers dans le cloud
git checkout <nom de la branche> # Permet de se déplacer sur une branche
```

Lien vers toutes les commandes : 

[Git - Reference](https://git-scm.com/docs)