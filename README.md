# n8n Workflows

Ce dépôt contient la logique métier (Workflows) de notre instance n8n.

## ⚠️ Fonctionnement Automatique

Ce dépôt est géré directement par l'instance n8n via la fonctionnalité "Source Control".
**Ne modifiez pas les fichiers JSON manuellement** sauf si vous savez exactement ce que vous faites (risque de corruption de l'UI n8n).

## 🔄 Workflow de développement

1.  Effectuez les modifications dans l'interface n8n (Instance de Dev/Local).
2.  Utilisez le bouton **Commit & Push** dans n8n pour sauvegarder ici.
3.  Sur l'instance de Prod, utilisez le bouton **Pull** pour récupérer les changements.

## 🔐 Sécurité

Les identifiants (Credentials) **ne sont pas** stockés ici. Ils sont chiffrés dans la base de données de l'instance n8n.
Lors d'une première installation, vous devrez reconfigurer les connexions (API Keys) manuellement dans l'interface.
