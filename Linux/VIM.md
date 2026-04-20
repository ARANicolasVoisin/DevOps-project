# VIM

- [VIM](#vim)
  - [Changer l’éditeur de texte par défaut](#changer-léditeur-de-texte-par-défaut)
  - [Commande basique](#commande-basique)
    - [Déplacements](#déplacements)
    - [Mouvements](#mouvements)
    - [Effacer/Couper](#effacercouper)
    - [Annuler](#annuler)
    - [Copier/Coller](#copiercoller)
    - [Mode insertion](#mode-insertion)
    - [Remplacer](#remplacer)
    - [Changer la couleur du texte](#changer-la-couleur-du-texte)
  - [Commandes avancées](#commandes-avancées)
    - [Commenter et décommenter plusieurs lignes](#commenter-et-décommenter-plusieurs-lignes)

## Changer l’éditeur de texte par défaut

Par défaut c’est nano qui est le principal. Pour effectuer cette modification, effectuez les manipulations suivantes : 

- `sudo update-alternatives --config editor` → Permet d’afficher ceux installé, celui utilisé sera marqué d’une étoile

- Trouver `vim.basic` ou `vim.tiny` et le rentrer dans la fenêtre demandée.

---

## Commande basique

### Déplacements

- `:set nu`  Affiche le numéro de ligne
- `:set nonu` Enlève les numéros de ligne
- :`10` Déplace le curseur ligne 10
- `/texteàchercher` Permet de se déplacer vers la fin du texte sur le texte que l’on cherche
- `?texteàchercher` Permet de se déplacer vers le début du texte sur le texte que l’on cherche
    - `n` Prochain mot
    - `N` Mot précèdent

### Mouvements

- **`0`** : le curseur revient au début de la ligne
- **`$`** : le curseur va à la fin de la ligne
- **`w`** : le curseur va au début du mot suivant
- **`e`** : le curseur va à la fin du mot courant
- **`b`** : le curseur va au début du mot précedent
- **`gg`** : Aller au début du document
- **`G`** : Aller au début de la dernière ligne du document
- **`G$`** : Aller à la fin de la dernière ligne du document

### Effacer/Couper

- **`x`** : efface le caractère sous le curseur

Avec mouvement :

- **`dw`** : efface le mot sous le curseur
- **`d$`** : efface jusqu’à la fin de la ligne à partir du curseur
- **`de`** : efface jusqu’à la fin du mot à partir du curseur
- **`dd`** : efface la ligne du curseur

Avec quantificateur :

- **`d2w`** : efface les deux mots à partir du curseur
- **`2dd`** : efface les deux lignes à partir du curseur

### Annuler

- **`u`** : annule la dernière commande.
- **`U`** : annule tous les changements sur une ligne
- **`CTRL-R`** : annule l’annulation.

### Copier/Coller

- **`yy`** : copie la ligne
- **`y$`** : copie jusqu’à la fin de ligne
- **`Y`** : copie dans le tampon la ligne du curseur
- **`p`** : colle à l’endroit du curseur
- **`r`** : remplace le caractère sous le curseur
- **`v0$y`** : copie la ligne en mode visuel

### Mode insertion

- **`i`** : insère des caractères après le curseur
- **`A`** : ajoute des caractères à la fin d’une ligne où que soit positionné le curseur
- **`o`** : insère une ligne après le curseur
- **`O`** : insère une ligne avant le curseur
- **`a`** : insère après le curseur

### Remplacer

- **`:s/aa/bb`** : remplace sur une ligne
- **`:s/aa/bb/g`** : remplace toute occurence sur une ligne
- **`:25,30s/aa/bb/g`** : remplace du texte de la ligne 25 à 30
- **`:%s/aa/bb/g`** : remplace toutes les occurrences dans le fichier
- **`:%s/aa/bb/gc`** : remplace toutes les occurrences dans le fichier avec confirmation

### Changer la couleur du texte

```bash
:colorscheme evening

# Autres couleurs 
darkblue
blue
default
delek
desert
elflord
evening
koehler
morning
murphy
pablo
peachpuff
ron
shine
slate
torte
zellner
```

Pour rendre la couleur permanente, il faut modifier le fichier `/etc/vim/vimrc` sur la ligne suivante : `colorscheme “nom couleur”`

---

## Commandes avancées

### Commenter et décommenter plusieurs lignes

- `:.,+23 s/^/#` De la ligne actuelle et les 23 suivantes, remplace le caractère de début de la ligne par #
- `:-23,. s/^/#`  # Commente les 23 lignes antérieurs et la courante
- `:15,30s/^/#`   # Commente les lignes de 15 à 30
- `:15,30s/^#`    # Décommente les lignes 15 à 30

`s` pour « subsitute » s’utilise avec la syntaxe suivante : `s/[pattern]/[string]/[options]`

- `^` : dans pattern étant la regex pour « début de ligne »
- `#` : étant le caractère qui remplace.

Les options possibles sur cette commande se trouvent sur le lien suivant :

[Vim Regular Expressions 101](https://vimregex.com/#substitute)