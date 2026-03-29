#!/bin/bash
# Validar prompts de usuario
# Hook: UserPromptSubmit

# Leer prompt desde stdin
PROMPT=$(cat)

echo "🔍 Validando prompt..."

# Verificar operaciones peligrosas
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "delete database"
  "drop database"
  "format disk"
  "dd if="
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qi "$pattern"; then
    echo "❌ Bloqueado: Operación peligrosa detectada: $pattern"
    exit 1
  fi
done

# Verificar despliegues a producción
if echo "$PROMPT" | grep -qiE "(deploy|push).*production"; then
  if [ ! -f ".deployment-approved" ]; then
    echo "❌ Bloqueado: El despliegue a producción requiere aprobación"
    echo "Crea el archivo .deployment-approved para proceder"
    exit 1
  fi
fi

# Verificar contexto requerido en ciertas operaciones
if echo "$PROMPT" | grep -qi "refactor"; then
  if [ ! -f "tests/" ] && [ ! -f "test/" ]; then
    echo "⚠️  Advertencia: Refactorizar sin tests puede ser riesgoso"
  fi
fi

echo "✅ Validación del prompt pasó"
exit 0
