<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/domina-claude-code-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/domina-claude-code-logo.svg">
</picture>

# Hooks

Los Hooks son scripts automatizados que se ejecutan en respuesta a eventos específicos durante las sesiones de Claude Code. Permiten automatización, validación, gestión de permisos y flujos de trabajo personalizados.

## Overview

Los Hooks son acciones automatizadas (comandos de shell, webhooks HTTP, prompts LLM o evaluaciones de subagentes) que se ejecutan automáticamente cuando ocurren eventos específicos en Claude Code. Reciben entrada JSON y comunican resultados mediante códigos de salida y salida JSON.

**Características clave:**
- Automatización dirigida por eventos
- Entrada/salida basada en JSON
- Soporte para tipos de hook: command, prompt, HTTP y agent
- Coincidencia de patrones para hooks específicos de herramientas

## Configuration

Los Hooks se configuran en archivos de settings con una estructura específica:

- `~/.claude/settings.json` - Configuración de usuario (todos los proyectos)
- `.claude/settings.json` - Configuración de proyecto (compartible, se hace commit)
- `.claude/settings.local.json` - Configuración local de proyecto (no se hace commit)
- Managed policy - Configuración a nivel de organización
- Plugin `hooks/hooks.json` - Hooks a nivel de plugin
- Skill/Agent frontmatter - Hooks del ciclo de vida de componentes

### Basic Configuration Structure

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

**Campos clave:**

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| `matcher` | Patrón para coincidir con nombres de herramientas (sensible a mayúsculas) | `"Write"`, `"Edit\|Write"`, `"*"` |
| `hooks` | Array de definiciones de hooks | `[{ "type": "command", ... }]` |
| `type` | Tipo de hook: `"command"` (bash), `"prompt"` (LLM), `"http"` (webhook), o `"agent"` (subagent) | `"command"` |
| `command` | Comando de shell a ejecutar | `"$CLAUDE_PROJECT_DIR/.claude/hooks/format.sh"` |
| `timeout` | Timeout opcional en segundos (por defecto 60) | `30` |
| `once` | Si es `true`, ejecuta el hook solo una vez por sesión | `true` |

### Matcher Patterns

| Patrón | Descripción | Ejemplo |
|---------|-------------|---------|
| String exacto | Coincide con herramienta específica | `"Write"` |
| Patrón regex | Coincide con múltiples herramientas | `"Edit\|Write"` |
| Wildcard | Coincide con todas las herramientas | `"*"` o `""` |
| Herramientas MCP | Servidor y patrón de herramienta | `"mcp__memory__.*"` |

## Hook Types

Claude Code soporta cuatro tipos de hooks:

### Command Hooks

El tipo de hook por defecto. Ejecuta un comando de shell y comunica mediante JSON stdin/stdout y códigos de salida.

```json
{
  "type": "command",
  "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate.py\"",
  "timeout": 60
}
```

### HTTP Hooks

> Agregado en v2.1.63.

Endpoints de webhook remotos que reciben la misma entrada JSON que los command hooks. Los HTTP hooks hacen POST de JSON a la URL y reciben una respuesta JSON. Los HTTP hooks se enrutan a través del sandbox cuando el sandboxing está habilitado. La interpolación de variables de entorno en URLs requiere una lista explícita `allowedEnvVars` por seguridad.

```json
{
  "hooks": {
    "PostToolUse": [{
      "type": "http",
      "url": "https://my-webhook.example.com/hook",
      "matcher": "Write"
    }]
  }
}
```

**Propiedades clave:**
- `"type": "http"` -- identifica esto como un hook HTTP
- `"url"` -- la URL del endpoint del webhook
- Se enruta a través del sandbox cuando el sandbox está habilitado
- Requiere lista explícita `allowedEnvVars` para cualquier interpolación de variables de entorno en la URL

### Prompt Hooks

Prompts evaluados por LLM donde el contenido del hook es un prompt que Claude evalúa. Se usa principalmente con eventos `Stop` y `SubagentStop` para verificación inteligente de finalización de tareas.

```json
{
  "type": "prompt",
  "prompt": "Evalúa si Claude completó todas las tareas solicitadas.",
  "timeout": 30
}
```

El LLM evalúa el prompt y devuelve una decisión estructurada (ver [Prompt-Based Hooks](#prompt-based-hooks) para detalles).

### Agent Hooks

Hooks de verificación basados en subagentes que generan un agente dedicado para evaluar condiciones o realizar verificaciones complejas. A diferencia de los prompt hooks (evaluación LLM de un solo turno), los agent hooks pueden usar herramientas y realizar razonamiento de múltiples pasos.

```json
{
  "type": "agent",
  "prompt": "Verifica que los cambios de código sigan nuestras pautas de arquitectura. Revisa los docs de diseño relevantes y compara.",
  "timeout": 120
}
```

**Propiedades clave:**
- `"type": "agent"` -- identifica esto como un hook de agent
- `"prompt"` -- la descripción de tarea para el subagente
- El agent puede usar herramientas (Read, Grep, Bash, etc.) para realizar su evaluación
- Devuelve una decisión estructurada similar a los prompt hooks

## Hook Events

Claude Code soporta **25 eventos de hooks**:

| Evento | Cuándo se Dispara | Entrada Matcher | Puede Bloquear | Uso Común |
|-------|---------------|---------------|-----------|------------|
| **SessionStart** | Inicio/resumen/limpieza/compactación de sesión | startup/resume/clear/compact | No | Configuración de entorno |
| **InstructionsLoaded** | Después de cargar CLAUDE.md o archivo de reglas | (ninguno) | No | Modificar/filtrar instrucciones |
| **UserPromptSubmit** | Usuario envía prompt | (ninguno) | Sí | Validar prompts |
| **PreToolUse** | Antes de ejecución de herramienta | Nombre de herramienta | Sí (allow/deny/ask) | Validar, modificar entradas |
| **PermissionRequest** | Diálogo de permiso mostrado | Nombre de herramienta | Sí | Auto-aprobar/denegar |
| **PostToolUse** | Después de éxito de herramienta | Nombre de herramienta | No | Agregar contexto, feedback |
| **PostToolUseFailure** | Ejecución de herramienta falla | Nombre de herramienta | No | Manejo de errores, logging |
| **Notification** | Notificación enviada | Tipo de notificación | No | Notificaciones personalizadas |
| **SubagentStart** | Subagente generado | Nombre de tipo de agente | No | Configuración de subagente |
| **SubagentStop** | Subagente finaliza | Nombre de tipo de agente | Sí | Validación de subagente |
| **Stop** | Claude finaliza respuesta | (ninguno) | Sí | Verificación de finalización de tarea |
| **StopFailure** | Error de API finaliza turno | (ninguno) | No | Recuperación de errores, logging |
| **TeammateIdle** | Compañero de equipo inactivo | (ninguno) | Sí | Coordinación de compañero de equipo |
| **TaskCompleted** | Tarea marcada como completa | (ninguno) | Sí | Acciones post-tarea |
| **TaskCreated** | Tarea creada vía TaskCreate | (ninguno) | No | Seguimiento de tareas, logging |
| **ConfigChange** | Cambios en archivo de configuración | (ninguno) | Sí (excepto policy) | Reaccionar a actualizaciones de configuración |
| **CwdChanged** | Cambios en directorio de trabajo | (ninguno) | No | Configuración específica de directorio |
| **FileChanged** | Cambios en archivo vigilado | (ninguno) | No | Monitoreo de archivos, rebuild |
| **PreCompact** | Antes de compactación de contexto | manual/auto | No | Acciones pre-compactación |
| **PostCompact** | Después de completar compactación | (ninguno) | No | Acciones post-compactación |
| **WorktreeCreate** | Worktree siendo creado | (ninguno) | Sí (retorno de ruta) | Inicialización de Worktree |
| **WorktreeRemove** | Worktree siendo eliminado | (ninguno) | No | Limpieza de Worktree |
| **Elicitation** | Servidor MCP solicita entrada de usuario | (ninguno) | Sí | Validación de entrada |
| **ElicitationResult** | Usuario responde a elicitation | (ninguno) | Sí | Procesamiento de respuesta |
| **SessionEnd** | Sesión termina | (ninguno) | No | Limpieza, logging final |

### PreToolUse

Se ejecuta después de que Claude crea los parámetros de la herramienta y antes del procesamiento. Úsalo para validar o modificar entradas de herramientas.

**Configuración:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py"
          }
        ]
      }
    ]
  }
}
```

**Matchers comunes:** `Task`, `Bash`, `Glob`, `Grep`, `Read`, `Edit`, `Write`, `WebFetch`, `WebSearch`

**Control de salida:**
- `permissionDecision`: `"allow"`, `"deny"` o `"ask"`
- `permissionDecisionReason`: Explicación para la decisión
- `updatedInput`: Parámetros de entrada de herramienta modificados

### PostToolUse

Se ejecuta inmediatamente después de que la herramienta completa. Úsalo para verificación, logging o proporcionar contexto de vuelta a Claude.

**Configuración:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py"
          }
        ]
      }
    ]
  }
}
```

**Control de salida:**
- La decisión `"block"` prompatea a Claude con feedback
- `additionalContext`: Contexto agregado para Claude

### UserPromptSubmit

Se ejecuta cuando el usuario envía un prompt, antes de que Claude lo procese.

**Configuración:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py"
          }
        ]
      }
    ]
  }
}
```

**Control de salida:**
- `decision`: `"block"` para prevenir procesamiento
- `reason`: Explicación si se bloquea
- `additionalContext`: Contexto agregado al prompt

### Stop y SubagentStop

Se ejecutan cuando Claude finaliza la respuesta (Stop) o un subagente completa (SubagentStop). Soporta evaluación basada en prompts para verificación inteligente de finalización de tareas.

**Campo de entrada adicional:** Tanto los hooks `Stop` como `SubagentStop` reciben un campo `last_assistant_message` en su entrada JSON, que contiene el mensaje final de Claude o del subagente antes de detenerse. Esto es útil para evaluar la finalización de tareas.

**Configuración:**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evalúa si Claude completó todas las tareas solicitadas.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### SubagentStart

Se ejecuta cuando un subagente comienza la ejecución. La entrada matcher es el nombre del tipo de agente, permitiendo que los hooks apunten a tipos específicos de subagentes.

**Configuración:**
```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "code-review",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/subagent-init.sh"
          }
        ]
      }
    ]
  }
}
```

### SessionStart

Se ejecuta cuando la sesión inicia o se reanuda. Puede persistir variables de entorno.

**Matchers:** `startup`, `resume`, `clear`, `compact`

**Característica especial:** Usa `CLAUDE_ENV_FILE` para persistir variables de entorno (también disponible en hooks `CwdChanged` y `FileChanged`):

```bash
#!/bin/bash
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=development' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

### SessionEnd

Se ejecuta cuando la sesión termina para realizar limpieza o logging final. No puede bloquear la terminación.

**Valores del campo reason:**
- `clear` - Usuario limpió la sesión
- `logout` - Usuario cerró sesión
- `prompt_input_exit` - Usuario salió vía entrada de prompt
- `other` - Otra razón

**Configuración:**
```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-cleanup.sh\""
          }
        ]
      }
    ]
  }
}
```

### Evento Notification

Matchers actualizados para eventos de notificación:
- `permission_prompt` - Notificación de solicitud de permiso
- `idle_prompt` - Notificación de estado inactivo
- `auth_success` - Éxito de autenticación
- `elicitation_dialog` - Diálogo mostrado al usuario

## Component-Scoped Hooks

Los Hooks pueden adjuntarse a componentes específicos (skills, agents, commands) en su frontmatter:

**En SKILL.md, agent.md, o command.md:**

```yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/check.sh"
          once: true  # Solo ejecutar una vez por sesión
---
```

**Eventos soportados para hooks de componentes:** `PreToolUse`, `PostToolUse`, `Stop`

Esto permite definir hooks directamente en el componente que los usa, manteniendo el código relacionado junto.

### Hooks en Frontmatter de Subagentes

Cuando un hook `Stop` se define en el frontmatter de un subagente, se convierte automáticamente en un hook `SubagentStop` con scope para ese subagente. Esto asegura que el hook stop solo se dispare cuando ese subagente específico completa, en lugar de cuando la sesión principal se detiene.

```yaml
---
name: code-review-agent
description: Automated code review subagent
hooks:
  Stop:
    - hooks:
        - type: prompt
          prompt: "Verifica que la revisión de código sea exhaustiva y completa."
  # El hook Stop anterior se auto-convierte a SubagentStop para este subagente
---
```

## Evento PermissionRequest

Maneja solicitudes de permiso con formato de salida personalizado:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": {},
      "message": "Mensaje personalizado",
      "interrupt": false
    }
  }
}
```

## Hook Input and Output

### JSON Input (vía stdin)

Todos los hooks reciben entrada JSON vía stdin:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/directory",
  "permission_mode": "default",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.js",
    "content": "..."
  },
  "tool_use_id": "toolu_01ABC123...",
  "agent_id": "agent-abc123",
  "agent_type": "main",
  "worktree": "/path/to/worktree"
}
```

**Campos comunes:**

| Campo | Descripción |
|-------|-------------|
| `session_id` | Identificador único de sesión |
| `transcript_path` | Ruta al archivo de transcripción de conversación |
| `cwd` | Directorio de trabajo actual |
| `hook_event_name` | Nombre del evento que disparó el hook |
| `agent_id` | Identificador del agente ejecutando este hook |
| `agent_type` | Tipo de agente (`"main"`, nombre de tipo de subagente, etc.) |
| `worktree` | Ruta al git worktree, si el agente está ejecutando en uno |

### Exit Codes

| Código de Salida | Significado | Comportamiento |
|-----------|---------|----------|
| **0** | Éxito | Continuar, parsear JSON stdout |
| **2** | Error de bloqueo | Bloquear operación, stderr mostrado como error |
| **Otro** | Error no bloqueante | Continuar, stderr mostrado en modo verbose |

### JSON Output (stdout, exit code 0)

```json
{
  "continue": true,
  "stopReason": "Mensaje opcional si se detiene",
  "suppressOutput": false,
  "systemMessage": "Mensaje de advertencia opcional",
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "El archivo está en directorio permitido",
    "updatedInput": {
      "file_path": "/modified/path.js"
    }
  }
}
```

## Environment Variables

| Variable | Disponibilidad | Descripción |
|----------|-------------|-------------|
| `CLAUDE_PROJECT_DIR` | Todos los hooks | Ruta absoluta al root del proyecto |
| `CLAUDE_ENV_FILE` | SessionStart, CwdChanged, FileChanged | Ruta de archivo para persistir env vars |
| `CLAUDE_CODE_REMOTE` | Todos los hooks | `"true"` si se ejecuta en entornos remotos |
| `${CLAUDE_PLUGIN_ROOT}` | Hooks de plugin | Ruta al directorio del plugin |
| `${CLAUDE_PLUGIN_DATA}` | Hooks de plugin | Ruta al directorio de datos del plugin |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | Hooks SessionEnd | Timeout configurable en milisegundos para hooks SessionEnd (sobrescribe el valor por defecto) |

## Prompt-Based Hooks

Para eventos `Stop` y `SubagentStop`, puedes usar evaluación basada en LLM:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Revisa si todas las tareas están completas. Devuelve tu decisión.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

**LLM Response Schema:**
```json
{
  "decision": "approve",
  "reason": "Todas las tareas completadas exitosamente",
  "continue": false,
  "stopReason": "Tarea completa"
}
```

## Examples

### Ejemplo 1: Validador de Comandos Bash (PreToolUse)

**Archivo:** `.claude/hooks/validate-bash.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"\brm\s+-rf\s+/", "Bloqueando comando peligroso rm -rf /"),
    (r"\bsudo\s+rm", "Bloqueando comando sudo rm"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name != "Bash":
        sys.exit(0)

    command = input_data.get("tool_input", {}).get("command", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, command):
            print(message, file=sys.stderr)
            sys.exit(2)  # Exit 2 = error de bloqueo

    sys.exit(0)

if __name__ == "__main__":
    main()
```

**Configuración:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\""
          }
        ]
      }
    ]
  }
}
```

### Ejemplo 2: Escáner de Seguridad (PostToolUse)

**Archivo:** `.claude/hooks/security-scan.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

SECRET_PATTERNS = [
    (r"password\s*=\s*['\"][^'\"]+['\"]", "Posible contraseña hardcodeada"),
    (r"api[_-]?key\s*=\s*['\"][^'\"]+['\"]", "Posible clave API hardcodeada"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name not in ["Write", "Edit"]:
        sys.exit(0)

    tool_input = input_data.get("tool_input", {})
    content = tool_input.get("content", "") or tool_input.get("new_string", "")
    file_path = tool_input.get("file_path", "")

    warnings = []
    for pattern, message in SECRET_PATTERNS:
        if re.search(pattern, content, re.IGNORECASE):
            warnings.append(message)

    if warnings:
        output = {
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": f"Advertencias de seguridad para {file_path}: " + "; ".join(warnings)
            }
        }
        print(json.dumps(output))

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Ejemplo 3: Auto-Formato de Código (PostToolUse)

**Archivo:** `.claude/hooks/format-code.sh`

```bash
#!/bin/bash

# Leer JSON desde stdin
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))")
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))")

if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

# Formatear basado en extensión de archivo
case "$FILE_PATH" in
    *.js|*.jsx|*.ts|*.tsx|*.json)
        command -v prettier &>/dev/null && prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    *.py)
        command -v black &>/dev/null && black "$FILE_PATH" 2>/dev/null
        ;;
    *.go)
        command -v gofmt &>/dev/null && gofmt -w "$FILE_PATH" 2>/dev/null
        ;;
esac

exit 0
```

### Ejemplo 4: Validador de Prompts (UserPromptSubmit)

**Archivo:** `.claude/hooks/validate-prompt.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"delete\s+(all\s+)?database", "Peligroso: eliminación de base de datos"),
    (r"rm\s+-rf\s+/", "Peligroso: eliminación de root"),
]

def main():
    input_data = json.load(sys.stdin)
    prompt = input_data.get("user_prompt", "") or input_data.get("prompt", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, prompt, re.IGNORECASE):
            output = {
                "decision": "block",
                "reason": f"Bloqueado: {message}"
            }
            print(json.dumps(output))
            sys.exit(0)

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Ejemplo 5: Hook Stop Inteligente (Basado en Prompt)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Revisa si Claude completó todas las tareas solicitadas. Verifica: 1) ¿Se crearon/modificaron todos los archivos? 2) ¿Hubo errores no resueltos? Si está incompleto, explica qué falta.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Ejemplo 6: Rastreador de Uso de Contexto (Pares de Hooks)

Rastrea el consumo de tokens por solicitud usando los hooks `UserPromptSubmit` (pre-mensaje) y `Stop` (post-respuesta) juntos.

**Archivo:** `.claude/hooks/context-tracker.py`

```python
#!/usr/bin/env python3
"""
Context Usage Tracker - Rastrea el consumo de tokens por solicitud.

Usa UserPromptSubmit como hook "pre-mensaje" y Stop como hook "post-respuesta"
para calcular el delta en el uso de tokens para cada solicitud.

Métodos de Conteo de Tokens:
1. Estimación por caracteres (por defecto): ~4 caracteres por token, sin dependencias
2. tiktoken (opcional): Más preciso (~90-95%), requiere: pip install tiktoken
"""
import json
import os
import sys
import tempfile

# Configuración
CONTEXT_LIMIT = 128000  # Ventana de contexto de Claude (ajustar para tu modelo)
USE_TIKTOKEN = False    # Establecer True si tiktoken está instalado para mejor precisión


def get_state_file(session_id: str) -> str:
    """Obtener ruta de archivo temporal para almacenar conteo de tokens pre-mensaje, aislado por sesión."""
    return os.path.join(tempfile.gettempdir(), f"claude-context-{session_id}.json")


def count_tokens(text: str) -> int:
    """
    Contar tokens en texto.

    Usa tiktoken con codificación p50k_base si está disponible (~90-95% precisión),
    de lo contrario usa estimación por caracteres (~80-90% precisión).
    """
    if USE_TIKTOKEN:
        try:
            import tiktoken
            enc = tiktoken.get_encoding("p50k_base")
            return len(enc.encode(text))
        except ImportError:
            pass  # Usar estimación

    # Estimación basada en caracteres: ~4 caracteres por token para inglés
    return len(text) // 4


def read_transcript(transcript_path: str) -> str:
    """Leer y concatenar todo el contenido del archivo de transcripción."""
    if not transcript_path or not os.path.exists(transcript_path):
        return ""

    content = []
    with open(transcript_path, "r") as f:
        for line in f:
            try:
                entry = json.loads(line.strip())
                # Extraer contenido de texto de varios formatos de mensaje
                if "message" in entry:
                    msg = entry["message"]
                    if isinstance(msg.get("content"), str):
                        content.append(msg["content"])
                    elif isinstance(msg.get("content"), list):
                        for block in msg["content"]:
                            if isinstance(block, dict) and block.get("type") == "text":
                                content.append(block.get("text", ""))
            except json.JSONDecodeError:
                continue

    return "\n".join(content)


def handle_user_prompt_submit(data: dict) -> None:
    """Hook pre-mensaje: Guardar conteo actual de tokens antes de la solicitud."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # Guardar en archivo temporal para comparación posterior
    state_file = get_state_file(session_id)
    with open(state_file, "w") as f:
        json.dump({"pre_tokens": current_tokens}, f)


def handle_stop(data: dict) -> None:
    """Hook post-respuesta: Calcular y reportar delta de tokens."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # Cargar conteo pre-mensaje
    state_file = get_state_file(session_id)
    pre_tokens = 0
    if os.path.exists(state_file):
        try:
            with open(state_file, "r") as f:
                state = json.load(f)
                pre_tokens = state.get("pre_tokens", 0)
        except (json.JSONDecodeError, IOError):
            pass

    # Calcular delta
    delta_tokens = current_tokens - pre_tokens
    remaining = CONTEXT_LIMIT - current_tokens
    percentage = (current_tokens / CONTEXT_LIMIT) * 100

    # Reportar uso
    method = "tiktoken" if USE_TIKTOKEN else "estimated"
    print(f"Contexto ({method}): ~{current_tokens:,} tokens ({percentage:.1f}% usado, ~{remaining:,} restante)", file=sys.stderr)
    if delta_tokens > 0:
        print(f"Esta solicitud: ~{delta_tokens:,} tokens", file=sys.stderr)


def main():
    data = json.load(sys.stdin)
    event = data.get("hook_event_name", "")

    if event == "UserPromptSubmit":
        handle_user_prompt_submit(data)
    elif event == "Stop":
        handle_stop(data)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

**Configuración:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ]
  }
}
```

**Cómo funciona:**
1. `UserPromptSubmit` se dispara antes de que tu prompt sea procesado - guarda el conteo actual de tokens... [truncado]
