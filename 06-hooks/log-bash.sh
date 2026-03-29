#!/bin/bash
# Registrar todos los comandos bash
# Hook: PostToolUse:Bash

COMMAND="$1"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="$HOME/.claude/bash-commands.log"

# Crear directorio de log si no existe
mkdir -p "$(dirname "$LOGFILE")"

# Registrar el comando
echo "[$TIMESTAMP] $COMMAND" >> "$LOGFILE"

# Opcional: Registrar también en el log del sistema
# logger -t "claude-bash" "$COMMAND"

exit 0
