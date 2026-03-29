#!/bin/bash

echo "🏥 Verificación de Salud del Sistema"
echo "==================== "

ENV=${1:-production}

# Verificar API
echo -n "API: "
if curl -sf http://api.$ENV.example.com/health > /dev/null; then
  echo "✅ Saludable"
else
  echo "❌ No saludable"
fi

# Verificar Base de Datos
echo -n "Base de Datos: "
if pg_isready -h db.$ENV.example.com > /dev/null 2>&1; then
  echo "✅ Saludable"
else
  echo "❌ No saludable"
fi

# Verificar Pods
echo -n "Pods de Kubernetes: "
PODS_READY=$(kubectl get pods -n $ENV --no-headers | grep "Running" | wc -l)
PODS_TOTAL=$(kubectl get pods -n $ENV --no-headers | wc -l)
echo "$PODS_READY/$PODS_TOTAL listos"

echo "==================== "
