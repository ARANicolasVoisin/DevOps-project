# Créer un blog

## Table des matières 

- [Créer un blog](#créer-un-blog)
  - [Table des matières](#table-des-matières)
  - [Comprendre les plugins Starlight](#comprendre-les-plugins-starlight)
  - [Fonctionnalités du plugin blog](#fonctionnalités-du-plugin-blog)
  - [Installation du plugin](#installation-du-plugin)
    - [Installer](#installer)
    - [Configurer le plugin](#configurer-le-plugin)
    - [Configurer les collection de contenu](#configurer-les-collection-de-contenu)
    - [Créer les dossier des articles](#créer-les-dossier-des-articles)
  - [Créer un article](#créer-un-article)
  - [Configuration des auteurs](#configuration-des-auteurs)
  - [URL de la documentation](#url-de-la-documentation)

## Comprendre les plugins Starlight

Ce sont des extensions qui ajoutes des fonctionnalités au site de documentation sans modifier le thème de base. 
La liste des plugins proposés par Starlight sont au lien [suivant](https://starlight.astro.build/resources/plugins/). IL existe un plugin officiel maintenu par l'équipe et les autres sont fait par des équipes indépendantes.
Pour installer les plugins, il est nécessaire de passer par **npm**.

## Fonctionnalités du plugin blog

- **Pages de liste et pagination** : Création automatique d'une page listant tous vos article avec une pagination.
- **Gestion des auteurs** : Il est possible de définir un ou plusieurs auteurs avec leurs noms, titre, photo et liens (ex : GitHub).
- **Système de Tags** : Organiser ses articles avec des tags, regroupement des articles automatique.
- **Image de couverture** : Amélioration du visuel de l'article avec une photo.

## Installation du plugin

### Installer 

```bash
npm install starlight-blog
```

### Configurer le plugin

La configuration du plugin se fait dans le fichier **astro.config.mjs**.

```js
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightBlog from 'starlight-blog'; // Import de la partie blog

export default defineConfig({
  integrations: [
    starlight({
      title: 'My Docs',
      plugins: [ // Ajout du plugin
        starlightBlog(),
      ],
      sidebar: [
        {
          label: 'Guides',
          items: [
            { label: 'Example Guide', slug: 'guides/example' },
          ],
        },
        {
          label: 'Reference',
          autogenerate: { directory: 'reference' },
        },
      ],
    }),
  ],
});
```

### Configurer les collection de contenu

Il faut ajouter un projet blog en plus de docs. Il est nécessaire de créer le fichier **src/content.config.ts**

```ts
import { defineCollection } from 'astro:content';
import { docsSchema } from '@astrojs/starlight/schema';
import { blogSchema } from 'starlight-blog/schema';

export const collections = {
  docs: defineCollection({
    schema: docsSchema({
      extend: (context) => blogSchema(context)
    })
  }),
};
```

Ce code permet 3 choses : 
1. Importe le schéma de base de Starlight
2. Importe le schéma du blog
3. Étend le schéma docs avec le scéma blog

Les fichiers dans **src/content/docs** peuvent maintenant utiliser les champs spécifiques au blog.

### Créer les dossier des articles

Créer un sous dossier **blog/** dans **src/content/docs/**.

## Créer un article

Créez un fichier dans le dossier **src/content/docs/blog/** sous la forme suivante : 

```md
---
title: Titre de l'article
description: Bienvenue sur mon nouvel article
date: 2026-05-28
tags: [annonce, nouveau, astro]
authors: [Nicolas]
draft: True
---

Bienvenu sur mon nouvel article.
```
L'option **draft: True** permet de ne pas afficher l'article dans le blog. Elle est utile si celui-ci est encore en cours d'écriture.

Un fois l'articlé créé, il faut utiliser la commande suivante pour créer les blog : 

```bash
npm run build
```

## Configuration des auteurs 

Le fichier **astro.config.mjs** permet de rajouter les auteurs/

```mjs
plugins: [
  starlightBlog({
    authors: {
      Nicolas: {
        name: 'Nicolas VOISIN',
        title: 'Futur DevOps',
        picture: '/images/nicolas-voisin.png',
        url: 'https://github.com/ARANicolasVoisin/',
      },
    },
  }),
],
```

## URL de la documentation

- [GitHub](https://github.com/HiDeoo/starlight-blog/tree/main)
- [Demo Blog](https://starlight-blog-docs.vercel.app/getting-started/)