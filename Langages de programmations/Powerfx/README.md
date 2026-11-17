# Power Fx

- [Power Fx](#power-fx)
  - [Introduction](#introduction)
  - [Commande interessantes](#commande-interessantes)
  - [Fonctions](#fonctions)

## Introduction 

Ce langage est principalement utilisé dans l'environement Power Platform (Power App et Power Automate).

## Commande interessantes

```powerfx
// Navigation vers une autre page
Navigate('Page';ScreenTransition.Cover)

// Liste déroulante
["1"; "2"; "3"; "4"; "5"; "6"; "7"; "8"]
```

## Fonctions

```powerfx
// Évaluer une formule 
With{Enregistrement, Formule}

// Aller chercher une information dans table
Lookup(table, formule)

// Vérification, pas de else entre les blocs
If(Condition, ThenResult, DefaultResult)
Switch(Formule, Match1, Result1)

// Remplir table
Patch()
Default(DataSource)

// Blanc
IsBlanck()
// Pas blanc
!IsBlanck()

// Notification
Notify("Texte"; NotificationType.Success)
```