<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Advanced Features

Guía completa de las capacidades avanzadas de Claude Code, incluyendo Planning Mode, Extended Thinking, Auto Mode, Background Tasks, Permission Modes, Print Mode (no interactivo), Session Management, Interactive Features, Channels, Voice Dictation, Remote Control, Web Sessions, Desktop App, Task List, Prompt Suggestions, Git Worktrees, Sandboxing, Managed Settings y configuración.

## Table of Contents

1. [Overview](#overview)
2. [Planning Mode](#planning-mode)
3. [Extended Thinking](#extended-thinking)
4. [Auto Mode](#auto-mode)
5. [Background Tasks](#background-tasks)
6. [Scheduled Tasks](#scheduled-tasks)
7. [Permission Modes](#permission-modes)
8. [Headless Mode](#headless-mode)
9. [Session Management](#session-management)
10. [Interactive Features](#interactive-features)
11. [Voice Dictation](#voice-dictation)
12. [Channels](#channels)
13. [Chrome Integration](#chrome-integration)
14. [Remote Control](#remote-control)
15. [Web Sessions](#web-sessions)
16. [Desktop App](#desktop-app)
17. [Task List](#task-list)
18. [Prompt Suggestions](#prompt-suggestions)
19. [Git Worktrees](#git-worktrees)
20. [Sandboxing](#sandboxing)
21. [Managed Settings (Enterprise)](#managed-settings-enterprise)
22. [Configuration and Settings](#configuration-and-settings)
23. [Best Practices](#best-practices)
24. [Related Concepts](#related-concepts)

---

## Overview

Las características avanzadas en Claude Code extienden las capacidades principales con planificación, razonamiento, automatización y mecanismos de control. Estas características permiten flujos de trabajo sofisticados para tareas de desarrollo complejas, revisión de código, automatización y gestión de múltiples sesiones.

**Las características avanzadas clave incluyen:**
- **Planning Mode**: Crear planes de implementación detallados antes de codificar
- **Extended Thinking**: Razonamiento profundo para problemas complejos
- **Auto Mode**: Un clasificador de seguridad en segundo plano revisa cada acción antes de su ejecución (Research Preview)
- **Background Tasks**: Ejecutar operaciones largas sin bloquear la conversación
- **Permission Modes**: Controlar lo que Claude puede hacer (`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`)
- **Print Mode**: Ejecutar Claude Code de forma no interactiva para automatización y CI/CD (`claude -p`)
- **Session Management**: Gestionar múltiples sesiones de trabajo
- **Interactive Features**: Atajos de teclado, entrada multilínea e historial de comandos
- **Voice Dictation**: Entrada de voz push-to-talk con soporte STT para 20 idiomas
- **Channels**: Los servidores MCP envían mensajes a sesiones en ejecución (Research Preview)
- **Remote Control**: Controlar Claude Code desde Claude.ai o la aplicación Claude
- **Web Sessions**: Ejecutar Claude Code en el navegador en claude.ai/code
- **Desktop App**: Aplicación independiente para revisión visual de diffs y múltiples sesiones
- **Task List**: Seguimiento persistente de tareas a través de compactaciones de contexto
- **Prompt Suggestions**: Sugerencias inteligentes de comandos basadas en el contexto
- **Git Worktrees**: Ramas worktree aisladas para trabajo paralelo
- **Sandboxing**: Aislamiento de sistema de archivos y red a nivel de SO
- **Managed Settings**: Implementación empresarial mediante plist, Registry o archivos gestionados
- **Configuration**: Personalizar comportamiento con archivos de configuración JSON

---

## Planning Mode

Planning Mode permite que Claude piense a través de tareas complejas antes de implementarlas, creando un plan detallado que puedes revisar y aprobar.

### What is Planning Mode?

Planning Mode es un enfoque de dos fases:
1. **Fase de Planificación**: Claude analiza la tarea y crea un plan de implementación detallado
2. **Fase de Implementación**: Después de la aprobación, Claude ejecuta el plan

### When to Use Planning Mode

✅ Usa Planning Mode para:
- Refactorización compleja de múltiples archivos
- Implementaciones de nuevas funcionalidades
- Cambios arquitectónicos
- Migraciones de bases de datos
- Rediseños importantes de API

❌ No uses Planning Mode para:
- Correcciones simples de bugs
- Cambios de formato
- Ediciones de un solo archivo
- Consultas rápidas

### Activating Planning Mode

**Comando slash**:
```bash
/plan Implement user authentication system
```

**Flag CLI**:
```bash
claude --permission-mode plan
```

**Establecer como predeterminado**:
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

**Atajo de teclado**:
- `Shift + Tab` - Alternar Permission Modes (incluyendo plan)
- `Alt + M` - Alternar Permission Modes (Windows/Linux)

### Benefits of Planning Mode

- **Enfoque de implementación estructurado**: Desglose detallado de los pasos de implementación
- **Revisión y aprobación**: Aprobar o ajustar el plan antes de la ejecución
- **Identificación de riesgos**: Identificar problemas potenciales antes de la implementación
- **Fases claras**: Fases de implementación organizadas y hitos

### Example: Feature Implementation

```
User: /plan Add a real-time notification system

Claude: I'll create a plan for implementing real-time notifications.

## Implementation Plan

### Phase 1: Infrastructure Setup
1. Install WebSocket libraries (socket.io)
2. Set up WebSocket server
3. Configure connection management

### Phase 2: Backend Implementation
4. Create notification service
5. Implement notification queue
6. Add database schema for notifications
7. Create API endpoints

### Phase 3: Frontend Integration
8. Set up WebSocket client
9. Create notification UI components
10. Implement notification state management
11. Add notification permissions

### Phase 4: Testing & Deployment
12. Write unit tests
13. Write integration tests
14. Update documentation
15. Deploy to staging

Estimated time: 3-4 hours
Files to modify: 12
New files to create: 8

Ready to proceed? (yes/no/modify plan)

User: yes

Claude: [Begins implementation following the plan]
```

### Plan Modifications

```
User: Modify the plan - skip the queue for now, we'll add it later

Claude: Updated plan:
[Shows modified plan with queue removed]

User: Looks good, proceed

Claude: [Implements modified plan]
```

### Planning Mode Configuration

Planning Mode se activa mediante el flag CLI o el comando slash:

```bash
# Activar Planning Mode vía CLI
claude --permission-mode plan

# O usa el comando slash /plan dentro del REPL
/plan Implement user authentication system
```

**Alias de modelo para planificación**: Usa `opusplan` como alias de modelo para usar Opus para planificación y Sonnet para ejecución:

```bash
claude --model opusplan "design and implement the new API"
```

**Editar plan externamente**: Presiona `Ctrl+G` para abrir el plan actual en tu editor externo para modificaciones detalladas.

---

## Extended Thinking

Extended Thinking permite que Claude dedique más tiempo a razonar sobre problemas complejos antes de proporcionar una solución.

### What is Extended Thinking?

Extended Thinking es un proceso de razonamiento deliberado y paso a paso donde Claude:
- Descompone problemas complejos
- Considera múltiples enfoques
- Evalúa compensaciones (trade-offs)
- Razona a través de casos extremos

### Activating Extended Thinking

**Atajo de teclado**:
- `Option + T` (macOS) / `Alt + T` (Windows/Linux) - Alternar Extended Thinking

**Activación automática**:
- Habilitado por defecto para todos los modelos (Opus 4.6, Sonnet 4.6, Haiku 4.5)
- Opus 4.6: Razonamiento adaptativo con niveles de esfuerzo: `low` (○), `medium` (◐), `high` (●), `max` (solo Opus 4.6)
- Otros modelos: Presupuesto fijo de hasta 31,999 tokens

**Métodos de configuración**:
- Alternar: `Alt+T` / `Option+T`, o vía `/config`
- Ver razonamiento: `Ctrl+O` (modo verbose)
- Establecer esfuerzo: Comando `/effort` o flag `--effort`

**Presupuesto personalizado**:
```bash
export MAX_THINKING_TOKENS=1024
```

**Nivel de esfuerzo** (solo Opus 4.6):
```bash
export CLAUDE_CODE_EFFORT_LEVEL=high   # low (○), medium (◐), high (●), o max (solo Opus 4.6)
```

**Flag CLI**:
```bash
claude --effort high "complex architectural review"
```

**Comando slash**:
```
/effort high
```

> **Nota:** La palabra clave "ultrathink" en los prompts activa el modo de razonamiento profundo. Los niveles de esfuerzo `low`, `medium`, `high` y `max` (solo Opus 4.6) controlan cuánto razonamiento realiza Claude.

### Benefits of Extended Thinking

- **Razonamiento profundo**: Dedicar más tiempo a pensar sobre problemas complejos
- **Mejores decisiones arquitectónicas**: Tomar decisiones informadas con evaluación comprehensiva
- **Consideración de casos extremos**: Pensar a través de problemas y escenarios potenciales
- **Análisis exhaustivo**: Enfoque estructurado para resolución de problemas complejos

### Example: Architectural Decision

```
User: /think Should we use microservices or a monolith for our e-commerce platform?

Claude: Let me think through this architectural decision carefully...

<extended_thinking>
## Context Analysis
- Team size: 5 developers
- Expected traffic: 10k daily users initially
- Need to scale to 100k+ users
- Limited DevOps resources
- 6-month timeline to MVP

## Approach 1: Microservices
Pros:
+ Independent scaling
+ Technology flexibility
+ Team independence
+ Fault isolation

Cons:
- Operational complexity
- Network overhead
- Distributed tracing needed
- Requires DevOps expertise
- Slower initial development

## Approach 2: Monolith
Pros:
+ Simpler deployment
+ Faster initial development
+ Easier debugging
+ Lower operational overhead
+ Single codebase

Cons:
- Scaling challenges later
- All-or-nothing deployments
- Technology lock-in
- Potential for tight coupling

## Decision Factors
1. Team size (5 devs) → Favors monolith
2. DevOps resources (limited) → Favors monolith
3. Timeline (6 months) → Favors monolith
4. Future scale (100k users) → Achievable with monolith + caching
5. Complexity budget → Limited

## Recommendation
Start with a **modular monolith**:
- Single deployment unit
- Clear module boundaries
- Clean interfaces between modules
- Prepare for future extraction to microservices if needed

This gives you:
✓ Fast initial development
✓ Low operational complexity
✓ Option to extract services later
✓ Clear architecture

Migration path: When you reach 50k+ users or specific modules need independent scaling, extract those modules into microservices.
</extended_thinking>

**Recommendation**: Implement a modular monolith with clean module boundaries.

This approach balances your current constraints (team size, timeline, DevOps resources) with future scalability needs. You can migrate specific modules to microservices later when there's a clear business need.
```

### Extended Thinking Configuration

Extended Thinking se controla mediante variables de entorno, atajos de teclado y flags CLI:

```bash
# Establecer presupuesto de tokens de pensamiento
export MAX_THINKING_TOKENS=16000

# Establecer nivel de esfuerzo (solo Opus 4.6): low (○), medium (◐), high (●), o max (solo Opus 4.6)
export CLAUDE_CODE_EFFORT_LEVEL=high
```

Alterna durante una sesión con `Alt+T` / `Option+T`, establece el esfuerzo con `/effort`, o configura vía `/config`.

---

## Auto Mode

Auto Mode es un Permission Mode de Research Preview (marzo 2026) que usa un clasificador de seguridad en segundo plano para revisar cada acción antes de su ejecución. Permite que Claude trabaje de forma autónoma mientras bloquea operaciones peligrosas.

### Requirements

- **Plan**: Plan Team (Enterprise y API en despliegue)
- **Model**: Claude Sonnet 4.6 o Opus 4.6
- **Classifier**: Se ejecuta en Claude Sonnet 4.6 (agrega costo adicional de tokens)

### Enabling Auto Mode

```bash
# Desbloquear Auto Mode con flag CLI
claude --enable-auto-mode

# Luego cicla a él con Shift+Tab en el REPL
```

O establécelo como el Permission Mode predeterminado:

```bash
claude --permission-mode auto
```

Estableciendo vía config:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### How the Classifier Works

El clasificador en segundo plano evalúa cada acción usando el siguiente orden de decisión:

1. **Reglas Allow/deny** -- Las reglas de permisos explícitas se verifican primero
2. **Edits auto-aprobados de solo lectura** -- Las lecturas y ediciones de archivos pasan automáticamente
3. **Clasificador** -- El clasificador en segundo plano revisa la acción
4. **Fallback** -- Vuelve a solicitar al usuario después de 3 bloqueos consecutivos o 20 totales

### Default Blocked Actions

Auto Mode bloquea lo siguiente por defecto:

| Blocked Action | Example |
|----------------|---------|
| Pipe-to-shell installs | `curl \| bash` |
| Enviar datos sensibles externamente | API keys, credenciales sobre red |
| Production deploys | Comandos de deploy apuntando a producción |
| Eliminación masiva | `rm -rf` en directorios grandes |
| Cambios IAM | Modificaciones de permisos y roles |
| Force push a main | `git push --force origin main` |

### Default Allowed Actions

| Allowed Action | Example |
|----------------|---------|
| Operaciones de archivos locales | Leer, escribir, editar archivos del proyecto |
| Instalaciones de dependencias declaradas | `npm install`, `pip install` desde manifiesto |
| HTTP de solo lectura | `curl` para obtener documentación |
| Push a rama actual | `git push origin feature-branch` |

### Configuring Auto Mode

**Imprimir reglas predeterminadas como JSON**:
```bash
claude auto-mode defaults
```

**Configurar infraestructura de confianza** vía el managed setting `autoMode.environment` para despliegues empresariales. Esto permite a los administradores definir entornos CI/CD de confianza, objetivos de despliegue y patrones de infraestructura.

### Fallback Behavior

Cuando el clasificador es incierto, Auto Mode vuelve a solicitar al usuario:
- Después de **3** bloqueos **consecutivos** del clasificador
- Después de **20** bloqueos **totales** del clasificador en una sesión

Esto asegura que el usuario siempre retiene el control cuando el clasificador no puede aprobar una acción con confianza.

---

## Background Tasks

Background Tasks permite que operaciones de larga duración se ejecuten sin bloquear tu conversación.

### What Are Background Tasks?

Background Tasks se ejecutan de forma asíncrona mientras continúas trabajando:
- Suites de tests largas
- Procesos de build
- Migraciones de bases de datos
- Scripts de despliegue
- Herramientas de análisis

**Uso Básico:**
```bash
User: Run tests in background

Claude: Started task bg-1234

/task list           # Mostrar todas las tareas
/task status bg-1234 # Verificar progreso
/task show bg-1234   # Ver output
/task cancel bg-1234 # Cancelar tarea
```

### Starting Background Tasks

```
User: Run the full test suite in the background

Claude: Starting tests in background (task-id: bg-1234)
You can continue working while tests run.

[You can continue the conversation]

User: Meanwhile, let's refactor the auth module

Claude: [Works on auth module while tests run in background]

[Later, when tests complete]

Claude: 📢 Background task bg-1234 completed:
✅ 245 tests passed
❌ 3 tests failed
View results: /task show bg-1234
```

### Managing Background Tasks

**Listar tareas activas**:
```
User: /task list

Active background tasks:
1. [bg-1234] Running tests (50% complete, 2min remaining)
2. [bg-1235] Building Docker image (25% complete, 8min remaining)
3. [bg-1236] Deploying to staging (90% complete, 30sec remaining)
```

**Verificar estado de tarea**:
```
User: /task status bg-1234

Task bg-1234: Running tests
Status: In progress
Progress: 120/245 tests (49%)
Started: 2025-11-08 10:30:15
Estimated completion: 2025-11-08 10:34:22
```

**Ver output de tarea**:
```
User: /task show bg-1234

[Shows live output from the test run]
```

**Cancelar tarea**:
```
User: /task cancel bg-1234

Cancelled background task bg-1234
```

### Example: Parallel Development

```
User: Run the build in the background

Claude: Starting build... (task-id: bg-5001)

User: Also run the linter in background

Claude: Starting linter... (task-id: bg-5002)

User: While those run, let's implement the new API endpoint

Claude: [Implements API endpoint while build and linter run]

[10 minutes later]

Claude: 📢 Build completed successfully (bg-5001)
📢 Linter found 12 issues (bg-5002)

User: Show me the linter issues

Claude: [Shows linter output from bg-5002]
```

### Configuration

```json
{
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5,
    "notifyOnCompletion": true,
    "autoCleanup": true,
    "logOutput": true
  }
}
```

---

## Scheduled Tasks

Scheduled Tasks te permite ejecutar prompts automáticamente en un horario recurrente o como recordatorios de una sola vez. Las tareas están limitadas a la sesión: se ejecutan mientras Claude Code está activo y se limpian cuando la sesión termina. Disponible desde v2.1.72+.

### The `/loop` command

```bash
# Intervalo explícito
/loop 5m check if the deployment finished

# Lenguaje natural
/loop check build status every 30 minutes
```

Las expresiones cron estándar de 5 campos también son soportadas para programación precisa.

### One-time reminders

Establece recordatorios que se activan una vez en un momento específico:

```
remind me at 3pm to push the release branch
in 45 minutes, run the integration tests
```

### Managing scheduled tasks

| Tool | Description |
|------|-------------|
| `CronCreate` | Crear una nueva tarea programada |
| `CronList` | Listar todas las tareas programadas activas |
| `CronDelete` | Eliminar una tarea programada |

**Límites y comportamiento**:
- Hasta **50 tareas programadas** por sesión
- Limitado a la sesión — se limpia cuando la sesión termina
- Las tareas recurrentes expiran automáticamente después de **3 días**
- Las tareas solo se activan mientras Claude Code está en ejecución — no hay recuperación para activaciones perdidas

### Behavior details

| Aspect | Detail |
|--------|--------|
| **Recurring jitter** | Hasta 10% del intervalo (máx 15 minutos) |
| **One-shot jitter** | Hasta 90 segundos en límites :00/:30 |
| **Missed fires** | No hay recuperación — se omite si Claude Code no estaba en ejecución |
| **Persistence** | No persiste a través de reinicios |

### Cloud Scheduled Tasks

Usa `/schedule` para crear Cloud Scheduled Tasks que se ejecutan en infraestructura de Anthropic:

```
/schedule daily at 9am run the test suite and report failures
```

Cloud Scheduled Tasks persisten a través de reinicios y no requieren que Claude Code esté ejecutándose localmente.

### Disabling scheduled tasks

```bash
export CLAUDE_CODE_DISABLE_CRON=1
```

### Example: monitoring a deployment

```
/loop 5m check the deployment status of the staging environment.
        If the deploy succeeded, notify me and stop looping.
        If it failed, show the error logs.
```

> **Tip**: Scheduled Tasks están limitadas a la sesión. Para automatización persistente que sobrevive a reinicios, usa pipelines CI/CD, GitHub Actions o Desktop App Scheduled Tasks en su lugar.

---

## Permission Modes

Permission Modes controlan qué acciones puede tomar Claude sin aprobación explícita.

### Available Permission Modes

| Mode | Behavior |
|---|---|
| `default` | Solo leer archivos; solicita para todas las demás acciones |
| `acceptEdits` | Leer y editar archivos; solicita para comandos |
| `plan` | Solo leer archivos (modo investigación, sin ediciones) |
| `auto` | Todas las acciones con verificaciones del clasificador de seguridad en segundo plano (Research Preview) |
| `bypassPermissions` | Todas las acciones, sin verificaciones de permisos (peligroso) |
| `dontAsk` | Solo se ejecutan herramientas pre-aprobadas; todas las demás son denegadas |

Cicla a través de los modos con `Shift+Tab` en el CLI. Establece un predeterminado con el flag `--permission-mode` o el setting `permissions.defaultMode`.

### Activation Methods

**Atajo de teclado**:
```bash
Shift + Tab  # Ciclar a través de los 6 modos
```

**Comando slash**:
```bash
/plan                  # Entrar en Plan Mode
```

**Flag CLI**:
```bash
claude --permission-mode plan
claude --permission-mode auto
```

**Setting**:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### Permission Mode Examples

#### Default Mode
Claude solicita confirmación en acciones significativas:

```
User: Fix the bug in auth.ts

Claude: I need to modify src/auth.ts to fix the bug.
The change will update the password validation logic.

Approve this change? (yes/no/show)
```

#### Plan Mode
Revisar el plan de implementación antes de la ejecución:

```
User: /plan Implement user authentication system

Claude: I'll create a plan for implementing authentication.

## Implementation Plan
[Detailed plan with phases and steps]

Ready to proceed? (yes/no/modify)
```

#### Accept Edits Mode
Aceptar automáticamente modificaciones de archivos:

```
User: acceptEdits
User: Fix the bug in auth.ts

Claude: [Makes changes without asking]
```

### Use Cases

**Code Review**:
```
User: claude --permission-mode plan
User: Review this PR and suggest improvements

Claude: [Reads code, provides feedback, but cannot modify]
```

**Pair Programming**:
```
User: claude --permission-mode default
User: Let's implement the feature together

Claude: [Asks for approval before each change]
```

**Automated Tasks**:
```
User: claude --permission-mode acceptEdits
User: Fix all linting issues in the codebase

Claude: [Auto-accepts file edits without asking]
```

---

## Headless Mode

Print Mode (`claude -p`) permite que Claude Code se ejecute sin entrada interactiva, perfecto para automatización y CI/CD. Este es el modo no interactivo, reemplazando el flag `--headless` más antiguo.

### What is Print Mode?

Print Mode permite:
- Ejecución automatizada de scripts
- Integración CI/CD
- Procesamiento por lotes
- Tareas programadas

### Running in Print Mode (Non-Interactive)

```bash
# Ejecutar tarea específica
claude -p "Run all tests"

# Procesar contenido pipeado
cat error.log | claude -p "Analyze these errors"

# Integración CI/CD (GitHub Actions)
- name: AI Code Review
  run: claude -p "Review PR"
```

### Additional Print Mode Usage Examples

```bash
# Ejecutar una tarea específica con captura de output
claude -p "Run all tests and generate coverage report"

# Con output estructurado
claude -p --output-format json "Analyze code quality"

# Con entrada desde stdin
echo "Analyze code quality" | claude -p "explain this"
```

### Example: CI/CD Integration

**GitHub Actions**:
```yaml
# .github/workflows/code-review.yml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Run Claude Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p --output-format json \
            --max-turns 3 \
            "Review this PR for:
            - Code quality issues
            - Security vulnerabilities
            - Performance concerns
            - Test coverage
            Output results as JSON" > review.json

      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: JSON.stringify(review, null, 2)
            });
```

### Print Mode Configuration

Print Mode (`claude -p`) soporta varios flags para automatización:

```bash
# Limitar turnos autónomos
claude -p --max-turns 5 "refactor this module"

# Output estructurado JSON
claude -p --output-format json "analyze this codebase"

# Con validación de schema
claude -p --json-schema '{"type":"object","properties":{"issues":{"type":"array"}}}' \
  "find bugs in this code"

# Deshabilitar persistencia de sesión
claude -p --no-session-persistence "one-off analysis"
```

---

## Session Management

Gestiona múltiples sesiones de Claude Code efectivamente.

### Session Management Commands

| Command | Description |
|---------|-------------|
| `/resume` | Reanudar una conversación por ID o nombre |
| `/rename` | Nombrar la sesión actual |
| `/fork` | Bifurcar la sesión actual en una nueva rama |
| `claude -c` | Continuar la conversación más reciente |
| `claude -r "session"` | Reanudar sesión por nombre o ID |

### Resuming Sessions

**Continuar última conversación**:
```bash
claude -c
```

**Reanudar una sesión nombrada**:
```bash
claude -r "auth-refactor" "finish this PR"
```

**Renombrar la sesión actual** (dentro del REPL):
```
/rename auth-refactor
```

### Forking Sessions

Bifurca una sesión para probar un enfoque alternativo sin perder la original:

```
/fork
```

O desde el CLI:
```bash
claude --resume auth-refactor --fork-session "try OAuth instead"
```

### Session Persistence

Las sesiones se guardan automáticamente y pueden reanudarse:

```bash
# Continuar última conversación
claude -c

# Reanudar sesión específica por nombre o ID
claude -r "auth-refactor"

# Reanudar y bifurcar para experimentación
claude --resume auth-refactor --fork-session "alternative approach"
```

---

## Interactive Features

### Keyboard Shortcuts

Claude Code soporta atajos de teclado para eficiencia. Aquí está la referencia completa de los docs oficiales:

| Shortcut | Description |
|----------|-------------|
| `Ctrl+C` | Cancelar entrada/generación actual |
| `Ctrl+D` | Salir de Claude Code |
| `Ctrl+G` | Editar plan en editor externo |
| `Ctrl+L` | Limpiar pantalla de terminal |
| `Ctrl+O` | Alternar output verbose (ver razonamiento) |
| `Ctrl+R` | Búsqueda inversa de historial |
| `Ctrl+T` | Alternar vista de Task List |
| `Ctrl+B` | Background running tasks |
| `Esc+Esc` | Rebobinar código/conversación |
| `Shift+Tab` / `Alt+M` | Alternar Permission Modes |
| `Option+P` / `Alt+P` | Cambiar modelo |
| `Option+T` / `Alt+T` | Alternar Extended Thinking |

**Line Editing (atajos readline estándar):**

| Shortcut | Action |
|----------|--------|
| `Ctrl + A` | Mover al inicio de la línea |
| `Ctrl + E` | Mover al final de la línea |
| `Ctrl + K` | Cortar hasta el final de la línea |
| `Ctrl + U` | Cortar hasta el inicio de la línea |
| `Ctrl + W` | Cortar palabra anterior |
| `Ctrl + Y` | Pegar (yank) |
| `Tab` | Autocompletar |
| `↑ / ↓` | Historial de comandos |

### Customizing keybindings

Crea atajos de teclado personalizados ejecutando `/keybindings`, que abre `~/.claude/keybindings.json` para edición (v2.1.18+).

**Formato de configuración**:

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+u": null,
        "ctrl+k ctrl+s": "chat:stash"
      }
    },
    {
      "context": "Confirmation",
      "bindings": {
        "ctrl+a": "confirmation:yes"
      }
    }
  ]
}
```

Establece un binding a `null` para desvincular un atajo predeterminado.

### Available contexts

Los keybindings están limitados a contextos de UI específicos:

| Context | Key Actions |
|---------|-------------|
| **Chat** | `submit`, `cancel`, `cycleMode`, `modelPicker`, `thinkingToggle`, `undo`, `externalEditor`, `stash`, `imagePaste` |
| **Confirmation** | `yes`, `no`, `previous`, `next`, `nextField`, `cycleMode`, `toggleExplanation` |
| **Global** | `interrupt`, `exit`, `toggleTodos`, `toggleTranscript` |
| **Autocomplete** | `accept`, `dismiss`, `next`, `previous` |
| **HistorySearch** | `search`, `previous`, `next` |
| **Settings** | Navegación de configuración específica del contexto |
| **Tabs** | Cambio y gestión de pestañas |
| **Help** | Navegación del panel de ayuda |

Hay 18 contextos en total incluyendo `Transcript`, `Task`, `ThemePicker`, `Attachments`, `Footer`, `MessageSelector`, `DiffDialog`, `ModelPicker` y `Select`.

### Chord support

Los keybindings soportan secuencias de acordes (combinaciones de teclas múltiples):

```
"ctrl+k ctrl+s"   → Secuencia de dos teclas: presiona ctrl+k, luego ctrl+s
"ctrl+shift+p"    → Teclas modificadoras simultáneas
```

**Sintaxis de teclas**:
- **Modificadores**: `ctrl`, `alt` (o `opt`), `shift`, `meta` (o `cmd`)
- **Mayúsculas implica Shift**: `K` es equivalente a `shift+k`
- **Teclas especiales**: `escape`, `enter`, `return`, `tab`, `space`, `backspace`, `delete`, teclas de flecha

### Reserved and conflicting keys

| Key | Status | Notes |
|-----|--------|-------|
| `Ctrl+C` | Reservado | No se puede reasignar (interrumpir) |
| `Ctrl+D` | Reservado | No se puede reasignar (salir) |
| `Ctrl+B` | Conflicto de terminal | Tecla prefijo tmux |
| `Ctrl+A` | Conflicto de terminal | Tecla prefijo GNU Screen |
| `Ctrl+Z` | Conflicto de terminal | Suspensión de proceso |

> **Tip**: Si un atajo no funciona, verifica conflictos con tu emulador de terminal o multiplexor.

### Tab Completion

Claude Code proporciona autocompletado inteligente:

```
User: /rew<TAB>
→ /rewind

User: /plu<TAB>
→ /plugin

User: /plugin <TAB>
→ /plugin install
→ /plugin enable
→ /plugin disable
```

### Command History

Acceder a comandos anteriores:

```
User: <↑>  # Comando anterior
User: <↓>  # Siguiente comando
User: Ctrl+R  # Buscar en historial

(reverse-i-search)`test': run all tests
```

### Multi-line Input

Para consultas complejas, usa el modo multilínea:

```bash
User: \
> Long complex prompt
> spanning multiple lines
> \end
```

**Example:**

```
User: \
> Implement a user authentication system
> with the following requirements:
> - JWT tokens
> - Email verification
> - Password reset
> - 2FA support
> \end

Claude: [Processes the multi-line request]
```

### Inline Editing

Editar comandos antes de enviar:

```
User: Deploy to prodcution<Backspace><Backspace>uction

[Edit in-place before sending]
```

### Vim Mode

Habilitar keybindings Vi/Vim para edición de texto:

**Activation**:
- Usa el comando `/vim` o `/config` para habilitar
- Cambio de modo con `Esc` para NORMAL, `i/a/o` para INSERT

**Teclas de navegación**:
- `h` / `l` - Mover izquierda/derecha |
- `j` / `k` - Mover abajo/arriba |
- `w` / `b` / `e` - Mover por palabra |
- `0` / `$` - Mover al inicio/final de la línea |
- `gg` / `G` - Saltar al inicio/final del texto |

**Text objects**:
- `iw` / `aw` - Inner/around word |
- `i"` / `a"` - Inner/around quoted string |
- `i(` / `a(` - Inner/around parentheses |

### Bash Mode

Ejecutar comandos de shell directamente con el prefijo `!`:

```bash
! npm test
! git status
! cat src/index.js
```

Usa esto para ejecución rápida de comandos sin cambiar contextos.

---

## Voice Dictation

Voice Dictation proporciona entrada de voz push-to-talk para Claude Code, permitiéndote hablar tus prompts en lugar de escribirlos.

### Activating Voice Dictation

```
/voice
```

### Features

| Feature | Description |
|---------|-------------|
| **Push-to-talk** | Mantener presionada una tecla para grabar, soltar para enviar |
| **20 idiomas** | Speech-to-text soporta 20 idiomas |
| **Custom keybinding** | Configurar la tecla push-to-talk vía `/keybindings` |
| **Account requirement** | Requiere una cuenta Claude.ai para procesamiento STT |

### Configuration

Personaliza el keybinding push-to-talk en tu archivo de keybindings (`/keybindings`). Voice Dictation usa tu cuenta Claude.ai para procesamiento de speech-to-text.

---

## Channels

Channels (Research Preview) permiten que los servidores MCP envíen mensajes a sesiones de Claude Code en ejecución, permitiendo integraciones en tiempo real con servicios externos.

### Subscribing to Channels

```bash
# Suscribirse a channel plugins al inicio
claude --channels discord,telegram
```

### Supported Integrations

| Integration | Description |
|-------------|-------------|
| **Discord** | Recibir y responder mensajes de Discord en tu sesión |
| **Telegram** | Recibir y responder mensajes de Telegram en tu sesión |

### Configuration

**Managed setting** para despliegues empresariales:

```json
{
  "allowedChannelPlugins": ["discord", "telegram"]
}
```

El managed setting `allowedChannelPlugins` controla qué channel plugins están permitidos en toda la organización.

### How It Works

1. Los servidores MCP actúan como channel plugins que se conectan a servicios externos
2. Los mensajes entrantes se envían a la sesión activa de Claude Code
3. Claude puede leer y responder mensajes dentro del contexto de la sesión
4. Los channel plugins deben ser aprobados vía el managed setting `allowedChannelPlugins`

---

## Chrome Integration

Chrome Integration conecta Claude Code a tu navegador Chrome o Microsoft Edge para automatización web en vivo y depuración. Esta es una característica beta disponible desde v2.0.73+ (soporte Edge agregado en v1.0.36+).

### Enabling Chrome Integration

**Al inicio**:

```bash
claude --chrome      # Habilitar conexión Chrome
claude --no-chrome   # Deshabilitar conexión Chrome
```

**Dentro de una sesión**:

```
/chrome
```

Selecciona "Enabled by default" para activar Chrome Integration para todas las sesiones futuras. Claude Code comparte el estado de inicio de sesión de tu navegador, por lo que puede interactuar con aplicaciones web autenticadas.

### Capabilities

| Capability | Description |
|------------|-------------|
| **Live debugging** | Leer logs de consola, inspeccionar elementos DOM, depurar JavaScript en tiempo real |
| **Design verification** | Comparar páginas renderizadas contra mockups de diseño |
| **Form validation** | Probar envíos de formularios, validación de entrada y manejo de errores |
| **Web app testing** | Interactuar con aplicaciones autenticadas (Gmail, Google Docs, Notion, etc.) |
| **Data extraction** | Extraer y procesar contenido de páginas web |
| **Session recording** | Grabar interacciones del navegador como archivos GIF |

### Site-level permissions

La extensión de Chrome gestiona el acceso por sitio. Otorga o revoca acceso para sitios específicos en cualquier momento a través del popup de la extensión. Claude Code solo interactúa con sitios que has permitido explícitamente.

### How it works

Claude Code controla el navegador en una ventana visible — puedes ver las acciones suceder en tiempo real. Cuando el navegador encuentra una página de inicio de sesión o CAPTCHA, Claude se pausa y espera que lo manejes manualmente antes de continuar.

### Known limitations

- **Soporte de navegador**: Solo Chrome y Edge — Brave, Arc y otros navegadores Chromium no son soportados
- **WSL**: No disponible en Windows Subsystem for Linux
- **Proveedores de terceros**: No soportado con proveedores de API Bedrock, Vertex o Foundry
- **Service worker idle**: El service worker de la extensión Chrome puede entrar en idle durante sesiones extendidas

> **Tip**: Chrome Integration es una característica beta. El soporte de navegador puede expandirse en versiones futuras.

---

## Remote Control

Remote Control te permite continuar una sesión de Claude Code en ejecución localmente desde tu teléfono, tableta o cualquier navegador. Tu sesión local continúa ejecutándose en tu máquina — nada se mueve a la nube. Disponible en planes Pro, Max, Team y Enterprise (v2.1.51+).

### Starting Remote Control

**Desde el CLI**:

```bash
# Iniciar con nombre de sesión predeterminado
claude remote-control

# Iniciar con un nombre personalizado
claude remote-control --name "Auth Refactor"
```

**Desde dentro de una sesión**:

```
/remote-control
/remote-control "Auth Refactor"
```

**Flags disponibles**:

| Flag | Description |
|------|-------------|
| `--name "title"` | Título personalizado de la sesión para fácil identificación |
| `--verbose` | Mostrar logs detallados de conexión |
| `--sandbox` | Habilitar aislamiento de sistema de archivos y red |
| `--no-sandbox` | Deshabilitar sandboxing (predeterminado) |

### Connecting to a session

Tres formas de conectarse desde otro dispositivo:

1. **URL de sesión** — Impresa en la terminal cuando la sesión inicia; ábrela en cualquier navegador
2. **Código QR** — Presiona `spacebar` después de iniciar para mostrar un código QR escaneable
3. **Buscar por nombre** — Navega por tus sesiones en claude.ai/code o en la aplicación móvil Claude (iOS/Android)

### Security

- **Sin puertos entrantes** abiertos en tu máquina
- **Solo HTTPS saliente** sobre TLS
- **Credenciales limitadas** — múltiples tokens de corta duración y estrechamente limitados
- **Aislamiento de sesión** — cada sesión remota es independiente

### Remote Control vs Claude Code on the web

| Aspect | Remote Control | Claude Code on Web |
|--------|---------------|-------------------|
| **Execution** | Se ejecuta en tu máquina | Se ejecuta en la nube de Anthropic |
| **Local tools** | Acceso completo a servidores MCP locales, archivos y CLI | Sin dependencias locales |
| **Use case** | Continuar trabajo local desde otro dispositivo | Iniciar fresco desde cualquier navegador |

### Limitations

- Una sesión remota por instancia de Claude Code
- La terminal debe permanecer abierta en la máquina host
- La sesión expira después de ~10 minutos si la red es inalcanzable

### Use cases

- Controlar Claude Code desde un dispositivo móvil o tableta mientras estás lejos de tu escritorio
- Usar la UI más rica de claude.ai mientras mantienes la ejecución de herramientas locales
- Revisiones rápidas de código en movimiento con tu entorno de desarrollo local completo

---

## Web Sessions

Web Sessions te permiten ejecutar Claude Code directamente en el navegador en claude.ai/code, o crear web sessions desde el CLI.

### Creating a Web Session

```bash
# Crear una nueva web session desde el CLI
claude --remote "implement the new API endpoints"
```

Esto inicia una sesión de Claude Code en claude.ai a la que puedes acceder desde cualquier navegador.

### Resuming Web Sessions Locally

Si iniciaste una sesión en la web y quieres continuarla localmente:

```bash
# Reanudar una web session en la terminal local
claude --teleport
```

O desde dentro de un REPL interactivo:
```
/teleport
```

### Use Cases

- Iniciar trabajo en una máquina y continuar en otra
- Compartir una URL de sesión con miembros del equipo
- Usar la UI web para revisión visual de diffs, luego cambiar a terminal para ejecución

---

## Desktop App

La Claude Code Desktop App proporciona una aplicación independiente con revisión visual de diffs, sesiones paralelas y conectores integrados. Disponible para macOS y Windows (planes Pro, Max, Team y Enterprise).

### Installation

Descarga desde [claude.ai](https://claude.ai) para tu plataforma:
- **macOS**: Build universal (Apple Silicon e Intel)
- **Windows**: Instaladores x64 y ARM64 disponibles

Ver el [Desktop Quickstart](https://code.claude.com/docs/en/desktop-quickstart) para instrucciones de configuración.

### Handing off from CLI

Transferir tu sesión CLI actual a la Desktop App:

```
/desktop
```

### Core features

| Feature | Description |
|---------|-------------|
| **Diff view** | Revisión visual archivo por archivo con comentarios en línea; Claude lee comentarios y revisa |
| **App preview** | Inicia automáticamente servidores de desarrollo con un navegador integrado para verificación en vivo |
| **PR monitoring** | Integración con GitHub CLI con auto-fix de fallos de CI y auto-merge cuando los checks pasan |
| **Parallel sessions** | Múltiples sesiones en la barra lateral con aislamiento automático de Git worktree |
| **Scheduled tasks** | Tareas recurrentes (horarias, diarias, días laborables, semanales) que se ejecutan mientras la app está abierta |
| **Rich rendering** | Renderizado de código, markdown y diagramas con resaltado de sintaxis |

### App preview configuration

Configura el comportamiento del servidor de desarrollo en `.claude/launch.json`:

```json
{
  "command": "npm run dev",
  "port": 3000,
  "readyPattern": "ready on",
  "persistCookies": true
}
```

### Connectors

Conectar servicios externos para contexto más rico:

| Connector | Capability |
|-----------|------------|
| **GitHub** | Monitoreo de PR, seguimiento de issues, revisión de código |
| **Slack** | Notificaciones, contexto de canal |
| **Linear** | Seguimiento de issues, gestión de sprints |
| **Notion** | Documentación, acceso a base de conocimientos |
| **Asana** | Gestión de tareas, seguimiento de proyectos |
| **Calendar** | Conciencia de horario, contexto de reuniones |

> **Nota**: Los conectores no están disponibles para sesiones remotas (en la nube).

### Remote and SSH sessions

- **Remote sessions**: Se ejecutan en infraestructura de nube de Anthropic; continúan incluso cuando la app está cerrada. Accesibles desde claude.ai/code o la aplicación móvil Claude
- **SSH sessions**: Conectarse a máquinas remotas sobre SSH con acceso completo al sistema de archivos remoto y herramientas. Claude Code debe estar instalado en la máquina remota

### Permission modes in Desktop

La Desktop App soporta los mismos 4 Permission Modes que el CLI:

| Mode | Behavior |
|------|----------|
| **Ask permissions** (predeterminado) | Revisar y aprobar cada edición y comando |
| **Auto accept edits** | Ediciones de archivos auto-aprobadas; los comandos requieren aprobación manual |
| **Plan mode** | Revisar enfoque antes de que se hagan cambios |
| **Bypass permissions** | Ejecución automática (solo sandbox, controlado por admin) |

### Enterprise features

- **Admin console**: Controlar acceso a la pestaña Code y configuración de permisos para la organización
- **MDM deployment**: Desplegar vía MDM en macOS o MSIX en Windows
- **SSO integration**: Requerir single sign-on para miembros de la organización
- **Managed settings**: Gestionar centralmente la configuración del equipo y disponibilidad de modelos

---

## Task List

La característica Task List proporciona seguimiento persistente de tareas que sobrevive a las compactaciones de contexto (cuando el historial de conversación se recorta para ajustarse a la ventana de contexto).

### Toggling the Task List

Presiona `Ctrl+T` para alternar la vista de Task List activada o desactivada durante una sesión.

### Persistent Tasks

Las tareas persisten a través de compactaciones de contexto, asegurando que los elementos de trabajo de larga duración no se pierdan cuando el contexto de conversación se recorta. Esto es particularmente útil para implementaciones complejas de múltiples pasos.

### Named Task Directories

Usa la variable de entorno `CLAUDE_CODE_TASK_LIST_ID` para crear directorios de tareas nombrados compartidos entre sesiones:

```bash
export CLAUDE_CODE_TASK_LIST_ID=my-project-sprint-3
```

Esto permite que múltiples sesiones compartan la misma lista de tareas, lo que lo hace útil para flujos de trabajo en equipo o proyectos de múltiples sesiones.

---

## Prompt Suggestions

Prompt Suggestions muestra comandos de ejemplo en gris basados en tu historial de git y el contexto de conversación actual.

### How It Works

- Las sugerencias aparecen como texto en gris debajo de tu prompt de entrada
- Presiona `Tab` para aceptar la sugerencia
- Presiona `Enter` para aceptar y enviar inmediatamente
- Las sugerencias son conscientes del contexto, extrayendo del historial de git y el estado de conversación

### Disabling Prompt Suggestions

```bash
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
```

---

## Git Worktrees

Git Worktrees te permiten iniciar Claude Code en un worktree aislado, permitiendo trabajo paralelo en diferentes ramas sin stashing o switching.

### Starting in a Worktree

```bash
# Iniciar Claude Code en un worktree aislado
claude --worktree
# o
claude -w
```

### Worktree Location

Los Worktrees se crean en:
```
<repo>/.claude/worktrees/<name>
```

### Sparse Checkout for Monorepos

Usa el setting `worktree.sparsePaths` para realizar sparse-checkout en monorepos, reduciendo el uso de disco y el tiempo de clonación:

```json
{
  "worktree": {
    "sparsePaths": ["packages/my-package", "shared/"]
  }
}
```

### Worktree Tools and Hooks

| Item | Description |
|------|-------------|
| `ExitWorktree` | Herramienta para salir y limpiar el worktree actual |
| `WorktreeCreate` | Evento hook disparado cuando se crea un worktree |
| `WorktreeRemove` | Evento hook disparado cuando se elimina un worktree |

### Auto-Cleanup

Si no se hacen cambios en el worktree, se limpia automáticamente cuando la sesión termina.

### Use Cases

- Trabajar en una rama de característica mientras mantienes la rama main intacta
- Ejecutar tests en aislamiento sin afectar el directorio de trabajo
- Probar cambios experimentales en un entorno desechable
- Sparse-checkout paquetes específicos en monorepos para inicio más rápido

---

## Sandboxing

Sandboxing proporciona aislamiento de sistema de archivos y red a nivel de SO para comandos Bash ejecutados por Claude Code. Esto es complementario a las reglas de permisos y proporciona una capa de seguridad adicional.

### Enabling Sandboxing

**Comando slash**:
```
/sandbox
```

**Flags CLI**:
```bash
claude --sandbox       # Habilitar sandboxing
claude --no-sandbox    # Deshabilitar sandboxing
```

### Configuration Settings

| Setting | Description |
|---------|-------------|
| `sandbox.enabled` | Habilitar o deshabilitar sandboxing |
| `sandbox.failIfUnavailable` | Fallar si el sandboxing no puede activarse |
| `sandbox.filesystem.allowWrite` | Rutas permitidas para acceso de escritura |
| `sandbox.filesystem.allowRead` | Rutas permitidas para acceso de lectura |
| `sandbox.filesystem.denyRead` | Rutas denegadas para acceso de lectura |
| `sandbox.enableWeakerNetworkIsolation` | Habilitar aislamiento de red más débil en macOS |

### Example Configuration

```json
{
  "sandbox": {
    "enabled": true,
    "failIfUnavailable": true,
    "filesystem": {
      "allowWrite": ["/Users/me/project"],
      "allowRead": ["/Users/me/project", "/usr/local/lib"],
      "denyRead": ["/Users/me/.ssh", "/Users/me/.aws"]
    },
    "enableWeakerNetworkIsolation": true
  }
}
```

### How It Works

- Los comandos Bash se ejecutan en un entorno sandboxed con acceso restringido al sistema de archivos
- El acceso a la red puede aislarse para prevenir conexiones externas no intencionadas
- Funciona junto con reglas de permisos para defensa en profundidad
- En macOS, usa `sandbox.enableWeakerNetworkIsolation` para restricciones de red (el aislamiento de red completo no está disponible en macOS)

### Use Cases

- Ejecutar código no confiado o generado de forma segura
- Prevenir modificaciones accidentales a archivos fuera del proyecto
- Restringir acceso a la red durante tareas automatizadas

---

## Managed Settings (Enterprise)

Managed Settings permite a los administradores empresariales desplegar configuración de Claude Code en toda una organización usando herramientas de gestión nativas de la plataforma.

### Deployment Methods

| Platform | Method | Since |
|----------|--------|-------|
| macOS | Managed plist files (MDM) | v2.1.51+ |
| Windows | Windows Registry | v2.1.51+ |
| Cross-platform | Managed configuration files | v2.1.51+ |
| Cross-platform | Managed drop-ins (directorio `managed-settings.d/`) | v2.1.83+ |

### Managed Drop-ins

Desde v2.1.83, los administradores pueden desplegar múltiples archivos de managed settings en un directorio `managed-settings.d/`. Los archivos se fusionan en orden alfabético, permitiendo configuración modular a través de equipos:

```
~/.claude/managed-settings.d/
  00-org-defaults.json
  10-team-policies.json
  20-project-overrides.json
```

### Available Managed Settings

| Setting | Description |
|---------|-------------|
| `disableBypassPermissionsMode` | Prevenir que los usuarios habiliten bypass permissions |
| `availableModels` | Restringir qué modelos pueden seleccionar los usuarios |
| `allowedChannelPlugins` | Controlar qué channel plugins están permitidos |
| `autoMode.environment` | Configurar infraestructura de confianza para Auto Mode |
| Custom policies | Políticas de permisos y herramientas específicas de la organización |

### Example: macOS Plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>disableBypassPermissionsMode</key>
  <true/>
  <key>availableModels</key>
  <array>
    <string>claude-sonnet-4-6</string>
    <string>claude-haiku-4-5</string>
  </array>
</dict>
</plist>
```

---

## Configuration and Settings

### Configuration File Locations

1. **Config global**: `~/.claude/config.json`
2. **Config de proyecto**: `./.claude/config.json`
3. **Config de usuario**: `~/.config/claude-code/settings.json`

### Complete Configuration Example

**Configuración completa de características avanzadas:**

```json
{
  "permissions": {
    "mode": "default"
  },
  "hooks": {
    "PreToolUse:Edit": "eslint --fix ${file_path}",
    "PostToolUse:Write": "~/.claude/hooks/security-scan.sh"
  },
  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"]
      }
    }
  }
}
```

**Ejemplo de configuración extendida:**

```json
{
  "permissions": {
    "mode": "default",
    "allowedTools": ["Bash(git log:*)", "Read"],
    "disallowedTools": ["Bash(rm -rf:*)"]
  },

  "hooks": {
    "PreToolUse": [{ "matcher": "Edit", "hooks": ["eslint --fix ${file_path}"] }],
    "PostToolUse": [{ "matcher": "Write", "hooks": ["~/.claude/hooks/security-scan.sh"] }],
    "Stop": [{ "hooks": ["~/.claude/hooks/notify.sh"] }]
  },

  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"],
        "env": {
          "GITHUB_TOKEN": "${GITHUB_TOKEN}"
        }
      }
    }
  }
}
```

### Environment Variables

Sobrescribir config con variables de entorno:

```bash
# Selección de modelo
export ANTHROPIC_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6
export ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-haiku-4-5

# Configuración de API
export ANTHROPIC_API_KEY=sk-ant-...

# Configuración de pensamiento
export MAX_THINKING_TOKENS=16000
export CLAUDE_CODE_EFFORT_LEVEL=high

# Feature toggles
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=true
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=true
export CLAUDE_CODE_DISABLE_CRON=1
export CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS=true
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=true
export CLAUDE_CODE_DISABLE_1M_CONTEXT=true
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=true
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
export CLAUDE_CODE_ENABLE_TASKS=true
export CLAUDE_CODE_SIMPLE=true              # Establecido por el flag --bare

# Configuración MCP
export MAX_MCP_OUTPUT_TOKENS=50000
export ENABLE_TOOL_SEARCH=true

# Gestión de tareas
export CLAUDE_CODE_TASK_LIST_ID=my-project-tasks

# Equipos de agentes (experimental)
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true

# Configuración de subagente y plugin
export CLAUDE_CODE_SUBAGENT_MODEL=sonnet
export CLAUDE_CODE_PLUGIN_SEED_DIR=./my-plugins
export CLAUDE_CODE_NEW_INIT=true

# Subproceso y streaming
export CLAUDE_CODE_SUBPROCESS_ENV_SCRUB="SECRET_KEY,DB_PASSWORD"
export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80
export CLAUDE_STREAM_IDLE_TIMEOUT_MS=30000
export ANTHROPIC_CUSTOM_MODEL_OPTION=my-custom-model
export SLASH_COMMAND_TOOL_CHAR_BUDGET=50000
```

### Configuration Management Commands

```
User: /config
[Opens interactive configuration menu]
```

El comando `/config` proporciona un menú interactivo para alternar configuraciones como:
- Extended thinking on/off
- Verbose output
- Permission mode
- Model selection

### Per-Project Configuration

Crea `.claude/config.json` en tu proyecto:

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": ["npm test && npm run lint"] }]
  },
  "permissions": {
    "mode": "default"
  },
  "mcp": {
    "servers": {
      "project-db": {
        "command": "mcp-postgres",
        "env": {
          "DATABASE_URL": "${PROJECT_DB_URL}"
        }
      }
    }
  }
}
```

---

## Best Practices

### Planning Mode
- ✅ Usar para tareas complejas de múltiples pasos
- ✅ Revisar planes antes de aprobar
- ✅ Modificar planes cuando sea necesario
- ❌ No usar para tareas simples

### Extended Thinking
- ✅ Usar para decisiones arquitectónicas
- ✅ Usar para resolución de problemas complejos
- ✅ Revisar el proceso de pensamiento
- ❌ No usar para consultas simples

### Background Tasks
- ✅ Usar para operaciones de larga duración
- ✅ Monitorear progreso de tareas
- ✅ Manejar fallos de tareas gracefulmente
- ❌ No iniciar demasiadas tareas concurrentes

### Permissions
- ✅ Usar `plan` para code review (solo lectura)
- ✅ Usar `default` para desarrollo interactivo
- ✅ Usar `acceptEdits` para flujos de trabajo de automatización
- ✅ Usar `auto` para trabajo autónomo con salvaguardas de seguridad
- ❌ No usar `bypassPermissions` a menos que sea absolutamente necesario

### Sessions
- ✅ Usar sesiones separadas para diferentes tareas
- ✅ Guardar estados de sesión importantes
- ✅ Limpiar sesiones antiguas
- ❌ No mezclar trabajo no relacionado en una sesión

---

## Additional Resources

Para más información sobre Claude Code y características relacionadas:

- [Official Interactive Mode Documentation](https://code.claude.com/docs/en/interactive-mode)
- [Official Headless Mode Documentation](https://code.claude.com/docs/en/headless)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Checkpoints Guide](../08-checkpoints/) - Session management and rewinding
- [Slash Commands](../01-slash-commands/) - Command reference
- [Memory Guide](../02-memory/) - Persistent context
- [Skills Guide](../03-skills/) - Autonomous capabilities
- [Subagents Guide](../04-subagents/) - Delegated task execution
- [MCP Guide](../05-mcp/) - External data access
- [Hooks Guide](../06-hooks/) - Event-driven automation
- [Plugins Guide](../07-plugins/) - Bundled extensions
- [Official Scheduled Tasks Documentation](https://code.claude.com/docs/en/scheduled-tasks)
- [Official Chrome Integration Documentation](https://code.claude.com/docs/en/chrome)
- [Official Remote Control Documentation](https://code.claude.com/docs/en/remote-control)
- [Official Keybindings Documentation](https://code.claude.com/docs/en/keybindings)
- [Official Desktop App Documentation](https://code.claude.com/docs/en/desktop)
