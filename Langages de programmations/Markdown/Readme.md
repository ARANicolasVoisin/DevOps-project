# Markdown

## Table des matières

- [Markdown](#markdown)
  - [Table des matières](#table-des-matières)
  - [Introduction](#introduction)
  - [Commandes de base](#commandes-de-base)
    - [Principales](#principales)
    - [Tableau](#tableau)
    - [Échappement des caractères spéciaux](#échappement-des-caractères-spéciaux)
    - [Note en bas de page](#note-en-bas-de-page)
  - [Arborescence de fichiers / dossiers](#arborescence-de-fichiers--dossiers)

## Introduction 

- Très utile pour la documentation 
- Extension : .md ou .mdx

## Commandes de base

### Principales

```md
# Titre

Texte **gras**, *italique*, `code`, ~barré~

/ Liste à puce 
- Liste item 1
- Liste item 2

/ Liste numéroté 
1. Premier
1. Deuxième
1. Troisième

/ Task list
- [x] Tâche terminée
- [ ] Tâche à faire
- [ ] Autre tâche

[Texte du lien](https://url.com)
[Texte du lien](https://url.com "Titre au survol")

![Texte alternatif](chemin/image.png)
![Alt](image.png "Légende")

> Ceci est une citation.
> > Et même être imbriquée.

Séparateurs :
---
***
___
```

### Tableau

```mk
| Colonne 1 | Colonne 2 | Colonne 3 |
|-----------|:---------:|----------:|
| Gauche    | Centré    | Droite    |
| Données   | Données   | Données   |
```
**Alignement**
- `:---` aligné à gauche (défaut)
- `:...:` centré
- `--:` aligné à droite

### Échappement des caractères spéciaux

Mettre un \ devant pour afficher le caractère 

### Note en bas de page 

```mk
Voici une affirmation importante[^1].
[1]: Source de l'affirmation avec lien.
```

## Arborescence de fichiers / dossiers

Il est possible de créer des arborescences de fichiers / dossier avec le code suivant :
```
.
+-- _config.yml
+-- _drafts
|   +-- begin-with-the-crazy-ideas.textile
|   +-- on-simplicity-in-technology.markdown
+-- _includes
|   +-- footer.html
|   +-- header.html
+-- _layouts
|   +-- default.html
|   +-- post.html
+-- _posts
|   +-- 2007-10-29-why-every-programmer-should-play-nethack.textile
|   +-- 2009-04-26-barcamp-boston-4-roundup.textile
+-- _data
|   +-- members.yml
+-- _site
+-- index.html
```

Pour avoir quelque chose de plus visuel, il est aussi possible d'installer l'extension **file-tree-generator** sur Visual Studio Code sur le [Lien suivant](https://marketplace.visualstudio.com/items?itemName=Shinotatwu-DS.file-tree-generator).