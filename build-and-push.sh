#!/bin/bash

# Script pour construire et pousser les images Docker vers DockerHub
# Assurez-vous d'être connecté à DockerHub avec `docker login` avant d'exécuter ce script

# Définir le tag de version (utilisez la date actuelle par défaut)
VERSION=$(date +"%Y%m%d%H%M")

# Construire et pousser l'image de la base de données
echo "Construction de l'image PostgreSQL..."
cd docker/database
docker build -t lytwz1/postgres-db:latest -t lytwz1/postgres-db:$VERSION .
docker push lytwz1/postgres-db:latest
docker push lytwz1/postgres-db:$VERSION
cd ../..

# Construire et pousser l'image de l'API
echo "Construction de l'image backend API..."
cd docker/api
docker build -t lytwz1/backend-api:latest -t lytwz1/backend-api:$VERSION .
docker push lytwz1/backend-api:latest
docker push lytwz1/backend-api:$VERSION
cd ../..

# Construire et pousser l'image du proxy
echo "Construction de l'image proxy..."
cd docker/proxy
docker build -t lytwz1/httpd-proxy:latest -t lytwz1/httpd-proxy:$VERSION .
docker push lytwz1/httpd-proxy:latest || echo "ERREUR: Impossible de pousser l'image proxy:latest"
docker push lytwz1/httpd-proxy:$VERSION || echo "ERREUR: Impossible de pousser l'image proxy:$VERSION"
cd ../..

echo "Construction et envoi des images terminés!"
echo "Images poussées avec les tags:"
echo "- lytwz1/postgres-db:latest et lytwz1/postgres-db:$VERSION"
echo "- lytwz1/backend-api:latest et lytwz1/backend-api:$VERSION"
echo "- lytwz1/httpd-proxy:latest et lytwz1/httpd-proxy:$VERSION"

echo -e "\n===== ÉTAPES POUR CONFIGURER GITHUB ACTIONS ====="
echo "1. Assurez-vous que le dossier .github/workflows existe dans votre dépôt"
echo "2. Vérifiez que le fichier continuous-deployment.yml est présent dans ce dossier"
echo "3. Poussez ces fichiers vers GitHub avec les commandes:"
echo "   git add .github/workflows/continuous-deployment.yml"
echo "   git commit -m \"Ajouter workflow de déploiement continu\""
echo "   git push origin main"
echo "4. Vérifiez l'onglet Actions sur GitHub pour voir si le workflow apparaît"
echo "5. Si le workflow est visible mais ne se déclenche pas automatiquement, vous pouvez le déclencher manuellement"
echo "=================================================="
