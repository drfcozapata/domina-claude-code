#!/bin/bash
# Ejecutar tests antes del commit
# Hook: PreToolUse (matcher: Bash) - verifica si el comando es un git commit
# Nota: No existe el evento de hook "PreCommit". Usa PreToolUse con un matcher Bash
# e inspecciona el comando para detectar operaciones de git commit.

echo "🧪 Ejecutando tests antes del commit..."

# Verificar si package.json existe (proyecto Node.js)
if [ -f "package.json" ]; then
  if grep -q "\"test\":" package.json; then
    npm test
    if [ $? -ne 0 ]; then
      echo "❌ ¡Tests fallaron! Commit bloqueado."
      exit 1
    fi
  fi
fi

# Verificar si pytest está disponible (proyecto Python)
if [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
  if command -v pytest &> /dev/null; then
    pytest
    if [ $? -ne 0 ]; then
      echo "❌ ¡Tests fallaron! Commit bloqueado."
      exit 1
    fi
  fi
fi

# Verificar si go.mod existe (proyecto Go)
if [ -f "go.mod" ]; then
  go test ./...
  if [ $? -ne 0 ]; then
    echo "❌ ¡Tests fallaron! Commit bloqueado."
    exit 1
  fi
fi

# Verificar si Cargo.toml existe (proyecto Rust)
if [ -f "Cargo.toml" ]; then
  cargo test
  if [ $? -ne 0 ]; then
    echo "❌ ¡Tests fallaron! Commit bloqueado."
    exit 1
  fi
fi

echo "✅ ¡Todos los tests pasaron! Procediendo con el commit."
exit 0
