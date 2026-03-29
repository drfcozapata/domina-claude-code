#!/bin/bash
# Enviar notificaciones en eventos
# Hook: PostPush

REPO_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)
COMMIT_MSG=$(git log -1 --pretty=%B 2>/dev/null)
AUTHOR=$(git log -1 --pretty=%an 2>/dev/null)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

echo "📢 Enviando notificación al equipo..."

# Ejemplo de webhook de Slack (reemplazar con tu URL de webhook)
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

if [ -n "$SLACK_WEBHOOK" ]; then
  curl -X POST "$SLACK_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"text\": \"Nuevo push a *$REPO_NAME*\",
      \"attachments\": [{
        \"color\": \"good\",
        \"fields\": [
          {\"title\": \"Branch\", \"value\": \"$BRANCH\", \"short\": true},
          {\"title\": \"Author\", \"value\": \"$AUTHOR\", \"short\": true},
          {\"title\": \"Commit\", \"value\": \"$COMMIT_MSG\"}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Notificación de Slack enviada"
fi

# Ejemplo de webhook de Discord (reemplazar con tu URL de webhook)
DISCORD_WEBHOOK="${DISCORD_WEBHOOK_URL:-}"

if [ -n "$DISCORD_WEBHOOK" ]; then
  curl -X POST "$DISCORD_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"content\": \"**Nuevo push a $REPO_NAME**\",
      \"embeds\": [{
        \"title\": \"$COMMIT_MSG\",
        \"color\": 3066993,
        \"fields\": [
          {\"name\": \"Branch\", \"value\": \"$BRANCH\", \"inline\": true},
          {\"name\": \"Author\", \"value\": \"$AUTHOR\", \"inline\": true}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Notificación de Discord enviada"
fi

# Ejemplo de notificación por email
EMAIL_TO="${TEAM_EMAIL:-}"

if [ -n "$EMAIL_TO" ]; then
  echo "Nuevo push a $REPO_NAME por $AUTHOR" | \
    mail -s "Git Push: $BRANCH" "$EMAIL_TO"

  echo "✅ Notificación por email enviada"
fi

exit 0
