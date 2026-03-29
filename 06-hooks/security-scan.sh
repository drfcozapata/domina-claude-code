#!/bin/bash
# Escaneo de seguridad al escribir archivo
# Hook: PostToolUse:Write

FILE=$1

if [ -z "$FILE" ]; then
  echo "Usage: $0 <file_path>"
  exit 0
fi

echo "🔒 Ejecutando escaneo de seguridad en: $FILE"

ISSUES_FOUND=0

# Verificar contraseñas hardcodeadas
if grep -qE "(password|passwd|pwd)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  ADVERTENCIA: Posible contraseña hardcodeada detectada en $FILE"
  ISSUES_FOUND=1
fi

# Verificar claves API hardcodeadas
if grep -qE "(api[_-]?key|apikey|access[_-]?token)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  ADVERTENCIA: Posible clave API hardcodeada detectada en $FILE"
  ISSUES_FOUND=1
fi

# Verificar secretos hardcodeados
if grep -qE "(secret|token)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  ADVERTENCIA: Posible secreto hardcodeado detectado en $FILE"
  ISSUES_FOUND=1
fi

# Verificar claves privadas
if grep -q "BEGIN.*PRIVATE KEY" "$FILE"; then
  echo "⚠️  ADVERTENCIA: Clave privada detectada en $FILE"
  ISSUES_FOUND=1
fi

# Verificar claves AWS
if grep -qE "AKIA[0-9A-Z]{16}" "$FILE"; then
  echo "⚠️  ADVERTENCIA: Clave de acceso AWS detectada en $FILE"
  ISSUES_FOUND=1
fi

# Escanear con semgrep si está disponible
if command -v semgrep &> /dev/null; then
  semgrep --config=auto "$FILE" --quiet 2>/dev/null
fi

# Escanear con trufflehog si está disponible
if command -v trufflehog &> /dev/null; then
  trufflehog filesystem "$FILE" --only-verified --quiet 2>/dev/null
fi

if [ $ISSUES_FOUND -eq 0 ]; then
  echo "✅ No se encontraron problemas de seguridad"
fi

# No bloquear la operación, solo advertir
exit 0
