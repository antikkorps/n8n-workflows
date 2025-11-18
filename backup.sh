#!/bin/bash

# 1. Définitions
INFRA_DIR="../n8n-infra"
WORKFLOWS_DIR="$(pwd)"
TIMESTAMP=$(date +'%Y-%m-%d %H:%M')

echo "🚀 Démarrage du backup..."

# 2. Aller dans le dossier infra pour parler à Docker
cd $INFRA_DIR

# 3. Exporter le JSON dans un dossier temporaire INTERNE au conteneur
# On écrit dans /tmp/ car l'utilisateur node a toujours le droit d'écrire là-bas
docker-compose exec -u node n8n n8n export:workflow --all --output=/tmp/all_workflows.json

# 4. Copier le fichier du conteneur vers ton PC (C'est là que la magie opère)
# On récupère l'ID du conteneur n8n
CONTAINER_ID=$(docker-compose ps -q n8n)
# On copie le fichier
docker cp $CONTAINER_ID:/tmp/all_workflows.json "$WORKFLOWS_DIR/workflows/all_workflows.json"

echo "✅ Export terminé et copié sur l'hôte."

# 5. Git Push
cd $WORKFLOWS_DIR

if [[ `git status --porcelain` ]]; then
  git add .
  git commit -m "chore(backup): auto-save workflows $TIMESTAMP"
  git push origin main
  echo "🎉 Sauvegardé sur GitHub !"
else
  echo "😴 Aucun changement détecté."
fi
