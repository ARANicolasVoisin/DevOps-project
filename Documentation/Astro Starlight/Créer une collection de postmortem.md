# Créer une collection de postmortem 

## Table des matières

## Introduction

Les postmortems sont essenciels pour documenter les incidents qui surviennent, ils permettent de faire un suivi sur les causes et les résolutions.

## Confuguration à mettre en place 

1. **Un schéma Zod** pour valider les métadonnées des postmortems (date d'incident, sévérités, ...).
2. **Une collection Astro** dédié, étendue avec le schéma postmortem.
3. **Un template structuré** incluant toutes les sections SRE (chronologie, actions correctives, leçon apprises, pourquoi ?).
4. **Un script de génération intéractif** pour créer rapidement des nouveaux postmortems.

```
src/
├── content/
|   ├── config.ts
|    └── docs/
|       ├── postmortems/
|           └── 2026-06-01-panne.md
|       ├── sre/
|           ├── docs/
|               ├── metriques-slo.md
|               ├── observabilite.md
|               └── runbooks.md
└── scripts/
```

## Créer un schéma Zod

### Comprendre le schéma

Zod est un bibliothèque qui  permet de définir une **structure attendue des donnée** et de **valider automatiquement** que chaque fichier respecte cette structure.
Exemple : Si on défini `severity: z.enum(['critical', 'high', 'medium', 'low'])`, alors :
- `severity: critical` -> accepté
- `severity: high`-> accepté
- `severity: critique`-> erreur
- Absence de `serverity`-> erreur : champ manquant

Pour se faire, il est nécessaire de modifier le fichier `src/content.config.ts`. Il centralise la définition des collections de contenu. 

```js
import { defineCollection } from 'astro:content';
import { docsSchema } from '@astrojs/starlight/schema';
import { blogSchema } from 'starlight-blog/schema';
import { z } from 'astro:content';

// Schema pour les postmortems SRE -> définition du schéma postmortem
const postmortemSchema = z.object({
  title: z.string(),
  description: z.string(),
  incident_date: z.string(),
  severity: z.enum(['critical', 'high', 'medium', 'low']),
  services_affected: z.array(z.string()),
  duration_minutes: z.number(),
  incident_lead: z.string(),
  participants: z.array(z.string()),
  status: z.enum(['draft', 'published', 'archived']).default('draft'),
});

export const collections = {
  docs: defineCollection({
    schema: docsSchema({
      extend: (context) => {
        const base = blogSchema(context);
        // Ajouter les champs postmortem de manière optionnelle -> extension du schéma dox existan avec les champs postemortem en optionnel
        return base.extend({
          incident_date: z.string().optional(),
          severity: z.enum(['critical', 'high', 'medium', 'low']).optional(),
          services_affected: z.array(z.string()).optional(),
          duration_minutes: z.number().optional(),
          incident_lead: z.string().optional(),
          participants: z.array(z.string()).optional(),
          status: z.enum(['draft', 'published', 'archived']).optional(),
        });
      }
    })
  }),
};
```
### Détail des champs 

| Champ | Type | Pourquoi | Exemple |
| :---: | :--: | :------: | :-----: |
| `incident_date` | string (format ISO) | Date de l'incident pour tri chronologique | "2025-05-15" |
| severity | enum (4 valeurs) | Criticité strictement définie (évite les variations) | critical, high, medium, low |
| `services_affected` | array de strings | Liste des services impactés (permet de filtrer) | ["api-client", "frontend"] |
| duration_minutes | number | Durée pour calculer le MTTR (Mean Time To Recovery) | 125 (= 2h05) |
| `incident_lead` | string | Responsable de la gestion de l'incident | "Marie Dubois" |
| participants | array de strings |	Personnes impliquées dans la résolution	| ["Marie", "Thomas", "Sophie"] |
| `status` | enum | Workflow de publication (draft → published → archived) | draft, published, archived |

### Créer le dossier des postmortems

Les fichiers dans le dossier suivant seront reconnus automatiquement comme postmortem par Astro `src/content/docs/postmortems`.

### Valider que le schéma fonctionne

Créer un fichier test `src/content/docs/postmortems/test.md` sous la forme suivante : 
```md
title: "Test postmortem"
description: "Validation du schéma"
incident_date: "2026-06-01"
severity: high
services_affected:
  - test-service
duration_minutes: 30
incident_lead: Test User
participants:
  - Test User
status: draft
---

## Test

Ceci est un test de validation du schéma.
```

Si il n'y a pas d'erreur après la commande `npm run build` c'est que le fichier `config.ts` a bien été configuré.
À la fin de ce test, supprimer le fichier.

## Script de génération

Créer le dossier `scripts` sous votre projet puis coller le script create-postmortem.js.
Rendre le script exécutable `chmod +x scripts/create-postmortem.js` et utilisez la commande suivante pour l'exécuter : `node scripts/create-postmortem.js`.