#!/bin/bash
set -e

echo "🚀 Iniciando despliegue..."

# Cargar entorno
ENV=${1:-staging}
echo "📦 Entorno objetivo: $ENV"

# Verificaciones pre-despliegue
echo "✓ Ejecutando verificaciones pre-despliegue..."
npm run lint
npm test

# Construir
echo "🔨 Construyendo aplicación..."
npm run build

# Desplegar
echo "🚢 Desplegando a $ENV..."
kubectl apply -f k8s/$ENV/

# Verificación de salud
echo "🏥 Ejecutando verificaciones de salud..."
sleep 10
curl -f http://api.$ENV.example.com/health

echo "✅ ¡Despliegue completado!"
