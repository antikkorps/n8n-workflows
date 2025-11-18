#!/bin/bash

# 1. Définir les chemins
# Chemin vers le dossier où est ton docker-compose.yml
INFRA_DIR="../n8n-infra"
# Chemin vers ton repo git workflows
WORKFLOWS_DIR="$(pwd)"

echo "🚀 Démarrage du backup des workflows..."

# 2. Demander à n8n (dans le docker) d'exporter les JSON vers le volume partagé
# On utilise l'utilisateur 'node' pour éviter les soucis de permissions root
cd $INFRA_DIR
docker-compose exec -u node n8n n8n export:workflow --all --output=/backup/workflows

echo "✅ Export terminé. Vérification git..."

# 3. Versionning Git automatique
cd $WORKFLOWS_DIR

# Vérifier s'il y a des changements
if [[ `git status --porcelain` ]]; then
  git add .
  git commit -m "chore(backup): auto-save workflows $(date +'%Y-%m-%d %H:%M')"
  git push origin main
  echo "🎉 Changements détectés et poussés sur GitHub !"
else
  echo "😴 Aucun changement détecté."
fi
