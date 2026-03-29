---
name: claude-md
description: Crear o actualizar archivos CLAUDE.md siguiendo mejores prácticas para onboarding óptimo de agentes de IA
---

## Input del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar el input del usuario antes de proceder (si no está vacío). El usuario puede especificar:
- `create` - Crear nuevo CLAUDE.md desde cero
- `update` - Mejorar CLAUDE.md existente
- `audit` - Analizar y reportar sobre calidad actual de CLAUDE.md
- Una ruta específica para crear/actualizar (ej. `src/api/CLAUDE.md` para instrucciones específicas de directorio)

## Principios Fundamentales

**Los LLMs son stateless**: CLAUDE.md es el único archivo automáticamente incluido en cada conversación. Sirve como el documento de onboarding primario para agentes de IA en tu codebase.

### Las Reglas de Oro

1. **Menos es Más**: Los LLMs frontier pueden seguir ~150-200 instrucciones. El system prompt de Claude Code ya usa ~50. Mantén tu CLAUDE.md enfocado y conciso.

2. **Aplicabilidad Universal**: Solo incluye información relevante para CADA sesión. Instrucciones específicas de tareas pertenecen en archivos separados.

3. **No Uses a Claude como un Linter**: Las guías de estilo inflan el contexto y degradan el seguimiento de instrucciones. Usa herramientas deterministas (prettier, eslint, etc.) en su lugar.

4. **Nunca Auto-Generes**: CLAUDE.md es el punto de mayor apalancamiento del arnés de IA. Elabóralo manualmente con cuidadosa consideración.

## Flujo de Ejecución

### 1. Análisis del Proyecto

Primero, analiza el estado actual del proyecto:

1. Verifica archivos CLAUDE.md existentes:
   - Nivel raíz: `./CLAUDE.md` o `.claude/CLAUDE.md`
   - Específico de directorio: `**/CLAUDE.md`
   - Configuración global de usuario: `~/.claude/CLAUDE.md`

2. Identifica la estructura del proyecto:
   - Stack tecnológico (lenguajes, frameworks)
   - Tipo de proyecto (monorepo, aplicación única, librería)
   - Herramientas de desarrollo (gestor de paquetes, sistema de build, test runner)

3. Revisa documentación existente:
   - README.md
   - CONTRIBUTING.md
   - package.json, pyproject.toml, Cargo.toml, etc.

### 2. Estrategia de Contenido (QUÉ, POR QUÉ, CÓMO)

Estructura CLAUDE.md alrededor de tres dimensiones:

#### QUÉ - Tecnología y Estructura
- Visión general del stack tecnológico
- Organización del proyecto (especialmente importante para monorepos)
- Directorios clave y sus propósitos

#### POR QUÉ - Propósito y Contexto
- Qué hace el proyecto
- Por qué se tomaron ciertas decisiones arquitectónicas
- De qué es responsable cada componente principal

#### CÓMO - Flujo de Trabajo y Convenciones
- Flujo de trabajo de desarrollo (bun vs node, pip vs uv, etc.)
- Procedimientos de testing y comandos
- Métodos de verificación y build
- "Gotchas" críticos o requisitos no obvios

### 3. Estrategia de Divulgación Progresiva

Para proyectos más grandes, recomienda crear una carpeta `agent_docs/`:

```
agent_docs/
  |- building_the_project.md
  |- running_tests.md
  |- code_conventions.md
  |- architecture_decisions.md
```

En CLAUDE.md, referencia estos archivos con instrucciones como:
```markdown
Para instrucciones detalladas de build, refiere a `agent_docs/building_the_project.md`
```

**Importante**: Usa referencias `archivo:línea` en lugar de snippets de código para evitar contexto desactualizado.

### 4. Restricciones de Calidad

Al crear o actualizar CLAUDE.md:

1. **Longitud Objetivo**: Bajo 300 líneas (idealmente bajo 100)
2. **Sin Reglas de Estilo**: Elimina cualquier instrucción de linting/formatting
3. **Sin Instrucciones de Tareas Específicas**: Mueve a archivos separados
4. **Sin Snippets de Código**: Usa referencias a archivos en su lugar
5. **Sin Información Redundante**: No repitas lo que está en package.json o README

### 5. Secciones Esenciales

Un CLAUDE.md bien estructurado debería incluir:

```markdown
# Nombre del Proyecto

Descripción breve de una línea.

## Tech Stack
- Lenguaje principal y versión
- Frameworks/librerías clave
- Base de datos/almacenamiento (si hay)

## Estructura del Proyecto
[Solo para monorepos o estructuras complejas]
- `apps/` - Puntos de entrada de aplicación
- `packages/` - Librerías compartidas

## Comandos de Desarrollo
- Install: `comando`
- Test: `comando`
- Build: `comando`

## Convenciones Críticas
[Solo convenciones no obvias, de alto impacto]
- Convención 1 con explicación breve
- Convención 2 con explicación breve

## Known Issues / Gotchas
[Cosas que consistentemente confunden a desarrolladores]
- Issue 1
- Issue 2
```

### 6. Anti-Patrones a Evitar

**NO incluyas:**
- Guías de estilo de código (usa linters)
- Documentación sobre cómo usar Claude
- Explicaciones largas de patrones obvios
- Ejemplos de código copy-paste
- Mejores prácticas genéricas ("escribe código limpio")
- Instrucciones para tareas específicas
- Contenido auto-generado
- Listas extensas de TODO

### 7. Checklist de Validación

Antes de finalizar, verifica:

- [ ] Bajo 300 líneas (preferiblemente bajo 100)
- [ ] Cada línea aplica a TODAS las sesiones
- [ ] Sin reglas de estilo/formatting
- [ ] Sin snippets de código (usa referencias a archivos)
- [ ] Los comandos están verificados de funcionar
- [ ] Divulgación progresiva usada para proyectos complejos
- [ ] Gotchas críticos están documentados
- [ ] Sin redundancia con README.md

## Formato de Salida

### Para `create` o por defecto:

1. Analiza el proyecto
2. Redacta un CLAUDE.md siguiendo la estructura anterior
3. Presenta el borrador para revisión
4. Escribe en la ubicación apropiada después de aprobación

### Para `update`:

1. Lee CLAUDE.md existente
2. Audita contra mejores prácticas
3. Identifica:
   - Contenido a eliminar (reglas de estilo, snippets de código, específico de tareas)
   - Contenido a condensar
   - Información esencial faltante
4. Presenta cambios para revisión
5. Aplica cambios después de aprobación

### Para `audit`:

1. Lee CLAUDE.md existente
2. Genera un reporte con:
   - Cantidad de líneas actual vs objetivo
   - Porcentaje de contenido universalmente aplicable
   - Lista de anti-patrones encontrados
   - Recomendaciones de mejora
3. NO modifiques el archivo, solo reporta

## Manejo de AGENTS.md

Si el usuario solicita creación/actualización de AGENTS.md:

AGENTS.md se usa para definir comportamientos de agentes especializados. A diferencia de CLAUDE.md (que es para contexto de proyecto), AGENTS.md define:
- Roles y capacidades de agentes personalizados
- Instrucciones y restricciones específicas de agentes
- Definiciones de flujo de trabajo para escenarios multi-agente

Aplica principios similares:
- Mantén enfocado y conciso
- Usa divulgación progresiva
- Referencia docs externos en lugar de incrustar contenido

## Notas

- Siempre verifica que los comandos funcionan antes de incluirlos
- Cuando dudes, déjalo fuera - menos es más
- El system reminder le dice a Claude que CLAUDE.md "puede o no ser relevante" - cuanto más ruido, más se ignora
- Los monorepos se benefician más de la estructura QUÉ/POR QUÉ/CÓMO
- Los archivos CLAUDE.md específicos de directorio deberían ser aún más enfocados
