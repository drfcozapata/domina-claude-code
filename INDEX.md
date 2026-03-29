<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Ejemplos de Claude Code - Índice Completo

Este documento proporciona un índice completo de todos los archivos de ejemplo organizados por tipo de funcionalidad.

## Estadísticas Resumen

- **Total de Archivos**: 100+ archivos
- **Categorías**: 10 categorías de funcionalidades
- **Plugins**: 3 plugins completos
- **Skills**: 6 skills completos
- **Hooks**: 8 hooks de ejemplo
- **Listo para Usar**: Todos los ejemplos

---

## 01. Slash Commands (10 archivos)

Atajos invocados por el usuario para flujos de trabajo comunes.

| Archivo | Descripción | Caso de Uso |
|------|-------------|----------|
| `optimize.md` | Analizador de optimización de código | Encontrar problemas de rendimiento |
| `pr.md` | Preparación de pull request | Automatización de flujo de trabajo de PR |
| `generate-api-docs.md` | Generador de documentación de API | Generar docs de API |
| `commit.md` | Asistente de mensajes de commit | Commits estandarizados |
| `setup-ci-cd.md` | Configuración de pipeline CI/CD | Automatización DevOps |
| `push-all.md` | Push de todos los cambios | Flujo de trabajo de push rápido |
| `unit-test-expand.md` | Expandir cobertura de pruebas unitarias | Automatización de pruebas |
| `doc-refactor.md` | Refactorización de documentación | Mejoras de documentación |
| `pr-slash-command.png` | Ejemplo de captura de pantalla | Referencia visual |
| `README.md` | Documentación | Guía de configuración y uso |

**Ruta de Instalación**: `.claude/commands/`

**Uso**: `/optimize`, `/pr`, `/generate-api-docs`, `/commit`, `/setup-ci-cd`, `/push-all`, `/unit-test-expand`, `/doc-refactor`

---

## 02. Memory (6 archivos)

Contexto persistente y estándares del proyecto.

| Archivo | Descripción | Alcance | Ubicación |
|------|-------------|-------|----------|
| `project-CLAUDE.md` | Estándares del equipo del proyecto | Todo el proyecto | `./CLAUDE.md` |
| `directory-api-CLAUDE.md` | Reglas específicas de API | Directorio | `./src/api/CLAUDE.md` |
| `personal-CLAUDE.md` | Preferencias personales | Usuario | `~/.claude/CLAUDE.md` |
| `memory-saved.png` | Captura: memoria guardada | - | Referencia visual |
| `memory-ask-claude.png` | Captura: preguntar a Claude | - | Referencia visual |
| `README.md` | Documentación | - | Referencia |

**Instalación**: Copiar a la ubicación apropiada

**Uso**: Cargado automáticamente por Claude

---

## 03. Skills (28 archivos)

Capacidades auto-invocadas con scripts y plantillas.

### Code Review Skill (5 archivos)
```
code-review/
├── SKILL.md                          # Definición del skill
├── scripts/
│   ├── analyze-metrics.py            # Analizador de métricas de código
│   └── compare-complexity.py         # Comparación de complejidad
└── templates/
    ├── review-checklist.md           # Lista de verificación de revisión
    └── finding-template.md           # Documentación de hallazgos
```

**Propósito**: Revisión completa de código con análisis de seguridad, rendimiento y calidad

**Auto-invocado**: Al revisar código

---

### Brand Voice Skill (4 archivos)
```
brand-voice/
├── SKILL.md                          # Definición del skill
├── templates/
│   ├── email-template.txt            # Formato de correo electrónico
│   └── social-post-template.txt      # Formato de redes sociales
└── tone-examples.md                  # Ejemplos de mensajes
```

**Propósito**: Asegurar una voz de marca consistente en las comunicaciones

**Auto-invocado**: Al crear contenido de marketing

---

### Documentation Generator Skill (2 archivos)
```
doc-generator/
├── SKILL.md                          # Definición del skill
└── generate-docs.py                  # Extractor de docs en Python
```

**Propósito**: Generar documentación de API completa desde el código fuente

**Auto-invocado**: Al crear/actualizar documentación de API

---

### Refactor Skill (5 archivos)
```
refactor/
├── SKILL.md                          # Definición del skill
├── scripts/
│   ├── analyze-complexity.py         # Analizador de complejidad
│   └── detect-smells.py              # Detector de code smells
├── references/
│   ├── code-smells.md                # Catálogo de code smells
│   └── refactoring-catalog.md        # Patrones de refactorización
└── templates/
    └── refactoring-plan.md           # Plantilla de plan de refactorización
```

**Propósito**: Refactorización sistemática de código con análisis de complejidad

**Auto-invocado**: Al refactorizar código

---

### Claude MD Skill (1 archivo)
```
claude-md/
└── SKILL.md                          # Definición del skill
```

**Propósito**: Gestionar y optimizar archivos CLAUDE.md

---

### Blog Draft Skill (3 archivos)
```
blog-draft/
├── SKILL.md                          # Definición del skill
└── templates/
    ├── draft-template.md             # Plantilla de borrador de blog
    └── outline-template.md           # Plantilla de esquema de blog
```

**Propósito**: Redactar publicaciones de blog con estructura consistente

**Además**: `README.md` - Visión general y guía de uso de Skills

**Ruta de Instalación**: `~/.claude/skills/` o `.claude/skills/`

---

## 04. Subagents (9 archivos)

Asistentes de IA especializados con capacidades personalizadas.

| Archivo | Descripción | Herramientas | Caso de Uso |
|------|-------------|-------|----------|
| `code-reviewer.md` | Análisis de calidad de código | read, grep, diff, lint_runner | Revisiones completas |
| `test-engineer.md` | Análisis de cobertura de pruebas | read, write, bash, grep | Automatización de pruebas |
| `documentation-writer.md` | Creación de documentación | read, write, grep | Generación de docs |
| `secure-reviewer.md` | Revisión de seguridad (solo lectura) | read, grep | Auditorías de seguridad |
| `implementation-agent.md` | Implementación completa | read, write, bash, grep, edit, glob | Desarrollo de funcionalidades |
| `debugger.md` | Especialista en depuración | read, bash, grep | Investigación de bugs |
| `data-scientist.md` | Especialista en análisis de datos | read, write, bash | Flujos de trabajo de datos |
| `clean-code-reviewer.md` | Estándares de código limpio | read, grep | Calidad de código |
| `README.md` | Documentación | - | Guía de configuración y uso |

**Ruta de Instalación**: `.claude/agents/`

**Uso**: Delegado automáticamente por el agente principal

---

## 05. MCP Protocol (5 archivos)

Integraciones de herramientas y APIs externas.

| Archivo | Descripción | Se Integra Con | Caso de Uso |
|------|-------------|-----------------|----------|
| `github-mcp.json` | Integración de GitHub | API de GitHub | Gestión de PR/issues |
| `database-mcp.json` | Consultas de base de datos | PostgreSQL/MySQL | Consultas de datos en vivo |
| `filesystem-mcp.json` | Operaciones de archivos | Sistema de archivos local | Gestión de archivos |
| `multi-mcp.json` | Múltiples servidores | GitHub + DB + Slack | Integración completa |
| `README.md` | Documentación | - | Guía de configuración y uso |

**Ruta de Instalación**: `.mcp.json` (alcance del proyecto) o `~/.claude.json` (alcance del usuario)

**Uso**: `/mcp__github__list_prs`, etc.

---

## 06. Hooks (9 archivos)

Scripts de automatización impulsados por eventos que se ejecutan automáticamente.

| Archivo | Descripción | Evento | Caso de Uso |
|------|-------------|-------|----------|
| `format-code.sh` | Auto-formateo de código | PreToolUse:Write | Formateo de código |
| `pre-commit.sh` | Ejecutar pruebas antes del commit | PreToolUse:Bash | Automatización de pruebas |
| `security-scan.sh` | Escaneo de seguridad | PostToolUse:Write | Verificaciones de seguridad |
| `log-bash.sh` | Registrar comandos bash | PostToolUse:Bash | Registro de comandos |
| `validate-prompt.sh` | Validar prompts | PreToolUse | Validación de entrada |
| `notify-team.sh` | Enviar notificaciones | Notification | Notificaciones al equipo |
| `context-tracker.py` | Rastrear uso de ventana de contexto | PostToolUse | Monitoreo de contexto |
| `context-tracker-tiktoken.py` | Rastreo de contexto basado en tokens | PostToolUse | Conteo preciso de tokens |
| `README.md` | Documentación | - | Guía de configuración y uso |

**Ruta de Instalación**: Configurar en `~/.claude/settings.json`

**Uso**: Configurado en settings, ejecutado automáticamente

**Tipos de Hooks** (4 tipos, 25 eventos):
- Tool Hooks: PreToolUse, PostToolUse, PostToolUseFailure, PermissionRequest
- Session Hooks: SessionStart, SessionEnd, Stop, StopFailure, SubagentStart, SubagentStop
- Task Hooks: UserPromptSubmit, TaskCompleted, TaskCreated, TeammateIdle
- Lifecycle Hooks: ConfigChange, CwdChanged, FileChanged, PreCompact, PostCompact, WorktreeCreate, WorktreeRemove, Notification, InstructionsLoaded, Elicitation, ElicitationResult

---

## 07. Plugins (3 plugins completos, 40 archivos)

Colecciones empaquetadas de funcionalidades.

### PR Review Plugin (10 archivos)
```
pr-review/
├── .claude-plugin/
│   └── plugin.json                   # Manifiesto del plugin
├── commands/
│   ├── review-pr.md                  # Revisión completa
│   ├── check-security.md             # Verificación de seguridad
│   └── check-tests.md                # Verificación de cobertura de pruebas
├── agents/
│   ├── security-reviewer.md          # Especialista en seguridad
│   ├── test-checker.md               # Especialista en pruebas
│   └── performance-analyzer.md       # Especialista en rendimiento
├── mcp/
│   └── github-config.json            # Integración de GitHub
├── hooks/
│   └── pre-review.js                 # Validación previa a la revisión
└── README.md                         # Documentación del plugin
```

**Funcionalidades**: Análisis de seguridad, cobertura de pruebas, impacto en el rendimiento

**Commands**: `/review-pr`, `/check-security`, `/check-tests`

**Instalación**: `/plugin install pr-review`

---

### DevOps Automation Plugin (15 archivos)
```
devops-automation/
├── .claude-plugin/
│   └── plugin.json                   # Manifiesto del plugin
├── commands/
│   ├── deploy.md                     # Despliegue
│   ├── rollback.md                   # Rollback
│   ├── status.md                     # Estado del sistema
│   └── incident.md                   # Respuesta a incidentes
├── agents/
│   ├── deployment-specialist.md      # Experto en despliegue
│   ├── incident-commander.md         # Coordinador de incidentes
│   └── alert-analyzer.md             # Analizador de alertas
├── mcp/
│   └── kubernetes-config.json        # Integración de Kubernetes
├── hooks/
│   ├── pre-deploy.js                 # Verificaciones previas al despliegue
│   └── post-deploy.js                # Tareas posteriores al despliegue
├── scripts/
│   ├── deploy.sh                     # Automatización de despliegue
│   ├── rollback.sh                   # Automatización de rollback
│   └── health-check.sh               # Verificaciones de salud
└── README.md                         # Documentación del plugin
```

**Funcionalidades**: Despliegue en Kubernetes, rollback, monitoreo, respuesta a incidentes

**Commands**: `/deploy`, `/rollback`, `/status`, `/incident`

**Instalación**: `/plugin install devops-automation`

---

### Documentation Plugin (14 archivos)
```
documentation/
├── .claude-plugin/
│   └── plugin.json                   # Manifiesto del plugin
├── commands/
│   ├── generate-api-docs.md          # Generación de docs de API
│   ├── generate-readme.md            # Creación de README
│   ├── sync-docs.md                  # Sincronización de docs
│   └── validate-docs.md              # Validación de docs
├── agents/
│   ├── api-documenter.md             # Especialista en docs de API
│   ├── code-commentator.md           # Especialista en comentarios de código
│   └── example-generator.md          # Creador de ejemplos
├── mcp/
│   └── github-docs-config.json       # Integración de GitHub
├── templates/
│   ├── api-endpoint.md               # Plantilla de endpoint de API
│   ├── function-docs.md              # Plantilla de docs de función
│   └── adr-template.md               # Plantilla de ADR
└── README.md                         # Documentación del plugin
```

**Funcionalidades**: Docs de API, generación de README, sincronización de docs, validación

**Commands**: `/generate-api-docs`, `/generate-readme`, `/sync-docs`, `/validate-docs`

**Instalación**: `/plugin install documentation`

**Además**: `README.md` - Visión general y guía de uso de Plugins

---

## 08. Checkpoints and Rewind (2 archivos)

Guardar estado de la conversación y explorar enfoques alternativos.

| Archivo | Descripción | Contenido |
|------|-------------|---------|
| `README.md` | Documentación | Guía completa de checkpoints |
| `checkpoint-examples.md` | Ejemplos del mundo real | Migración de base de datos, optimización de rendimiento, iteración de UI, depuración |
| | | |

**Conceptos Clave**:
- **Checkpoint**: Instantánea del estado de la conversación
- **Rewind**: Volver a un checkpoint anterior
- **Branch Point**: Explorar múltiples enfoques

**Uso**:
```
# Los checkpoints se crean automáticamente con cada prompt del usuario
# Para rewinding, presiona Esc dos veces o usa:
/rewind
# Luego elige: Restaurar código y conversación, Restaurar conversación,
# Restaurar código, Resumir desde aquí, o No importa
```

**Casos de Uso**:
- Probar diferentes implementaciones
- Recuperarse de errores
- Experimentación segura
- Comparar soluciones
- Pruebas A/B

---

## 09. Advanced Features (3 archivos)

Capacidades avanzadas para flujos de trabajo complejos.

| Archivo | Descripción | Funcionalidades |
|------|-------------|----------|
| `README.md` | Guía completa | Documentación de todas las funcionalidades avanzadas |
| `config-examples.json` | Ejemplos de configuración | 10+ configuraciones específicas para casos de uso |
| `planning-mode-examples.md` | Ejemplos de Planning | API REST, migración de base de datos, refactorización |
| Tareas Programadas | Tareas recurrentes con `/loop` y herramientas cron | Flujos de trabajo recurrentes automatizados |
| Integración con Chrome | Automatización del navegador vía Chromium headless | Pruebas web y scraping |
| Control Remoto (expandido) | Métodos de conexión, seguridad, tabla comparativa | Gestión de sesiones remotas |
| Personalización de Teclado | Atajos de teclado personalizados, soporte de acordes, contextos | Atajos personalizados |
| Aplicación de Escritorio (expandida) | Conectores, launch.json, funcionalidades empresariales | Integración con escritorio |
| | | |

**Funcionalidades Avanzadas Cubiertas**:

### Planning Mode
- Crear planes de implementación detallados
- Estimaciones de tiempo y evaluación de riesgos
- Desglose sistemático de tareas

### Extended Thinking
- Razonamiento profundo para problemas complejos
- Análisis de decisiones arquitectónicas
- Evaluación de compensaciones

### Background Tasks
- Operaciones de larga duración sin bloqueo
- Flujos de trabajo de desarrollo en paralelo
- Gestión y monitoreo de tareas

### Permission Modes
- **default**: Preguntar aprobación en acciones riesgosas
- **acceptEdits**: Auto-aceptar ediciones de archivos, preguntar por otros
- **plan**: Análisis de solo lectura, sin modificaciones
- **auto**: Aprobar automáticamente acciones seguras, preguntar por riesgosas
- **dontAsk**: Aceptar todas las acciones excepto las riesgosas
- **bypassPermissions**: Aceptar todo (requiere `--dangerously-skip-permissions`)

### Headless Mode (`claude -p`)
- Integración CI/CD
- Ejecución automatizada de tareas
- Procesamiento por lotes

### Session Management
- Múltiples sesiones de trabajo
- Cambio y guardado de sesiones
- Persistencia de sesiones

### Funcionalidades Interactivas
- Atajos de teclado
- Historial de comandos
- Autocompletado con Tab
- Entrada multilínea

### Configuration
- Gestión completa de configuración
- Configuraciones específicas por entorno
- Personalización por proyecto

### Scheduled Tasks
- Tareas recurrentes con el comando `/loop`
- Herramientas Cron: CronCreate, CronList, CronDelete
- Flujos de trabajo recurrentes automatizados

### Chrome Integration
- Automatización del navegador vía Chromium headless
- Capacidades de pruebas web y scraping
- Interacción con páginas y extracción de datos

### Remote Control (expandido)
- Métodos y protocolos de conexión
- Consideraciones de seguridad y mejores prácticas
- Tabla comparativa de opciones de acceso remoto

### Keyboard Customization
- Configuración de atajos de teclado personalizados
- Soporte de acordes para atajos de múltiples teclas
- Activación de atajos consciente del contexto

### Desktop App (expandida)
- Conectores para integración con IDE
- Configuración de launch.json
- Funcionalidades empresariales y despliegue

---

## 10. CLI Usage (1 archivo)

Patrones de uso y referencia de la interfaz de línea de comandos.

| Archivo | Descripción | Contenido |
|------|-------------|---------|
| `README.md` | Documentación de CLI | Banderas, opciones y patrones de uso |

**Funcionalidades Clave de CLI**:
- `claude` - Iniciar sesión interactiva
- `claude -p "prompt"` - Modo headless/no interactivo
- `claude web` - Lanzar sesión web
- `claude --model` - Seleccionar modelo (Sonnet 4.6, Opus 4.6)
- `claude --permission-mode` - Establecer modo de permisos
- `claude --remote` - Habilitar control remoto vía WebSocket

---

## Archivos de Documentación (13 archivos)

| Archivo | Ubicación | Descripción |
|------|----------|-------------|
| `README.md` | `/` | Visión general principal de ejemplos |
| `INDEX.md` | `/` | Este índice completo |
| `QUICK_REFERENCE.md` | `/` | Tarjeta de referencia rápida |
| `README.md` | `/01-slash-commands/` | Guía de Slash Commands |
| `README.md` | `/02-memory/` | Guía de Memory |
| `README.md` | `/03-skills/` | Guía de Skills |
| `README.md` | `/04-subagents/` | Guía de Subagents |
| `README.md` | `/05-mcp/` | Guía de MCP |
| `README.md` | `/06-hooks/` | Guía de Hooks |
| `README.md` | `/07-plugins/` | Guía de Plugins |
| `README.md` | `/08-checkpoints/` | Guía de Checkpoints |
| `README.md` | `/09-advanced-features/` | Guía de funcionalidades avanzadas |
| `README.md` | `/10-cli/` | Guía de CLI |

---

## Árbol de Archivos Completo

```
claude-howto/
├── README.md                                    # Visión general principal
├── INDEX.md                                     # Este archivo
├── QUICK_REFERENCE.md                           # Tarjeta de referencia rápida
├── claude_concepts_guide.md                     # Guía original
│
├── 01-slash-commands/                           # Slash Commands
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   ├── commit.md
│   ├── setup-ci-cd.md
│   ├── push-all.md
│   ├── unit-test-expand.md
│   ├── doc-refactor.md
│   ├── pr-slash-command.png
│   └── README.md
│
├── 02-memory/                                   # Memory
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   ├── memory-saved.png
│   ├── memory-ask-claude.png
│   └── README.md
│
├── 03-skills/                                   # Skills
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-metrics.py
│   │   │   └── compare-complexity.py
│   │   └── templates/
│   │       ├── review-checklist.md
│   │       └── finding-template.md
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   ├── templates/
│   │   │   ├── email-template.txt
│   │   │   └── social-post-template.txt
│   │   └── tone-examples.md
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   ├── refactor/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-complexity.py
│   │   │   └── detect-smells.py
│   │   ├── references/
│   │   │   ├── code-smells.md
│   │   │   └── refactoring-catalog.md
│   │   └── templates/
│   │       └── refactoring-plan.md
│   ├── claude-md/
│   │   └── SKILL.md
│   ├── blog-draft/
│   │   ├── SKILL.md
│   │   └── templates/
│   │       ├── draft-template.md
│   │       └── outline-template.md
│   └── README.md
│
├── 04-subagents/                                # Subagents
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   ├── debugger.md
│   ├── data-scientist.md
│   ├── clean-code-reviewer.md
│   └── README.md
│
├── 05-mcp/                                      # MCP Protocol
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
│
├── 06-hooks/                                    # Hooks
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   ├── context-tracker.py
│   ├── context-tracker-tiktoken.py
│   └── README.md
│
├── 07-plugins/                                  # Plugins
│   ├── pr-review/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── review-pr.md
│   │   │   ├── check-security.md
│   │   │   └── check-tests.md
│   │   ├── agents/
│   │   │   ├── security-reviewer.md
│   │   │   ├── test-checker.md
│   │   │   └── performance-analyzer.md
│   │   ├── mcp/
│   │   │   └── github-config.json
│   │   ├── hooks/
│   │   │   └── pre-review.js
│   │   └── README.md
│   ├── devops-automation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── deploy.md
│   │   │   ├── rollback.md
│   │   │   ├── status.md
│   │   │   └── incident.md
│   │   ├── agents/
│   │   │   ├── deployment-specialist.md
│   │   │   ├── incident-commander.md
│   │   │   └── alert-analyzer.md
│   │   ├── mcp/
│   │   │   └── kubernetes-config.json
│   │   ├── hooks/
│   │   │   ├── pre-deploy.js
│   │   │   └── post-deploy.js
│   │   ├── scripts/
│   │   │   ├── deploy.sh
│   │   │   ├── rollback.sh
│   │   │   └── health-check.sh
│   │   └── README.md
│   ├── documentation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── generate-api-docs.md
│   │   │   ├── generate-readme.md
│   │   │   ├── sync-docs.md
│   │   │   └── validate-docs.md
│   │   ├── agents/
│   │   │   ├── api-documenter.md
│   │   │   ├── code-commentator.md
│   │   │   └── example-generator.md
│   │   ├── mcp/
│   │   │   └── github-docs-config.json
│   │   ├── templates/
│   │   │   ├── api-endpoint.md
│   │   │   ├── function-docs.md
│   │   │   └── adr-template.md
│   │   └── README.md
│   └── README.md
│
├── 08-checkpoints/                              # Checkpoints
│   ├── checkpoint-examples.md
│   └── README.md
│
├── 09-advanced-features/                        # Advanced Features
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
│
└── 10-cli/                                      # CLI Usage
    └── README.md
```

---

## Inicio Rápido por Caso de Uso

### Calidad de Código y Revisiones
```bash
# Instalar slash command
cp 01-slash-commands/optimize.md .claude/commands/

# Instalar subagent
cp 04-subagents/code-reviewer.md .claude/agents/

# Instalar skill
cp -r 03-skills/code-review ~/.claude/skills/

# O instalar plugin completo
/plugin install pr-review
```

### DevOps y Despliegue
```bash
# Instalar plugin (incluye todo)
/plugin install devops-automation
```

### Documentación
```bash
# Instalar slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# Instalar subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# Instalar skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# O instalar plugin completo
/plugin install documentation
```

### Estándares del Equipo
```bash
# Configurar memoria del proyecto
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Editar para coincidir con los estándares de tu equipo
```

### Integraciones Externas
```bash
# Establecer variables de entorno
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# Instalar configuración MCP (alcance del proyecto)
cp 05-mcp/multi-mcp.json .mcp.json
```

### Automatización y Validación
```bash
# Instalar hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Configurar hooks en settings (~/.claude/settings.json)
# Ver 06-hooks/README.md
```

### Experimentación Segura
```bash
# Los checkpoints se crean automáticamente con cada prompt del usuario
# Para rewinding: presiona Esc+Esc o usa /rewind
# Luego elige qué restaurar desde el menú de rewind

# Ver 08-checkpoints/README.md para ejemplos
```

### Flujos de Trabajo Avanzados
```bash
# Configurar funcionalidades avanzadas
# Ver 09-advanced-features/config-examples.json

# Usar planning mode
/plan Implementar funcionalidad X

# Usar permission modes
claude --permission-mode plan          # Para revisión de código (solo lectura)
claude --permission-mode acceptEdits   # Auto-aceptar ediciones
claude --permission-mode auto          # Auto-aprobar acciones seguras

# Ejecutar en headless mode para CI/CD
claude -p "Ejecutar pruebas y reportar resultados"

# Ejecutar tareas en segundo plano
Run tests in background

# Ver 09-advanced-features/README.md para guía completa
```

---

## Matriz de Cobertura de Funcionalidades

| Categoría | Commands | Agents | MCP | Hooks | Scripts | Templates | Docs | Imágenes | Total |
|----------|----------|--------|-----|-------|---------|-----------|------|--------|-------|
| **01 Slash Commands** | 8 | - | - | - | - | - | 1 | 1 | **10** |
| **02 Memory** | - | - | - | - | - | 3 | 1 | 2 | **6** |
| **03 Skills** | - | - | - | - | 5 | 9 | 1 | - | **28** |
| **04 Subagents** | - | 8 | - | - | - | - | 1 | - | **9** |
| **05 MCP** | - | - | 4 | - | - | - | 1 | - | **5** |
| **06 Hooks** | - | - | - | 8 | - | - | 1 | - | **9** |
| **07 Plugins** | 11 | 9 | 3 | 3 | 3 | 3 | 4 | - | **40** |
| **08 Checkpoints** | - | - | - | - | - | - | 1 | 1 | **2** |
| **09 Advanced** | - | - | - | - | - | - | 1 | 2 | **3** |
| **10 CLI** | - | - | - | - | - | - | 1 | - | **1** |

---

## Ruta de Aprendizaje

### Principiante (Semana 1)
1. ✅ Leer `README.md`
2. ✅ Instalar 1-2 slash commands
3. ✅ Crear archivo de memoria del proyecto
4. ✅ Probar comandos básicos

### Intermedio (Semana 2-3)
1. ✅ Configurar GitHub MCP
2. ✅ Instalar un subagent
3. ✅ Probar delegación de tareas
4. ✅ Instalar un skill

### Avanzado (Semana 4+)
1. ✅ Instalar plugin completo
2. ✅ Crear slash commands personalizados
3. ✅ Crear subagent personalizado
4. ✅ Crear skill personalizado
5. ✅ Construir tu propio plugin

### Experto (Semana 5+)
1. ✅ Configurar hooks para automatización
2. ✅ Usar checkpoints para experimentación
3. ✅ Configurar planning mode
4. ✅ Usar permission modes efectivamente
5. ✅ Configurar headless mode para CI/CD
6. ✅ Dominar session management

---

## Búsqueda por Palabra Clave

### Rendimiento
- `01-slash-commands/optimize.md` - Análisis de rendimiento
- `04-subagents/code-reviewer.md` - Revisión de rendimiento
- `03-skills/code-review/` - Métricas de rendimiento
- `07-plugins/pr-review/agents/performance-analyzer.md` - Especialista en rendimiento

### Seguridad
- `04-subagents/secure-reviewer.md` - Revisión de seguridad
- `03-skills/code-review/` - Análisis de seguridad
- `07-plugins/pr-review/commands/check-security.md` - Verificación de seguridad
- `06-hooks/security-scan.sh` - Escaneo de seguridad

### Pruebas
- `04-subagents/test-engineer.md` - Ingeniero de pruebas
- `07-plugins/pr-review/commands/check-tests.md` - Cobertura de pruebas

### Documentación
- `01-slash-commands/generate-api-docs.md` - Comando de docs de API
- `04-subagents/documentation-writer.md` - Agente escritor de docs
- `03-skills/doc-generator/` - Skill generador de docs
- `07-plugins/documentation/` - Plugin completo de docs

### Despliegue
- `07-plugins/devops-automation/` - Solución completa de DevOps

### Automatización
- `06-hooks/` - Automatización impulsada por eventos
- `06-hooks/pre-commit.sh` - Automatización pre-commit
- `06-hooks/format-code.sh` - Auto-formateo
- `09-advanced-features/` - Headless mode para CI/CD

### Validación
- `06-hooks/security-scan.sh` - Validación de seguridad
- `06-hooks/validate-prompt.sh` - Validación de prompts

### Experimentación
- `08-checkpoints/` - Experimentación segura con rewind
- `08-checkpoints/checkpoint-examples.md` - Ejemplos del mundo real

### Planning
- `09-advanced-features/planning-mode-examples.md` - Ejemplos de planning mode
- `09-advanced-features/README.md` - Extended thinking

### Configuration
- `09-advanced-features/config-examples.json` - Ejemplos de configuración

---

## Notas

- Todos los ejemplos están listos para usar
- Modificar para ajustarse a tus necesidades específicas
- Los ejemplos siguen las mejores prácticas de Claude Code
- Cada categoría tiene su propio README con instrucciones detalladas
- Los scripts incluyen manejo de errores apropiado
- Las plantillas son personalizables

---

## Contribuciones

¿Quieres agregar más ejemplos? Sigue la estructura:
1. Crear el subdirectorio apropiado
2. Incluir README.md con el uso
3. Seguir las convenciones de nomenclatura
4. Probar exhaustivamente
5. Actualizar este índice

---

**Última Actualización**: Marzo 2026
**Total de Ejemplos**: 100+ archivos
**Categorías**: 10 funcionalidades
**Hooks**: 8 scripts de automatización
**Ejemplos de Configuración**: 10+ escenarios
**Listo para Usar**: Todos los ejemplos
