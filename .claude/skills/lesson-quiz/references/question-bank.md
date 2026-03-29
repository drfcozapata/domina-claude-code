---

# Cuestionario de Lección — Banco de Preguntas

10 preguntas por lección. Cada pregunta tiene: categoría, texto de la pregunta, opciones (3-4), respuesta correcta, explicación y sección de revisión.

---

## Lección 01: Comandos Slash

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los cuatro tipos de comandos slash en Claude Code?
- **Opciones**: A) Integrados, habilidades, comandos de plugin, prompts MCP | B) Integrados, personalizados, comandos hook, prompts API | C) Sistema, usuario, plugin, comandos de terminal | D) Core, extensión, macro, comandos de script
- **Correcta**: A
- **Explicación**: Claude Code tiene comandos integrados (como /help, /compact), habilidades (archivos SKILL.md), comandos de plugin (comandos con namespace plugin-name:command), y prompts MCP (/mcp__server__prompt).
- **Revisar**: Sección Tipos de Comandos Slash

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo pasas todos los argumentos proporcionados por el usuario a una habilidad?
- **Opciones**: A) Usar `${args}` | B) Usar `$ARGUMENTS` | C) Usar `$@` | D) Usar `$INPUT`
- **Correcta**: B
- **Explicación**: `$ARGUMENTS` captura todo el texto después del nombre del comando. Para argumentos posicionales, usar `$0`, `$1`, etc.
- **Revisar**: Sección Manejo de Argumentos

### P3
- **Categoría**: conceptual
- **Pregunta**: Cuando tanto una habilidad (.claude/skills/name/SKILL.md) como un comando legacy (.claude/commands/name.md) existen con el mismo nombre, ¿cuál tiene prioridad?
- **Opciones**: A) El comando legacy | B) La habilidad | C) El que se creó primero | D) Claude pregunta al usuario para elegir
- **Correcta**: B
- **Explicación**: Las habilidades tienen prioridad sobre los comandos legacy con el mismo nombre. El sistema de habilidades supersede al sistema de comandos más antiguo.
- **Revisar**: Sección Precedencia de Habilidades

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo inyectas salida de shell en vivo en el prompt de una habilidad?
- **Opciones**: A) Usar sintaxis `$(command)` | B) Usar sintaxis `!`command`` (backtick con !) | C) Usar sintaxis `@shell:command` | D) Usar sintaxis `{command}`
- **Correcta**: B
- **Explicación**: La sintaxis `!`command`` ejecuta un comando de shell e inyecta su salida en el prompt de la habilidad antes de que Claude lo vea.
- **Revisar**: Sección Inyección de Contexto Dinámico

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace `disable-model-invocation: true` en el frontmatter de una habilidad?
- **Opciones**: A) Previene que la habilidad se ejecute por completo | B) Permite que solo el usuario la invoque (Claude no puede auto-invocar) | C) La oculta del menú /help | D) Deshabilita el procesamiento de IA de la habilidad
- **Correcta**: B
- **Explicación**: `disable-model-invocation: true` significa que solo el usuario puede activar el comando vía `/command-name`. Claude nunca lo auto-invocará, útil para habilidades con efectos secundarios como deployments.
- **Revisar**: Sección Control de Invocación

### P6
- **Categoría**: práctica
- **Pregunta**: Quieres crear una habilidad que solo Claude pueda invocar automáticamente (oculta del menú / del usuario). ¿Qué campo del frontmatter configuras?
- **Opciones**: A) `disable-model-invocation: true` | B) `user-invocable: false` | C) `hidden: true` | D) `auto-only: true`
- **Correcta**: B
- **Explicación**: `user-invocable: false` oculta la habilidad del menú slash del usuario pero permite que Claude la invoque automáticamente basado en el contexto.
- **Revisar**: Sección Matriz de Control de Invocación

### P7
- **Categoría**: práctica
- **Pregunta**: ¿Cuál es la estructura de directorio correcta para una nueva habilidad personalizada llamada "deploy"?
- **Opciones**: A) `.claude/commands/deploy.md` | B) `.claude/skills/deploy/SKILL.md` | C) `.claude/skills/deploy.md` | D) `.claude/deploy/SKILL.md`
- **Correcta**: B
- **Explicación**: Las habilidades viven en un directorio bajo `.claude/skills/` con un archivo `SKILL.md` dentro. El nombre del directorio coincide con el nombre del comando.
- **Revisar**: Sección Tipos y Ubicaciones de Habilidades

### P8
- **Categoría**: conceptual
- **Pregunta**: ¿Cómo evitan los comandos de plugin conflictos de nombres con comandos de usuario?
- **Opciones**: A) Usan un namespace `plugin-name:command-name` | B) Tienen una extensión .plugin especial | C) Tienen prefijo `p/` | D) Sobrescriben comandos de usuario automáticamente
- **Correcta**: A
- **Explicación**: Los comandos de plugin usan un namespace como `pr-review:check-security` para evitar conflictos con comandos de usuario independientes.
- **Revisar**: Sección Comandos de Plugin

### P9
- **Categoría**: práctica
- **Pregunta**: Quieres restringir qué herramientas puede usar una habilidad. ¿Qué campo del frontmatter agregas?
- **Opciones**: A) `tools: [Read, Grep]` | B) `allowed-tools: [Read, Grep]` | C) `permissions: [Read, Grep]` | D) `restrict-tools: [Read, Grep]`
- **Correcta**: B
- **Explicación**: El campo `allowed-tools` en el frontmatter de SKILL.md delimita qué herramientas puede invocar el comando.
- **Revisar**: Sección Referencia de Campos de Frontmatter

### P10
- **Categoría**: conceptual
- **Pregunta**: ¿Para qué se usa la sintaxis `@file` en una habilidad?
- **Opciones**: A) Importar otra habilidad | B) Referenciar un archivo para incluir su contenido en el prompt | C) Crear un symlink | D) Establecer permisos de archivo
- **Correcta**: B
- **Explicación**: La sintaxis `@path/to/file` en una habilidad incluye el contenido del archivo referenciado en el prompt, permitiendo que las habilidades extraigan plantillas o archivos de contexto.
- **Revisar**: Sección Referencias de Archivos

---

## Lección 02: Memoria

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuántos niveles tiene la jerarquía de memoria de Claude Code, y qué tiene la prioridad más alta?
- **Opciones**: A) 5 niveles, Memoria de Usuario es la más alta | B) 7 niveles, Política Gestionada es la más alta | C) 3 niveles, Memoria de Proyecto es la más alta | D) 7 niveles, Auto Memoria es la más alta
- **Correcta**: B
- **Explicación**: La jerarquía tiene 7 niveles: Política Gestionada > Memoria de Proyecto > Reglas de Proyecto > Memoria de Usuario > Reglas de Usuario > Memoria de Proyecto Local > Auto Memoria. La Política Gestionada (establecida por admins) tiene la prioridad más alta.
- **Revisar**: Sección Jerarquía de Memoria

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo agregas rápidamente una nueva regla a la memoria durante una conversación?
- **Opciones**: A) Escribir `/memory add "texto de regla"` | B) Prefijar tu mensaje con `#` (por ejemplo, `# siempre usar TypeScript`) | C) Escribir `/rule "texto de regla"` | D) Usar `@add-memory "texto de regla"`
- **Correcta**: B
- **Explicación**: El patrón de prefijo `#` permite adiciones rápidas de reglas individuales durante la conversación. Claude preguntará en qué nivel de memoria guardarlo.
- **Revisar**: Sección Actualizaciones Rápidas de Memoria

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la profundidad máxima para imports `@path/to/file` en CLAUDE.md?
- **Opciones**: A) 3 niveles de profundidad | B) 5 niveles de profundidad | C) 10 niveles de profundidad | D) Ilimitado
- **Correcta**: B
- **Explicación**: La sintaxis `@import` soporta imports recursivos hasta una profundidad máxima de 5 para prevenir bucles infinitos.
- **Revisar**: Sección Sintaxis Import

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo scopes una regla para que solo aplique a archivos en `src/api/`?
- **Opciones**: A) Poner la regla en `src/api/CLAUDE.md` | B) Agregar YAML frontmatter `paths: src/api/**` a un archivo `.claude/rules/*.md` | C) Nombrar el archivo `.claude/rules/api.md` | D) Usar `@scope: src/api` en el archivo de regla
- **Correcta**: B
- **Explicación**: Los archivos en `.claude/rules/` soportan un campo `paths:` en el frontmatter con patrones glob para scoping de reglas a directorios específicos.
- **Revisar**: Sección Reglas Específicas de Ruta

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Cuántas líneas de MEMORY.md de Auto Memoria se cargan al inicio de la sesión?
- **Opciones**: A) Todas las líneas | B) Primeras 100 líneas | C) Primeras 200 líneas | D) Primeras 500 líneas
- **Correcta**: C
- **Explicación**: Las primeras 200 líneas de MEMORY.md se auto-cargan en contexto al inicio de la sesión. Los archivos de tema referenciados desde MEMORY.md se cargan bajo demanda.
- **Revisar**: Sección Auto Memoria

### P6
- **Categoría**: práctica
- **Pregunta**: Quieres preferencias de proyecto personal que NO se commiteen a git. ¿Qué archivo deberías usar?
- **Opciones**: A) `~/.claude/CLAUDE.md` | B) `CLAUDE.local.md` | C) `.claude/rules/personal.md` | D) `.claude/memory/personal.md`
- **Correcta**: B
- **Explicación**: `CLAUDE.local.md` en la raíz del proyecto es para preferencias personales específicas del proyecto. Debería estar en git-ignored.
- **Revisar**: Sección Comparación de Ubicaciones de Memoria

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace el comando `/init`?
- **Opciones**: A) Inicializa un nuevo proyecto de Claude Code desde cero | B) Genera una plantilla CLAUDE.md basada en la estructura de tu proyecto | C) Reinicia toda la memoria a valores predeterminados | D) Crea una nueva sesión
- **Correcta**: B
- **Explicación**: `/init` analiza tu proyecto y genera una plantilla CLAUDE.md con reglas y estándares sugeridos. Es una herramienta de bootstrapping de una sola vez.
- **Revisar**: Sección Comando /init

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo deshabilitas Auto Memoria completamente?
- **Opciones**: A) Eliminar el directorio ~/.claude/projects | B) Establecer `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` | C) Agregar `auto-memory: false` a CLAUDE.md | D) Usar `/memory disable auto`
- **Correcta**: B
- **Explicación**: Establecer `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` deshabilita auto memoria. Valor `0` la fuerza a encendida. Sin establecer = predeterminado encendido.
- **Revisar**: Sección Configuración de Auto Memoria

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Puede un nivel de memoria de menor prioridad sobrescribir reglas de un nivel de mayor prioridad?
- **Opciones**: A) Sí, la regla más reciente siempre gana | B) No, los niveles superiores siempre tienen precedencia | C) Sí, si el nivel inferior usa el flag `!important` | D) Depende del tipo de regla
- **Correcta**: B
- **Explicación**: La precedencia de memoria fluye hacia abajo desde Política Gestionada. Los niveles inferiores (como Auto Memoria) no pueden sobrescribir niveles superiores (como Memoria de Proyecto).
- **Revisar**: Sección Jerarquía de Memoria

### P10
- **Categoría**: práctica
- **Pregunta**: Trabajas en dos repositorios y quieres que Claude cargue CLAUDE.md de ambos. ¿Qué flag usas?
- **Opciones**: A) `--multi-repo` | B) `--add-dir /path/to/other` | C) `--include /path/to/other` | D) `--merge-context /path/to/other`
- **Correcta**: B
- **Explicación**: El flag `--add-dir` carga CLAUDE.md desde directorios adicionales, permitiendo contexto multi-repo.
- **Revisar**: Sección Directorios Adicionales

---

## Lección 03: Habilidades

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los 3 niveles de disclosure progresivo en el sistema de habilidades?
- **Opciones**: A) Metadatos, instrucciones, recursos | B) Nombre, cuerpo, adjuntos | C) Encabezado, contenido, scripts | D) Resumen, detalles, datos
- **Correcta**: A
- **Explicación**: Nivel 1: Metadatos (~100 tokens, siempre cargados), Nivel 2: Cuerpo de SKILL.md (<5k tokens, cargado en activación), Nivel 3: Recursos empaquetados (scripts/references/assets, cargados bajo demanda).
- **Revisar**: Sección Arquitectura de Disclosure Progresivo

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cuál es el factor más importante para que una habilidad sea auto-invocada por Claude?
- **Opciones**: A) El nombre del archivo de la habilidad | B) El campo `description` en el frontmatter con palabras clave de cuándo-usar | C) La ubicación del directorio de la habilidad | D) El campo de frontmatter `auto-invoke: true`
- **Correcta**: B
- **Explicación**: Claude decide si auto-invocar una habilidad basado únicamente en su campo `description`. Debe incluir frases de activación específicas y escenarios.
- **Revisar**: Sección Auto-Invocación

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la longitud máxima recomendada para un archivo SKILL.md?
- **Opciones**: A) 100 líneas | B) 250 líneas | C) 500 líneas | D) 1000 líneas
- **Correcta**: C
- **Explicación**: SKILL.md debería mantenerse bajo 500 líneas. El material de referencia más grande pertenece al subdirectorio `references/`.
- **Revisar**: Sección Directrices de Contenido

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo haces que una habilidad se ejecute en un subagente aislado con su propio contexto?
- **Opciones**: A) Establecer `isolation: true` en el frontmatter | B) Establecer `context: fork` con un campo `agent` en el frontmatter | C) Establecer `subagent: true` en el frontmatter | D) Poner la habilidad en `.claude/agents/`
- **Correcta**: B
- **Explicación**: `context: fork` ejecuta la habilidad en un contexto separado, y el campo `agent` especifica qué tipo de agente (por ejemplo, `Explore`, `Plan`, agente personalizado) usar.
- **Revisar**: Sección Ejecución de Habilidades en Subagentes

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es el presupuesto de contexto aproximado asignado a los metadatos de habilidad (Nivel 1)?
- **Opciones**: A) 0.5% de la ventana de contexto | B) 2% de la ventana de contexto | C) 5% de la ventana de contexto | D) 10% de la ventana de contexto
- **Correcta**: B
- **Explicación**: Los metadatos de habilidad ocupan aproximadamente el 2% de la ventana de contexto (fallback: 16,000 caracteres). Esto es configurable con `SLASH_COMMAND_TOOL_CHAR_BUDGET`.
- **Revisar**: Sección Presupuesto de Contexto

### P6
- **Categoría**: práctica
- **Pregunta**: Una habilidad necesita referenciar una especificación API grande. ¿Dónde deberías ponerla?
- **Opciones**: A) En línea en SKILL.md | B) En un archivo `references/api-spec.md` dentro del directorio de la habilidad | C) En el CLAUDE.md del proyecto | D) En un archivo `.claude/rules/` separado
- **Correcta**: B
- **Explicación**: El material de referencia grande pertenece al subdirectorio `references/`. Claude carga recursos de Nivel 3 bajo demanda, manteniendo SKILL.md ligero.
- **Revisar**: Sección Estructura de Archivos de Soporte

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la diferencia entre Contenido de Referencia y Contenido de Tarea en una habilidad?
- **Opciones**: A) Referencia es solo lectura, Tarea es lectura-escritura | B) Referencia agrega conocimiento al contexto, Tarea proporciona instrucciones paso a paso | C) Referencia es para documentación, Tarea es para código | D) No hay diferencia
- **Correcta**: B
- **Explicación**: Contenido de Referencia agrega conocimiento de dominio al contexto de Claude (por ejemplo, directrices de marca). Contenido de Tarea proporciona instrucciones accionables paso a paso para un flujo de trabajo.
- **Revisar**: Sección Tipos de Contenido de Habilidad

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Qué caracteres están permitidos en el campo `name` del frontmatter de una habilidad?
- **Opciones**: A) Cualquier carácter | B) Solo letras minúsculas, números y guiones (máx 64 caracteres) | C) Letras y guiones bajos | D) Solo alfanumérico
- **Correcta**: B
- **Explicación**: El nombre debe ser kebab-case (minúsculas, guiones), máx 64 caracteres, y no puede contener "anthropic" o "claude".
- **Revisar**: Sección Formato SKILL.md

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿En qué orden busca Claude las habilidades?
- **Opciones**: A) Usuario > Proyecto > Empresa | B) Empresa > Personal > Proyecto (los plugins usan namespace) | C) Proyecto > Usuario > Empresa | D) Orden alfabético
- **Correcta**: B
- **Explicación**: El orden de prioridad es: Empresa > Personal > Proyecto. Las habilidades de plugin usan un namespace (plugin-name:skill) así que no entran en conflicto.
- **Revisar**: Sección Tipos y Ubicaciones de Habilidades

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Cómo previenes que Claude invoque automáticamente una habilidad mientras aún permites que los usuarios la usen manualmente?
- **Opciones**: A) Establecer `user-invocable: false` | B) Establecer `disable-model-invocation: true` | C) Eliminar el campo description | D) Establecer `auto-invoke: false`
- **Correcta**: B
- **Explicación**: `disable-model-invocation: true` previene que Claude auto-invoque pero mantiene la habilidad disponible en el menú `/` del usuario para uso manual.
- **Revisar**: Sección Control de Invocación

---

## Lección 04: Subagentes

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la ventaja principal de los subagentes sobre la conversación en línea?
- **Opciones**: A) Son más rápidos | B) Operan en una ventana de contexto separada y limpia previniendo contaminación de contexto | C) Pueden usar más herramientas | D) Tienen mejor manejo de errores
- **Correcta**: B
- **Explicación**: Los subagentes obtienen una ventana de contexto fresca, recibiendo solo lo que el agente principal pasa. Esto previene que la conversación principal sea contaminada con detalles específicos de la tarea.
- **Revisar**: Sección Visión General

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cuál es el orden de prioridad para las definiciones de agentes?
- **Opciones**: A) Proyecto > Usuario > CLI | B) CLI > Usuario > Proyecto | C) Usuario > Proyecto > CLI | D) Todos tienen igual prioridad
- **Correcta**: B
- **Explicación**: Los agentes definidos por CLI (flag `--agents`) sobrescriben los de nivel de Usuario (`~/.claude/agents/`), que sobrescriben los de nivel de Proyecto (`.claude/agents/`).
- **Revisar**: Sección Ubicaciones de Archivos

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Qué subagente integrado usa el modelo Haiku y está optimizado para exploración de código de solo lectura?
- **Opciones**: A) general-purpose | B) Plan | C) Explore | D) Bash
- **Correcta**: C
- **Explicación**: El subagente Explore usa Haiku para exploración rápida de código de solo lectura. Soporta tres niveles de exhaustividad: quick, medium, very thorough.
- **Revisar**: Sección Subagentes Integrados

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo restringes qué subagentes puede spawnear un agente coordinador?
- **Opciones**: A) Usar campo `allowed-agents:` | B) Usar sintaxis `Task(agent_name)` en el campo `tools` | C) Establecer `spawn-limit: 2` | D) Usar `restrict-agents: [name1, name2]`
- **Correcta**: B
- **Explicación**: Agregar `Task(worker, researcher)` en el campo tools crea una allowlist — el agente solo puede spawnear subagentes llamados "worker" o "researcher".
- **Revisar**: Sección Restringir Subagentes Spawneables

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace `isolation: worktree` para un subagente?
- **Opciones**: A) Ejecuta el agente en un contenedor Docker | B) Da al agente su propio worktree de git así los cambios no afectan el árbol principal | C) Previene que el agente lea cualquier archivo | D) Ejecuta el agente en un sandbox
- **Correcta**: B
- **Explicación**: El aislamiento Worktree crea un worktree de git separado. Si el agente no hace cambios, se auto-limpia. Si se hacen cambios, se devuelve la ruta del worktree y la rama.
- **Revisar**: Sección Aislamiento Worktree

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Cómo haces que un subagente se ejecute en segundo plano?
- **Opciones**: A) Establecer `background: true` en la configuración del agente | B) Usar `async: true` en la configuración del agente | C) Presionar Ctrl+D después de iniciarlo | D) Usar flag `--background` de CLI
- **Correcta**: A
- **Explicación**: `background: true` en la configuración del agente hace que el subagente siempre se ejecute como tarea en segundo plano. Los usuarios también pueden usar Ctrl+B para enviar una tarea en primer plano a segundo plano.
- **Revisar**: Sección Subagentes en Segundo Plano

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace el campo `memory` con scope `project` para un subagente?
- **Opciones**: A) Da acceso de lectura al CLAUDE.md del proyecto | B) Crea un directorio de memoria persistente con scope al proyecto actual | C) Comparte el historial de conversación del agente principal | D) Carga el historial de git del proyecto
- **Correcta**: B
- **Explicación**: El campo `memory` crea un directorio persistente para el subagente. Scope `project` significa que la memoria está atada al proyecto actual. Las primeras 200 líneas del MEMORY.md del agente se auto-cargan.
- **Revisar**: Sección Memoria Persistente

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo incluyes una frase en la descripción de un subagente para animar a Claude a delegar tareas automáticamente a él?
- **Opciones**: A) Agregar "priority: high" | B) Incluir "use PROACTIVELY" o "MUST BE USED" en la descripción | C) Establecer `auto-delegate: true` | D) Agregar "trigger: always"
- **Correcta**: B
- **Explicación**: Incluir frases como "use PROACTIVELY" o "MUST BE USED" en la descripción anima fuertemente a Claude a delegar automáticamente tareas coincidentes.
- **Revisar**: Sección Delegación Automática

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los valores válidos de `permissionMode` para un subagente?
- **Opciones**: A) read, write, admin | B) default, acceptEdits, bypassPermissions, plan, dontAsk, auto | C) safe, normal, dangerous | D) restricted, standard, elevated
- **Correcta**: B
- **Explicación**: Los subagentes soportan seis modos de permisos: default (prompts para todo), acceptEdits (auto-acepta ediciones de archivos), bypassPermissions (omite todo), plan (solo lectura), dontAsk (auto-deniega a menos que esté pre-aprobado), auto (clasificador en segundo plano decide).
- **Revisar**: Sección Campos de Configuración

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Cómo reanudas un subagente que devolvió un agentId de una ejecución anterior?
- **Opciones**: A) Usar `/resume agent-id` | B) Pasar el parámetro `resume` con el agentId al llamar la herramienta Task | C) Usar `claude -r agent-id` | D) Los subagentes no pueden reanudarse
- **Correcta**: B
- **Explicación**: Los subagentes pueden reanudarse pasando el parámetro `resume` con el agentId previamente devuelto, continuando con el contexto completo preservado.
- **Revisar**: Sección Agentes Reanudables

---

## Lección 05: MCP

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los tres protocolos de transporte MCP, y cuál se recomienda?
- **Opciones**: A) HTTP (recomendado), Stdio, SSE (obsoleto) | B) WebSocket (recomendado), REST, gRPC | C) TCP, UDP, HTTP | D) Stdio (recomendado), HTTP, SSE
- **Correcta**: A
- **Explicación**: HTTP se recomienda para servidores remotos. Stdio es para procesos locales (el más común actualmente). SSE está obsoleto pero aún soportado.
- **Revisar**: Sección Protocolos de Transporte

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo agregas un servidor MCP de GitHub vía CLI?
- **Opciones**: A) `claude mcp install github` | B) `claude mcp add --transport http github https://api.github.com/mcp` | C) `claude plugin add github-mcp` | D) `claude connect github`
- **Correcta**: B
- **Explicación**: Usar `claude mcp add` con flag `--transport`, un nombre, y la URL del servidor. Para stdio: `claude mcp add github -- npx -y @modelcontextprotocol/server-github`.
- **Revisar**: Sección Gestión de Configuración MCP

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Qué pasa cuando las descripciones de herramientas MCP exceden el 10% de la ventana de contexto?
- **Opciones**: A) Se truncan | B) Tool Search se auto-activa para seleccionar dinámicamente herramientas relevantes | C) Claude muestra un error | D) Las herramientas extra se deshabilitan
- **Correcta**: B
- **Explicación**: MCP Tool Search se auto-activa cuando las herramientas exceden el 10% del contexto. Requiere Sonnet 4 o Opus 4 mínimo (Haiku no soportado).
- **Revisar**: Sección MCP Tool Search

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo usas fallbacks de variables de entorno en configuración MCP?
- **Opciones**: A) `${VAR || "default"}` | B) `${VAR:-default}` | C) `${VAR:default}` | D) `${VAR ? "default"}`
- **Correcta**: B
- **Explicación**: `${VAR:-default}` proporciona un valor de fallback si la variable de entorno no está establecida. `${VAR}` sin fallback dará error si no está establecida.
- **Revisar**: Sección Expansión de Variables de Entorno

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la diferencia entre MCP y Memoria para acceso de datos?
- **Opciones**: A) MCP es más rápido, Memoria es más lenta | B) MCP es para datos externos en vivo/cambiantes, Memoria es para preferencias persistentes/estáticas | C) MCP es para código, Memoria es para texto | D) Son intercambiables
- **Correcta**: B
- **Explicación**: MCP se conecta a fuentes de datos externas en vivo y cambiantes (APIs, bases de datos). Memoria almacena contexto de proyecto y preferencias estáticas persistentes.
- **Revisar**: Sección MCP vs Memoria

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Qué pasa cuando un miembro del equipo encuentra por primera vez un `.mcp.json` con scope de proyecto?
- **Opciones**: A) Se carga automáticamente | B) Reciben un prompt de aprobación para confiar en los servidores MCP del proyecto | C) Se ignora a menos que opten vía configuraciones | D) Claude pregunta al admin para aprobar
- **Correcta**: B
- **Explicación**: `.mcp.json` con scope de proyecto activa un prompt de aprobación de seguridad en el primer uso de cada miembro del equipo. Esto es intencional — previene servidores MCP no confiables.
- **Revisar**: Sección Alcances MCP

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace `claude mcp serve`?
- **Opciones**: A) Inicia un dashboard de servidor MCP | B) Hace que Claude Code mismo actúe como un servidor MCP para otras aplicaciones | C) Sirve documentación MCP | D) Prueba conexiones de servidor MCP
- **Correcta**: B
- **Explicación**: `claude mcp serve` convierte a Claude Code en un servidor MCP, habilitando orquestación multi-agente donde una instancia de Claude puede ser controlada por otra.
- **Revisar**: Sección Claude como Servidor MCP

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cuál es el tamaño máximo de salida predeterminado para herramientas MCP?
- **Opciones**: A) 5,000 tokens | B) 10,000 tokens | C) 25,000 tokens | D) 50,000 tokens
- **Correcta**: C
- **Explicación**: El máx predeterminado es 25,000 tokens (`MAX_MCP_OUTPUT_TOKENS`). Una advertencia aparece a los 10k tokens. La persistencia en disco tiene tope en 50k caracteres.
- **Revisar**: Sección Límites de Salida MCP

### P9
- **Categoría**: conceptual
- **Pregunta**: Cuando tanto `allowedMcpServers` como `deniedMcpServers` coinciden con un servidor en configuración gestionada, ¿cuál gana?
- **Opciones**: A) Allowed gana | B) Denied gana | C) El último configurado gana | D) Ambos se aplican independientemente
- **Correcta**: B
- **Explicación**: En configuración MCP gestionada, las reglas de denegación siempre tienen precedencia sobre las reglas de permiso.
- **Revisar**: Sección Configuración MCP Gestionada

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Cómo referencias un recurso MCP en una conversación?
- **Opciones**: A) Usar `/mcp resource-name` | B) Usar sintaxis de mención `@server-name:protocol://resource/path` | C) Usar `mcp.get("resource")` | D) Los recursos no pueden referenciarse
- **Correcta**: B
- **Explicación**: Los recursos MCP se acceden vía sintaxis de mención `@server-name:protocol://resource/path` en la conversación.
- **Revisar**: Sección Recursos MCP

---

## Lección 06: Hooks

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los cuatro tipos de hooks en Claude Code?
- **Opciones**: A) Hooks Pre, Post, Error y Filter | B) Hooks Command, HTTP, Prompt y Agent | C) Hooks Before, After, Around y Through | D) Hooks Input, Output, Filter y Transform
- **Correcta**: B
- **Explicación**: Los hooks Command ejecutan scripts de shell, los hooks HTTP llaman endpoints de webhook, los hooks Prompt usan evaluación LLM de un solo turno, y los hooks Agent usan verificación basada en subagente.
- **Revisar**: Sección Tipos de Hooks

### P2
- **Categoría**: práctica
- **Pregunta**: Un script de hook sale con código 2. ¿Qué pasa?
- **Opciones**: A) Advertencia no bloqueante mostrada | B) Error bloqueante — stderr se muestra como error a Claude, se previene el uso de la herramienta | C) El hook se reintenta | D) La sesión termina
- **Correcta**: B
- **Explicación**: Código de salida 0 = éxito/continuar, código de salida 2 = error bloqueante (stderr mostrado como error), cualquier otro no-cero = no bloqueante (stderr solo en verbose).
- **Revisar**: Sección Códigos de Salida

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Qué campos JSON recibe un hook PreToolUse en stdin?
- **Opciones**: A) `tool_name` y `tool_output` | B) `session_id`, `tool_name`, `tool_input`, `hook_event_name`, `cwd`, y más | C) Solo `tool_name` | D) El historial completo de conversación
- **Correcta**: B
- **Explicación**: Los hooks reciben un objeto JSON en stdin con: session_id, transcript_path, hook_event_name, tool_name, tool_input, tool_use_id, cwd, y permission_mode.
- **Revisar**: Sección Estructura de Entrada JSON

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo puede un hook PreToolUse modificar los parámetros de entrada de la herramienta antes de la ejecución?
- **Opciones**: A) Devolver JSON modificado en stderr | B) Devolver JSON con campo `updatedInput` en stdout (código de salida 0) | C) Escribir en un archivo temporal | D) Los hooks no pueden modificar entradas
- **Correcta**: B
- **Explicación**: Un hook PreToolUse puede producir JSON con `"updatedInput": {...}` en stdout (con salida 0) para modificar los parámetros de la herramienta antes de que Claude los use.
- **Revisar**: Sección Salida PreToolUse

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Qué evento de hook soporta `CLAUDE_ENV_FILE` para persistir variables de entorno en la sesión?
- **Opciones**: A) PreToolUse | B) UserPromptSubmit | C) SessionStart | D) Todos los eventos
- **Correcta**: C
- **Explicación**: Solo los hooks SessionStart pueden usar `CLAUDE_ENV_FILE` para persistir variables de entorno en la sesión.
- **Revisar**: Sección SessionStart

### P6
- **Categoría**: práctica
- **Pregunta**: Quieres un hook que solo se ejecute una vez cuando una habilidad se carga por primera vez, no en cada llamada de herramienta. ¿Qué campo agregas?
- **Opciones**: A) `run-once: true` | B) `once: true` en la definición de hook de componente | C) `single: true` | D) `max-runs: 1`
- **Correcta**: B
- **Explicación**: Los hooks con scope de componente (definidos en SKILL.md o frontmatter de agente) soportan `once: true` para ejecutarse solo en la primera activación.
- **Revisar**: Sección Hooks con Scope de Componente

### P7
- **Categoría**: conceptual
- **Pregunta**: Un hook Stop está definido en el frontmatter de un subagente. ¿A qué se convierte automáticamente?
- **Opciones**: A) Un hook PostToolUse | B) Un hook SubagentStop | C) Un hook SessionEnd | D) Permanece como hook Stop
- **Correcta**: B
- **Explicación**: Cuando un hook Stop se coloca en el frontmatter de un subagente, se auto-convierte a SubagentStop así se ejecuta cuando ese subagente específico termina.
- **Revisar**: Sección Hooks con Scope de Componente

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo haces match de un hook a todas las herramientas MCP de un servidor específico?
- **Opciones**: A) `matcher: "mcp_github"` | B) `matcher: "mcp__github__.*"` (patrón regex) | C) `matcher: "mcp:github:*"` | D) `matcher: "github-mcp"`
- **Correcta**: B
- **Explicación**: Usar patrones regex para matchers. Las herramientas MCP siguen la convención de nombres `mcp__server__tool`, así `mcp__github__.*` coincide con todas las herramientas MCP de GitHub.
- **Revisar**: Sección Patrones Matcher

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Cuántos eventos de hook soporta Claude Code en total?
- **Opciones**: A) 10 | B) 16 | C) 25 | D) 30
- **Correcta**: C
- **Explicación**: Claude Code soporta 25 eventos de hook: PreToolUse, PostToolUse, PostToolUseFailure, UserPromptSubmit, Stop, StopFailure, SubagentStop, SubagentStart, PermissionRequest, Notification, PreCompact, PostCompact, SessionStart, SessionEnd, WorktreeCreate, WorktreeRemove, ConfigChange, CwdChanged, FileChanged, TeammateIdle, TaskCompleted, TaskCreated, Elicitation, ElicitationResult, InstructionsLoaded.
- **Revisar**: Sección Tabla de Eventos de Hook

### P10
- **Categoría**: práctica
- **Pregunta**: Quieres depurar por qué un hook no se está activando. ¿Cuál es el mejor enfoque?
- **Opciones**: A) Agregar sentencias print al script del hook | B) Usar flag `--debug` y modo verbose con `Ctrl+O` | C) Verificar el log del sistema | D) Los hooks no tienen herramientas de depuración
- **Correcta**: B
- **Explicación**: El flag `--debug` y el modo verbose `Ctrl+O` muestran detalles de ejecución de hooks incluyendo qué hooks se activan, sus entradas y salidas.
- **Revisar**: Sección Depuración

---

## Lección 07: Plugins

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es el archivo de manifiesto principal para un plugin y dónde vive?
- **Opciones**: A) `plugin.yaml` en el directorio raíz | B) `.claude-plugin/plugin.json` | C) `package.json` con una clave "claude" | D) `.claude/plugin.md`
- **Correcta**: B
- **Explicación**: El manifiesto del plugin vive en `.claude-plugin/plugin.json` con campos requeridos: name, description, version, author.
- **Revisar**: Sección Estructura de Definición de Plugin

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo pruebas un plugin localmente antes de publicar?
- **Opciones**: A) Usar `/plugin test ./my-plugin` | B) Usar `claude --plugin-dir ./my-plugin` | C) Usar `claude plugin validate ./my-plugin` | D) Copiarlo a ~/.claude/plugins/
- **Correcta**: B
- **Explicación**: El flag `--plugin-dir` carga un plugin desde un directorio local para testing. Es repetible para cargar múltiples plugins.
- **Revisar**: Sección Testing

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Qué variable de entorno está disponible dentro de hooks de plugin y configuraciones MCP para referenciar el directorio de instalación del plugin?
- **Opciones**: A) `$PLUGIN_HOME` | B) `${CLAUDE_PLUGIN_ROOT}` | C) `$PLUGIN_DIR` | D) `${CLAUDE_PLUGIN_PATH}`
- **Correcta**: B
- **Explicación**: `${CLAUDE_PLUGIN_ROOT}` se resuelve al directorio instalado del plugin, habilitando referencias de ruta portables en hooks y configuraciones MCP.
- **Revisar**: Sección Estructura de Directorio de Plugin

### P4
- **Categoría**: práctica
- **Pregunta**: Un plugin tiene un comando llamado "check-security" en el plugin "pr-review". ¿Cómo lo invoca un usuario?
- **Opciones**: A) `/check-security` | B) `/pr-review:check-security` | C) `/plugin pr-review check-security` | D) `/pr-review/check-security`
- **Correcta**: B
- **Explicación**: Los comandos de plugin usan un namespace `plugin-name:command-name` para evitar conflictos con comandos de usuario y otros plugins.
- **Revisar**: Sección Comandos de Plugin

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Qué componentes puede empaquetar un plugin?
- **Opciones**: A) Solo comandos y configuraciones | B) Comandos, agentes, habilidades, hooks, servidores MCP, configuración LSP, configuraciones, plantillas, scripts | C) Solo comandos, hooks y servidores MCP | D) Solo habilidades y agentes
- **Correcta**: B
- **Explicación**: Los plugins pueden empaquetar: commands/, agents/, skills/, hooks/hooks.json, .mcp.json, .lsp.json, settings.json, templates/, scripts/, docs/, tests/.
- **Revisar**: Sección Estructura de Directorio de Plugin

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Cómo instalas un plugin desde GitHub?
- **Opciones**: A) `claude plugin add github:username/repo` | B) `/plugin install github:username/repo` | C) `npm install @claude/username-repo` | D) `git clone` luego `claude plugin register`
- **Correcta**: B
- **Explicación**: Usar `/plugin install github:username/repo` para instalar directamente desde un repositorio de GitHub.
- **Revisar**: Sección Métodos de Instalación

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace la clave `agent` de `settings.json` en un plugin?
- **Opciones**: A) Especifica credenciales de autenticación | B) Establece el agente de hilo principal para el plugin | C) Lista subagentes disponibles | D) Configura permisos de agente
- **Correcta**: B
- **Explicación**: La clave `agent` en el settings.json de un plugin especifica qué definición de agente usar como agente de hilo principal cuando el plugin está activo.
- **Revisar**: Sección Configuraciones de Plugin

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo gestionas el ciclo de vida del plugin (habilitar/deshabilitar/actualizar)?
- **Opciones**: A) Editar un archivo de configuración manualmente | B) Usar `/plugin enable`, `/plugin disable`, `/plugin update plugin-name` | C) Usar `claude plugin-manager` | D) Reinstalar el plugin
- **Correcta**: B
- **Explicación**: Claude Code proporciona comandos slash para gestión completa del ciclo de vida: enable, disable, update, uninstall.
- **Revisar**: Sección Métodos de Instalación

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la ventaja principal de un plugin sobre habilidades/hooks/MCP independientes?
- **Opciones**: A) Los plugins son más rápidos | B) Instalación con un comando, versionado, distribución en marketplace, empaqueta todo junto | C) Los plugins tienen más permisos | D) Los plugins funcionan offline
- **Correcta**: B
- **Explicación**: Los plugins empaquetan múltiples componentes en una unidad instalable con versionado, distribución en marketplace y actualizaciones automáticas — vs. configuración manual de componentes independientes.
- **Revisar**: Sección Comparación Independiente vs Plugin

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Dónde vive la configuración de hooks de plugin dentro del directorio del plugin?
- **Opciones**: A) `.claude-plugin/hooks.json` | B) `hooks/hooks.json` | C) Sección hooks de `plugin.json` | D) `.claude/settings.json`
- **Correcta**: B
- **Explicación**: Los hooks de plugin están configurados en `hooks/hooks.json` dentro de la estructura de directorio del plugin.
- **Revisar**: Sección Hooks de Plugin

---

## Lección 08: Checkpoints

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Qué cuatro cosas capturan los checkpoints?
- **Opciones**: A) Commits de git, ramas, tags, stashes | B) Mensajes, modificaciones de archivos, historial de uso de herramientas, contexto de sesión | C) Código, tests, logs, configuraciones | D) Entradas, salidas, errores, timing
- **Correcta**: B
- **Explicación**: Los checkpoints capturan mensajes de conversación, modificaciones de archivos hechas por herramientas de Claude, historial de uso de herramientas y contexto de sesión.
- **Revisar**: Sección Visión General

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo accedes al navegador de checkpoints?
- **Opciones**: A) Usar comando `/checkpoints` | B) Presionar `Esc + Esc` (doble escape) o usar `/rewind` | C) Usar comando `/history` | D) Presionar `Ctrl+Z`
- **Correcta**: B
- **Explicación**: Doble escape (Esc+Esc) o el comando `/rewind` abre el navegador de checkpoints para seleccionar un punto de restauración.
- **Revisar**: Sección Accediendo a Checkpoints

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Cuántas opciones de rewind hay disponibles, y cuáles son?
- **Opciones**: A) 3: Undo, Redo, Reset | B) 5: Restaurar código+conversación, Restaurar conversación, Restaurar código, Resumir desde aquí, Nunca importa | C) 2: Restauración completa, Restauración parcial | D) 4: Código, Mensajes, Ambos, Cancelar
- **Correcta**: B
- **Explicación**: Las 5 opciones son: Restaurar código y conversación (rollback completo), Restaurar solo conversación, Restaurar solo código, Resumir desde aquí (comprimir), Nunca importa (cancelar).
- **Revisar**: Sección Opciones de Rewind

### P4
- **Categoría**: práctica
- **Pregunta**: Usaste `rm -rf temp/` vía Bash en Claude Code, luego quieres rewind. ¿El checkpoint restaurará esos archivos?
- **Opciones**: A) Sí, los checkpoints capturan todo | B) No, las operaciones de filesystem de Bash (rm, mv, cp) no son rastreadas por checkpoints | C) Solo si usaste la herramienta Edit en su lugar | D) Solo si autoCheckpoint estaba habilitado
- **Correcta**: B
- **Explicación**: Los checkpoints solo rastrean cambios de archivos hechos por herramientas de Claude (Write, Edit). Comandos Bash como rm, mv, cp operan fuera del rastreo de checkpoints.
- **Revisar**: Sección Limitaciones

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Por cuánto tiempo se retienen los checkpoints?
- **Opciones**: A) Hasta que la sesión termine | B) 7 días | C) 30 días | D) Indefinidamente
- **Correcta**: C
- **Explicación**: Los checkpoints persisten entre sesiones hasta por 30 días, después de los cuales se limpian automáticamente.
- **Revisar**: Sección Persistencia de Checkpoints

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Qué hace "Summarize from here" al rewind?
- **Opciones**: A) Elimina la conversación desde ese punto | B) Comprime la conversación en un resumen generado por IA mientras preserva el original en la transcripción | C) Crea una lista de puntos de cambios | D) Exporta la conversación a un archivo
- **Correcta**: B
- **Explicación**: Summarize comprime la conversación en un resumen más corto generado por IA. El texto completo original se preserva en el archivo de transcripción.
- **Revisar**: Sección Opción Summarize

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Cuándo se crean los checkpoints automáticamente?
- **Opciones**: A) Cada 5 minutos | B) En cada prompt de usuario | C) Solo cuando guardas manualmente | D) Después de cada uso de herramienta
- **Correcta**: B
- **Explicación**: Los checkpoints automáticos se crean con cada prompt de usuario, capturando el estado antes de que Claude procese la solicitud.
- **Revisar**: Sección Checkpoints Automáticos

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo deshabilitas la creación automática de checkpoints?
- **Opciones**: A) Usar flag `--no-checkpoints` | B) Establecer `autoCheckpoint: false` en configuraciones | C) Eliminar el directorio checkpoints | D) Los checkpoints no pueden deshabilitarse
- **Correcta**: B
- **Explicación**: Establecer `autoCheckpoint: false` en tu configuración para deshabilitar la creación automática de checkpoints (predeterminado es true).
- **Revisar**: Sección Configuración

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Son los checkpoints un reemplazo para los commits de git?
- **Opciones**: A) Sí, son más poderosos | B) No, son complementarios — los checkpoints tienen scope de sesión y expiran, git es permanente y compartible | C) Sí, para proyectos pequeños | D) Solo en desarrollo en solitario
- **Correcta**: B
- **Explicación**: Los checkpoints son temporales (retención de 30 días), con scope de sesión, y no pueden compartirse. Los commits de git son permanentes, auditables y compartibles. Usar ambos juntos.
- **Revisar**: Sección Integración con git

### P10
- **Categoría**: práctica
- **Pregunta**: Quieres comparar dos enfoques diferentes. ¿Cuál es el flujo de trabajo de checkpoint recomendado?
- **Opciones**: A) Crear dos sesiones separadas | B) Checkpoint antes del enfoque A, probarlo, rewind al checkpoint, probar enfoque B, comparar resultados | C) Usar ramas de git en su lugar | D) No hay una buena forma de comparar enfoques
- **Correcta**: B
- **Explicación**: La estrategia de ramificación: checkpoint en estado limpio, probar enfoque A, notar resultados, rewind al mismo checkpoint, probar enfoque B. Comparar ambos resultados.
- **Revisar**: Sección Patrones de Flujo de Trabajo

---

## Lección 09: Características Avanzadas

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los seis modos de permisos en Claude Code?
- **Opciones**: A) read, write, execute, admin, root, sudo | B) default, acceptEdits, plan, auto, dontAsk, bypassPermissions | C) safe, normal, elevated, admin, unrestricted, god | D) view, edit, run, deploy, full, bypass
- **Correcta**: B
- **Explicación**: Los seis modos son: default (prompts para todo), acceptEdits (auto-acepta ediciones de archivos), plan (análisis de solo lectura), auto (clasificador en segundo plano decide), dontAsk (auto-deniega a menos que esté pre-aprobado), bypassPermissions (omite todas las verificaciones).
- **Revisar**: Sección Modos de Permisos

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo activas el modo planning?
- **Opciones**: A) Solo vía comando `/plan` | B) Vía `/plan`, `Shift+Tab`/`Alt+M`, flag `--permission-mode plan`, o configuración predeterminada | C) Solo vía flag `--planning` | D) Planning está siempre encendido
- **Correcta**: B
- **Explicación**: El modo planning puede activarse de múltiples formas: comando /plan, atajo de teclado Shift+Tab/Alt+M, flag CLI --permission-mode plan, o como predeterminado en configuración.
- **Revisar**: Sección Modo Planning

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Qué hace el alias de modelo `opusplan`?
- **Opciones**: A) Usa solo Opus para todo | B) Usa Opus para la fase de planning y Sonnet para implementación | C) Usa un modelo especial optimizado para planning | D) Habilita modo plan automáticamente
- **Correcta**: B
- **Explicación**: `opusplan` es un alias de modelo que usa Opus para la fase de planning (análisis de mayor calidad) y Sonnet para la fase de ejecución (implementación más rápida).
- **Revisar**: Sección Modo Planning

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo alternas extended thinking durante una sesión?
- **Opciones**: A) Escribir `/think` | B) Presionar `Option+T` (macOS) o `Alt+T` | C) Usar flag `--thinking` | D) Siempre está habilitado y no puede alternarse
- **Correcta**: B
- **Explicación**: Option+T (macOS) o Alt+T alterna extended thinking. Está habilitado predeterminadamente para todos los modelos. Opus 4.6 soporta niveles de esfuerzo adaptativos.
- **Revisar**: Sección Extended Thinking

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Son "think" o "ultrathink" palabras clave especiales que activan pensamiento mejorado?
- **Opciones**: A) Sí, activan razonamiento más profundo | B) No, se tratan como texto regular de prompt sin comportamiento especial | C) Solo "ultrathink" es especial | D) Funcionan solo con Opus
- **Correcta**: B
- **Explicación**: La documentación establece explícitamente que estas son instrucciones regulares de prompt, no palabras clave de activación especiales. Extended thinking se controla vía alternancia Alt+T y variables de entorno.
- **Revisar**: Sección Extended Thinking

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Cómo ejecutas Claude en un pipeline CI/CD con salida JSON estructurada y límite de turnos?
- **Opciones**: A) `claude --ci --json --limit 3` | B) `claude -p --output-format json --max-turns 3 "review code"` | C) `claude --pipeline --format json` | D) `claude run --json --turns 3`
- **Correcta**: B
- **Explicación**: Modo Print (`-p`) con `--output-format json` y `--max-turns` es el patrón estándar de integración CI/CD.
- **Revisar**: Sección Modo Headless/Print

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Qué proporciona la característica Task List (Ctrl+T)?
- **Opciones**: A) Una lista de procesos en segundo plano ejecutándose | B) Una lista de to-do persistente que sobrevive la compactación de contexto, compartible vía `CLAUDE_CODE_TASK_LIST_ID` | C) Un historial de sesiones pasadas | D) Una cola de llamadas de herramientas pendientes
- **Correcta**: B
- **Explicación**: La Task List (Ctrl+T) es persistente entre compactaciones de contexto y puede compartirse entre sesiones vía directorios de tareas con nombre usando `CLAUDE_CODE_TASK_LIST_ID`.
- **Revisar**: Sección Task List

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo editas un plan externamente (en tu editor preferido) durante el modo planning?
- **Opciones**: A) Copiar-pegar desde la terminal | B) Presionar `Ctrl+G` para abrir el plan en un editor externo | C) Usar comando `/export-plan` | D) Los planes no pueden editarse externamente
- **Correcta**: B
- **Explicación**: Ctrl+G abre el plan actual en tu editor externo configurado para modificación.
- **Revisar**: Sección Modo Planning

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la diferencia entre los modos `dontAsk` y `bypassPermissions`?
- **Opciones**: A) Son lo mismo | B) `dontAsk` auto-deniega a menos que esté pre-aprobado; `bypassPermissions` omite todas las verificaciones por completo | C) `dontAsk` es para archivos; `bypassPermissions` es para comandos | D) `bypassPermissions` es más seguro
- **Correcta**: B
- **Explicación**: dontAsk auto-deniega solicitudes de permisos a menos que coincidan con patrones pre-aprobados. bypassPermissions omite todas las verificaciones de seguridad por completo — es peligroso para uso rutinario.
- **Revisar**: Sección Modos de Permisos

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Cómo transfieres una sesión de CLI a la aplicación de escritorio?
- **Opciones**: A) Usar comando `/export` | B) Usar comando `/desktop` | C) Copiar el ID de sesión y pegar en la app | D) Las sesiones no pueden transferirse entre CLI y escritorio
- **Correcta**: B
- **Explicación**: El comando `/desktop` transfiere la sesión actual de CLI a la aplicación nativa de escritorio para revisión de diff visual y gestión multi-sesión.
- **Revisar**: Sección Aplicación de Escritorio

---

## Lección 10: Referencia CLI

### P1
- **Categoría**: conceptual
- **Pregunta**: ¿Cuáles son los dos modos primarios de la CLI de Claude?
- **Opciones**: A) Modo online y offline | B) REPL interactivo (`claude`) y modo print (`claude -p`) | C) Modo GUI y terminal | D) Modo individual y por lotes
- **Correcta**: B
- **Explicación**: REPL interactivo es el modo conversacional predeterminado. Modo print (-p) es no interactivo, scriptable, pipeable — sale después de una respuesta.
- **Revisar**: Sección Arquitectura CLI

### P2
- **Categoría**: práctica
- **Pregunta**: ¿Cómo pipeas un archivo a Claude y obtienes salida JSON?
- **Opciones**: A) `claude --file error.log --json` | B) `cat error.log | claude -p --output-format json "explain this"` | C) `claude < error.log --format json` | D) `claude -p --input error.log --json`
- **Correcta**: B
- **Explicación**: Pipear contenido vía stdin a modo print (-p) y usar --output-format json para salida estructurada.
- **Revisar**: Sección Modo Interactivo vs Print

### P3
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es la diferencia entre los flags `-c` y `-r`?
- **Opciones**: A) Ambos hacen lo mismo | B) `-c` continúa la sesión más reciente; `-r` reanuda por nombre o ID | C) `-c` crea una nueva sesión; `-r` reanuda | D) `-c` es para código; `-r` es para revisión
- **Correcta**: B
- **Explicación**: `-c/--continue` reanuda la conversación más reciente. `-r/--resume "name"` reanuda una sesión específica por nombre o ID de sesión.
- **Revisar**: Sección Gestión de Sesiones

### P4
- **Categoría**: práctica
- **Pregunta**: ¿Cómo garantizas salida JSON válida en esquema desde Claude?
- **Opciones**: A) Solo usar `--output-format json` | B) Usar `--output-format json --json-schema '{"type":"object",...}'` | C) Usar `--strict-json` flag | D) La salida JSON siempre es válida en esquema
- **Correcta**: B
- **Explicación**: `--output-format json` solo produce JSON de mejor esfuerzo. Agregar `--json-schema` con una definición JSON Schema garantiza que la salida coincida con el esquema.
- **Revisar**: Sección Salida y Formato

### P5
- **Categoría**: conceptual
- **Pregunta**: ¿Qué flag solo funciona en modo print (-p) y no tiene efecto en modo interactivo?
- **Opciones**: A) `--model` | B) `--system-prompt-file` | C) `--verbose` | D) `--max-turns`
- **Correcta**: B
- **Explicación**: `--system-prompt-file` carga un prompt de sistema desde un archivo pero solo funciona en modo print. Usar `--system-prompt` (cadena en línea) para sesiones interactivas.
- **Revisar**: Sección Tabla de Comparación de Flags de Prompt de Sistema

### P6
- **Categoría**: práctica
- **Pregunta**: ¿Cómo restringes a Claude a solo usar herramientas de solo lectura para una auditoría de seguridad?
- **Opciones**: A) `claude --read-only "audit code"` | B) `claude --permission-mode plan --tools "Read,Grep,Glob" "audit code"` | C) `claude --safe-mode "audit code"` | D) `claude --no-write "audit code"`
- **Correcta**: B
- **Explicación**: Combinar `--permission-mode plan` (análisis de solo lectura) con `--tools` (allowlist de herramientas específicas) para restringir a Claude a solo operaciones de lectura.
- **Revisar**: Sección Gestión de Herramientas y Permisos

### P7
- **Categoría**: conceptual
- **Pregunta**: ¿Cuál es el orden de prioridad de definición de agentes?
- **Opciones**: A) Proyecto > Usuario > CLI | B) CLI > Usuario > Proyecto | C) Usuario > CLI > Proyecto | D) Todos son igual prioridad
- **Correcta**: B
- **Explicación**: Los agentes definidos por CLI (flag --agents) tienen prioridad más alta, luego nivel de Usuario (~/.claude/agents/), luego nivel de Proyecto (.claude/agents/).
- **Revisar**: Sección Configuración de Agentes

### P8
- **Categoría**: práctica
- **Pregunta**: ¿Cómo bifurcas una sesión existente para probar un enfoque diferente sin perder la original?
- **Opciones**: A) Usar comando `/fork` | B) Usar `--resume session-name --fork-session "branch name"` | C) Usar `--clone session-name` | D) Usar `/branch session-name`
- **Correcta**: B
- **Explicación**: `--resume` con `--fork-session` crea una nueva rama independiente desde la sesión reanudada, preservando la conversación original.
- **Revisar**: Sección Gestión de Sesiones

### P9
- **Categoría**: conceptual
- **Pregunta**: ¿Qué código de salida devuelve `claude auth status` cuando el usuario ha iniciado sesión?
- **Opciones**: A) 1 | B) 0 | C) 200 | D) No devuelve un código de salida
- **Correcta**: B
- **Explicación**: `claude auth status` sale con código 0 cuando ha iniciado sesión, 1 cuando no. Esto lo hace scriptable para verificaciones de autenticación CI/CD.
- **Revisar**: Sección Tabla de Comandos CLI

### P10
- **Categoría**: práctica
- **Pregunta**: ¿Cómo procesas múltiples archivos en un lote con Claude?
- **Opciones**: A) `claude --batch *.md` | B) Usar un bucle for: `for file in *.md; do claude -p --output-format json "process $file" < "$file"; done` | C) `claude --process-all *.md` | D) Los archivos no pueden procesarse en lote
- **Correcta**: B
- **Explicación**: Usar bucles for de shell con modo print para procesar archivos uno a la vez. Cada invocación es independiente y puede producir salida estructurada.
- **Revisar**: Sección Procesamiento por Lotes
