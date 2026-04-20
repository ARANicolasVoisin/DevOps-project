# Markdown

## Introduction 

- Très utile pour la documentation 
- Extension : .md ou .mdx

## Commandes de base

### Table des matières

- [Markdown](#markdown)
  - [Introduction](#introduction)
  - [Commandes de base](#commandes-de-base)
    - [Table des matières](#table-des-matières)
    - [Principales](#principales)
    - [Tableau](#tableau)
    - [Échappement des caractères spéciaux](#échappement-des-caractères-spéciaux)
    - [Note en bas de page](#note-en-bas-de-page)

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

> Citation importante

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