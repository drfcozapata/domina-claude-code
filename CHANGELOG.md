# Registro de Cambios

## v2.2.0 — 2026-03-26

### Documentación

- Sincronizar todos los tutoriales y referencias con Claude Code v2.1.84 (f78c094) @luongnv89
  - Actualizar comandos slash a 55+ integrados + 5 habilidades empaquetadas, marcar 3 como obsoletas
  - Expandir eventos hook de 18 a 25, agregar tipo de hook `agent` (ahora 4 tipos)
  - Agregar Auto Mode, Channels, Voice Dictation a características avanzadas
  - Agregar campos `effort`, `shell` en frontmatter de habilidades; campos `initialPrompt`, `disallowedTools` de agente
  - Agregar transporte MCP WebSocket, elicitation, límite de herramienta 2KB
  - Agregar soporte LSP de plugin, `userConfig`, `${CLAUDE_PLUGIN_DATA}`
  - Actualizar todos los documentos de referencia (CATALOG, QUICK_REFERENCE, LEARNING-ROADMAP, INDEX)
- Reescribir README como guía estructurada tipo landing-page (32a0776) @luongnv89

### Correcciones de Errores

- Agregar palabras cSpell faltantes y secciones README para cumplimiento de CI (93f9d51) @luongnv89
- Agregar `Sandboxing` al diccionario cSpell (b80ce6f) @luongnv89

**Registro completo de cambios**: https://github.com/luongnv89/domina-claude-code/compare/v2.1.1...v2.2.0

---

## v2.1.1 — 2026-03-13

### Correcciones de Errores

- Eliminar enlace de marketplace muerto que fallaba en las verificaciones de enlaces de CI (3fdf0d6) @luongnv89
- Agregar `sandboxed` y `pycache` al diccionario cSpell (dc64618) @luongnv89

**Registro completo de cambios**: https://github.com/luongnv89/domina-claude-code/compare/v2.1.0...v2.1.1

---

## v2.1.0 — 2026-03-13

### Características

- Agregar ruta de aprendizaje adaptativa con habilidades de autoevaluación y cuestionario de lección (1ef46cd) @luongnv89
  - `/self-assessment` — cuestionario interactivo de competencia en 10 áreas de características con ruta de aprendizaje personalizada
  - `/lesson-quiz [lesson]` — verificación de conocimiento por lección con 8-10 preguntas específicas

### Correcciones de Errores

- Actualizar URLs rotas, obsoletas y referencias desactualizadas (8fe4520) @luongnv89
- Corregir enlaces rotos en recursos y habilidad de autoevaluación (7a05863) @luongnv89
- Usar cercos de tilde para bloques de código anidados en la guía de conceptos (5f82719) @VikalpP
- Agregar palabras faltantes al diccionario cSpell (8df7572) @luongnv89

### Documentación

- QA Fase 5 — corregir consistencia, URLs y terminología en todos los documentos (00bbe4c) @luongnv89
- Completar Fases 3-4 — cobertura de nuevas características y actualizaciones de documentos de referencia (132de29) @luongnv89
- Agregar MCPorter runtime a la sección de sobrecarga de contexto MCP (ef52705) @luongnv89
- Agregar comandos, características y configuraciones faltantes en 6 guías (4bc8f15) @luongnv89
- Agregar guía de estilo basada en convenciones existentes del repositorio (84141d0) @luongnv89
- Agregar fila de autoevaluación a la tabla comparativa de guías (8fe0c96) @luongnv89
- Agregar VikalpP a la lista de contribuyentes para PR #7 (d5b4350) @luongnv89
- Agregar referencias de habilidades de autoevaluación y cuestionario de lección a README y roadmap (d5a6106) @luongnv89

### Nuevos Contribuyentes

- @VikalpP hizo su primera contribución en #7

**Registro completo de cambios**: https://github.com/luongnv89/domina-claude-code/compare/v2.0.0...v2.1.0

---

## v2.0.0 — 2026-02-01

### Características

- Sincronizar toda la documentación con las características de Claude Code de febrero 2026 (487c96d)
  - Actualizar 26 archivos en los 10 directorios de tutoriales y 7 documentos de referencia
  - Agregar documentación para **Auto Memory** — aprendizajes persistentes por proyecto
  - Agregar documentación para **Remote Control**, **Web Sessions**, y **Desktop App**
  - Agregar documentación para **Agent Teams** (colaboración multi-agente experimental)
  - Agregar documentación para **MCP OAuth 2.0**, **Tool Search**, y **Claude.ai Connectors**
  - Agregar documentación para **Persistent Memory** y **Worktree Isolation** para subagentes
  - Agregar documentación para **Background Subagents**, **Task List**, **Prompt Suggestions**
  - Agregar documentación para **Sandboxing** y **Managed Settings** (Enterprise)
  - Agregar documentación para **HTTP Hooks** y 7 nuevos eventos hook
  - Agregar documentación para **Plugin Settings**, **LSP Servers**, y actualizaciones de Marketplace
  - Agregar documentación para opción de retroceso **Summarize from Checkpoint**
  - Documentar 17 nuevos comandos slash (`/fork`, `/desktop`, `/teleport`, `/tasks`, `/fast`, etc.)
  - Documentar nuevas flags de CLI (`--worktree`, `--from-pr`, `--remote`, `--teleport`, `--teammate-mode`, etc.)
  - Documentar nuevas variables de entorno para auto memoria, niveles de esfuerzo, equipos de agentes, y más

### Diseño

- Rediseñar logo a marca de soporte de compás con paleta minimalista (20779db)

### Correcciones de Errores / Correcciones

- Actualizar nombres de modelos: Sonnet 4.5 → **Sonnet 4.6**, Opus 4.5 → **Opus 4.6**
- Corregir nombres de modo de permiso: reemplazar "Unrestricted/Confirm/Read-only" ficticios por `default`/`acceptEdits`/`plan`/`dontAsk`/`bypassPermissions` reales
- Corregir eventos hook: eliminar `PreCommit`/`PostCommit`/`PrePush` ficticios, agregar eventos reales (`SubagentStart`, `WorktreeCreate`, `ConfigChange`, etc.)
- Corregir sintaxis de CLI: reemplazar `claude-code --headless` con `claude -p` (modo impresión)
- Corregir comandos de checkpoint: reemplazar `/checkpoint save/list/rewind/diff` ficticios con interfaz real `Esc+Esc` / `/rewind`
- Corregir gestión de sesiones: reemplazar `/session list/new/switch/save` ficticios con `/resume`/`/rename`/`/fork` reales
- Corregir formato de manifiesto de plugin: migrar `plugin.yaml` → `.claude-plugin/plugin.json`
- Corregir rutas de configuración MCP: `~/.claude/mcp.json` → `.mcp.json` (proyecto) / `~/.claude.json` (usuario)
- Corregir URLs de documentación: `docs.claude.com` → `docs.anthropic.com`; eliminar `plugins.claude.com` ficticio
- Eliminar campos de configuración ficticios en múltiples archivos
- Actualizar todas las fechas de "Last Updated" a febrero 2026

**Registro completo de cambios**: https://github.com/luongnv89/domina-claude-code/compare/20779db...v2.0.0
