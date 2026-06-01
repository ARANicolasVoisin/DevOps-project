#!/usr/bin/env node

import { writeFileSync, existsSync } from 'fs';
import { createInterface } from 'readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(query) {
  return new Promise(resolve => rl.question(query, resolve));
}

function slugify(text) {
  return text.toLowerCase()
    .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

async function main() {
  console.log('\n📝 Création d\'un nouveau postmortem SRE\n');

  const title = await question('Titre de l\'incident : ');
  const description = await question('Description courte : ');
  const incidentDate = await question('Date de l\'incident (YYYY-MM-DD) : ');
  const severity = await question('Sévérité (critical/high/medium/low) : ');
  const services = await question('Services affectés (séparés par des virgules) : ');
  const duration = await question('Durée en minutes : ');
  const lead = await question('Responsable incident : ');
  const participants = await question('Participants (séparés par des virgules) : ');

  const servicesArray = services.split(',').map(s => s.trim());
  const participantsArray = participants.split(',').map(s => s.trim());

  const slug = slugify(title);
  const filename = `src/content/docs/postmortems/${incidentDate}-${slug}.md`;

  if (existsSync(filename)) {
    console.error(`\n❌ Le fichier ${filename} existe déjà !`);
    rl.close();
    process.exit(1);
  }

  const template = `---
title: "${title}"
description: "${description}"
incident_date: "${incidentDate}"
severity: ${severity}
services_affected:
${servicesArray.map(s => `  - ${s}`).join('\n')}
duration_minutes: ${duration}
incident_lead: ${lead}
participants:
${participantsArray.map(p => `  - ${p}`).join('\n')}
status: draft
---

## Résumé

[Décrivez brièvement l'incident en 2-3 phrases : quoi, quand, impact]

## Chronologie

### Détection
- **Date/Heure** : ${incidentDate}
- **Comment** : [Comment l'incident a-t-il été détecté ?]
- **Par qui** : ${lead}

### Investigation
- **HH:MM** - [Action entreprise]
- **HH:MM** - [Découverte importante]
- **HH:MM** - [Autre événement]

### Résolution
- **HH:MM** - [Action de résolution]
- **HH:MM** - [Vérification du retour à la normale]

## Impact

### Services touchés
${servicesArray.map(s => `- **${s}** : [Décrire l'impact]`).join('\n')}

### Métriques
- **Durée** : ${duration} minutes
- **Utilisateurs impactés** : [Nombre ou pourcentage]
- **Requêtes en échec** : [Si applicable]
- **Perte financière estimée** : [Si applicable]

## Cause racine

### Cause immédiate
[Qu'est-ce qui a directement causé l'incident ?]

### Causes contributives
1. [Facteur qui a facilité ou aggravé l'incident]
2. [Autre facteur]

### Pourquoi cela s'est-il produit ?

Utilisez la méthode des "5 Pourquoi" :

1. **Pourquoi** l'incident s'est-il produit ? → [Réponse]
2. **Pourquoi** [réponse précédente] ? → [Réponse]
3. **Pourquoi** [réponse précédente] ? → [Réponse]
4. **Pourquoi** [réponse précédente] ? → [Réponse]
5. **Pourquoi** [réponse précédente] ? → [Cause racine]

## Ce qui a bien fonctionné

- [Point positif #1]
- [Point positif #2]

## Ce qui peut être amélioré

- [Point d'amélioration #1]
- [Point d'amélioration #2]

## Actions correctives

| Action | Responsable | Date limite | Statut | Priorité |
|--------|-------------|-------------|--------|----------|
| [Action #1] | [@personne] | YYYY-MM-DD | ⏳ En attente | Haute |
| [Action #2] | [@personne] | YYYY-MM-DD | ⏳ En attente | Moyenne |
| [Action #3] | [@personne] | YYYY-MM-DD | ⏳ En attente | Basse |

### Statuts possibles
- ⏳ En attente
- 🚧 En cours
- ✅ Terminé
- ❌ Annulé

## Leçons apprises

### Ce que nous avons appris
1. [Leçon #1]
2. [Leçon #2]

### Ce que nous ferons différemment
1. [Changement #1]
2. [Changement #2]

## Références

- [Lien vers le ticket d'incident]
- [Lien vers les métriques]
- [Lien vers les logs]
`;

  writeFileSync(filename, template);

  console.log(`\n✅ Postmortem créé : ${filename}`);
  console.log('\n💡 Prochaines étapes :');
  console.log('   1. Remplissez les sections du postmortem');
  console.log('   2. Changez le statut de "draft" à "published" quand terminé');
  console.log('   3. Lancez "npm run build" pour générer le site\n');

  rl.close();
}

main().catch(error => {
  console.error('Erreur:', error);
  rl.close();
  process.exit(1);
});