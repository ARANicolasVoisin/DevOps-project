# Installation et première configuration

## Installation sur Debian

### Installation de node.js

```bash
sudo apt install nodejs npm
```
Une fois installer, il est nécessaire d'avoir nodejs en version 22 pour pouvoir faire fonctionner l'application. Pour ce faire, il est nécessaire de visiter ce [lien](https://nodejs.org/fr/download) pour avoir la documentation de la version nécessaire. 

### Installation d'Astro 

```bash
npm create astro@latest -- --template starlight
```

## Démarrer le serveur 

```bash
cd nom-du-projet
npm run dev
```

Une fois cette commander effectuée, il est possible d'accéder au rendu via ce [lien](http://localhost:4321/)

## Configuration de base

### Fichier de configuration 

Pour se faire, il est nécessaire de modifier le fichier nom-du-projet/astro.config.mjs.

```bash
// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
        integrations: [
                starlight({
                        title: 'My Docs', # Nom du projet
                        social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/withastro/starlight' }], # Connexion à différent réseaux
                        sidebar: [
                                {
                                        label: 'Guides', # Création des raccourcis
                                        items: [
                                                // Each item here is one entry in the navigation menu.
                                                { label: 'Example Guide', slug: 'guides/example' },
                                        ],
                                },
                                {
                                        label: 'Reference', # Laisser Astro créer les raccourcis
                                        autogenerate: { directory: 'reference' },
                                },
                        ],
                }),
        ],
});
```
### Ajouter une page 

Ajouter un fichier .md ou .mdx dans /src/content/docs. Par exemple un fichier **src/content/docs/guides/installation.md** sera accessible à l’adresse **/guides/installation/**.
Chaque page commence par un **frontmatter** — un bloc de métadonnées encadré par trois tirets. Ces informations permettent à Starlight de générer le titre et la description de la page.

### Construir et déployer le site

- Créer la version finale après modification de fichiers :
```bash
npm run build
```
- Prévisualiser le site 
```bash
npm run preview
```

### Utiliser les composants Starlight

Il est possible d'ajouter des composant Starlight pour habiller la page et la rendre plus agréable à lire. Pour se faire il faut utiliser l'extension `.mdx`.

La documentation est sur le [lien suivant](https://starlight.astro.build/components/using-components/)

## Déploiement de la documentation 

Il est possible d'afficher la documentation sur un serveur Nginx en copiant le dossier `dist/` vers le dossier `/var/www/nom-de-la-documentation`.
Alternativement, il est aussi possible d'afficher ce serveur sur GitHub Pages avec cette [documentation](https://docs.astro.build/guides/deploy/)

## Lien vers la documentation

[Doc starlight](https://starlight.astro.build/components/using-components/)
[Doc Astro](https://docs.astro.build/en/tutorial/0-introduction/)