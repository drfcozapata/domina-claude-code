<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Catálogo de Funcionalidades de Claude Code

> Guía de referencia rápida para todas las funcionalidades de Claude Code: commands, agents, skills, plugins y hooks.

**Navegación**: [Commands](#slash-commands) | [Permission Modes](#permission-modes) | [Subagents](#subagents) | [Skills](#skills) | [Plugins](#plugins) | [MCP Servers](#mcp-servers) | [Hooks](#hooks) | [Memory](#memory-files) | [Nuevas Funcionalidades](#new-features-march-2026)

---

## Resumen

| Funcionalidad | Integradas | Ejemplos | Total | Referencia |
|---------|----------|----------|-------|-----------|
| **Slash Commands** | 55+ | 8 | 63+ | [01-slash-commands/](01-slash-commands/) |
| **Subagents** | 6 | 10 | 16 | [04-subagents/](04-subagents/) |
| **Skills** | 5 bundled | 4 | 9 | [03-skills/](03-skills/) |
| **Plugins** | - | 3 | 3 | [07-plugins/](07-plugins/) |
| **MCP Servers** | 1 | 8 | 9 | [05-mcp/](05-mcp/) |
| **Hooks** | 25 events | 7 | 7 | [06-hooks/](06-hooks/) |
| **Memory** | 7 types | 3 | 3 | [02-memory/](02-memory/) |
| **Total** | **99** | **43** | **117** | |

---

## Slash Commands (Comandos de Barra)

Los commands son atajos invocados por el usuario que ejecutan acciones específicas.

### Built-in Commands (Comandos Integrados)

| Command | Descripción | Cuándo Usar |
|---------|-------------|-------------|
| `/help` | Mostrar información de ayuda | Para comenzar, aprender commands |
| `/btw` | Pregunta secundaria sin agregar al contexto | Preguntas rápidas tangenciales |
| `/chrome` | Configurar integración con Chrome | Automatización del navegador |
| `/clear` | Limpiar historial de conversación | Empezar de nuevo, reducir contexto |
| `/diff` | Visor interactivo de diff | Revisar cambios |
| `/config` | Ver/editar configuración | Personalizar comportamiento |
| `/status` | Mostrar estado de la sesión | Verificar estado actual |
| `/agents` | Listar agents disponibles | Ver opciones de delegación |
| `/skills` | Listar skills disponibles | Ver capacidades de auto-invocación |
| `/hooks` | Listar hooks configurados | Depurar automatización |
| `/insights` | Analizar patrones de sesión | Optimización de sesión |
| `/install-slack-app` | Instalar app de Claude para Slack | Integración con Slack |
| `/keybindings` | Personalizar atajos de teclado | Personalización de teclas |
| `/mcp` | Listar MCP servers | Verificar integraciones externas |
| `/memory` | Ver archivos de memory cargados | Depurar carga de contexto |
| `/mobile` | Generar código QR para móvil | Acceso móvil |
| `/passes` | Ver usage passes | Información de suscripción |
| `/plugin` | Gestionar plugins | Instalar/eliminar extensiones |
| `/plan` | Entrar en planning mode | Implementaciones complejas |
| `/rewind` | Retroceder al checkpoint | Deshacer cambios, explorar alternativas |
| `/checkpoint` | Gestionar checkpoints | Guardar/restaurar estados |
| `/cost` | Mostrar costos de uso de tokens | Monitorear gasto |
| `/context` | Mostrar uso de ventana de contexto | Gestionar longitud de conversación |
| `/export` | Exportar conversación | Guardar para referencia |
| `/extra-usage` | Configurar límites de extra usage | Gestión de límites de tasa |
| `/feedback` | Enviar feedback o reporte de bug | Reportar problemas |
| `/login` | Autenticar con Anthropic | Acceder a funcionalidades |
| `/logout` | Cerrar sesión | Cambiar cuentas |
| `/sandbox` | Alternar modo sandbox | Ejecución segura de commands |
| `/vim` | Alternar modo vim | Edición estilo Vim |
| `/doctor` | Ejecutar diagnósticos | Solucionar problemas |
| `/reload-plugins` | Recargar plugins instalados | Gestión de plugins |
| `/release-notes` | Mostrar release notes | Verificar nuevas funcionalidades |
| `/remote-control` | Habilitar remote control | Acceso remoto |
| `/permissions` | Gestionar permissions | Controlar acceso |
| `/session` | Gestionar sesiones | Flujos de trabajo multi-sesión |
| `/rename` | Renombrar sesión actual | Organizar sesiones |
| `/resume` | Reanudar sesión anterior | Continuar trabajo |
| `/todo` | Ver/gestionar lista de todo | Seguir tareas |
| `/tasks` | Ver background tasks | Monitorear operaciones asíncronas |
| `/copy` | Copiar última respuesta al portapapeles | Compartir output rápidamente |
| `/teleport` | Transferir sesión a otra máquina | Continuar trabajo remotamente |
| `/desktop` | Abrir app Claude Desktop | Cambiar a interfaz de escritorio |
| `/theme` | Cambiar tema de color | Personalizar apariencia |
| `/usage` | Mostrar estadísticas de uso de API | Monitorear cuota y costos |
| `/fork` | Bifurcar conversación actual | Explorar alternativas |
| `/stats` | Mostrar estadísticas de sesión | Revisar métricas de sesión |
| `/statusline` | Configurar status line | Personalizar visualización de estado |
| `/stickers` | Ver session stickers | Recompensas divertidas |
| `/fast` | Alternar modo de output rápido | Acelerar respuestas |
| `/terminal-setup` | Configurar integración con terminal | Configurar funcionalidades de terminal |
| `/upgrade` | Verificar actualizaciones | Gestión de versiones |

### Custom Commands (Comandos Personalizados - Ejemplos)

| Command | Descripción | Cuándo Usar | Scope | Instalación |
|---------|-------------|-------------|-------|--------------|
| `/optimize` | Analizar código para optimización | Mejora de rendimiento | Project | `cp 01-slash-commands/optimize.md .claude/commands/` |
| `/pr` | Preparar pull request | Antes de enviar PRs | Project | `cp 01-slash-commands/pr.md .claude/commands/` |
| `/generate-api-docs` | Generar documentación de API | Documentar APIs | Project | `cp 01-slash-commands/generate-api-docs.md .claude/commands/` |
| `/commit` | Crear git commit con contexto | Confirmar cambios | User | `cp 01-slash-commands/commit.md .claude/commands/` |
| `/push-all` | Stage, commit y push | Despliegue rápido | User | `cp 01-slash-commands/push-all.md .claude/commands/` |
| `/doc-refactor` | Reestructurar documentación | Mejorar docs | Project | `cp 01-slash-commands/doc-refactor.md .claude/commands/` |
| `/setup-ci-cd` | Configurar pipeline CI/CD | Nuevos proyectos | Project | `cp 01-slash-commands/setup-ci-cd.md .claude/commands/` |
| `/unit-test-expand` | Expandir cobertura de tests | Mejorar testing | Project | `cp 01-slash-commands/unit-test-expand.md .claude/commands/` |

> **Scope**: `User` = flujos de trabajo personales (`~/.claude/commands/`), `Project` = compartido con el equipo (`.claude/commands/`)

**Referencia**: [01-slash-commands/](01-slash-commands/) | [Documentación Oficial](https://code.claude.com/docs/en/interactive-mode)

**Instalación Rápida (Todos los Custom Commands)**:
```bash
cp 01-slash-commands/*.md .claude/commands/
```

---

## Permission Modes (Modos de Permiso)

Claude Code soporta 6 permission modes que controlan cómo se autoriza el uso de tools.

| Mode | Descripción | Cuándo Usar |
|------|-------------|-------------|
| `default` | Prompt para cada tool call | Uso interactivo estándar |
| `acceptEdits` | Auto-aceptar edits de archivos, prompt para otros | Flujos de edición de confianza |
| `plan` | Solo tools de lectura, sin escritura | Planificación y exploración |
| `auto` | Aceptar todos los tools sin prompt | Operación totalmente autónoma (Research Preview) |
| `bypassPermissions` | Omitir todos los checks de permission | CI/CD, entornos headless |
| `dontAsk` | Omitir tools que requerirían permission | Scripting no interactivo |

> **Nota**: `auto` mode es una funcionalidad de Research Preview (marzo 2026). Usar `bypassPermissions` solo en entornos confiables y sandboxed.

**Referencia**: [Documentación Oficial](https://code.claude.com/docs/en/permissions)

---

## Subagents (Subagentes)

Asistentes de IA especializados con contextos aislados para tareas específicas.

### Built-in Subagents (Subagentes Integrados)

| Agent | Descripción | Tools | Model | Cuándo Usar |
|-------|-------------|-------|-------|-------------|
| **general-purpose** | Tareas multi-step, investigación | All tools | Inherits model | Investigación compleja, tareas multi-archivo |
| **Plan** | Planificación de implementación | Read, Glob, Grep, Bash | Inherits model | Diseño de arquitectura, planificación |
| **Explore** | Exploración de codebase | Read, Glob, Grep | Haiku 4.5 | Búsquedas rápidas, entender código |
| **Bash** | Ejecución de commands | Bash | Inherits model | Operaciones de Git, tareas de terminal |
| **statusline-setup** | Configuración de status line | Bash, Read, Write | Sonnet 4.6 | Configurar visualización de status line |
| **Claude Code Guide** | Ayuda y documentación | Read, Glob, Grep | Haiku 4.5 | Obtener ayuda, aprender funcionalidades |

### Subagent Configuration Fields (Campos de Configuración de Subagents)

| Field | Tipo | Descripción |
|-------|------|-------------|
| `name` | string | Identificador del agent |
| `description` | string | Qué hace el agent |
| `model` | string | Override de model (ej: `haiku-4.5`) |
| `tools` | array | Lista de tools permitidos |
| `effort` | string | Nivel de reasoning effort (`low`, `medium`, `high`) |
| `initialPrompt` | string | System prompt inyectado al inicio del agent |
| `disallowedTools` | array | Tools explícitamente denegados a este agent |

### Custom Subagents (Subagentes Personalizados - Ejemplos)

| Agent | Descripción | Cuándo Usar | Scope | Instalación |
|-------|-------------|-------------|-------|--------------|
| `code-reviewer` | Calidad de código comprehensiva | Sesiones de code review | Project | `cp 04-subagents/code-reviewer.md .claude/agents/` |
| `code-architect` | Diseño de arquitectura de features | Planificación de nuevos features | Project | `cp 04-subagents/code-architect.md .claude/agents/` |
| `code-explorer` | Análisis profundo de codebase | Entender features existentes | Project | `cp 04-subagents/code-explorer.md .claude/agents/` |
| `clean-code-reviewer` | Revisión de principios Clean Code | Revisión de mantenibilidad | Project | `cp 04-subagents/clean-code-reviewer.md .claude/agents/` |
| `test-engineer` | Estrategia y cobertura de tests | Planificación de tests | Project | `cp 04-subagents/test-engineer.md .claude/agents/` |
| `documentation-writer` | Documentación técnica | Docs de API, guías | Project | `cp 04-subagents/documentation-writer.md .claude/agents/` |
| `secure-reviewer` | Revisión enfocada en seguridad | Auditorías de seguridad | Project | `cp 04-subagents/secure-reviewer.md .claude/agents/` |
| `implementation-agent` | Implementación completa de features | Desarrollo de features | Project | `cp 04-subagents/implementation-agent.md .claude/agents/` |
| `debugger` | Análisis de causa raíz | Investigación de bugs | User | `cp 04-subagents/debugger.md .claude/agents/` |
| `data-scientist` | Queries SQL, análisis de datos | Tareas de datos | User | `cp 04-subagents/data-scientist.md .claude/agents/` |

> **Scope**: `User` = personal (`~/.claude/agents/`), `Project` = compartido con el equipo (`.claude/agents/`)

**Referencia**: [04-subagents/](04-subagents/) | [Documentación Oficial](https://code.claude.com/docs/en/sub-agents)

**Instalación Rápida (Todos los Custom Agents)**:
```bash
cp 04-subagents/*.md .claude/agents/
```

---

## Skills (Habilidades)

Capacidades auto-invocadas con instructions, scripts y templates.

### Example Skills (Ejemplos de Skills)

| Skill | Descripción | Cuándo Auto-Invoked | Scope | Instalación |
|-------|-------------|-------------------|-------|--------------|
| `code-review` | Revisión de código comprehensiva | "Review this code", "Check quality" | Project | `cp -r 03-skills/code-review .claude/skills/` |
| `brand-voice` | Verificador de consistencia de marca | Escribir copy de marketing | Project | `cp -r 03-skills/brand-voice .claude/skills/` |
| `doc-generator` | Generador de documentación de API | "Generate docs", "Document API" | Project | `cp -r 03-skills/doc-generator .claude/skills/` |
| `refactor` | Refactorización sistemática de código (Martin Fowler) | "Refactor this", "Clean up code" | User | `cp -r 03-skills/refactor ~/.claude/skills/` |

> **Scope**: `User` = personal (`~/.claude/skills/`), `Project` = compartido con el equipo (`.claude/skills/`)

### Skill Structure (Estructura de Skill)

```
~/.claude/skills/skill-name/
├── SKILL.md          # Definición e instrucciones del skill
├── scripts/          # Scripts auxiliares
└── templates/        # Templates de output
```

### Skill Frontmatter Fields (Campos de Frontmatter de Skills)

Skills soporta YAML frontmatter en `SKILL.md` para configuración:

| Field | Tipo | Descripción |
|-------|------|-------------|
| `name` | string | Nombre para mostrar del skill |
| `description` | string | Qué hace el skill |
| `autoInvoke` | array | Frases trigger para auto-invocación |
| `effort` | string | Nivel de reasoning effort (`low`, `medium`, `high`) |
| `shell` | string | Shell a usar para scripts (`bash`, `zsh`, `sh`) |

**Referencia**: [03-skills/](03-skills/) | [Documentación Oficial](https://code.claude.com/docs/en/skills)

**Instalación Rápida (Todos los Skills)**:
```bash
cp -r 03-skills/* ~/.claude/skills/
```

### Bundled Skills (Skills Incluidos)

| Skill | Descripción | Cuándo Auto-Invoked |
|-------|-------------|-------------------|
| `/simplify` | Revisar código para calidad | Después de escribir código |
| `/batch` | Ejecutar prompts en múltiples archivos | Operaciones por lotes |
| `/debug` | Depurar tests/errors fallidos | Sesiones de debugging |
| `/loop` | Ejecutar prompts en intervalo | Tareas recurrentes |
| `/claude-api` | Construir apps con Claude API | Desarrollo de API |

---

## Plugins

Colecciones bundled de commands, agents, MCP servers y hooks.

### Example Plugins (Ejemplos de Plugins)

| Plugin | Descripción | Components | Cuándo Usar | Scope | Instalación |
|--------|-------------|------------|-------------|-------|--------------|
| `pr-review` | Flujo de trabajo de PR review | 3 commands, 3 agents, GitHub MCP | Code reviews | Project | `/plugin install pr-review` |
| `devops-automation` | Despliegue y monitoreo | 4 commands, 3 agents, K8s MCP | Tareas de DevOps | Project | `/plugin install devops-automation` |
| `documentation` | Suite de generación de docs | 4 commands, 3 agents, templates | Documentación | Project | `/plugin install documentation` |

> **Scope**: `Project` = compartido con el equipo, `User` = flujos de trabajo personales

### Plugin Structure (Estructura de Plugin)

```
.claude-plugin/
├── plugin.json       # Archivo de manifiesto
├── commands/         # Slash commands
├── agents/           # Subagents
├── skills/           # Skills
├── mcp/              # Configuraciones MCP
├── hooks/            # Hook scripts
└── scripts/          # Scripts de utilidad
```

**Referencia**: [07-plugins/](07-plugins/) | [Documentación Oficial](https://code.claude.com/docs/en/plugins)

**Commandos de Gestión de Plugins**:
```bash
/plugin list              # Listar plugins instalados
/plugin install <name>    # Instalar plugin
/plugin remove <name>     # Eliminar plugin
/plugin update <name>     # Actualizar plugin
```

---

## MCP Servers (Servidores MCP)

Model Context Protocol servers para acceso a tools y APIs externas.

### Common MCP Servers (Servidores MCP Comunes)

| Server | Descripción | Cuándo Usar | Scope | Instalación |
|--------|-------------|-------------|-------|--------------|
| **GitHub** | Gestión de PR, issues, código | Flujos de trabajo de GitHub | Project | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| **Database** | Queries SQL, acceso a datos | Operaciones de base de datos | Project | `claude mcp add db -- npx -y @modelcontextprotocol/server-postgres` |
| **Filesystem** | Operaciones avanzadas de archivos | Tareas complejas de archivos | User | `claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem` |
| **Slack** | Comunicación de equipo | Notificaciones, actualizaciones | Project | Configurar en settings |
| **Google Docs** | Acceso a documentos | Edición, revisión de docs | Project | Configurar en settings |
| **Asana** | Gestión de proyectos | Seguimiento de tareas | Project | Configurar en settings |
| **Stripe** | Datos de pagos | Análisis financiero | Project | Configurar en settings |
| **Memory** | Memoria persistente | Recall entre sesiones | User | Configurar en settings |
| **Context7** | Documentación de librerías | Búsqueda de docs actualizadas | Built-in | Built-in |

> **Scope**: `Project` = equipo (`.mcp.json`), `User` = personal (`~/.claude.json`), `Built-in` = pre-instalado

### MCP Configuration Example (Ejemplo de Configuración MCP)

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Referencia**: [05-mcp/](05-mcp/) | [Documentación del Protocolo MCP](https://modelcontextprotocol.io)

**Instalación Rápida (GitHub MCP)**:
```bash
export GITHUB_TOKEN="your_token" && claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## Hooks

Automatización event-driven que ejecuta shell commands en eventos de Claude Code.

### Hook Events (Eventos de Hook)

| Event | Descripción | Cuándo Triggered | Use Cases |
|-------|-------------|----------------|-----------|
| `SessionStart` | Sesión comienza/reanuda | Inicialización de sesión | Tareas de setup |
| `InstructionsLoaded` | Instructions cargadas | CLAUDE.md o archivo de reglas cargado | Manejo de custom instructions |
| `UserPromptSubmit` | Antes del procesamiento del prompt | Usuario envía mensaje | Validación de input |
| `PreToolUse` | Antes de la ejecución del tool | Antes de que cualquier tool se ejecute | Validación, logging |
| `PermissionRequest` | Permission dialog mostrado | Antes de acciones sensibles | Flujos de aprobación custom |
| `PostToolUse` | Después de que el tool tiene éxito | Después de que cualquier tool completa | Formateo, notificaciones |
| `PostToolUseFailure` | Ejecución del tool falla | Después de error del tool | Manejo de errores, logging |
| `Notification` | Notificación enviada | Claude envía notificación | Alertas externas |
| `SubagentStart` | Subagent spawned | Inicio de tarea de subagent | Inicializar contexto de subagent |
| `SubagentStop` | Subagent finaliza | Tarea de subagent completa | Encadenar acciones |
| `Stop` | Claude finaliza la respuesta | Respuesta completa | Limpieza, reporting |
| `StopFailure` | Error de API termina el turno | Ocurre error de API | Recuperación de errores, logging |
| `TeammateIdle` | Teammate agent inactivo | Coordinación de equipo de agents | Distribuir trabajo |
| `TaskCompleted` | Tarea marcada como completa | Tarea hecha | Procesamiento post-tarea |
| `TaskCreated` | Tarea creada vía TaskCreate | Nueva tarea creada | Seguimiento de tareas, logging |
| `ConfigChange` | Configuración actualizada | Settings modificados | Reaccionar a cambios de config |
| `CwdChanged` | Directorio de trabajo cambia | Directorio cambiado | Setup específico de directorio |
| `FileChanged` | Archivo vigilado cambia | Archivo modificado | Monitoreo de archivos, rebuild |
| `PreCompact` | Antes de operación de compact | Compresión de contexto | Preservación de estado |
| `PostCompact` | Después de que la compactación completa | Compactación hecha | Acciones post-compact |
| `WorktreeCreate` | Worktree siendo creado | Git worktree creado | Configurar entorno de worktree |
| `WorktreeRemove` | Worktree siendo eliminado | Git worktree eliminado | Limpieza de recursos de worktree |
| `Elicitation` | MCP server solicita input | MCP elicitation | Validación de input |
| `ElicitationResult` | Usuario responde a elicitation | Usuario responde | Procesamiento de respuesta |
| `SessionEnd` | Sesión termina | Terminación de sesión | Limpieza, guardar estado |

### Example Hooks (Ejemplos de Hooks)

| Hook | Descripción | Event | Scope | Instalación |
|------|-------------|-------|-------|--------------|
| `validate-bash.py` | Validación de commands | PreToolUse:Bash | Project | `cp 06-hooks/validate-bash.py .claude/hooks/` |
| `security-scan.py` | Escaneo de seguridad | PostToolUse:Write | Project | `cp 06-hooks/security-scan.py .claude/hooks/` |
| `format-code.sh` | Auto-formateo | PostToolUse:Write | User | `cp 06-hooks/format-code.sh ~/.claude/hooks/` |
| `validate-prompt.py` | Validación de prompt | UserPromptSubmit | Project | `cp 06-hooks/validate-prompt.py .claude/hooks/` |
| `context-tracker.py` | Seguimiento de uso de tokens | Stop | User | `cp 06-hooks/context-tracker.py ~/.claude/hooks/` |
| `pre-commit.sh` | Validación pre-commit | PreToolUse:Bash | Project | `cp 06-hooks/pre-commit.sh .claude/hooks/` |
| `log-bash.sh` | Logging de commands | PostToolUse:Bash | User | `cp 06-hooks/log-bash.sh ~/.claude/hooks/` |

> **Scope**: `Project` = equipo (`.claude/settings.json`), `User` = personal (`~/.claude/settings.json`)

### Hook Configuration (Configuración de Hooks)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "~/.claude/hooks/validate-bash.py"
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "~/.claude/hooks/format-code.sh"
      }
    ]
  }
}
```

**Referencia**: [06-hooks/](06-hooks/) | [Documentación Oficial](https://code.claude.com/docs/en/hooks)

**Instalación Rápida (Todos los Hooks)**:
```bash
mkdir -p ~/.claude/hooks && cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh
```

---

## Memory Files (Archivos de Memoria)

Contexto persistente cargado automáticamente entre sesiones.

### Memory Types (Tipos de Memory)

| Type | Ubicación | Scope | Cuándo Usar |
|------|----------|-------|-------------|
| **Managed Policy** | Políticas gestionadas por org | Organization | Aplicar estándares de org |
| **Project** | `./CLAUDE.md` | Project (equipo) | Estándares de equipo, contexto de proyecto |
| **Project Rules** | `.claude/rules/` | Project (equipo) | Reglas de proyecto modulares |
| **User** | `~/.claude/CLAUDE.md` | User (personal) | Preferencias personales |
| **User Rules** | `~/.claude/rules/` | User (personal) | Reglas personales modulares |
| **Local** | `./CLAUDE.local.md` | Local (git-ignored) | Overrides específicos de máquina (no en documentación oficial desde marzo 2026; puede ser legacy) |
| **Auto Memory** | Automático | Session | Insights y correcciones auto-capturadas |

> **Scope**: `Organization` = gestionado por admins, `Project` = compartido con equipo vía git, `User` = preferencias personales, `Local` = no commiteado, `Session` = auto-gestionado

**Referencia**: [02-memory/](02-memory/) | [Documentación Oficial](https://code.claude.com/docs/en/memory)

**Instalación Rápida**:
```bash
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

---

## New Features (Nuevas Funcionalidades - Marzo 2026)

| Feature | Descripción | Cómo Usar |
|---------|-------------|------------|
| **Remote Control** | Controlar sesiones de Claude Code remotamente vía API | Usar la API de remote control para enviar prompts y recibir responses programáticamente |
| **Web Sessions** | Ejecutar Claude Code en un entorno basado en navegador | Acceder vía `claude web` o a través de Anthropic Console |
| **Desktop App** | Aplicación de escritorio nativa para Claude Code | Usar `/desktop` o descargar desde el sitio web de Anthropic |
| **Agent Teams** | Coordinar múltiples agents trabajando en tareas relacionadas | Configurar teammate agents que colaboran y comparten contexto |
| **Task List** | Gestión y monitoreo de background tasks | Usar `/tasks` para ver y gestionar operaciones en background |
| **Prompt Suggestions** | Sugerencias de commands context-aware | Las sugerencias aparecen automáticamente según el contexto actual |
| **Git Worktrees** | Git worktrees aislados para desarrollo paralelo | Usar commands de worktree para trabajo seguro en ramas paralelas |
| **Sandboxing** | Entornos de ejecución aislados para seguridad | Usar `/sandbox` para alternar; ejecuta commands en entornos restringidos |
| **MCP OAuth** | Autenticación OAuth para MCP servers | Configurar credenciales OAuth en settings de MCP server para acceso seguro |
| **MCP Tool Search** | Buscar y descubrir MCP tools dinámicamente | Usar búsqueda de tools para encontrar MCP tools disponibles en servidores conectados |
| **Scheduled Tasks** | Configurar tareas recurrentes con `/loop` y herramientas cron | Usar `/loop 5m /command` o herramienta CronCreate |
| **Chrome Integration** | Automatización de navegador con Chromium headless | Usar flag `--chrome` o command `/chrome` |
| **Keyboard Customization** | Personalizar keybindings incluyendo soporte de chord | Usar `/keybindings` o editar `~/.claude/keybindings.json` |
| **Auto Mode** | Operación totalmente autónoma sin prompts de permission (Research Preview) | Usar `--mode auto` o `/permissions auto`; marzo 2026 |
| **Channels** | Comunicación multi-canal (Telegram, Slack, etc.) (Research Preview) | Configurar plugins de canal; marzo 2026 |
| **Voice Dictation** | Input de voz para prompts | Usar ícono de micrófono o keybinding de voz |
| **Agent Hook Type** | Hooks que spawn un subagent en lugar de ejecutar un shell command | Establecer `"type": "agent"` en configuración de hook |
| **Prompt Hook Type** | Hooks que inyectan texto de prompt en la conversación | Establecer `"type": "prompt"` en configuración de hook |
| **MCP Elicitation** | MCP servers pueden solicitar input del usuario durante la ejecución del tool | Manejar vía eventos de hook `Elicitation` y `ElicitationResult` |
| **WebSocket MCP Transport** | Transporte basado en WebSocket para conexiones de MCP server | Usar `"transport": "websocket"` en configuración de MCP server |
| **Plugin LSP Support** | Integración de Language Server Protocol vía plugins | Configurar LSP servers en `plugin.json` para funcionalidades de editor |
| **Managed Drop-ins** | Configuraciones drop-in gestionadas por organización (v2.1.83) | Configurado por admin vía managed policies; auto-aplicado a todos los usuarios |

---

## Quick Reference Matrix (Matriz de Referencia Rápida)

### Feature Selection Guide (Guía de Selección de Funcionalidades)

| Necesidad | Funcionalidad Recomendada | Por Qué |
|------|---------------------|-----|
| Atajo rápido | Slash Command | Manual, inmediato |
| Contexto persistente | Memory | Auto-loaded |
| Automatización compleja | Skill | Auto-invoked |
| Tarea especializada | Subagent | Contexto aislado |
| Datos externos | MCP Server | Acceso en tiempo real |
| Automatización por eventos | Hook | Event-triggered |
| Solución completa | Plugin | Bundle todo-en-uno |

### Installation Priority (Prioridad de Instalación)

| Prioridad | Funcionalidad | Command |
|----------|---------|---------|
| 1. Esencial | Memory | `cp 02-memory/project-CLAUDE.md ./CLAUDE.md` |
| 2. Uso Diario | Slash Commands | `cp 01-slash-commands/*.md .claude/commands/` |
| 3. Calidad | Subagents | `cp 04-subagents/*.md .claude/agents/` |
| 4. Automatización | Hooks | `cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh` |
| 5. Externo | MCP | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| 6. Avanzado | Skills | `cp -r 03-skills/* ~/.claude/skills/` |
| 7. Completo | Plugins | `/plugin install pr-review` |

---

## Complete One-Command Installation (Instalación Completa en Un Commando)

Instalar todas las funcionalidades esenciales en un solo commando:

```bash
# Crear directorios
mkdir -p .claude/{commands,agents,skills} ~/.claude/{hooks,skills}

# Instalar todas las funcionalidades
cp 01-slash-commands/*.md .claude/commands/ && \
cp 02-memory/project-CLAUDE.md ./CLAUDE.md && \
cp -r 03-skills/* ~/.claude/skills/ && \
cp 04-subagents/*.md .claude/agents/ && \
cp 06-hooks/*.sh ~/.claude/hooks/ && \
chmod +x ~/.claude/hooks/*.sh
```

---

## Additional Resources (Recursos Adicionales)

- [Documentación Oficial de Claude Code](https://code.claude.com/docs/en/overview)
- [Especificación del Protocolo MCP](https://modelcontextprotocol.io)
- [Hoja de Ruta de Aprendizaje](LEARNING-ROADMAP.md)
- [README Principal](README.md)

---

**Última Actualización**: Marzo 2026
