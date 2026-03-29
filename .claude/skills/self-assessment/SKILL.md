---
name: self-assessment
version: 2.2.0
description: Asesor completo de autoevaluación y ruta de aprendizaje de Claude Code. Ejecuta un cuestionario multicategoría que cubre 10 áreas de funcionalidades, produce un perfil de habilidades detallado con puntuaciones por tema, identifica brechas específicas y genera una ruta de aprendizaje personalizada con próximos pasos priorizados. Usar cuando se solicite "evaluar mi nivel", "hacer el cuestionario", "encontrar mi nivel", "dónde debería empezar", "qué debería aprender después", "verificar mis habilidades", "verificación de habilidades" o "subir de nivel".
---

# Asesor de Autoevaluación y Ruta de Aprendizaje

Evaluación interactiva completa que evalúa la competencia en Claude Code en 10 áreas de funcionalidades, identifica brechas de habilidades específicas y genera una ruta de aprendizaje personalizada para subir de nivel.

## Instrucciones

### Paso 1: Bienvenida y Elegir Modo de Evaluación

Presentar al usuario una opción de profundidad de evaluación:

Usar AskUserQuestion con estas opciones:
- **Evaluación Rápida** — "8 preguntas, ~2 minutos. Determina tu nivel general (Principiante/Intermedio/Avanzado) y proporciona una ruta de aprendizaje."
- **Evaluación Profunda** — "5 categorías con preguntas detalladas, ~5 minutos. Proporciona puntuaciones de habilidades por tema, identifica brechas específicas y construye una ruta de aprendizaje priorizada."

Si el usuario elige **Evaluación Rápida**, ir al Paso 2A.
Si el usuario elige **Evaluación Profunda**, ir al Paso 2B.

---

### Paso 2A: Evaluación Rápida

Presentar DOS preguntas de selección múltiple (AskUserQuestion soporta máx. 4 opciones cada una):

**Pregunta 1** (header: "Básicos"):
"Parte 1/2: ¿Cuáles de estas habilidades de Claude Code ya tienes?"
Opciones:
1. "Iniciar Claude Code y chatear" — Puedo ejecutar `claude` e interactuar con él
2. "Creé/edité CLAUDE.md" — He configurado memoria de proyecto o de usuario
3. "Usé 3+ comandos slash" — por ejemplo, /help, /compact, /model, /clear
4. "Creé comando/habilidad personalizada" — Escribí un archivo SKILL.md o archivo de comando personalizado

**Pregunta 2** (header: "Avanzado"):
"Parte 2/2: ¿Cuáles de estas habilidades avanzadas tienes?"
Opciones:
1. "Configuré un servidor MCP" — por ejemplo, GitHub, base de datos u otra fuente de datos externa
2. "Configuré hooks" — Configuré hooks en ~/.claude/settings.json
3. "Creé/usé subagentes" — Usé .claude/agents/ para delegación de tareas
4. "Usé modo print (claude -p)" — Usé `claude -p` para uso no interactivo o CI/CD

**Puntuación:**
- 0-2 total = Nivel 1: Principiante
- 3-5 total = Nivel 2: Intermedio
- 6-8 total = Nivel 3: Avanzado

Ir al Paso 3 con el resultado del nivel, listando los ítems específicos que NO fueron marcados como brechas.

---

### Paso 2B: Evaluación Profunda

Presentar 5 rondas de preguntas, una llamada AskUserQuestion por ronda. Cada ronda cubre 2 áreas de funcionalidades relacionadas. Usar selección múltiple para todas las rondas.

**IMPORTANTE**: AskUserQuestion soporta máx. 4 opciones por pregunta. Cada ronda tiene exactamente 1 pregunta con 4 opciones cubriendo 2 temas (2 opciones por tema).

---

**Ronda 1 — Comandos Slash y Memoria** (header: "Comandos")

"¿Cuáles de estos has hecho? Selecciona todos los que apliquen."
Opciones:
1. "Creé un comando slash o habilidad personalizada" — Escribí un archivo SKILL.md con frontmatter, o creé archivos .claude/commands/
2. "Usé contexto dinámico en comandos" — Usé `$ARGUMENTS`, `$0`/`$1`, sintaxis de backtick `!command`, o referencias `@file` en archivos de habilidad/comando
3. "Configuré memoria de proyecto + personal" — Creé tanto un CLAUDE.md de proyecto como ~/.claude/CLAUDE.md personal (o CLAUDE.local.md)
4. "Usé características de jerarquía de memoria" — Entiendo el orden de prioridad de 7 niveles, usé el directorio .claude/rules/, reglas específicas de ruta, o sintaxis @import

**Puntuación para Ronda 1:**
- Opciones 1-2 mapean a **Comandos Slash** (0-2 puntos)
- Opciones 3-4 mapean a **Memoria** (0-2 puntos)

---

**Ronda 2 — Habilidades y Hooks** (header: "Automatización")

"¿Cuáles de estos has hecho? Selecciona todos los que apliquen."
Opciones:
1. "Instalé y usé una habilidad de auto-invocación" — Una habilidad que se activa automáticamente basado en su descripción, sin invocación manual /command
2. "Controlé el comportamiento de invocación de habilidades" — Usé `disable-model-invocation`, `user-invocable`, o `context: fork` con campo agent en el frontmatter de SKILL.md
3. "Configuré un hook PreToolUse o PostToolUse" — Configuré un hook que se ejecuta antes/después de la ejecución de herramientas (por ejemplo, validador de comandos, auto-formateador)
4. "Usé características avanzadas de hooks" — Configuré hooks de tipo prompt, hooks con scope de componente en SKILL.md, hooks HTTP, o hooks con salida JSON personalizada (updatedInput, systemMessage)

**Puntuación para Ronda 2:**
- Opciones 1-2 mapean a **Habilidades** (0-2 puntos)
- Opciones 3-4 mapean a **Hooks** (0-2 puntos)

---

**Ronda 3 — MCP y Subagentes** (header: "Integración")

"¿Cuáles de estos has hecho? Selecciona todos los que apliquen."
Opciones:
1. "Conecté un servidor MCP y usé sus herramientas" — por ejemplo, GitHub MCP para PRs/issues, database MCP para consultas, o cualquier fuente de datos externa
2. "Usé características avanzadas de MCP" — .mcp.json con scope de proyecto, autenticación OAuth, recursos MCP con @mentions, Tool Search, o `claude mcp serve`
3. "Creé o configuré subagentes personalizados" — Definí agentes en .claude/agents/ con herramientas, modelo o permisos personalizados
4. "Usé características avanzadas de subagentes" — Aislamiento worktree, memoria persistente de agente, tareas en segundo plano con Ctrl+B, allowlists de agentes con `Task(agent_name)`, o equipos de agentes

**Puntuación para Ronda 3:**
- Opciones 1-2 mapean a **MCP** (0-2 puntos)
- Opciones 3-4 mapean a **Subagentes** (0-2 puntos)

---

**Ronda 4 — Checkpoints y Características Avanzadas** (header: "Usuario Avanzado")

"¿Cuáles de estos has hecho? Selecciona todos los que apliquen."
Opciones:
1. "Usé checkpoints para experimentación segura" — Creé checkpoints, usé Esc+Esc o /rewind, restauré código y/o conversación, o usé la opción Summarize
2. "Usé modo planning o extended thinking" — Activé planning vía /plan, Shift+Tab, o --permission-mode plan; alterné extended thinking con Alt+T/Option+T
3. "Configuré modos de permisos" — Usé acceptEdits, plan, dontAsk, o modo bypassPermissions vía flags CLI, atajos de teclado, o configuraciones
4. "Usé características remotas/de escritorio/web" — Usé `claude remote-control`, `claude --remote`, `/teleport`, `/desktop`, o worktrees con `claude -w`

**Puntuación para Ronda 4:**
- Opción 1 mapea a **Checkpoints** (0-1 punto)
- Opciones 2-4 mapean a **Características Avanzadas** (0-3 puntos, tope en 2)

---

**Ronda 5 — Plugins y CLI** (header: "Maestría")

"¿Cuáles de estos has hecho? Selecciona todos los que apliquen."
Opciones:
1. "Instalé o creé un plugin" — Usé un plugin empaquetado del marketplace, o creé un directorio .claude-plugin/ con manifiesto plugin.json
2. "Usé características avanzadas de plugins" — Hooks de plugins, servidores MCP de plugins, configuración LSP, comandos con namespace de plugin, o flag --plugin-dir para testing
3. "Usé modo print en scripts o CI/CD" — Usé `claude -p` con --output-format json, --max-turns, entrada pipeada, o integré en GitHub Actions / pipelines CI
4. "Usé características avanzadas de CLI" — Resumir sesión (-c/-r), flag --agents, --json-schema para salida estructurada, --fallback-model, --from-pr, o bucles de procesamiento por lotes

**Puntuación para Ronda 5:**
- Opciones 1-2 mapean a **Plugins** (0-2 puntos)
- Opciones 3-4 mapean a **CLI** (0-2 puntos)

---

### Paso 3: Calcular y Presentar Resultados

#### 3A: Para Evaluación Rápida

Contar total de selecciones y determinar nivel. Luego presentar:

```markdown
## Resultados de Evaluación de Habilidades de Claude Code

### Tu Nivel: [Nivel 1: Principiante / Nivel 2: Intermedio / Nivel 3: Avanzado]

Marcaste **N/8** ítems.

[Resumen motivacional de una línea basado en el nivel]

### Tu Perfil de Habilidades

| Área | Estado |
|------|--------|
| CLI Básico y Conversaciones | [Marcado/Brecha] |
| CLAUDE.md y Memoria | [Marcado/Brecha] |
| Comandos Slash (integrados) | [Marcado/Brecha] |
| Comandos Personalizados y Habilidades | [Marcado/Brecha] |
| Servidores MCP | [Marcado/Brecha] |
| Hooks | [Marcado/Brecha] |
| Subagentes | [Marcado/Brecha] |
| Modo Print y CI/CD | [Marcado/Brecha] |

### Brechas Identificadas

[Para cada ítem no marcado, proporcionar una descripción de 1 línea de qué aprender y un enlace al tutorial]

### Tu Ruta de Aprendizaje Personalizada

[Salida de la ruta de aprendizaje específica del nivel — ver Paso 4]
```

#### 3B: Para Evaluación Profunda

Calcular puntuaciones por tema de las 5 rondas. Cada tema obtiene 0-2 puntos. Luego presentar:

```markdown
## Resultados de Evaluación de Habilidades de Claude Code

### Nivel General: [Nivel 1 / Nivel 2 / Nivel 3]

**Puntuación Total: N/20 puntos**

[Resumen motivacional de una línea]

### Tu Perfil de Habilidades

| Área de Funcionalidad | Puntuación | Maestría | Estado |
|-------------|-------|---------|--------|
| Comandos Slash | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Memoria | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Habilidades | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Hooks | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| MCP | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Subagentes | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Checkpoints | N/1 | [Ninguna/Competente] | [Aprender/Dominado] |
| Características Avanzadas | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| Plugins | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |
| CLI | N/2 | [Ninguna/Básica/Competente] | [Aprender/Revisar/Dominado] |

**Clave de maestría:** 0 = Ninguna, 1 = Básica, 2 = Competente

### Áreas de Fortaleza
[Listar temas con puntuación 2/2 — estos están dominados]

### Brechas Prioritarias (Aprender Después)
[Listar temas con puntuación 0 — estos necesitan atención primero, ordenados por dependencia]

### Áreas de Revisión
[Listar temas con puntuación 1/2 — básicos conocidos pero características avanzadas aún no usadas]

### Tu Ruta de Aprendizaje Personalizada

[Salida de la ruta de aprendizaje específica de brechas — ver Paso 4]
```

**Cálculo de nivel general para Evaluación Profunda:**
- 0-6 puntos totales = Nivel 1: Principiante
- 7-13 puntos totales = Nivel 2: Intermedio
- 14-20 puntos totales = Nivel 3: Avanzado

---

### Paso 4: Generar Ruta de Aprendizaje Personalizada

Basado en los resultados de la evaluación, generar una ruta de aprendizaje específica para las brechas del usuario. NO simplemente repetir la ruta genérica de nivel — adaptarla.

#### Reglas para Generación de Ruta

1. **Omitir temas dominados**: Si un tema obtuvo 2/2, no incluirlo en la ruta.
2. **Priorizar por orden de dependencia**: Comandos Slash antes que Habilidades, Memoria antes que Subagentes, etc. El orden de dependencia es:
   - Comandos Slash (sin deps) -> Habilidades (depende de Comandos Slash)
   - Memoria (sin deps) -> Subagentes (depende de Memoria)
   - CLI Básico (sin deps) -> Maestría CLI (depende de todo)
   - Checkpoints (sin deps)
   - Hooks (depende de Comandos Slash)
   - MCP (sin deps) -> Plugins (depende de MCP, Habilidades, Hooks)
   - Características Avanzadas (depende de todo lo anterior)
3. **Para temas con puntuación 1/2**: Recomendar la "inmersión profunda" — enlazar a la sección avanzada específica que les falta.
4. **Estimar tiempo**: Sumar solo los temas que necesitan aprender/revisar.
5. **Agrupar en fases**: Organizar los temas restantes en fases lógicas de 2-3 temas cada una.

#### Formato de Salida de Ruta

```markdown
### Tu Ruta de Aprendizaje Personalizada

**Tiempo estimado**: ~N horas (ajustado para tus habilidades actuales)

#### Fase 1: [Nombre de Fase] (~N horas)
[Solo si tienen brechas en estas áreas]

**[Nombre del Tema]** — [Aprender desde cero / Inmersión profunda en características avanzadas]
- Tutorial: [enlace al directorio del tutorial]
- Enfocarse en: [secciones/conceptos específicos que necesitan]
- Ejercicio clave: [un ejercicio concreto para hacer]
- Sabrás que está hecho cuando: [criterio de éxito específico]

**[Nombre del Tema]** — ...

---

#### Fase 2: [Nombre de Fase] (~N horas)
...

---

### Proyectos de Práctica Recomendados

Basado en tus brechas, prueba estos ejercicios del mundo real para solidificar tu aprendizaje:

1. **[Nombre del Proyecto]**: [descripción de 1 línea combinando 2-3 temas de brecha]
2. **[Nombre del Proyecto]**: [descripción de 1 línea]
3. **[Nombre del Proyecto]**: [descripción de 1 línea]
```

#### Recomendaciones Específicas por Tema

Usar estas recomendaciones específicas cuando un tema es una brecha:

**Comandos Slash (puntuación 0)**:
- Tutorial: [01-slash-commands/](../../../01-slash-commands/)
- Enfocarse en: Referencia de comandos integrados, crear tu primer SKILL.md, sintaxis `$ARGUMENTS`
- Ejercicio clave: Crear un comando `/optimize` y probarlo
- Hecho cuando: Puedes crear una habilidad personalizada con argumentos y contexto dinámico

**Comandos Slash (puntuación 1 — revisar)**:
- Enfocarse en: Contexto dinámico con sintaxis `!`backtick``, referencias `@file`, control `disable-model-invocation` vs `user-invocable`
- Hecho cuando: Puedes crear una habilidad que inyecta salida de comando en vivo y controla su propio comportamiento de invocación

**Memoria (puntuación 0)**:
- Tutorial: [02-memory/](../../../02-memory/)
- Enfocarse en: Creación de CLAUDE.md, comandos `/init` y `/memory`, prefijo `#` para actualizaciones rápidas
- Ejercicio clave: Crear un CLAUDE.md de proyecto con tus estándares de código
- Hecho cuando: Claude recuerda tus preferencias entre sesiones

**Memoria (puntuación 1 — revisar)**:
- Enfocarse en: Jerarquía de 7 niveles y orden de prioridad, directorio .claude/rules/ con reglas específicas de ruta, sintaxis `@import` (profundidad máx. 5), Auto Memory MEMORY.md (límite de 200 líneas)
- Hecho cuando: Tienes reglas modulares para diferentes directorios y entiendes la jerarquía completa

**Habilidades (puntuación 0)**:
- Tutorial: [03-skills/](../../../03-skills/)
- Enfocarse en: Formato SKILL.md, auto-invocación vía campo description, disclosure progresivo (3 niveles de carga)
- Ejercicio clave: Instalar la habilidad code-review y verificar que se activa automáticamente
- Hecho cuando: Una habilidad se activa automáticamente basado en el contexto de la conversación

**Habilidades (puntuación 1 — revisar)**:
- Enfocarse en: `context: fork` con campo `agent` para ejecución de subagente, `disable-model-invocation` vs `user-invocable`, presupuesto de contexto del 2%, recursos empaquetados (scripts/, references/, assets/)
- Hecho cuando: Puedes crear una habilidad que se ejecuta en un subagente con contexto bifurcado

**Hooks (puntuación 0)**:
- Tutorial: [06-hooks/](../../../06-hooks/)
- Enfocarse en: Estructura de configuración (matcher + array hooks), eventos PreToolUse/PostToolUse, códigos de salida (0=éxito, 2=bloqueo), formato de entrada/salida JSON
- Ejercicio clave: Crear un hook PreToolUse que valida comandos Bash
- Hecho cuando: Un hook bloquea comandos peligrosos antes de la ejecución

**Hooks (puntuación 1 — revisar)**:
- Enfocarse en: Los 25 eventos de hook (incluyendo PostToolUseFailure, StopFailure, TaskCreated, CwdChanged, FileChanged, PostCompact, Elicitation, ElicitationResult), 4 tipos de hook (command, http, prompt, agent), hooks con scope de componente en frontmatter de SKILL.md, hooks HTTP con allowedEnvVars, `CLAUDE_ENV_FILE` para SessionStart/CwdChanged/FileChanged
- Hecho cuando: Puedes crear un hook Stop basado en prompt y un hook con scope de componente en una habilidad

**MCP (puntuación 0)**:
- Tutorial: [05-mcp/](../../../05-mcp/)
- Enfocarse en: Comando `claude mcp add`, tipos de transporte (HTTP recomendado), configuración de GitHub MCP, expansión de variables de entorno
- Ejercicio clave: Agregar servidor GitHub MCP y consultar PRs
- Hecho cuando: Puedes consultar datos en vivo de un servicio externo vía MCP

**MCP (puntuación 1 — revisar)**:
- Enfocarse en: .mcp.json con scope de proyecto (requiere aprobación del equipo), autenticación OAuth 2.0, recursos MCP con menciones `@server:resource`, Tool Search (ENABLE_TOOL_SEARCH), `claude mcp serve`, límites de salida (10k/25k/50k)
- Hecho cuando: Tienes un .mcp.json de proyecto y entiendes el modo automático de Tool Search

**Subagentes (puntuación 0)**:
- Tutorial: [04-subagents/](../../../04-subagents/)
- Enfocarse en: Formato de archivo de agente (.claude/agents/*.md), agentes integrados (general-purpose, Plan, Explore), configuración tools/model/permissionMode
- Ejercicio clave: Crear un subagente code-reviewer y probar delegación
- Hecho cuando: Claude delega revisión de código a tu agente personalizado

**Subagentes (puntuación 1 — revisar)**:
- Enfocarse en: Aislamiento Worktree (`isolation: worktree`), memoria persistente de agente (campo `memory` con scopes), agentes en segundo plano (Ctrl+B/Ctrl+F), allowlists de agentes con `Task(agent_name)`, equipos de agentes (`--teammate-mode`)
- Hecho cuando: Tienes un subagente con memoria persistente ejecutándose en aislamiento worktree

**Checkpoints (puntuación 0)**:
- Tutorial: [08-checkpoints/](../../../08-checkpoints/)
- Enfocarse en: Acceso Esc+Esc y /rewind, 5 opciones de rewind (restaurar código+conversación, restaurar conversación, restaurar código, resumir, cancelar), limitaciones (operaciones de filesystem bash no rastreadas)
- Ejercicio clave: Hacer cambios experimentales, luego rewind para restaurar
- Hecho cuando: Puedes experimentar con confianza sabiendo que puedes rewind

**Características Avanzadas (puntuación 0)**:
- Tutorial: [09-advanced-features/](../../../09-advanced-features/)
- Enfocarse en: Modo Planning (/plan o Shift+Tab), modos de permisos (5 tipos), extended thinking (alternar Alt+T)
- Ejercicio clave: Usar modo planning para diseñar una característica, luego implementarla
- Hecho cuando: Puedes cambiar entre modos planning e implementación fluidamente

**Características Avanzadas (puntuación 1 — revisar)**:
- Enfocarse en: Control remoto (`claude remote-control`), sesiones web (`claude --remote`), handoff de escritorio (`/desktop`), worktrees (`claude -w`), listas de tareas (Ctrl+T), configuraciones gestionadas para empresa
- Hecho cuando: Puedes transferir sesiones entre CLI, web y escritorio

**Plugins (puntuación 0)**:
- Tutorial: [07-plugins/](../../../07-plugins/)
- Enfocarse en: Estructura de plugin (.claude-plugin/plugin.json), qué empaquetan los plugins (comandos, agentes, MCP, hooks, configuraciones), instalación desde marketplace
- Ejercicio clave: Instalar un plugin y explorar sus componentes
- Hecho cuando: Entiendes cuándo usar un plugin vs componentes independientes

**Plugins (puntuación 1 — revisar)**:
- Enfocarse en: Crear manifiesto plugin.json, hooks de plugin (hooks/hooks.json), configuración LSP (.lsp.json), variable `${CLAUDE_PLUGIN_ROOT}`, --plugin-dir para testing, publicación en marketplace
- Hecho cuando: Puedes crear y probar un plugin para tu equipo

**CLI (puntuación 0)**:
- Tutorial: [10-cli/](../../../10-cli/)
- Enfocarse en: Modo interactivo vs print, `claude -p` con piping, `--output-format json`, gestión de sesiones (-c/-r)
- Ejercicio clave: Pipear un archivo a `claude -p` y obtener salida JSON
- Hecho cuando: Puedes usar Claude de forma no interactiva en un script

**CLI (puntuación 1 — revisar)**:
- Enfocarse en: Flag --agents con configuración JSON, --json-schema para salida estructurada, --fallback-model, --from-pr, --strict-mcp-config, procesamiento por lotes con bucles for, `claude mcp serve`
- Hecho cuando: Tienes un script CI/CD que usa Claude con salida JSON estructurada

---

### Paso 5: Ofrecer Acciones de Seguimiento

Después de presentar resultados, preguntar al usuario qué le gustaría hacer después:

Usar AskUserQuestion con estas opciones:
- **Comenzar aprendizaje** — "Ayúdame a comenzar el primer tema en mi ruta de aprendizaje ahora mismo"
- **Inmersión profunda en una brecha** — "Explica una de mis áreas de brecha en detalle para que pueda aprenderla aquí"
- **Proyecto de práctica** — "Configura un proyecto de práctica que cubra mis áreas de brecha"
- **Volver a hacer evaluación** — "Quiero volver a hacer el cuestionario (quizás el otro modo)"

Si **Comenzar aprendizaje**: Leer el README.md del primer tutorial de brecha y guiar al usuario a través del primer ejercicio.
Si **Inmersión profunda en una brecha**: Preguntar qué tema de brecha, luego leer el README.md del tutorial relevante y explicar los conceptos clave con ejemplos.
Si **Proyecto de práctica**: Diseñar un pequeño proyecto que combine 2-3 de sus temas de brecha con pasos concretos.
Si **Volver a hacer evaluación**: Volver al Paso 1.

## Manejo de Errores

### El usuario no selecciona ningún ítem en una ronda
Tratar como 0 puntos para los temas de esa ronda. Continuar a la siguiente ronda.

### El usuario no selecciona ningún ítem en ninguna ronda
Asignar Nivel 1: Principiante. Alentar comenzar desde el principio. Mostrar la ruta completa de Nivel 1.

### El usuario quiere volver a hacer
Re-ejecutar desde el Paso 1 con una evaluación fresca.

### El usuario no está de acuerdo con su nivel
Reconocer su preferencia. Preguntar con qué nivel se identifica. Presentar la ruta para su nivel elegido con una verificación de prerrequisitos para temas que pudo haber omitido.

### El usuario pregunta sobre un tema específico
Si el usuario dice algo como "háblame sobre hooks" o "quiero aprender MCP" durante la evaluación, notarlo. Después de presentar resultados, resaltar ese tema en su ruta de aprendizaje sin importar la puntuación.

## Validación

### Ejecutar suite de tests

**DEBERÍA activarse:**
- "evaluar mi nivel"
- "hacer el cuestionario"
- "encontrar mi nivel"
- "dónde debería empezar"
- "qué nivel tengo"
- "cuestionario de ruta de aprendizaje"
- "autoevaluación"
- "qué debería aprender después"
- "verificar mis habilidades"
- "verificación de habilidades"
- "subir de nivel"
- "qué tan bueno soy en Claude Code"
- "evaluar mi conocimiento de Claude Code"

**NO DEBERÍA activarse:**
- "revisar mi código"
- "crear una habilidad"
- "ayúdame con MCP"
- "explica comandos slash"
- "qué es un checkpoint"
