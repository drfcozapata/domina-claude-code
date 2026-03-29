#!/bin/bash
set -e

echo "⏪ Iniciando rollback..."

ENV=${1:-staging}
echo "📦 Entorno objetivo: $ENV"

# Obtener despliegue anterior
PREVIOUS=$(kubectl rollout history deployment/app -n $ENV | tail -2 | head -1 | awk '{print $1}')
echo "🔄 Retrocediendo a revisión: $PREVIOUS"

# Ejecutar rollback
kubectl rollout undo deployment/app -n $ENV

# Esperar rollback
echo "⏳ Esperando a que el rollback se complete..."
kubectl rollout status deployment/app -n $ENV

# Verificación de salud
echo "🏥 Ejecutando verificaciones de salud..."
sleep 5
curl -f http://api.$ENV.example.com/health

echo "✅ ¡Rollback completado!"
