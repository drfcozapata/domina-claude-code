#!/bin/bash
# Auto-formatear código antes de escribir
# Hook: PreToolUse:Write

FILE=$1

if [ -z "$FILE" ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

# Detectar tipo de archivo y formatear en consecuencia
case "$FILE" in
  *.js|*.jsx|*.ts|*.tsx)
    if command -v prettier &> /dev/null; then
      echo "Formateando archivo JavaScript/TypeScript: $FILE"
      prettier --write "$FILE"
    fi
    ;;
  *.py)
    if command -v black &> /dev/null; then
      echo "Formateando archivo Python: $FILE"
      black "$FILE"
    fi
    ;;
  *.go)
    if command -v gofmt &> /dev/null; then
      echo "Formateando archivo Go: $FILE"
      gofmt -w "$FILE"
    fi
    ;;
  *.rs)
    if command -v rustfmt &> /dev/null; then
      echo "Formateando archivo Rust: $FILE"
      rustfmt "$FILE"
    fi
    ;;
  *.java)
    if command -v google-java-format &> /dev/null; then
      echo "Formateando archivo Java: $FILE"
      google-java-format -i "$FILE"
    fi
    ;;
esac

exit 0
