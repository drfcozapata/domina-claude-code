<picture>
  <img alt="Claude How To" src="resources/logos/logo.svg">
</picture>

[![GitHub Stars](https://img.shields.io/github/stars/drfcozapata/domina-claude-code?style=flat&color=gold)](https://github.com/drfcozapata/domina-claude-code/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/drfcozapata/domina-claude-code?style=flat)](https://github.com/drfcozapata/domina-claude-code/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.2.0-brightgreen)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1.86-purple)](https://code.claude.com)

# Domina Claude Code

Pasa de escribir `claude` a orquestar agentes, hooks (ganchos), skills (habilidades) y servidores MCP — con tutoriales visuales, plantillas para copiar y pegar, y una ruta de aprendizaje guiada.

**[Comienza en 15 Minutos](#-comienza-en-15-minutos)** | **[Encuentra Tu Nivel](#no-estás-seguro-dónde-comenzar)** | **[Explora el Catálogo de Funcionalidades](CATALOG.md)**

---

## Tabla de Contenidos

- [El Problema](#el-problema)
- [Cómo Claude How To Soluciona Esto](#cómo-claude-how-to-soluciona-esto)
- [Cómo Funciona](#cómo-funciona)
- [¿No Estás Seguro Dónde Comenzar?](#no-estás-seguro-dónde-comenzar)
- [Comienza en 15 Minutos](#-comienza-en-15-minutos)
- [¿Qué Puedes Construir Con Esto?](#qué-puedes-construir-con-esto)
- [FAQ](#faq)
- [Contribución](#contribución)
- [Licencia](#licencia)

---

## El Problema

Instalaste Claude Code. Ejecutaste algunos prompts. ¿Y ahora qué?

- **La documentación oficial describe funcionalidades, pero no te muestra cómo combinarlas.** Sabes que los slash commands (comandos de barra) existen, pero no cómo encadenarlos con hooks, memory, y subagents en un flujo de trabajo que realmente ahorre horas.
- **No hay una ruta de aprendizaje clara.** ¿Deberías aprender MCP antes que hooks? ¿Skills antes que subagents? Terminas hojeando todo y sin dominar nada.
- **Los ejemplos son demasiado básicos.** Un comando de barra "hello world" no te ayuda a construir un pipeline de revisión de código de producción que use memoria, delegue a agentes especializados y ejecute análisis de seguridad automáticamente.

Te estás perdiendo el 90% del poder de Claude Code — y no sabes lo que no sabes.

---

## Cómo Claude How To Soluciona Esto

Esta no es otra referencia de funcionalidades. Es una **guía estructurada, visual y basada en ejemplos** que te enseña a usar cada funcionalidad de Claude Code con plantillas del mundo real que puedes copiar en tu proyecto hoy.

| | Documentación Oficial | Esta Guía |
|--|---------------|------------|
| **Formato** | Documentación de referencia | Tutoriales visuales con diagramas Mermaid |
| **Profundidad** | Descripciones de funcionalidades | Cómo funciona por debajo |
| **Ejemplos** | Fragmentos básicos | Plantillas listas para producción que usas inmediatamente |
| **Estructura** | Organizado por funcionalidad | Ruta de aprendizaje progresiva (principiante a avanzado) |
| **Onboarding** | Auto-dirigido | Ruta guiada con estimaciones de tiempo |
| **Autoevaluación** | Ninguna | Cuestionarios interactivos para encontrar tus brechas y construir una ruta personalizada |

### ¿Qué obtienes?

- **10 módulos de tutorial** que cubren cada funcionalidad de Claude Code — desde slash commands hasta equipos de agentes personalizados
- **Configuraciones para copiar y pegar** — slash commands, plantillas CLAUDE.md, scripts de hook, configuraciones MCP, definiciones de subagentes y paquetes completos de plugins
- **Diagramas Mermaid** que muestran cómo funciona cada funcionalidad internamente, para que entiendas *por qué*, no solo *cómo*
- **Una ruta de aprendizaje guiada** que te lleva de principiante a usuario avanzado en 11-13 horas
- **Autoevaluación integrada** — ejecuta `/self-assessment` o `/lesson-quiz hooks` directamente en Claude Code para identificar brechas

**[Inicia la Ruta de Aprendizaje ->](LEARNING-ROADMAP.md)**

---

## Cómo Funciona

### 1. Encuentra tu nivel

Realiza el [cuestionario de autoevaluación](LEARNING-ROADMAP.md#-find-your-level) o ejecuta `/self-assessment` en Claude Code. Obtén una ruta de aprendizaje personalizada basada en lo que ya sabes.

### 2. Sigue la ruta guiada

Trabaja en 10 módulos en orden — cada uno se basa en el anterior. Copia plantillas directamente a tu proyecto mientras aprendes.

### 3. Combina funcionalidades en flujos de trabajo

El poder real está en combinar funcionalidades. Aprende a conectar slash commands + memory + subagents + hooks en pipelines automatizados que manejan revisiones de código, despliegues y generación de documentación.

### 4. Pon a prueba tu comprensión

Ejecuta `/lesson-quiz [tema]` después de cada módulo. El cuestionario identifica lo que te faltó para que puedas llenar brechas rápidamente.

**[Comienza en 15 Minutos](#-comienza-en-15-minutos)**

---

## ¿No Estás Seguro Dónde Comenzar?

Realiza la autoevaluación o elige tu nivel:

| Nivel | Puedes... | Comienza aquí | Tiempo |
|-------|-----------|------------|------|
| **Principiante** | Iniciar Claude Code y chatear | [Slash Commands](01-slash-commands/) | ~2.5 horas |
| **Intermedio** | Usar CLAUDE.md y comandos personalizados | [Skills](03-skills/) | ~3.5 horas |
| **Avanzado** | Configurar servidores MCP y hooks | [Funcionalidades Avanzadas](09-advanced-features/) | ~5 horas |

**Ruta de aprendizaje completa con los 10 módulos:**

| Orden | Módulo | Nivel | Tiempo |
|-------|--------|-------|------|
| 1 | [Slash Commands](01-slash-commands/) | Principiante | 30 min |
| 2 | [Memory](02-memory/) | Principiante+ | 45 min |
| 3 | [Checkpoints](08-checkpoints/) | Intermedio | 45 min |
| 4 | [CLI Basics](10-cli/) | Principiante+ | 30 min |
| 5 | [Skills](03-skills/) | Intermedio | 1 hora |
| 6 | [Hooks](06-hooks/) | Intermedio | 1 hora |
| 7 | [MCP](05-mcp/) | Intermedio+ | 1 hora |
| 8 | [Subagents](04-subagents/) | Intermedio+ | 1.5 horas |
| 9 | [Advanced Features](09-advanced-features/) | Avanzado | 2-3 horas |
| 10 | [Plugins](07-plugins/) | Avanzado | 2 horas |

**[Ruta de Aprendizaje Completa ->](LEARNING-ROADMAP.md)**

---

## Comienza en 15 Minutos

```bash
# 1. Clona la guía
git clone https://github.com/drfcozapata/domina-claude-code.git
cd domina-claude-code

# 2. Copia tu primer slash command
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. Pruébalo — en Claude Code, escribe:
# /optimize

# 4. ¿Listo para más? Configura la memoria del proyecto:
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. Instala una skill:
cp -r 03-skills/code-review ~/.claude/skills/
```

¿Quieres la configuración completa? Aquí está la **configuración esencial de 1 hora**:

```bash
# Slash commands (15 min)
cp 01-slash-commands/*.md .claude/commands/

# Memoria del proyecto (15 min)
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Instala una skill (15 min)
cp -r 03-skills/code-review ~/.claude/skills/

# Objetivo del fin de semana: agrega hooks, subagents, MCP y plugins
# Sigue la ruta de aprendizaje para una configuración guiada
```

**[Ver la Referencia Completa de Instalación](#referencia-rápida-de-instalación)**

---

## ¿Qué Puedes Construir Con Esto?

| Caso de Uso | Funcionalidades que Combinarás |
|----------|------------------------|
| **Revisión Automatizada de Código** | Slash Commands + Subagents + Memory + MCP |
| **Incorporación de Equipo** | Memory + Slash Commands + Plugins |
| **Automatización CI/CD** | CLI Reference + Hooks + Background Tasks |
| **Generación de Documentación** | Skills + Subagents + Plugins |
| **Auditorías de Seguridad** | Subagents + Skills + Hooks (modo solo lectura) |
| **Pipelines DevOps** | Plugins + MCP + Hooks + Background Tasks |
| **Refactorización Compleja** | Checkpoints + Planning Mode + Hooks |

---

## FAQ

**¿Esto es gratuito?**
Sí. Licencia MIT, gratuito para siempre. Úsalo en proyectos personales, en el trabajo, en tu equipo — sin restricciones más allá de incluir el aviso de licencia.

**¿Esto tiene mantenimiento?**
Activamente. La guía está sincronizada con cada lanzamiento de Claude Code. Versión actual: v2.2.0 (marzo 2026), compatible con Claude Code 2.1+.

**¿En qué se diferencia esto de la documentación oficial?**
La documentación oficial es una referencia de funcionalidades. Esta guía es un tutorial con diagramas, plantillas listas para producción y una ruta de aprendizaje progresiva. Se complementan entre sí — comienza aquí para aprender, consulta la documentación oficial cuando necesites detalles específicos.

**¿Cuánto tiempo lleva completar todo?**
11-13 horas para la ruta completa. Pero obtendrás valor inmediato en 15 minutos — simplemente copia una plantilla de slash command y pruébala.

**¿Puedo usar esto con Claude Sonnet / Haiku / Opus?**
Sí. Todas las plantillas funcionan con Claude Sonnet 4.6, Claude Opus 4.6 y Claude Haiku 4.5.

**¿Puedo contribuir?**
Absolutamente. Consulta [CONTRIBUTING.md](CONTRIBUTING.md) para ver las directrices. Damos la bienvenida a nuevos ejemplos, correcciones de errores, mejoras de documentación y plantillas comunitarias.

**¿Puedo leer esto sin conexión?**
Sí. Ejecuta `uv run scripts/build_epub.py` para generar un libro electrónico EPUB con todo el contenido y diagramas renderizados.

---

## Comienza a Dominar Claude Code Hoy

Ya tienes Claude Code instalado. Lo único entre tú y una productividad 10x es saber cómo usarlo. Esta guía te da la ruta estructurada, las explicaciones visuales y las plantillas para copiar y pegar para llegar allí.

Licencia MIT. Gratuito para siempre. Clónalo, haz un fork, hazlo tuyo.

**[Inicia la Ruta de Aprendizaje ->](LEARNING-ROADMAP.md)** | **[Explora el Catálogo de Funcionalidades](CATALOG.md)** | **[Comienza en 15 Minutos](#-comienza-en-15-minutos)**

---

<details>
<summary>Navegación Rápida — Todas las Funcionalidades</summary>

| Funcionalidad | Descripción | Carpeta |
|---------|-------------|--------|
| **Catálogo de Funcionalidades** | Referencia completa con comandos de instalación | [CATALOG.md](CATALOG.md) |
| **Slash Commands** | Atajos invocados por el usuario | [01-slash-commands/](01-slash-commands/) |
| **Memory** | Contexto persistente | [02-memory/](02-memory/) |
| **Skills** | Capacidades reutilizables | [03-skills/](03-skills/) |
| **Subagents** | Asistentes de IA especializados | [04-subagents/](04-subagents/) |
| **MCP Protocol** | Acceso a herramientas externas | [05-mcp/](05-mcp/) |
| **Hooks** | Automatización dirigida por eventos | [06-hooks/](06-hooks/) |
| **Plugins** | Funcionalidades empaquetadas | [07-plugins/](07-plugins/) |
| **Checkpoints** | Instantáneas de sesión y rewind | [08-checkpoints/](08-checkpoints/) |
| **Funcionalidades Avanzadas** | Planificación, pensamiento, tareas en segundo plano | [09-advanced-features/](09-advanced-features/) |
| **Referencia CLI** | Comandos, banderas y opciones | [10-cli/](10-cli/) |
| **Blog Posts** | Ejemplos de uso del mundo real | [Blog Posts](https://medium.com/@drfcozapata) |

</details>

<details>
<summary>Comparación de Funcionalidades</summary>

| Funcionalidad | Invocación | Persistencia | Ideal Para |
|---------|-----------|------------|----------|
| **Slash Commands** | Manual (`/cmd`) | Solo sesión | Atajos rápidos |
| **Memory** | Auto-cargado | Entre sesiones | Aprendizaje a largo plazo |
| **Skills** | Auto-invocado | Sistema de archivos | Flujos de trabajo automatizados |
| **Subagents** | Auto-delegado | Contexto aislado | Distribución de tareas |
| **MCP Protocol** | Auto-consultado | Tiempo real | Acceso a datos en vivo |
| **Hooks** | Activado por eventos | Configurado | Automatización y validación |
| **Plugins** | Un comando | Todas las funcionalidades | Soluciones completas |
| **Checkpoints** | Manual/Auto | Basado en sesión | Experimentación segura |
| **Planning Mode** | Manual/Auto | Fase de plan | Implementaciones complejas |
| **Background Tasks** | Manual | Duración de tarea | Operaciones de larga duración |
| **Referencia CLI** | Comandos de terminal | Sesión/Script | Automatización y scripting |

</details>

<details>
<summary>Referencia Rápida de Instalación</summary>

```bash
# Slash Commands
cp 01-slash-commands/*.md .claude/commands/

# Memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skills
cp -r 03-skills/code-review ~/.claude/skills/

# Subagents
cp 04-subagents/*.md .claude/agents/

# MCP
export GITHUB_TOKEN="token"
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# Hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Plugins
/plugin install pr-review

# Checkpoints (auto-enabled, configure in settings)
# See 08-checkpoints/README.md

# Advanced Features (configure in settings)
# See 09-advanced-features/config-examples.json

# CLI Reference (no installation needed)
# See 10-cli/README.md for usage examples
```

</details>

<details>
<summary>01. Slash Commands</summary>

**Ubicación**: [01-slash-commands/](01-slash-commands/)

**Qué son**: Atajos invocados por el usuario almacenados como archivos Markdown

**Ejemplos**:
- `optimize.md` - Análisis de optimización de código
- `pr.md` - Preparación de pull request
- `generate-api-docs.md` - Generador de documentación API

**Instalación**:
```bash
cp 01-slash-commands/*.md /path/to/project/.claude/commands/
```

**Uso**:
```
/optimize
/pr
/generate-api-docs
```

**Más Información**: [Discovering Claude Code Slash Commands](https://medium.com/@drfcozapata/discovering-claude-code-slash-commands-cdc17f0dfb29)

</details>

<details>
<summary>02. Memory</summary>

**Ubicación**: [02-memory/](02-memory/)

**Qué es**: Contexto persistente entre sesiones

**Ejemplos**:
- `project-CLAUDE.md` - Estándares del proyecto para todo el equipo
- `directory-api-CLAUDE.md` - Reglas específicas del directorio
- `personal-CLAUDE.md` - Preferencias personales

**Instalación**:
```bash
# Memoria del proyecto
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# Memoria del directorio
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# Memoria personal
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**Uso**: Cargado automáticamente por Claude

</details>

<details>
<summary>03. Skills</summary>

**Ubicación**: [03-skills/](03-skills/)

**Qué son**: Capacidades reutilizables y auto-invocadas con instrucciones y scripts

**Ejemplos**:
- `code-review/` - Revisión completa de código con scripts
- `brand-voice/` - Verificador de consistencia de voz de marca
- `doc-generator/` - Generador de documentación API

**Instalación**:
```bash
# Skills personales
cp -r 03-skills/code-review ~/.claude/skills/

# Skills del proyecto
cp -r 03-skills/code-review /path/to/project/.claude/skills/
```

**Uso**: Auto-invocado cuando es relevante

</details>

<details>
<summary>04. Subagents</summary>

**Ubicación**: [04-subagents/](04-subagents/)

**Qué son**: Asistentes de IA especializados con contextos aislados y prompts personalizados

**Ejemplos**:
- `code-reviewer.md` - Análisis exhaustivo de calidad de código
- `test-engineer.md` - Estrategia de pruebas y cobertura
- `documentation-writer.md` - Documentación técnica
- `secure-reviewer.md` - Revisión enfocada en seguridad (solo lectura)
- `implementation-agent.md` - Implementación completa de funcionalidades

**Instalación**:
```bash
cp 04-subagents/*.md /path/to/project/.claude/agents/
```

**Uso**: Delegado automáticamente por el agente principal

</details>

<details>
<summary>05. MCP Protocol</summary>

**Ubicación**: [05-mcp/](05-mcp/)

**Qué es**: Model Context Protocol para acceder a herramientas externas y APIs

**Ejemplos**:
- `github-mcp.json` - Integración con GitHub
- `database-mcp.json` - Consultas de base de datos
- `filesystem-mcp.json` - Operaciones de archivos
- `multi-mcp.json` - Múltiples servidores MCP

**Instalación**:
```bash
# Configurar variables de entorno
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# Agregar servidor MCP vía CLI
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# O agregar a project .mcp.json manualmente (ver ejemplos en 05-mcp/)
```

**Uso**: Las herramientas MCP están automáticamente disponibles para Claude una vez configuradas

</details>

<details>
<summary>06. Hooks</summary>

**Ubicación**: [06-hooks/](06-hooks/)

**Qué son**: Comandos shell dirigidos por eventos que se ejecutan automáticamente en respuesta a eventos de Claude Code

**Ejemplos**:
- `format-code.sh` - Auto-formatear código antes de escribir
- `pre-commit.sh` - Ejecutar pruebas antes de commits
- `security-scan.sh` - Escanear problemas de seguridad
- `log-bash.sh` - Registrar todos los comandos bash
- `validate-prompt.sh` - Validar prompts del usuario
- `notify-team.sh` - Enviar notificaciones en eventos

**Instalación**:
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Configura hooks en `~/.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/format-code.sh"]
    }],
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/security-scan.sh"]
    }]
  }
}
```

**Uso**: Los hooks se ejecutan automáticamente en eventos

**Tipos de Hooks** (4 tipos, 25 eventos):
- **Tool Hooks**: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`
- **Session Hooks**: `SessionStart`, `SessionEnd`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`
- **Task Hooks**: `UserPromptSubmit`, `TaskCompleted`, `TaskCreated`, `TeammateIdle`
- **Lifecycle Hooks**: `ConfigChange`, `CwdChanged`, `FileChanged`, `PreCompact`, `PostCompact`, `WorktreeCreate`, `WorktreeRemove`, `Notification`, `InstructionsLoaded`, `Elicitation`, `ElicitationResult`

</details>

<details>
<summary>07. Plugins</summary>

**Ubicación**: [07-plugins/](07-plugins/)

**Qué son**: Colecciones empaquetadas de comandos, agentes, MCP y hooks

**Ejemplos**:
- `pr-review/` - Flujo de trabajo completo de revisión de PR
- `devops-automation/` - Despliegue y monitoreo
- `documentation/` - Generación de documentación

**Instalación**:
```bash
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

**Uso**: Usa slash commands y funcionalidades empaquetadas

</details>

<details>
<summary>08. Checkpoints y Rewind</summary>

**Ubicación**: [08-checkpoints/](08-checkpoints/)

**Qué es**: Guarda el estado de la conversación y rebobina a puntos anteriores para explorar diferentes enfoques

**Conceptos Clave**:
- **Checkpoint**: Instantánea del estado de la conversación
- **Rewind**: Regresar al checkpoint anterior
- **Branch Point**: Explorar múltiples enfoques desde el mismo checkpoint

**Uso**:
```
# Los checkpoints se crean automáticamente con cada prompt del usuario
# Para rebobinar, presiona Esc dos veces o usa:
/rewind

# Luego elige entre cinco opciones:
# 1. Restaurar código y conversación
# 2. Restaurar conversación
# 3. Restaurar código
# 4. Resumir desde aquí
# 5. Cancelar
```

**Casos de Uso**:
- Probar diferentes enfoques de implementación
- Recuperarse de errores
- Experimentación segura
- Comparar soluciones alternativas
- Pruebas A/B de diferentes diseños

</details>

<details>
<summary>09. Funcionalidades Avanzadas</summary>

**Ubicación**: [09-advanced-features/](09-advanced-features/)

**Qué son**: Capacidades avanzadas para flujos de trabajo complejos y automatización

**Incluye**:
- **Planning Mode** — Crea planes de implementación detallados antes de codificar
- **Extended Thinking** — Razonamiento profundo para problemas complejos (alternar con `Alt+T` / `Option+T`)
- **Background Tasks** — Ejecuta operaciones largas sin bloquear
- **Permission Modes** — `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`
- **Headless Mode** — Ejecuta Claude Code en CI/CD: `claude -p "Run tests and generate report"`
- **Session Management** — `/resume`, `/rename`, `/fork`, `claude -c`, `claude -r`
- **Configuration** — Personaliza el comportamiento en `~/.claude/settings.json`

Consulta [config-examples.json](09-advanced-features/config-examples.json) para configuraciones completas.

</details>

<details>
<summary>10. Referencia CLI</summary>

**Ubicación**: [10-cli/](10-cli/)

**Qué es**: Referencia completa de la interfaz de línea de comandos para Claude Code

**Ejemplos Rápidos**:
```bash
# Modo interactivo
claude "explain this project"

# Modo impresión (no interactivo)
claude -p "review this code"

# Procesar contenido de archivo
cat error.log | claude -p "explain this error"

# Salida JSON para scripts
claude -p --output-format json "list functions"

# Reanudar sesión
claude -r "feature-auth" "continue implementation"
```

**Casos de Uso**: Integración con pipeline CI/CD, automatización de scripts, procesamiento por lotes, flujos de trabajo multi-sesión, configuraciones de agentes personalizados

</details>

<details>
<summary>Ejemplos de Flujos de Trabajo</summary>

### Flujo de Trabajo Completo de Revisión de Código

```markdown
# Usa: Slash Commands + Subagents + Memory + MCP

Usuario: /review-pr

Claude:
1. Carga la memoria del proyecto (estándares de codificación)
2. Obtiene el PR vía GitHub MCP
3. Delega al subagente code-reviewer
4. Delega al subagente test-engineer
5. Sintetiza hallazgos
6. Proporciona revisión completa
```

### Documentación Automatizada

```markdown
# Usa: Skills + Subagents + Memory

Usuario: "Genera documentación API para el módulo de autenticación"

Claude:
1. Carga la memoria del proyecto (estándares de documentación)
2. Detecta solicitud de generación de documentación
3. Auto-invoca la skill doc-generator
4. Delega al subagente api-documenter
5. Crea documentación completa con ejemplos
```

### Despliegue DevOps

```markdown
# Usa: Plugins + MCP + Hooks

Usuario: /deploy production

Claude:
1. Ejecuta hook pre-despliegue (valida entorno)
2. Delega al subagente deployment-specialist
3. Ejecuta despliegue vía Kubernetes MCP
4. Monitorea progreso
5. Ejecuta hook post-despliegue (verificaciones de salud)
6. Reporta estado
```

</details>

<details>
<summary>Estructura del Directorio</summary>

```
├── 01-slash-commands/
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   └── README.md
├── 02-memory/
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   └── README.md
├── 03-skills/
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   └── templates/
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   └── templates/
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   └── README.md
├── 04-subagents/
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   └── README.md
├── 05-mcp/
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
├── 06-hooks/
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   └── README.md
├── 07-plugins/
│   ├── pr-review/
│   ├── devops-automation/
│   ├── documentation/
│   └── README.md
├── 08-checkpoints/
│   ├── checkpoint-examples.md
│   └── README.md
├── 09-advanced-features/
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
├── 10-cli/
│   └── README.md
└── README.md (este archivo)
```

</details>

<details>
<summary>Buenas Prácticas</summary>

### Qué Hacer
- Comienza simple con slash commands
- Agrega funcionalidades incrementalmente
- Usa memory para estándares del equipo
- Prueba configuraciones localmente primero
- Documenta implementaciones personalizadas
- Control de versiones para configuraciones del proyecto
- Comparte plugins con el equipo

### Qué No Hacer
- No crees funcionalidades redundantes
- No hardcodees credenciales
- No saltes la documentación
- No compliques demasiado tareas simples
- No ignores las mejores prácticas de seguridad
- No hagas commit de datos sensibles

</details>

<details>
<summary>Solución de Problemas</summary>

### La Funcionalidad No Carga
1. Verifica la ubicación y nombre del archivo
2. Verifica la sintaxis YAML frontmatter
3. Verifica los permisos del archivo
4. Revisa la compatibilidad de la versión de Claude Code

### Conexión MCP Falló
1. Verifica las variables de entorno
2. Verifica la instalación del servidor MCP
3. Prueba las credenciales
4. Revisa la conectividad de red

### Subagent No Delega
1. Verifica los permisos de herramientas
2. Verifica la claridad de la descripción del agente
3. Revisa la complejidad de la tarea
4. Prueba el agente independientemente

</details>

<details>
<summary>Testing</summary>

Este proyecto incluye testing automatizado exhaustivo:

- **Unit Tests**: Pruebas de Python usando pytest (Python 3.10, 3.11, 3.12)
- **Code Quality**: Linting y formateo con Ruff
- **Security**: Escaneo de vulnerabilidades con Bandit
- **Type Checking**: Análisis de tipos estático con mypy
- **Build Verification**: Testing de generación EPUB
- **Coverage Tracking**: Integración con Codecov

```bash
# Instalar dependencias de desarrollo
uv pip install -r requirements-dev.txt

# Ejecutar todas las pruebas unitarias
pytest scripts/tests/ -v

# Ejecutar pruebas con reporte de cobertura
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# Ejecutar verificaciones de calidad de código
ruff check scripts/
ruff format --check scripts/

# Ejecutar escaneo de seguridad
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# Ejecutar verificación de tipos
mypy scripts/ --ignore-missing-imports
```

Las pruebas se ejecutan automáticamente en cada push a `main`/`develop` y cada PR a `main`. Consulta [TESTING.md](.github/TESTING.md) para información detallada.

</details>

<details>
<summary>Generación de EPUB</summary>

¿Quieres leer esta guía sin conexión? Genera un libro electrónico EPUB:

```bash
uv run scripts/build_epub.py
```

Esto crea `domina-claude-code-guide.epub` con todo el contenido, incluyendo diagramas Mermaid renderizados.

Consulta [scripts/README.md](scripts/README.md) para más opciones.

</details>

<details>
<summary>Contribución</summary>

¿Encontraste un problema o quieres contribuir con un ejemplo? ¡Nos encantaría tu ayuda!

**Por favor lee [CONTRIBUTING.md](CONTRIBUTING.md) para directrices detalladas sobre:**
- Tipos de contribuciones (ejemplos, docs, funcionalidades, bugs, feedback)
- Cómo configurar tu entorno de desarrollo
- Estructura del directorio y cómo agregar contenido
- Directrices de escritura y mejores prácticas
- Proceso de commit y PR

**Nuestros Estándares Comunitarios:**
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - Cómo nos tratamos entre nosotros
- [SECURITY.md](SECURITY.md) - Política de seguridad y reporte de vulnerabilidades

### Reportar Problemas de Seguridad

Si descubres una vulnerabilidad de seguridad, por favor repórtala responsablemente:

1. **Usa GitHub Private Vulnerability Reporting**: https://github.com/drfcozapata/domina-claude-code/security/advisories
2. **O lee** [.github/SECURITY_REPORTING.md](.github/SECURITY_REPORTING.md) para instrucciones detalladas
3. **NO** abras un issue público para vulnerabilidades de seguridad

Inicio rápido:
1. Haz fork y clona el repositorio
2. Crea una rama descriptiva (`add/feature-name`, `fix/bug`, `docs/improvement`)
3. Realiza tus cambios siguiendo las directrices
4. Envía un pull request con una descripción clara

**¿Necesitas ayuda?** Abre un issue o discusión, y te guiaremos en el proceso.

</details>

<details>
<summary>Recursos Adicionales</summary>

- [Documentación de Claude Code](https://code.claude.com/docs/en/overview)
- [Especificación del Protocolo MCP](https://modelcontextprotocol.io)
- [Repositorio de Skills](https://github.com/drfcozapata/skills) - Colección de skills listas para usar
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Flujo de Trabajo de Claude Code de Boris Cherny](https://x.com/bcherny/status/2007179832300581177) - El creador de Claude Code comparte su flujo de trabajo sistematizado: agentes paralelos, CLAUDE.md compartido, modo Plan, slash commands, subagents y hooks de verificación para sesiones autónomas de larga duración.

</details>

---

## Contribución

¡Damos la bienvenida contribuciones! Por favor consulta nuestra [Guía de Contribución](CONTRIBUTING.md) para detalles sobre cómo comenzar.

## Contribuidores

¡Gracias a todos los que han contribuido a este proyecto!

| Contribuidor | PRs |
|-------------|-----|
| [wjhrdy](https://github.com/wjhrdy) | [#1 - agregar herramienta para crear un epub](https://github.com/drfcozapata/domina-claude-code/pull/1) |
| [VikalpP](https://github.com/VikalpP) | [#7 - fix(docs): Usar tildes para bloques de código anidados en la guía de conceptos](https://github.com/drfcozapata/domina-claude-code/pull/7) |

---

## Licencia

Licencia MIT - consulta [LICENSE](LICENSE). Libre para usar, modificar y distribuir. El único requisito es incluir el aviso de licencia.

---

**Última Actualización**: Marzo 2026
**Versión de Claude Code**: 2.1.86
**Modelos Compatibles**: Claude Sonnet 4.6, Claude Opus 4.6, Claude Haiku 4.5
