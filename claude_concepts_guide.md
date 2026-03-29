<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Guía Completa de Conceptos de Claude

Una referencia completa que cubre Slash Commands, Subagents, Memory, Protocolo MCP, y Agent Skills con tablas, diagramas y ejemplos prácticos.

---

## Tabla de Contenidos

1. [Slash Commands](#slash-commands)
2. [Subagents](#subagents)
3. [Memory](#memory)
4. [Protocolo MCP](#mcp-protocol)
5. [Agent Skills](#agent-skills)
6. [Plugins](#plugins)
7. [Hooks](#hooks)
8. [Checkpoints and Rewind](#checkpoints-and-rewind)
9. [Características Avanzadas](#advanced-features)
10. [Comparación e Integración](#comparison--integration)

---

## Slash Commands

### Visión General

Los Slash Commands son atajos invocados por el usuario almacenados como archivos Markdown que Claude Code puede ejecutar. Permiten a los equipos estandarizar prompts y flujos de trabajo de uso frecuente.

### Arquitectura

```mermaid
graph TD
    A["Entrada de Usuario: /command-name"] -->|Activa| B["Buscar en .claude/commands/"]
    B -->|Encuentra| C["command-name.md"]
    C -->|Carga| D["Contenido Markdown"]
    D -->|Ejecuta| E["Claude Procesa el Prompt"]
    E -->|Devuelve| F["Resultado en Contexto"]
```

### Estructura de Archivos

```mermaid
graph LR
    A["Raíz del Proyecto"] -->|contiene| B[".claude/commands/"]
    B -->|contiene| C["optimize.md"]
    B -->|contiene| D["test.md"]
    B -->|contiene| E["docs/"]
    E -->|contiene| F["generate-api-docs.md"]
    E -->|contiene| G["generate-readme.md"]
```

### Tabla de Organización de Commands

| Ubicación | Alcance | Disponibilidad | Caso de Uso | Git Tracked |
|----------|-------|--------------|----------|-------------|
| `.claude/commands/` | Específico del proyecto | Miembros del equipo | Flujos de trabajo del equipo, estándares compartidos | ✅ Sí |
| `~/.claude/commands/` | Personal | Usuario individual | Atajos personales entre proyectos | ❌ No |
| Subdirectorios | Con namespace | Basado en el padre | Organizar por categoría | ✅ Sí |

### Características y Capacidades

| Característica | Ejemplo | Soportado |
|---------|---------|-----------|
| Ejecución de scripts shell | `bash scripts/deploy.sh` | ✅ Sí |
| Referencias a archivos | `@path/to/file.js` | ✅ Sí |
| Integración Bash | `$(git log --oneline)` | ✅ Sí |
| Argumentos | `/pr --verbose` | ✅ Sí |
| Commands MCP | `/mcp__github__list_prs` | ✅ Sí |

### Ejemplos Prácticos

#### Ejemplo 1: Command de Optimización de Código

**Archivo:** `.claude/commands/optimize.md`

```markdown
---
name: Code Optimization
description: Analyze code for performance issues and suggest optimizations
tags: performance, analysis
---

# Code Optimization

Review the provided code for the following issues in order of priority:

1. **Performance bottlenecks** - identify O(n²) operations, inefficient loops
2. **Memory leaks** - find unreleased resources, circular references
3. **Algorithm improvements** - suggest better algorithms or data structures
4. **Caching opportunities** - identify repeated computations
5. **Concurrency issues** - find race conditions or threading problems

Format your response with:
- Issue severity (Critical/High/Medium/Low)
- Location in code
- Explanation
- Recommended fix with code example
```

**Uso:**
```bash
# El usuario escribe en Claude Code
/optimize

# Claude carga el prompt y espera la entrada de código
```

#### Ejemplo 2: Command Helper para Pull Request

**Archivo:** `.claude/commands/pr.md`

```markdown
---
name: Prepare Pull Request
description: Clean up code, stage changes, and prepare a pull request
tags: git, workflow
---

# Pull Request Preparation Checklist

Before creating a PR, execute these steps:

1. Run linting: `prettier --write .`
2. Run tests: `npm test`
3. Review git diff: `git diff HEAD`
4. Stage changes: `git add .`
5. Create commit message following conventional commits:
   - `fix:` for bug fixes
   - `feat:` for new features
   - `docs:` for documentation
   - `refactor:` for code restructuring
   - `test:` for test additions
   - `chore:` for maintenance

6. Generate PR summary including:
   - What changed
   - Why it changed
   - Testing performed
   - Potential impacts
```

**Uso:**
```bash
/pr

# Claude ejecuta la lista de verificación y prepara el PR
```

#### Ejemplo 3: Generador de Documentación Jerárquica

**Archivo:** `.claude/commands/docs/generate-api-docs.md`

```markdown
---
name: Generate API Documentation
description: Create comprehensive API documentation from source code
tags: documentation, api
---

# API Documentation Generator

Generate API documentation by:

1. Scanning all files in `/src/api/`
2. Extracting function signatures and JSDoc comments
3. Organizing by endpoint/module
4. Creating markdown with examples
5. Including request/response schemas
6. Adding error documentation

Output format:
- Markdown file in `/docs/api.md`
- Include curl examples for all endpoints
- Add TypeScript types
```

### Diagrama de Ciclo de Vida del Command

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant FS as File System
    participant CLI as Shell/Bash

    User->>Claude: Escribe /optimize
    Claude->>FS: Busca en .claude/commands/
    FS-->>Claude: Devuelve optimize.md
    Claude->>Claude: Carga contenido Markdown
    Claude->>User: Muestra contexto del prompt
    User->>Claude: Proporciona código para analizar
    Claude->>CLI: (Puede ejecutar scripts)
    CLI-->>Claude: Resultados
    Claude->>User: Devuelve análisis
```

### Mejores Prácticas

| ✅ Hacer | ❌ No Hacer |
|------|---------|
| Usar nombres claros y orientados a la acción | Crear commands para tareas de una sola vez |
| Documentar palabras activadoras en la descripción | Construir lógica compleja en commands |
| Mantener commands enfocados en una sola tarea | Crear commands redundantes |
| Control de versión para commands del proyecto | Hardcodear información sensible |
| Organizar en subdirectorios | Crear listas largas de commands |
| Usar prompts simples y legibles | Usar abreviaturas o palabras crípticas |

---

## Subagents

### Visión General

Los Subagents son asistentes especializados de IA con ventanas de contexto aisladas y system prompts personalizados. Permiten la ejecución delegada de tareas manteniendo una separación limpia de responsabilidades.

### Diagrama de Arquitectura

```mermaid
graph TB
    User["👤 Usuario"]
    Main["🎯 Agente Principal<br/>(Coordinador)"]
    Reviewer["🔍 Revisor de Código<br/>Subagent"]
    Tester["✅ Ingeniero de Pruebas<br/>Subagent"]
    Docs["📝 Documentación<br/>Subagent"]

    User -->|pregunta| Main
    Main -->|delega| Reviewer
    Main -->|delega| Tester
    Main -->|delega| Docs
    Reviewer -->|devuelve resultado| Main
    Tester -->|devuelve resultado| Main
    Docs -->|devuelve resultado| Main
    Main -->|sintetiza| User
```

### Ciclo de Vida del Subagent

```mermaid
sequenceDiagram
    participant User
    participant MainAgent as Agente Principal
    participant CodeReviewer as Revisor de Código<br/>Subagent
    participant Context as Ventana de<br/>Contexto Separada

    User->>MainAgent: "Construir nueva función de auth"
    MainAgent->>MainAgent: Analizar tarea
    MainAgent->>CodeReviewer: "Revisar este código"
    CodeReviewer->>Context: Inicializar contexto limpio
    Context->>CodeReviewer: Cargar instrucciones del revisor
    CodeReviewer->>CodeReviewer: Realizar revisión
    CodeReviewer-->>MainAgent: Devolver hallazgos
    MainAgent->>MainAgent: Incorporar resultados
    MainAgent-->>User: Proporcionar síntesis
```

### Tabla de Configuración de Subagent

| Configuración | Tipo | Propósito | Ejemplo |
|---------------|------|---------|---------|
| `name` | String | Identificador del agente | `code-reviewer` |
| `description` | String | Propósito y términos activadores | `Análisis completo de calidad de código` |
| `tools` | Lista/String | Capacidades permitidas | `read, grep, diff, lint_runner` |
| `system_prompt` | Markdown | Instrucciones de comportamiento | Directrices personalizadas |

### Jerarquía de Acceso a Herramientas

```mermaid
graph TD
    A["Configuración de Subagent"] -->|Opción 1| B["Heredar Todas las Herramientas<br/>del Hilo Principal"]
    A -->|Opción 2| C["Especificar Herramientas Individuales"]
    B -->|Incluye| B1["Operaciones de Archivo"]
    B -->|Incluye| B2["Commands Shell"]
    B -->|Incluye| B3["Herramientas MCP"]
    C -->|Lista Explícita| C1["read, grep, diff"]
    C -->|Lista Explícita| C2["Bash(npm:*), Bash(test:*)"]
```

### Ejemplos Prácticos

#### Ejemplo 1: Configuración Completa de Subagent

**Archivo:** `.claude/agents/code-reviewer.md`

```yaml
---
name: code-reviewer
description: Comprehensive code quality and maintainability analysis
tools: read, grep, diff, lint_runner
---

# Code Reviewer Agent

You are an expert code reviewer specializing in:
- Performance optimization
- Security vulnerabilities
- Code maintainability
- Testing coverage
- Design patterns

## Review Priorities (in order)

1. **Security Issues** - Authentication, authorization, data exposure
2. **Performance Problems** - O(n²) operations, memory leaks, inefficient queries
3. **Code Quality** - Readability, naming, documentation
4. **Test Coverage** - Missing tests, edge cases
5. **Design Patterns** - SOLID principles, architecture

## Review Output Format

For each issue:
- **Severity**: Critical / High / Medium / Low
- **Category**: Security / Performance / Quality / Testing / Design
- **Location**: File path and line number
- **Issue Description**: What's wrong and why
- **Suggested Fix**: Code example
- **Impact**: How this affects the system

## Example Review

### Issue: N+1 Query Problem
- **Severity**: High
- **Category**: Performance
- **Location**: src/user-service.ts:45
- **Issue**: Loop executes database query in each iteration
- **Fix**: Use JOIN or batch query
```

**Archivo:** `.claude/agents/test-engineer.md`

```yaml
---
name: test-engineer
description: Test strategy, coverage analysis, and automated testing
tools: read, write, bash, grep
---

# Test Engineer Agent

You are expert at:
- Writing comprehensive test suites
- Ensuring high code coverage (>80%)
- Testing edge cases and error scenarios
- Performance benchmarking
- Integration testing

## Testing Strategy

1. **Unit Tests** - Individual functions/methods
2. **Integration Tests** - Component interactions
3. **End-to-End Tests** - Complete workflows
4. **Edge Cases** - Boundary conditions
5. **Error Scenarios** - Failure handling

## Test Output Requirements

- Use Jest for JavaScript/TypeScript
- Include setup/teardown for each test
- Mock external dependencies
- Document test purpose
- Include performance assertions when relevant

## Coverage Requirements

- Minimum 80% code coverage
- 100% for critical paths
- Report missing coverage areas
```

**Archivo:** `.claude/agents/documentation-writer.md`

```yaml
---
name: documentation-writer
description: Technical documentation, API docs, and user guides
tools: read, write, grep
---

# Documentation Writer Agent

You create:
- API documentation with examples
- User guides and tutorials
- Architecture documentation
- Changelog entries
- Code comment improvements

## Documentation Standards

1. **Clarity** - Use simple, clear language
2. **Examples** - Include practical code examples
3. **Completeness** - Cover all parameters and returns
4. **Structure** - Use consistent formatting
5. **Accuracy** - Verify against actual code

## Documentation Sections

### For APIs
- Description
- Parameters (with types)
- Returns (with types)
- Throws (possible errors)
- Examples (curl, JavaScript, Python)
- Related endpoints

### For Features
- Overview
- Prerequisites
- Step-by-step instructions
- Expected outcomes
- Troubleshooting
- Related topics
```

#### Ejemplo 2: Delegación de Subagent en Acción

```markdown
# Escenario: Construyendo una Función de Pago

## Solicitud del Usuario
"Construir una función de procesamiento de pagos segura que se integre con Stripe"

## Flujo del Agente Principal

1. **Fase de Planificación**
   - Comprende los requisitos
   - Determina las tareas necesarias
   - Planifica la arquitectura

2. **Delega al Subagent Revisor de Código**
   - Tarea: "Revisar la implementación del procesamiento de pagos para seguridad"
   - Contexto: Auth, claves de API, manejo de tokens
   - Revisa para: Inyección SQL, exposición de claves, aplicación de HTTPS

3. **Delega al Subagent Ingeniero de Pruebas**
   - Tarea: "Crear pruebas completas para flujos de pago"
   - Contexto: Escenarios de éxito, fallos, casos extremos
   - Crea pruebas para: Pagos válidos, tarjetas rechazadas, fallos de red, webhooks

4. **Delega al Subagent Escritor de Documentación**
   - Tarea: "Documentar los endpoints de la API de pago"
   - Contexto: Esquemas de solicitud/respuesta
   - Produce: Documentación de API con ejemplos curl, códigos de error

5. **Síntesis**
   - El agente principal recopila todas las salidas
   - Integra los hallazgos
   - Devuelve la solución completa al usuario
```

#### Ejemplo 3: Ámbito de Permisos de Herramientas

**Configuración Restrictiva - Limitado a Commands Específicos**

```yaml
---
name: secure-reviewer
description: Security-focused code review with minimal permissions
tools: read, grep
---

# Secure Code Reviewer

Reviews code for security vulnerabilities only.

This agent:
- ✅ Reads files to analyze
- ✅ Searches for patterns
- ❌ Cannot execute code
- ❌ Cannot modify files
- ❌ Cannot run tests

This ensures the reviewer doesn't accidentally break anything.
```

**Configuración Extendida - Todas las Herramientas para Implementación**

```yaml
---
name: implementation-agent
description: Full implementation capabilities for feature development
tools: read, write, bash, grep, edit, glob
---

# Implementation Agent

Builds features from specifications.

This agent:
- ✅ Reads specifications
- ✅ Writes new code files
- ✅ Runs build commands
- ✅ Searches codebase
- ✅ Edits existing files
- ✅ Finds files matching patterns

Full capabilities for independent feature development.
```

### Gestión de Contexto de Subagent

```mermaid
graph TB
    A["Contexto del Agente Principal<br/>50,000 tokens"]
    B["Contexto del Subagent 1<br/>20,000 tokens"]
    C["Contexto del Subagent 2<br/>20,000 tokens"]
    D["Contexto del Subagent 3<br/>20,000 tokens"]

    A -->|Pizarra limpia| B
    A -->|Pizarra limpia| C
    A -->|Pizarra limpia| D

    B -->|Solo resultados| A
    C -->|Solo resultados| A
    D -->|Solo resultados| A

    style A fill:#e1f5ff
    style B fill:#fff9c4
    style C fill:#fff9c4
    style D fill:#fff9c4
```

### Cuándo Usar Subagents

| Escenario | Usar Subagent | Por Qué |
|----------|--------------|-----|
| Función compleja con muchos pasos | ✅ Sí | Separar responsabilidades, prevenir contaminación de contexto |
| Revisión de código rápida | ❌ No | Sobrecarga innecesaria |
| Ejecución de tareas paralelas | ✅ Sí | Cada subagent tiene su propio contexto |
| Se necesita experiencia especializada | ✅ Sí | System prompts personalizados |
| Análisis de larga duración | ✅ Sí | Previene el agotamiento del contexto principal |
| Tarea única | ❌ No | Añade latencia innecesariamente |

### Equipos de Agentes (Agent Teams)

Los Agent Teams coordinan múltiples agentes trabajando en tareas relacionadas. En lugar de delegar a un subagent a la vez, los Agent Teams permiten al agente principal orquestar un grupo de agentes que colaboran, comparten resultados intermedios y trabajan hacia un objetivo común. Esto es útil para tareas a gran escala como el desarrollo de funciones full-stack donde un agente de frontend, un agente de backend y un agente de pruebas trabajan en paralelo.

---

## Memory

### Visión General

Memory permite a Claude retener contexto entre sesiones y conversaciones. Existe en dos formas: síntesis automática en claude.ai, y CLAUDE.md basado en el sistema de archivos en Claude Code.

### Arquitectura de Memory

```mermaid
graph TB
    A["Sesión de Claude"]
    B["Entrada del Usuario"]
    C["Sistema de Memory"]
    D["Almacenamiento de Memory"]

    B -->|El usuario proporciona información| C
    C -->|Sintetiza cada 24h| D
    D -->|Carga automáticamente| A
    A -->|Usa contexto| C
```

### Jerarquía de Memory en Claude Code (7 Niveles)

Claude Code carga memory de 7 niveles, listados de mayor a menor prioridad:

```mermaid
graph TD
    A["1. Managed Policy<br/>Políticas administrativas empresariales"] --> B["2. Project Memory<br/>./CLAUDE.md"]
    B --> C["3. Project Rules<br/>.claude/rules/*.md"]
    C --> D["4. User Memory<br/>~/.claude/CLAUDE.md"]
    D --> E["5. User Rules<br/>~/.claude/rules/*.md"]
    E --> F["6. Local Memory<br/>.claude/local/CLAUDE.md"]
    F --> G["7. Auto Memory<br/>Preferencias capturadas automáticamente"]

    style A fill:#fce4ec,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#e1f5fe,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
    style G fill:#fff3e0,stroke:#333,color:#333
```

### Tabla de Ubicaciones de Memory

| Nivel | Ubicación | Alcance | Prioridad | Compartido | Ideal Para |
|------|----------|-------|----------|--------|----------|
| 1. Managed Policy | Admin empresarial | Organización | Más alta | Todos los usuarios de la org | Cumplimiento, políticas de seguridad |
| 2. Project | `./CLAUDE.md` | Proyecto | Alta | Equipo (Git) | Estándares del equipo, arquitectura |
| 3. Project Rules | `.claude/rules/*.md` | Proyecto | Alta | Equipo (Git) | Convenciones modulares del proyecto |
| 4. User | `~/.claude/CLAUDE.md` | Personal | Media | Individual | Preferencias personales |
| 5. User Rules | `~/.claude/rules/*.md` | Personal | Media | Individual | Módulos de reglas personales |
| 6. Local | `.claude/local/CLAUDE.md` | Local | Baja | No compartido | Configuraciones específicas de la máquina |
| 7. Auto Memory | Automático | Sesión | Más baja | Individual | Preferencias y patrones aprendidos |

### Auto Memory

Auto Memory captura automáticamente preferencias de usuario y patrones observados durante las sesiones. Claude aprende de tus interacciones y recuerda:

- Preferencias de estilo de codificación
- Correcciones comunes que realizas
- Elecciones de frameworks y herramientas
- Preferencias de estilo de comunicación

Auto Memory funciona en segundo plano y no requiere configuración manual.

### Ciclo de Vida de Actualización de Memory

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Editor as File System
    participant Memory as CLAUDE.md

    User->>Claude: "Recuerda: usa async/await"
    Claude->>User: "¿Qué archivo de memory?"
    User->>Claude: "Memory del proyecto"
    Claude->>Editor: Abre ~/.claude/settings.json
    Claude->>Memory: Escribe en ./CLAUDE.md
    Memory-->>Claude: Archivo guardado
    Claude->>Claude: Carga memory actualizado
    Claude-->>User: "¡Memory guardado!"
```

### Ejemplos Prácticos

#### Ejemplo 1: Estructura de Project Memory

**Archivo:** `./CLAUDE.md`

```markdown
# Project Configuration

## Project Overview
- **Name**: E-commerce Platform
- **Tech Stack**: Node.js, PostgreSQL, React 18, Docker
- **Team Size**: 5 developers
- **Deadline**: Q4 2025

## Architecture
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Development Standards

### Code Style
- Use Prettier for formatting
- Use ESLint with airbnb config
- Maximum line length: 100 characters
- Use 2-space indentation

### Naming Conventions
- **Files**: kebab-case (user-controller.js)
- **Classes**: PascalCase (UserService)
- **Functions/Variables**: camelCase (getUserById)
- **Constants**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Database Tables**: snake_case (user_accounts)

### Git Workflow
- Branch names: `feature/description` or `fix/description`
- Commit messages: Follow conventional commits
- PR required before merge
- All CI/CD checks must pass
- Minimum 1 approval required

### Testing Requirements
- Minimum 80% code coverage
- All critical paths must have tests
- Use Jest for unit tests
- Use Cypress for E2E tests
- Test filenames: `*.test.ts` or `*.spec.ts`

### API Standards
- RESTful endpoints only
- JSON request/response
- Use HTTP status codes correctly
- Version API endpoints: `/api/v1/`
- Document all endpoints with examples

### Database
- Use migrations for schema changes
- Never hardcode credentials
- Use connection pooling
- Enable query logging in development
- Regular backups required

### Deployment
- Docker-based deployment
- Kubernetes orchestration
- Blue-green deployment strategy
- Automatic rollback on failure
- Database migrations run before deploy

## Common Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server |
| `npm test` | Run test suite |
| `npm run lint` | Check code style |
| `npm run build` | Build for production |
| `npm run migrate` | Run database migrations |

## Team Contacts
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Known Issues & Workarounds
- PostgreSQL connection pooling limited to 20 during peak hours
- Workaround: Implement query queuing
- Safari 14 compatibility issues with async generators
- Workaround: Use Babel transpiler

## Related Projects
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`
```

#### Ejemplo 2: Memory Específico de Directorio

**Archivo:** `./src/api/CLAUDE.md`

~~~~markdown
# API Module Standards

This file overrides root CLAUDE.md for everything in /src/api/

## API-Specific Standards

### Request Validation
- Use Zod for schema validation
- Always validate input
- Return 400 with validation errors
- Include field-level error details

### Authentication
- All endpoints require JWT token
- Token in Authorization header
- Token expires after 24 hours
- Implement refresh token mechanism

### Response Format

All responses must follow this structure:

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

### Error responses:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Pagination
- Use cursor-based pagination (not offset)
- Include `hasMore` boolean
- Limit max page size to 100
- Default page size: 20

### Rate Limiting
- 1000 requests per hour for authenticated users
- 100 requests per hour for public endpoints
- Return 429 when exceeded
- Include retry-after header

### Caching
- Use Redis for session caching
- Cache duration: 5 minutes default
- Invalidate on write operations
- Tag cache keys with resource type
~~~~

#### Ejemplo 3: Personal Memory

**Archivo:** `~/.claude/CLAUDE.md`

~~~~markdown
# My Development Preferences

## About Me
- **Experience Level**: 8 years full-stack development
- **Preferred Languages**: TypeScript, Python
- **Communication Style**: Direct, with examples
- **Learning Style**: Visual diagrams with code

## Code Preferences

### Error Handling
I prefer explicit error handling with try-catch blocks and meaningful error messages.
Avoid generic errors. Always log errors for debugging.

### Comments
Use comments for WHY, not WHAT. Code should be self-documenting.
Comments should explain business logic or non-obvious decisions.

### Testing
I prefer TDD (test-driven development).
Write tests first, then implementation.
Focus on behavior, not implementation details.

### Architecture
I prefer modular, loosely-coupled design.
Use dependency injection for testability.
Separate concerns (Controllers, Services, Repositories).

## Debugging Preferences
- Use console.log with prefix: `[DEBUG]`
- Include context: function name, relevant variables
- Use stack traces when available
- Always include timestamps in logs

## Communication
- Explain complex concepts with diagrams
- Show concrete examples before explaining theory
- Include before/after code snippets
- Summarize key points at the end

## Project Organization
I organize my projects as:
```
project/
  ├── src/
  │   ├── api/
  │   ├── services/
  │   ├── models/
  │   └── utils/
  ├── tests/
  ├── docs/
  └── docker/
```

## Tooling
- **IDE**: VS Code with vim keybindings
- **Terminal**: Zsh with Oh-My-Zsh
- **Format**: Prettier (100 char line length)
- **Linter**: ESLint with airbnb config
- **Test Framework**: Jest with React Testing Library
~~~~

#### Ejemplo 4: Actualización de Memory Durante la Sesión

**Interacción de Sesión:**

```markdown
User: Remember that I prefer using React hooks instead of class components
     for all new components.

Claude: I'm adding that to your memory. Which memory file should this go in?
        1. Project memory (./CLAUDE.md)
        2. Personal memory (~/.claude/CLAUDE.md)

User: Project memory

Claude: ✅ Memory saved!

Added to ./CLAUDE.md:
---

### Component Development
- Use functional components with React Hooks
- Prefer hooks over class components
- Custom hooks for reusable logic
- Use useCallback for event handlers
- Use useMemo for expensive computations
```

### Memory en Claude Web/Desktop

#### Línea de Tiempo de Síntesis de Memory

```mermaid
graph LR
    A["Día 1: Usuario<br/>Conversaciones"] -->|24 horas| B["Día 2: Síntesis<br/>de Memory"]
    B -->|Automático| C["Memory Actualizado<br/>Resumido"]
    C -->|Cargado en| D["Día 2-N:<br/>Nuevas Conversaciones"]
    D -->|Añade a| E["Memory"]
    E -->|24 horas después| F["Memory Refrescado"]
```

**Ejemplo de Resumen de Memory:**

```markdown
## Claude's Memory of User

### Professional Background
- Senior full-stack developer with 8 years experience
- Focus on TypeScript/Node.js backends and React frontends
- Active open source contributor
- Interested in AI and machine learning

### Project Context
- Currently building e-commerce platform
- Tech stack: Node.js, PostgreSQL, React 18, Docker
- Working with team o... [truncado]
- Using CI/CD and blue-green deployments

### Communication Preferences
- Prefers direct, concise explanations
- Likes visual diagrams and examples
- Appreciates code snippets
- Explains business logic in comments

### Current Goals
- Improve API performance
- Increase test coverage to 90%
- Implement caching strategy
- Document architecture
```

### Comparación de Características de Memory

| Característica | Claude Web/Desktop | Claude Code (CLAUDE.md) |
|---------|-------------------|------------------------|
| Auto-síntesis | ✅ Cada 24h | ❌ Manual |
| Entre proyectos | ✅ Compartido | ❌ Específico del proyecto |
| Acceso del equipo | ✅ Proyectos compartidos | ✅ Con seguimiento en Git |
| Buscable | ✅ Integrado | ✅ A través de `/memory` |
| Editable | ✅ En chat | ✅ Edición directa de archivo |
| Importar/Exportar | ✅ Sí | ✅ Copiar/pegar |
| Persistente | ✅ 24h+ | ✅ Indefinido |

---

## Protocolo MCP

### Visión General

MCP (Model Context Protocol) es una forma estandarizada para que Claude acceda a herramientas externas, APIs y datos en tiempo real. A diferencia de Memory, MCP proporciona acceso en vivo a datos cambiantes.

### Arquitectura MCP

```mermaid
graph TB
    A["Claude"]
    B["Servidor MCP"]
    C["Servicio Externo"]

    A -->|Solicitud: list_issues| B
    B -->|Consulta| C
    C -->|Datos| B
    B -->|Respuesta| A

    A -->|Solicitud: create_issue| B
    B -->|Acción| C
    C -->|Resultado| B
    B -->|Respuesta| A
```

### Ecosistema MCP

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>Servidor MCP"]
    A -->|MCP| C["GitHub<br/>Servidor MCP"]
    A -->|MCP| D["Database<br/>Servidor MCP"]
    A -->|MCP| E["Slack<br/>Servidor MCP"]
    A -->|MCP| F["Google Docs<br/>Servidor MCP"]

    B -->|E/S de Archivos| G["Archivos Locales"]
    C -->|API| H["Repositorios GitHub"]
    D -->|Consulta| I["PostgreSQL/MySQL"]
    E -->|Mensajes| J["Espacio de Trabajo Slack"]
    F -->|Docs| K["Google Drive"]
```

### Proceso de Configuración MCP

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Archivo de Configuración
    participant Service as Servicio Externo

    User->>Claude: Escribe /mcp
    Claude->>Claude: Lista servidores MCP disponibles
    Claude->>User: Muestra opciones
    User->>Claude: Selecciona GitHub MCP
    Claude->>Config: Actualiza configuración
    Config->>Claude: Activa conexión
    Claude->>Service: Prueba conexión
    Service-->>Claude: Autenticación exitosa
    Claude->>User: ✅ ¡MCP conectado!
```

### Tabla de Servidores MCP Disponibles

| Servidor MCP | Propósito | Herramientas Comunes | Auth | Tiempo Real |
|------------|---------|--------------|------|-----------|
| **Filesystem** | Operaciones de archivo | read, write, delete | Permisos del SO | ✅ Sí |
| **GitHub** | Gestión de repositorios | list_prs, create_issue, push | OAuth | ✅ Sí |
| **Slack** | Comunicación de equipo | send_message, list_channels | Token | ✅ Sí |
| **Database** | Consultas SQL | query, insert, update | Credenciales | ✅ Sí |
| **Google Docs** | Acceso a documentos | read, write, share | OAuth | ✅ Sí |
| **Asana** | Gestión de proyectos | create_task, update_status | API Key | ✅ Sí |
| **Stripe** | Datos de pago | list_charges, create_invoice | API Key | ✅ Sí |
| **Memory** | Memory persistente | store, retrieve, delete | Local | ❌ No |

### Ejemplos Prácticos

#### Ejemplo 1: Configuración de GitHub MCP

**Archivo:** `.mcp.json` (ámbito del proyecto) o `~/.claude.json` (ámbito de usuario)

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Herramientas de GitHub MCP Disponibles:**

~~~~markdown
# GitHub MCP Tools

## Pull Request Management
- `list_prs` - List all PRs in repository
- `get_pr` - Get PR details including diff
- `create_pr` - Create new PR
- `update_pr` - Update PR description/title
- `merge_pr` - Merge PR to main branch
- `review_pr` - Add review comments

Example request:
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

## Issue Management
- `list_issues` - List all issues
- `get_issue` - Get issue details
- `create_issue` - Create new issue
- `close_issue` - Close issue
- `add_comment` - Add comment to issue

## Repository Information
- `get_repo_info` - Repository details
- `list_files` - File tree structure
- `get_file_content` - Read file contents
- `search_code` - Search across codebase

## Commit Operations
- `list_commits` - Commit history
- `get_commit` - Specific commit details
- `create_commit` - Create new commit
~~~~

#### Ejemplo 2: Configuración de Database MCP

**Configuración:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-database"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost/mydb"
      }
    }
  }
}
```

**Ejemplo de Uso:**

```markdown
User: Fetch all users with more than 10 orders

Claude: I'll query your database to find that information.

# Using MCP database tool:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Results:
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

#### Ejemplo 3: Flujo de Trabajo Multi-MCP

**Escenario: Generación de Informe Diario**

```markdown
# Daily Report Workflow using Multiple MCPs

## Setup
1. GitHub MCP - fetch PR metrics
2. Database MCP - query sales data
3. Slack MCP - post report
4. Filesystem MCP - save report

## Workflow

### Step 1: Fetch GitHub Data
/mcp__github__list_prs completed:true last:7days

Output:
- Total PRs: 42
- Average merge time: 2.3 hours
- Review turnaround: 1.1 hours

### Step 2: Query Database
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

Output:
- Sales: 247
- Revenue: $12,450

### Step 3: Generate Report
Combine data into HTML report

### Step 4: Save to Filesystem
Write report.html to /reports/

### Step 5: Post to Slack
Send summary to #daily-reports channel

Final Output:
✅ Report generated and posted
📊 47 PRs merged this week
💰 $12,450 in daily sales
```

#### Ejemplo 4: Operaciones de Filesystem MCP

**Configuración:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**Operaciones Disponibles:**

| Operación | Command | Propósito |
|-----------|---------|---------|
| Listar archivos | `ls ~/projects` | Mostrar contenidos del directorio |
| Leer archivo | `cat src/main.ts` | Leer contenidos del archivo |
| Escribir archivo | `create docs/api.md` | Crear nuevo archivo |
| Editar archivo | `edit src/app.ts` | Modificar archivo |
| Buscar | `grep "async function"` | Buscar en archivos |
| Eliminar | `rm old-file.js` | Eliminar archivo |

### MCP vs Memory: Matriz de Decisión

```mermaid
graph TD
    A["¿Necesitas datos externos?"]
    A -->|No| B["Usar Memory"]
    A -->|Sí| C["¿Cambia frecuentemente?"]
    C -->|No/Rara vez| B
    C -->|Sí/A menudo| D["Usar MCP"]

    B -->|Almacena| E["Preferencias<br/>Contexto<br/>Historial"]
    D -->|Accede| F["APIs en Vivo<br/>Bases de Datos<br/>Servicios"]

    style B fill:#e1f5ff
    style D fill:#fff9c4
```

### Patrón Solicitud/Respuesta

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as Servidor MCP
    participant DB as Base de Datos

    App->>MCP: Solicitud: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Ejecutar consulta
    DB-->>MCP: Conjunto de resultados
    MCP-->>App: Devolver datos parseados
    App->>App: Procesar resultado
    App->>App: Continuar tarea

    Note over MCP,DB: Acceso en tiempo real<br/>Sin caché
```

---

## Agent Skills

### Visión General

Agent Skills son capacidades reutilizables invocadas por el modelo, empaquetadas como carpetas que contienen instrucciones, scripts y recursos. Claude detecta y usa automáticamente las skills relevantes.

### Arquitectura de Skill

```mermaid
graph TB
    A["Directorio de Skill"]
    B["SKILL.md"]
    C["Metadatos YAML"]
    D["Instrucciones"]
    E["Scripts"]
    F["Plantillas"]

    A --> B
    B --> C
    B --> D
    E --> A
    F --> A
```

### Proceso de Carga de Skills

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude
    participant System as System
    participant Skill as Skill

    User->>Claude: "Crear informe Excel"
    Claude->>System: Escanear skills disponibles
    System->>System: Cargar metadatos de skill
    Claude->>Claude: Coincidir solicitud de usuario con skills
    Claude->>Skill: Cargar SKILL.md de skill xlsx
    Skill-->>Claude: Devolver instrucciones + herramientas
    Claude->>Claude: Ejecutar skill
    Claude->>User: Generar archivo Excel
```

### Tabla de Tipos y Ubicaciones de Skills

| Tipo | Ubicación | Alcance | Compartido | Sync | Ideal Para |
|------|----------|-------|--------|------|----------|
| Pre-built | Integrado | Global | Todos los usuarios | Auto | Creación de documentos |
| Personal | `~/.claude/skills/` | Individual | No | Manual | Automatización personal |
| Project | `.claude/skills/` | Equipo | Sí | Git | Estándares del equipo |
| Plugin | Vía instalación de plugin | Varía | Depende | Auto | Características integradas |

### Skills Pre-built

```mermaid
graph TB
    A["Skills Pre-built"]
    B["PowerPoint (pptx)"]
    C["Excel (xlsx)"]
    D["Word (docx)"]
    E["PDF"]

    A --> B
    A --> C
    A --> D
    A --> E

    B --> B1["Crear presentaciones"]
    B --> B2["Editar diapositivas"]
    C --> C1["Crear hojas de cálculo"]
    C --> C2["Analizar datos"]
    D --> D1["Crear documentos"]
    D --> D2["Formatear texto"]
    E --> E1["Generar PDFs"]
    E --> E2["Completar formularios"]
```

### Skills Bundled

Claude Code ahora incluye 5 skills bundled disponibles desde el inicio:

| Skill | Command | Propósito |
|-------|---------|---------|
| **Simplify** | `/simplify` | Simplificar código complejo o explicaciones |
| **Batch** | `/batch` | Ejecutar operaciones en múltiples archivos o elementos |
| **Debug** | `/debug` | Depuración sistemática de problemas con análisis de causa raíz |
| **Loop** | `/loop` | Programar tareas recurrentes en un temporizador |
| **Claude API** | `/claude-api` | Interactuar directamente con la API de Anthropic |

Estas skills bundled están siempre disponibles y no requieren instalación ni configuración.

### Ejemplos Prácticos

#### Ejemplo 1: Skill de Revisión de Código Personalizada

**Estructura de Directorio:**

```
~/.claude/skills/code-review/
├── SKILL.md
├── templates/
│   ├── review-checklist.md
│   └── finding-template.md
└── scripts/
    ├── analyze-metrics.py
    └── compare-complexity.py
```

**Archivo:** `~/.claude/skills/code-review/SKILL.md`

```yaml
---
name: Code Review Specialist
description: Comprehensive code review with security, performance, and quality analysis
version: "1.0.0"
tags:
  - code-review
  - quality
  - security
when_to_use: When users ask to review code, analyze code quality, or evaluate pull requests
effort: high
shell: bash
---

# Code Review Skill

This skill provides comprehensive code review capabilities focusing on:

1. **Security Analysis**
   - Authentication/authorization issues
   - Data exposure risks
   - Injection vulnerabilities
   - Cryptographic weaknesses
   - Sensitive data logging

2. **Performance Review**
   - Algorithm efficiency (Big O analysis)
   - Memory optimization
   - Database query optimization
   - Caching opportunities
   - Concurrency issues

3. **Code Quality**
   - SOLID principles
   - Design patterns
   - Naming conventions
   - Documentation
   - Test coverage

4. **Maintainability**
   - Code readability
   - Function size (should be < 50 lines)
   - Cyclomatic complexity
   - Dependency management
   - Type safety

## Review Template

For each piece of code reviewed, provide:

### Summary
- Overall quality assessment (1-5)
- Key findings count
- Recommended priority areas

### Critical Issues (if any)
- **Issue**: Clear description
- **Location**: File and line number
- **Impact**: Why this matters
- **Severity**: Critical/High/Medium
- **Fix**: Code example

### Findings by Category

#### Security (if issues found)
List security vulnerabilities with examples

#### Performance (if issues found)
List performance problems with complexity analysis

#### Quality (if issues found)
List code quality issues with refactoring suggestions

#### Maintainability (if issues found)
List maintainability problems with improvements
```

## Script Python: analyze-metrics.py

```python
#!/usr/bin/env python3
import re
import sys

def analyze_code_metrics(code):
    """Analyze code for common metrics."""

    # Count functions
    functions = len(re.findall(r'^def\s+\w+', code, re.MULTILINE))

    # Count classes
    classes = len(re.findall(r'^class\s+\w+', code, re.MULTILINE))

    # Average line length
    lines = code.split('\n')
    avg_length = sum(len(l) for l in lines) / len(lines) if lines else 0

    # Estimate complexity
    complexity = len(re.findall(r'\b(if|elif|else|for|while|and|or)\b', code))

    return {
        'functions': functions,
        'classes': classes,
        'avg_line_length': avg_length,
        'complexity_score': complexity
    }

if __name__ == '__main__':
    with open(sys.argv[1], 'r') as f:
        code = f.read()
    metrics = analyze_code_metrics(code)
    for key, value in metrics.items():
        print(f"{key}: {value:.2f}")
```

## Script Python: compare-complexity.py

```python
#!/usr/bin/env python3
"""
Compare cyclomatic complexity of code before and after changes.
Helps identify if refactoring actually simplifies code structure.
"""

import re
import sys
from typing import Dict, Tuple

class ComplexityAnalyzer:
    """Analyze code complexity metrics."""

    def __init__(self, code: str):
        self.code = code
        self.lines = code.split('\n')

    def calculate_cyclomatic_complexity(self) -> int:
        """
        Calculate cyclomatic complexity using McCabe's method.
        Count decision points: if, elif, else, for, while, except, and, or
        """
        complexity = 1  # Base complexity

        # Count decision points
        decision_patterns = [
            r'\bif\b',
            r'\belif\b',
            r'\bfor\b',
            r'\bwhile\b',
            r'\bexcept\b',
            r'\band\b(?!$)',
            r'\bor\b(?!$)'
        ]

        for pattern in decision_patterns:
            matches = re.findall(pattern, self.code)
            complexity += len(matches)

        return complexity

    def calculate_cognitive_complexity(self) -> int:
        """
        Calculate cognitive complexity - how hard is it to understand?
        Based on nesting depth and control flow.
        """
        cognitive = 0
        nesting_depth = 0

        for line in self.lines:
            # Track nesting depth
            if re.search(r'^\s*(if|for|while|def|class|try)\b', line):
                nesting_depth += 1
                cognitive += nesting_depth
            elif re.search(r'^\s*(elif|else|except|finally)\b', line):
                cognitive += nesting_depth

            # Reduce nesting when unindenting
            if line and not line[0].isspace():
                nesting_depth = 0

        return cognitive

    def calculate_maintainability_index(self) -> float:
        """
        Maintainability Index ranges from 0-100.
        > 85: Excellent
        > 65: Good
        > 50: Fair
        < 50: Poor
        """
        lines = len(self.lines)
        cyclomatic = self.calculate_cyclomatic_complexity()
        cognitive = self.calculate_cognitive_complexity()

        # Simplified MI calculation
        mi = 171 - 5.2 * (cyclomatic / lines) - 0.23 * (cognitive) - 16.2 * (lines / 1000)

        return max(0, min(100, mi))

    def get_complexity_report(self) -> Dict:
        """Generate comprehensive complexity report."""
        return {
            'cyclomatic_complexity': self.calculate_cyclomatic_complexity(),
            'cognitive_complexity': self.calculate_cognitive_complexity(),
            'maintainability_index': round(self.calculate_maintainability_index(), 2),
            'lines_of_code': len(self.lines),
            'avg_line_length': round(sum(len(l) for l in self.lines) / len(self.lines), 2) if self.lines else 0
        }


def compare_files(before_file: str, after_file: str) -> None:
    """Compare complexity metrics between two code versions."""

    with open(before_file, 'r') as f:
        before_code = f.read()

    with open(after_file, 'r') as f:
        after_code = f.read()

    before_analyzer = ComplexityAnalyzer(before_code)
    after_analyzer = ComplexityAnalyzer(after_code)

    before_metrics = before_analyzer.get_complexity_report()
    after_metrics = after_analyzer.get_complexity_report()

    print("=" * 60)
    print("CODE COMPLEXITY COMPARISON")
    print("=" * 60)

    print("\nBEFORE:")
    print(f"  Cyclomatic Complexity:    {before_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {before_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {before_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {before_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {before_metrics['avg_line_length']}")

    print("\nAFTER:")
    print(f"  Cyclomatic Complexity:    {after_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {after_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {after_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {after_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {after_metrics['avg_line_length']}")

    print("\nCHANGES:")
    cyclomatic_change = after_metrics['cyclomatic_complexity'] - before_metrics['cyclomatic_complexity']
    cognitive_change = after_metrics['cognitive_complexity'] - before_metrics['cognitive_complexity']
    mi_change = after_metrics['maintainability_index'] - before_metrics['maintainability_index']
    loc_change = after_metrics['lines_of_code'] - before_metrics['lines_of_code']

    print(f"  Cyclomatic Complexity:    {cyclomatic_change:+d}")
    print(f"  Cognitive Complexity:     {cognitive_change:+d}")
    print(f"  Maintainability Index:    {mi_change:+.2f}")
    print(f"  Lines of Code:            {loc_change:+d}")

    print("\nASSESSMENT:")
    if mi_change > 0:
        print("  ✅ Code is MORE maintainable")
    elif mi_change < 0:
        print("  ⚠️  Code is LESS maintainable")
    else:
        print("  ➡️  Maintainability unchanged")

    if cyclomatic_change < 0:
        print("  ✅ Complexity DECREASED")
    elif cyclomatic_change > 0:
        print("  ⚠️  Complexity INCREASED")
    else:
        print("  ➡️  Complexity unchanged")

    print("=" * 60)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python compare-complexity.py <before_file> <after_file>")
        sys.exit(1)

    compare_files(sys.argv[1], sys.argv[2])
```

## Plantilla: review-checklist.md

```markdown
# Code Review Checklist

## Security Checklist
- [ ] No hardcoded credentials or secrets
- [ ] Input validation on all user inputs
- [ ] SQL injection prevention (parameterized queries)
- [ ] CSRF protection on state-changing operations
- [ ] XSS prevention with proper escaping
- [ ] Authentication checks on protected endpoints
- [ ] Authorization checks on resources
- [ ] Secure password hashing (bcrypt, argon2)
- [ ] No sensitive data in logs
- [ ] HTTPS enforced

## Performance Checklist
- [ ] No N+1 queries
- [ ] Appropriate use of indexes
- [ ] Caching implemented where beneficial
- [ ] No blocking operations on main thread
- [ ] Async/await used correctly
- [ ] Large datasets paginated
- [ ] Database connections pooled
- [ ] Regular expressions optimized
- [ ] No unnecessary object creation
- [ ] Memory leaks prevented

## Quality Checklist
- [ ] Functions < 50 lines
- [ ] Clear variable naming
- [ ] No duplicate code
- [ ] Proper error handling
- [ ] Comments explain WHY, not WHAT
- [ ] No console.logs in production
- [ ] Type checking (TypeScript/JSDoc)
- [ ] SOLID principles followed
- [ ] Design patterns applied correctly
- [ ] Self-documenting code

## Testing Checklist
- [ ] Unit tests written
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Integration tests present
- [ ] Coverage > 80%
- [ ] No flaky tests
- [ ] Mock external dependencies
- [ ] Clear test names
```

## Plantilla: finding-template.md

~~~~markdown
# Code Review Finding Template

Use this template when documenting each issue found during code review.

---

## Issue: [TITLE]

### Severity
- [ ] Critical (blocks deployment)
- [ ] High (should fix before merge)
- [ ] Medium (should fix soon)
- [ ] Low (nice to have)

### Category
- [ ] Security
- [ ] Performance
- [ ] Code Quality
- [ ] Maintainability
- [ ] Testing
- [ ] Design Pattern
- [ ] Documentation

### Location
**File:** `src/components/UserCard.tsx`

**Lines:** 45-52

**Function/Method:** `renderUserDetails()`

### Issue Description

**What:** Describe what the issue is.

**Why it matters:** Explain the impact and why this needs to be fixed.

**Current behavior:** Show the problematic code or behavior.

**Expected behavior:** Describe what should happen instead.

### Code Example

#### Current (Problematic)

```typescript
// Shows the N+1 query problem
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // Query per user!
  renderUserPosts(posts);
});
```

#### Suggested Fix

```typescript
// Optimized with JOIN query
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Impact Analysis

| Aspect | Impact | Severity |
|--------|--------|----------|
| Performance | 100+ queries for 20 users | High |
| User Experience | Slow page load | High |
| Scalability | Breaks at scale | Critical |
| Maintainability | Hard to debug | Medium |

### Related Issues

- Similar issue in `AdminUserList.tsx` line 120
- Related PR: #456
- Related issue: #789

### Additional Resources

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)
- [Performance Optimization Guide](./docs/performance.md)

### Reviewer Notes

- This is a common pattern in this codebase
- Consider adding this to the code style guide
- Might be worth creating a helper function

### Author Response (for feedback)

*To be filled by the code author:*

- [ ] Fix implemented in commit: `abc123`
- [ ] Fix status: Complete / In Progress / Needs Discussion
- [ ] Questions or concerns: (describe)

---

## Finding Statistics (for Reviewer)

When reviewing multiple findings, track:

- **Total Issues Found:** X
- **Critical:** X
- **High:** X
- **Medium:** X
- **Low:** X

**Recommendation:** ✅ Approve / ⚠️ Request Changes / 🔄 Needs Discussion

**Overall Code Quality:** 1-5 stars
~~~~

## Ejemplo de Uso

~~~~markdown
User: Review this React component code

Claude: I'll conduct a comprehensive code review using my Code Review Skill.

[Loads SKILL.md]
[Analyzes code against checklist]
[Runs Python metrics script]
[Applies templates]

## Code Review Results

### Summary
Quality Score: 3.5/5
Key Findings: 7 items
Priority Areas: Performance optimization, error handling

### Critical Issues: 1

**Issue**: N+1 Query Problem
**Location**: UserComponent.tsx, lines 45-52
**Impact**: Renders 100+ database queries for list of 20 users
**Severity**: High
**Fix**:
```javascript
// Before: N+1 queries
const users = fetchUsers();
users.forEach(user => fetchUserPosts(user.id)); // 20+ queries

// After: Single query with JOIN
const users = fetchUsersWithPosts(); // 1 query
```

### Performance Findings
- Missing pagination on large lists
- Recommendation: Use React.memo() for items
- Database query: Could be optimized with index

### Quality Findings
- Function in line 20 is 127 lines (max: 50)
- Missing error boundary
- Props should have TypeScript types
~~~~

#### Ejemplo 2: Skill de Voz de Marca

**Estructura de Directorio:**

```
.claude/skills/brand-voice/
├── SKILL.md
├── brand-guidelines.md
├── tone-examples.md
└── templates/
    ├── email-template.txt
    ├── social-post-template.txt
    └── blog-post-template.md
```

**Archivo:** `.claude/skills/brand-voice/SKILL.md`

```yaml
---
name: Brand Voice Consistency
description: Ensure all communication matches brand voice and tone guidelines
tags:
  - brand
  - writing
  - consistency
when_to_use: When creating marketing copy, customer communications, or public-facing content
---

# Brand Voice Skill

## Overview
This skill ensures all communications maintain consistent brand voice, tone, and messaging.

## Brand Identity

### Mission
Help teams automate their development workflows with AI

### Values
- **Simplicity**: Make complex things simple
- **Reliability**: Rock-solid execution
- **Empowerment**: Enable human creativity

### Tone of Voice
- **Friendly but professional** - approachable without being casual
- **Clear and concise** - avoid jargon, explain technical concepts simply
- **Confident** - we know what we're doing
- **Empathetic** - understand user needs and ... [truncado]
```

## Directrices de Escritura

### Do's ✅
- Use "you" when addressing readers
- Use active voice: "Claude generates reports" not "Reports are generated by Claude"
- Start with value proposition
- Use concrete examples
- Keep sentences under 20 words
- Use lists for clarity
- Include calls-to-action

### Don'ts ❌
- Don't use corporate jargon
- Don't patronize or oversimplify
- Don't use "we believe" or "we think"
- Don't use ALL CAPS except for emphasis
- Don't create walls of text
- Don't assume technical knowledge

## Vocabulary

### ✅ Preferred Terms
- Claude (not "the Claude AI")
- Code generation (not "auto-coding")
- Agent (not "bot")
- Streamline (not "revolutionize")
- Integrate (not "synergize")

### ❌ Avoid Terms
- "Cutting-edge" (overused)
- "Game-changer" (vague)
- "Leverage" (corporate-speak)
- "Utilize" (use "use")
- "Paradigm shift" (unclear)
```

## Examples

### ✅ Good Example
"Claude automates your code review process. Instead of manually checking each PR, Claude reviews security, performance, and quality—saving your team hours every week."

Why it works: Clear value, specific benefits, action-oriented

### ❌ Bad Example
"Claude leverages cutting-edge AI to provide comprehensive software development solutions."

Why it doesn't work: Vague, corporate jargon, no specific value

## Template: Email

```
Subject: [Clear, benefit-driven subject]

Hi [Name],

[Opening: What's the value for them]

[Body: How it works / What they'll get]

[Specific example or benefit]

[Call to action: Clear next step]

Best regards,
[Name]
```

## Template: Social Media

```
[Hook: Grab attention in first line]
[2-3 lines: Value or interesting fact]
[Call to action: Link, question, or engagement]
[Emoji: 1-2 max for visual interest]
```

## File: tone-examples.md
```
Exciting announcement:
"Save 8 hours per week on code reviews. Claude reviews your PRs automatically."

Empathetic support:
"We know deployments can be stressful. Claude handles testing so you don't have to worry."

Confident product feature:
"Claude doesn't just suggest code. It understands your architecture and maintains consistency."

Educational blog post:
"Let's explore how agents improve code review workflows. Here's what we learned..."
```

#### Ejemplo 3: Skill de Generador de Documentación

**Archivo:** `.claude/skills/doc-generator/SKILL.md`

~~~~yaml
---
name: API Documentation Generator
description: Generate comprehensive, accurate API documentation from source code
version: "1.0.0"
tags:
  - documentation
  - api
  - automation
when_to_use: When creating or updating API documentation
---

# API Documentation Generator Skill

## Generates

- OpenAPI/Swagger specifications
- API endpoint documentation
- SDK usage examples
- Integration guides
- Error code references
- Authentication guides

## Documentation Structure

### For Each Endpoint

```markdown
## GET /api/v1/users/:id

### Description
Brief explanation of what this endpoint does

### Parameters

| Name | Type | Required | Description |
|------|------|----------|-------------|
| id | string | Yes | User ID |

### Response

**200 Success**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Not Found**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "User does not exist"
}
```

### Examples

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```

## Python Script: generate-docs.py

```python
#!/usr/bin/env python3
import ast
import json
from typing import Dict, List

class APIDocExtractor(ast.NodeVisitor):
    """Extract API documentation from Python source code."""

    def __init__(self):
        self.endpoints = []

    def visit_FunctionDef(self, node):
        """Extract function documentation."""
        if node.name.startswith('get_') or node.name.startswith('post_'):
            doc = ast.get_docstring(node)
            endpoint = {
                'name': node.name,
                'docstring': doc,
                'params': [arg.arg for arg in node.args.args],
                'returns': self._extract_return_type(node)
            }
            self.endpoints.append(endpoint)
        self.generic_visit(node)

    def _extract_return_type(self, node):
        """Extract return type from function annotation."""
        if node.returns:
            return ast.unparse(node.returns)
        return "Any"

def generate_markdown_docs(endpoints: List[Dict]) -> str:
    """Generate markdown documentation from endpoints."""
    docs = "# API Documentation\n\n"

    for endpoint in endpoints:
        docs += f"## {endpoint['name']}\n\n"
        docs += f"{endpoint['docstring']}\n\n"
        docs += f"**Parameters**: {', '.join(endpoint['params'])}\n\n"
        docs += f"**Returns**: {endpoint['returns']}\n\n"
        docs += "---\n\n"

    return docs

if __name__ == '__main__':
    import sys
    with open(sys.argv[1], 'r') as f:
        tree = ast.parse(f.read())

    extractor = APIDocExtractor()
    extractor.visit(tree)

    markdown = generate_markdown_docs(extractor.endpoints)
    print(markdown)
~~~~

### Descubrimiento e Invocación de Skills

```mermaid
graph TD
    A["Solicitud del Usuario"] --> B["Claude Analiza"]
    B -->|Escanea| C["Skills Disponibles"]
    C -->|Verificación de metadatos| D["¿Coincide Descripción de Skill?"]
    D -->|Sí| E["Cargar SKILL.md"]
    D -->|No| F["Intentar siguiente skill"]
    F -->|¿Más skills?| D
    F -->|No más| G["Usar conocimiento general"]
    E --> H["Extraer Instrucciones"]
    H --> I["Ejecutar Skill"]
    I --> J["Devolver Resultados"]
```

### Skill vs Otras Características

```mermaid
graph TB
    A["Extender Claude"]
    B["Slash Commands"]
    C["Subagents"]
    D["Memory"]
    E["MCP"]
    F["Skills"]

    A --> B
    A --> C
    A --> D
    A --> E
    A --> F

    B -->|Invocado por usuario| G["Atajos rápidos"]
    C -->|Delegado automáticamente| H["Contextos aislados"]
    D -->|Persistente| I["Contexto entre sesiones"]
    E -->|Tiempo real| J["Acceso a datos externos"]
    F -->|Invocado automáticamente| K["Ejecución autónoma"]
```

---

## Claude Code Plugins

### Visión General

Claude Code Plugins son colecciones empaquetadas de personalizaciones (slash commands, subagents, servidores MCP, y hooks) que se instalan con un solo command. Representan el mecanismo de extensión de más alto nivel, combinando múltiples características en paquetes cohesivos y compartibles.

### Arquitectura

```mermaid
graph TB
    A["Plugin"]
    B["Slash Commands"]
    C["Subagents"]
    D["Servidores MCP"]
    E["Hooks"]
    F["Configuración"]

    A -->|agrupa| B
    A -->|agrupa| C
    A -->|agrupa| D
    A -->|agrupa| E
    A -->|agrupa| F
```

### Proceso de Carga de Plugins

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Plugin as Marketplace de Plugins
    participant Install as Instalación
    participant SlashCmds as Slash Commands
    participant Subagents
    participant MCPServers as Servidores MCP
    participant Hooks
    participant Tools as Herramientas Configuradas

    User->>Claude: /plugin install pr-review
    Claude->>Plugin: Descargar manifiesto del plugin
    Plugin-->>Claude: Devolver definición del plugin
    Claude->>Install: Extraer componentes
    Install->>SlashCmds: Configurar
    Install->>Subagents: Configurar
    Install->>MCPServers: Configurar
    Install->>Hooks: Configurar
    SlashCmds-->>Tools: Listo para usar
    Subagents-->>Tools: Listo para usar
    MCPServers-->>Tools: Listo para usar
    Hooks-->>Tools: Listo para usar
    Tools-->>Claude: Plugin instalado ✅
```

### Tipos y Distribución de Plugins

| Tipo | Alcance | Compartido | Autoridad | Ejemplos |
|------|-------|--------|-----------|----------|
| Oficial | Global | Todos los usuarios | Anthropic | PR Review, Security Guidance |
| Comunidad | Público | Todos los usuarios | Comunidad | DevOps, Data Science |
| Organización | Interno | Miembros del equipo | Empresa | Estándares internos, herramientas |
| Personal | Individual | Usuario único | Desarrollador | Flujos de trabajo personalizados |

### Estructura de Definición de Plugin

```yaml
---
name: plugin-name
version: "1.0.0"
description: "Lo que hace este plugin"
author: "Tu Nombre"
license: MIT

# Metadatos del plugin
tags:
  - categoría
  - caso-de-uso

# Requisitos
requires:
  - claude-code: ">=1.0.0"

# Componentes agrupados
components:
  - type: commands
    path: commands/
  - type: agents
    path: agents/
  - type: mcp
    path: mcp/
  - type: hooks
    path: hooks/

# Configuración
config:
  auto_load: true
  enabled_by_default: true
---
```

### Estructura de Plugin

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── task-1.md
│   ├── task-2.md
│   └── workflows/
├── agents/
│   ├── specialist-1.md
│   ├── specialist-2.md
│   └── configs/
├── skills/
│   ├── skill-1.md
│   └── skill-2.md
├── hooks/
│   └── hooks.json
├── .mcp.json
├── .lsp.json
├── settings.json
├── templates/
│   └── issue-template.md
├── scripts/
│   ├── helper-1.sh
│   └── helper-2.py
├── docs/
│   ├── README.md
│   └── USAGE.md
└── tests/
    └── plugin.test.js
```

### Ejemplos Prácticos

#### Ejemplo 1: Plugin PR Review

**Archivo:** `.claude-plugin/plugin.json`

```json
{
  "name": "pr-review",
  "version": "1.0.0",
  "description": "Complete PR review workflow with security, testing, and docs",
  "author": {
    "name": "Anthropic"
  },
  "license": "MIT"
}
```

**Archivo:** `commands/review-pr.md`

```markdown
---
name: Review PR
description: Start comprehensive PR review with security and testing checks
---

# PR Review

This command initiates a complete pull request review including:

1. Security analysis
2. Test coverage verification
3. Documentation updates
4. Code quality checks
5. Performance impact assessment
```

**Archivo:** `agents/security-reviewer.md`

```yaml
---
name: security-reviewer
description: Security-focused code review
tools: read, grep, diff
---

# Security Reviewer

Specializes in finding security vulnerabilities:
- Authentication/authorization issues
- Data exposure
- Injection attacks
- Secure configuration
```

**Instalación:**

```bash
/plugin install pr-review

# Resultado:
# ✅ 3 slash commands instalados
# ✅ 3 subagents configurados
# ✅ 2 servidores MCP conectados
# ✅ 4 hooks registrados
# ✅ ¡Listo para usar!
```

#### Ejemplo 2: Plugin DevOps

**Componentes:**

```
devops-automation/
├── commands/
│   ├── deploy.md
│   ├── rollback.md
│   ├── status.md
│   └── incident.md
├── agents/
│   ├── deployment-specialist.md
│   ├── incident-commander.md
│   └── alert-analyzer.md
├── mcp/
│   ├── github-config.json
│   ├── kubernetes-config.json
│   └── prometheus-config.json
├── hooks/
│   ├── pre-deploy.js
│   ├── post-deploy.js
│   └── on-error.js
└── scripts/
    ├── deploy.sh
    ├── rollback.sh
    └── health-check.sh
```

#### Ejemplo 3: Plugin de Documentación

**Componentes Agrupados:**

```
documentation/
├── commands/
│   ├── generate-api-docs.md
│   ├── generate-readme.md
│   ├── sync-docs.md
│   └── validate-docs.md
├── agents/
│   ├── api-documenter.md
│   ├── code-commentator.md
│   └── example-generator.md
├── mcp/
│   ├── github-docs-config.json
│   └── slack-announce-config.json
└── templates/
    ├── api-endpoint.md
    ├── function-docs.md
    └── adr-template.md
```

### Marketplace de Plugins

```mermaid
graph TB
    A["Marketplace de Plugins"]
    B["Oficial<br/>Anthropic"]
    C["Marketplace<br/>de Comunidad"]
    D["Registro<br/>Empresarial"]

    A --> B
    A --> C
    A --> D

    B -->|Categorías| B1["Desarrollo"]
    B -->|Categorías| B2["DevOps"]
    B -->|Categorías| B3["Documentación"]

    C -->|Búsqueda| C1["Automatización DevOps"]
    C -->|Búsqueda| C2["Desarrollo Móvil"]
    C -->|Búsqueda| C3["Data Science"]

    D -->|Interno| D1["Estándares de Empresa"]
    D -->|Interno| D2["Sistemas Legacy"]
    D -->|Interno| D3["Cumplimiento"]
```

### Instalación y Ciclo de Vida de Plugins

```mermaid
graph LR
    A["Descubrir"] -->|Explorar| B["Marketplace"]
    B -->|Seleccionar| C["Página del Plugin"]
    C -->|Ver| D["Componentes"]
    D -->|Instalar| E["/plugin install"]
    E -->|Extraer| F["Configurar"]
    F -->|Activar| G["Usar"]
    G -->|Verificar| H["Actualizar"]
    H -->|Disponible| G
    G -->|Hecho| I["Deshabilitar"]
    I -->|Más tarde| J["Habilitar"]
    J -->|Volver| G
```

### Comparación de Características de Plugins

| Característica | Slash Command | Skill | Subagent | Plugin |
|---------|---------------|-------|----------|--------|
| **Instalación** | Copia manual | Copia manual | Configuración manual | Un command |
| **Tiempo de Configuración** | 5 minutos | 10 minutos | 15 minutos | 2 minutos |
| **Agrupación** | Archivo único | Archivo único | Archivo único | Múltiple |
| **Versionado** | Manual | Manual | Manual | Automático |
| **Compartir en Equipo** | Copiar archivo | Copiar archivo | Copiar archivo | ID de instalación |
| **Actualizaciones** | Manual | Manual | Manual | Auto-disponible |
| **Dependencias** | Ninguna | Ninguna | Ninguna | Puede incluir |
| **Marketplace** | No | No | No | Sí |
| **Distribución** | Repositorio | Repositorio | Repositorio | Marketplace |

### Casos de Uso de Plugins

| Caso de Uso | Recomendación | Por Qué |
|----------|-----------------|-----|
| **Incorporación de Equipo** | ✅ Usar Plugin | Configuración instantánea, todas las configuraciones |
| **Configuración de Framework** | ✅ Usar Plugin | Agrupa commands específicos del framework |
| **Estándares Empresariales** | ✅ Usar Plugin | Distribución centralizada, control de versiones |
| **Automatización de Tarea Rápida** | ❌ Usar Command | Complejidad excesiva |
| **Experiencia de Dominio Único** | ❌ Usar Skill | Demasiado pesado, usar skill en su lugar |
| **Análisis Especializado** | ❌ Usar Subagent | Crear manualmente o usar skill |
| **Acceso a Datos en Vivo** | ❌ Usar MCP | Independiente, no agrupar |

### Cuándo Crear un Plugin

```mermaid
graph TD
    A["¿Debería crear un plugin?"]
    A -->|Necesito múltiples componentes| B{"¿Múltiples commands<br/>o subagents<br/>o MCPs?"}
    B -->|Sí| C["✅ Crear Plugin"]
    B -->|No| D["Usar Característica Individual"]
    A -->|Flujo de trabajo del equipo| E{"¿Compartir con<br/>el equipo?"}
    E -->|Sí| C
    E -->|No| F["Mantener como Configuración Local"]
    A -->|Configuración compleja| G{"¿Necesita auto<br/>configuración?"}
    G -->|Sí| C
    G -->|No| D
```

### Publicar un Plugin

**Pasos para publicar:**

1. Crear estructura de plugin con todos los componentes
2. Escribir manifiesto `.claude-plugin/plugin.json`
3. Crear `README.md` con documentación
4. Probar localmente con `/plugin install ./my-plugin`
5. Enviar al marketplace de plugins
6. Obtener revisión y aprobación
7. Publicado en el marketplace
8. Los usuarios pueden instalar con un command

**Ejemplo de envío:**

~~~~markdown
# PR Review Plugin

## Description
Complete PR review workflow with security, testing, and documentation checks.

## What's Included
- 3 slash commands for different review types
- 3 specialized subagents
- GitHub and CodeQL MCP integration
- Automated security scanning hooks

## Installation
```bash
/plugin install pr-review
```

## Features
✅ Security analysis
✅ Test coverage checking
✅ Documentation verification
✅ Code quality assessment
✅ Performance impact analysis

## Usage
```bash
/review-pr
/check-security
/check-tests
```

## Requirements
- Claude Code 1.0+
- GitHub access
- CodeQL (optional)
~~~~

### Plugin vs Configuración Manual

**Configuración Manual (2+ horas):**
- Instalar slash commands uno por uno
- Crear subagents individualmente
- Configurar MCPs por separado
- Configurar hooks manualmente
- Documentar todo
- Compartir con el equipo (esperar que configuren correctamente)

**Con Plugin (2 minutos):**
```bash
/plugin install pr-review
# ✅ Todo instalado y configurado
# ✅ Listo para usar inmediatamente
# ✅ El equipo puede reproducir la configuración exacta
```

---

## Comparación e Integración

### Matriz de Comparación de Características

| Característica | Invocación | Persistencia | Alcance | Caso de Uso |
|---------|-----------|------------|-------|----------|
| **Slash Commands** | Manual (`/cmd`) | Solo sesión | Command único | Atajos rápidos |
| **Subagents** | Auto-delegado | Contexto aislado | Tarea especializada | Distribución de tareas |
| **Memory** | Auto-cargado | Entre sesiones | Contexto de usuario/equipo | Aprendizaje a largo plazo |
| **Protocolo MCP** | Auto-consultado | Externo en tiempo real | Acceso a datos en vivo | Información dinámica |
| **Skills** | Auto-invocado | Basado en sistema de archivos | Experiencia reutilizable | Flujos de trabajo automatizados |

### Línea de Tiempo de Interacción

```mermaid
graph LR
    A["Inicio de Sesión"] -->|Cargar| B["Memory (CLAUDE.md)"]
    B -->|Descubrir| C["Skills Disponibles"]
    C -->|Registrar| D["Slash Commands"]
    D -->|Conectar| E["Servidores MCP"]
    E -->|Listo| F["Interacción con Usuario"]

    F -->|Escribe /cmd| G["Slash Command"]
    F -->|Solicitud| H["Auto-Invocar Skill"]
    F -->|Consulta| I["Datos MCP"]
    F -->|Tarea compleja| J["Delegar a Subagent"]

    G -->|Usa| B
    H -->|Usa| B
    I -->|Usa| B
    J -->|Usa| B
```

### Ejemplo de Integración Práctica: Automatización de Soporte al Cliente

#### Arquitectura

```mermaid
graph TB
    User["Email del Cliente"] -->|Recibe| Router["Enrutador de Soporte"]

    Router -->|Analizar| Memory["Memory<br/>Historial del cliente"]
    Router -->|Buscar| MCP1["MCP: BD de Clientes<br/>Tickets anteriores"]
    Router -->|Verificar| MCP2["MCP: Slack<br/>Estado del equipo"]

    Router -->|Enrutar Complejo| Sub1["Subagent: Soporte Técnico<br/>Contexto: Problemas técnicos"]
    Router -->|Enrutar Simple| Sub2["Subagent: Facturación<br/>Contexto: Problemas de pago"]
    Router -->|Enrutar Urgente| Sub3["Subagent: Escalamiento<br/>Contexto: Manejo prioritario"]

    Sub1 -->|Formatear| Skill1["Skill: Generador de Respuestas<br/>Voz de marca mantenida"]
    Sub2 -->|Formatear| Skill2["Skill: Generador de Respuestas"]
    Sub3 -->|Formatear| Skill3["Skill: Generador de Respuestas"]

    Skill1 -->|Generar| Output["Respuesta Formateada"]
    Skill2 -->|Generar| Output
    Skill3 -->|Generar| Output

    Output -->|Publicar| MCP3["MCP: Slack<br/>Notificar al equipo"]
    Output -->|Enviar| Reply["Respuesta al Cliente"]
```

#### Flujo de Solicitud

```markdown
## Flujo de Solicitud de Soporte al Cliente

### 1. Email Entrante
"¡Estoy recibiendo error 500 al intentar subir archivos. Esto está bloqueando mi flujo de trabajo!"

### 2. Búsqueda de Memory
- Carga CLAUDE.md con estándares de soporte
- Verifica historial del cliente: Cliente VIP, 3er incidente este mes

### 3. Consultas MCP
- GitHub MCP: Listar issues abiertos (encuentra informe de bug relacionado)
- Database MCP: Verificar estado del sistema (sin interrupciones reportadas)
- Slack MCP: Verificar si ingeniería está al tanto

### 4. Detección y Carga de Skills
- La solicitud coincide con la skill "Soporte Técnico"
- Carga plantilla de respuesta de soporte desde la Skill

### 5. Delegación de Subagent
- Enruta al Subagent de Soporte Técnico
- Proporciona contexto: historial del cliente, detalles del error, issues conocidos
- El subagent tiene acceso completo a: herramientas read, bash, grep

### 6. Procesamiento del Subagent
Subagent de Soporte Técnico:
- Busca en el código base error 500 en subida de archivos
- Encuentra cambio reciente en commit 8f4a2c
- Crea documentación de solución alternativa

### 7. Ejecución de Skill
Skill Generador de Respuestas:
- Usa directrices de Brand Voice
- Formatea respuesta con empatía
- Incluye pasos de solución alternativa
- Enlaza a documentación relacionada

### 8. Salida MCP
- Publica actualización en canal de Slack #support
- Etiqueta al equipo de ingeniería
- Actualiza ticket en Jira MCP

### 9. Respuesta
El cliente recibe:
- Reconocimiento empático
- Explicación de la causa
- Solución alternativa inmediata
- Cronograma para solución permanente
- Enlace a issues relacionados
```

### Orquestación Completa de Características

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Memory as Memory<br/>CLAUDE.md
    participant MCP as Servidores MCP
    participant Skills as Skills
    participant SubAgent as Subagents

    User->>Claude: Solicitud: "Construir sistema de auth"
    Claude->>Memory: Cargar estándares del proyecto
    Memory-->>Claude: Estándares de auth, prácticas del equipo
    Claude->>MCP: Consultar GitHub para implementaciones similares
    MCP-->>Claude: Ejemplos de código, mejores prácticas
    Claude->>Skills: Detectar Skills coincidentes
    Skills-->>Claude: Skill de Revisión de Seguridad + Skill de Pruebas
    Claude->>SubAgent: Delegar implementación
    SubAgent->>SubAgent: Construir función
    Claude->>Skills: Aplicar Skill de Revisión de Seguridad
    Skills-->>Claude: Resultados de lista de verificación de seguridad
    Claude->>SubAgent: Delegar pruebas
    SubAgent-->>Claude: Resultados de pruebas
    Claude->>User: Sistema completo entregado
```

### Cuándo Usar Cada Característica

```mermaid
graph TD
    A["Nueva Tarea"] --> B{¿Tipo de Tarea?}

    B -->|Flujo de trabajo repetido| C["Slash Command"]
    B -->|Necesita datos en tiempo real| D["Protocolo MCP"]
    B -->|Recordar para la próxima vez| E["Memory"]
    B -->|Subtarea especializada| F["Subagent"]
    B -->|Trabajo específico de dominio| G["Skill"]

    C --> C1["✅ Atajo del equipo"]
    D --> D1["✅ Acceso a API en vivo"]
    E --> E1["✅ Contexto persistente"]
    F --> F1["✅ Ejecución paralela"]
    G --> G1["✅ Experiencia auto-invocada"]
```

### Árbol de Decisión de Selección

```mermaid
graph TD
    Start["¿Necesitas extender Claude?"]

    Start -->|Tarea repetida rápida| A{"¿Manual o Auto?"}
    A -->|Manual| B["Slash Command"]
    A -->|Auto| C["Skill"]

    Start -->|Necesita datos externos| D{"¿En tiempo real?"}
    D -->|Sí| E["Protocolo MCP"]
    D -->|No/Entre sesiones| F["Memory"]

    Start -->|Proyecto complejo| G{"¿Múltiples roles?"}
    G -->|Sí| H["Subagents"]
    G -->|No| I["Skills + Memory"]

    Start -->|Contexto a largo plazo| J["Memory"]
    Start -->|Flujo de trabajo del equipo| K["Slash Command +<br/>Memory"]
    Start -->|Automatización completa| L["Skills +<br/>Subagents +<br/>MCP"]
```

---

## Tabla Resumen

| Aspecto | Slash Commands | Subagents | Memory | MCP | Skills | Plugins |
|--------|---|---|---|---|---|---|
| **Dificultad de Configuración** | Fácil | Media | Fácil | Media | Media | Fácil |
| **Curva de Aprendizaje** | Baja | Media | Baja | Media | Media | Baja |
| **Beneficio para Equipo** | Alto | Alto | Medio | Alto | Alto | Muy Alto |
| **Nivel de Automatización** | Bajo | Alto | Medio | Alto | Alto | Muy Alto |
| **Gestión de Contexto** | Sesión única | Aislado | Persistente | Tiempo real | Persistente | Todas las características |
| **Carga de Mantenimiento** | Bajo | Medio | Bajo | Medio | Medio | Bajo |
| **Escalabilidad** | Buena | Excelente | Buena | Excelente | Excelente | Excelente |
| **Capacidad de Compartir** | Regular | Regular | Buena | Buena | Buena | Excelente |
| **Versionado** | Manual | Manual | Manual | Manual | Manual | Automático |
| **Instalación** | Copia manual | Configuración manual | N/A | Configuración manual | Copia manual | Un command |

---

## Guía de Inicio Rápido

### Semana 1: Comenzar Simple
- Crear 2-3 slash commands para tareas comunes
- Habilitar Memory en Configuración
- Documentar estándares del equipo en CLAUDE.md

### Semana 2: Añadir Acceso en Tiempo Real
- Configurar 1 MCP (GitHub o Database)
- Usar `/mcp` para configurar
- Consultar datos en vivo en tus flujos de trabajo

### Semana 3: Distribuir Trabajo
- Crear primer Subagent para rol específico
- Usar `/agents` command
- Probar delegación con tarea simple

### Semana 4: Automatizar Todo
- Crear primera Skill para automatización repetida
- Usar marketplace de Skills o construir personalizada
- Combinar todas las características para flujo de trabajo completo

### Continuo
- Revisar y actualizar Memory mensualmente
- Añadir nuevas Skills a medida que surjan patrones
- Optimizar consultas MCP
- Refinar prompts de Subagent

---

## Hooks

### Visión General

Hooks son commands shell impulsados por eventos que se ejecutan automáticamente en respuesta a eventos de Claude Code. Permiten automatización, validación y flujos de trabajo personalizados sin intervención manual.

### Eventos de Hook

Claude Code soporta **25 eventos de hook** en cuatro tipos de hook (command, http, prompt, agent):

| Evento de Hook | Activador | Casos de Uso |
|------------|---------|-----------|
| **SessionStart** | Sesión comienza/resume/limpia/compacta | Configuración de entorno, inicialización |
| **InstructionsLoaded** | CLAUDE.md o archivo de reglas cargado | Validación, transformación, aumento |
| **UserPromptSubmit** | Usuario envía prompt | Validación de entrada, filtrado de prompts |
| **PreToolUse** | Antes de que cualquier herramienta se ejecute | Validación, puertas de aprobación, registro |
| **PermissionRequest** | Diálogo de permiso mostrado | Flujos de auto-aprobación/denegación |
| **PostToolUse** | Después de que la herramienta tenga éxito | Auto-formateo, notificaciones, limpieza |
| **PostToolUseFailure** | Ejecución de herramienta falla | Manejo de errores, registro |
| **Notification** | Notificación enviada | Alertas, integraciones externas |
| **SubagentStart** | Subagent spawned | Inyección de contexto, inicialización |
| **SubagentStop** | Subagent termina | Validación de resultados, registro |
| **Stop** | Claude termina de responder | Generación de resumen, tareas de limpieza |
| **StopFailure** | Error de API termina el turno | Recuperación de errores, registro |
| **TeammateIdle** | Compañero de equipo de agente inactivo | Distribución de trabajo, coordinación |
| **TaskCompleted** | Tarea marcada como completada | Procesamiento posterior a la tarea |
| **TaskCreated** | Tarea creada vía TaskCreate | Seguimiento de tareas, registro |
| **ConfigChange** | Archivo de configuración cambia | Validación, propagación |
| **CwdChanged** | Cambios de directorio de trabajo | Configuración específica del directorio |
| **FileChanged** | Cambios de archivo vigilado | Monitoreo de archivos, activadores de reconstrucción |
| **PreCompact** | Antes de la compactación de contexto | Preservación de estado |
| **PostCompact** | Después de que se completa la compactación | Acciones posteriores a la compactación |
| **WorktreeCreate** | Worktree siendo creado | Configuración, inicialización de recursos |
| **WorktreeRemove** | Worktree siendo eliminado | Limpieza, desasignación de recursos |
| **Elicitation** | Servidor MCP solicita entrada del usuario | Validación de entrada |
| **ElicitationResult** | Usuario responde a elicitation | Procesamiento de respuesta |
| **SessionEnd** | Sesión termina | Limpieza, registro final |

### Hooks Comunes

Hooks están configurados en `~/.claude/settings.json` (nivel de usuario) o `.claude/settings.json` (nivel de proyecto):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write $CLAUDE_FILE_PATH"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "eslint $CLAUDE_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Variables de Entorno de Hook

- `$CLAUDE_FILE_PATH` - Ruta al archivo siendo editado/escrito
- `$CLAUDE_TOOL_NAME` - Nombre de la herramienta siendo usada
- `$CLAUDE_SESSION_ID` - Identificador de sesión actual
- `$CLAUDE_PROJECT_DIR` - Ruta del directorio del proyecto

### Mejores Prácticas

✅ **Hacer:**
- Mantener hooks rápidos (< 1 segundo)
- Usar hooks para validación y automatización
- Manejar errores gracefulmente
- Usar rutas absolutas

❌ **No Hacer:**
- Hacer hooks interactivos
- Usar hooks para tareas de larga duración
- Hardcodear credenciales

**Ver**: [06-hooks/](06-hooks/) para ejemplos detallados

---

## Checkpoints and Rewind

### Visión General

Checkpoints permiten guardar el estado de la conversación y retroceder a puntos anteriores, permitiendo experimentación segura y exploración de múltiples enfoques.

### Conceptos Clave

| Concepto | Descripción |
|---------|-------------|
| **Checkpoint** | Instantánea del estado de la conversación incluyendo mensajes, archivos y contexto |
| **Rewind** | Volver a un checkpoint anterior, descartando cambios posteriores |
| **Branch Point** | Checkpoint desde el cual se exploran múltiples enfoques |

### Accediendo a Checkpoints

Checkpoints se crean automáticamente con cada prompt de usuario. Para retroceder:

```bash
# Presiona Esc dos veces para abrir el navegador de checkpoints
Esc + Esc

# O usa el command /rewind
/rewind
```

Cuando seleccionas un checkpoint, eliges entre cinco opciones:
1. **Restaurar código y conversación** -- Revertir ambos a ese punto
2. **Restaurar conversación** -- Rebobinar mensajes, mantener código actual
3. **Restaurar código** -- Revertir archivos, mantener conversación
4. **Resumir desde aquí** -- Comprimir conversación en un resumen
5. **Never mind** -- Cancelar

### Casos de Uso

| Escenario | Flujo de Trabajo |
|----------|----------|
| **Explorar Enfoques** | Guardar → Intentar A → Guardar → Rewind → Intentar B → Comparar |
| **Refactorización Segura** | Guardar → Refactorizar → Probar → Si falla: Rewind |
| **Pruebas A/B** | Guardar → Diseño A → Guardar → Rewind → Diseño B → Comparar |
| **Recuperación de Errores** | Notar problema → Rewind al último buen estado |

### Configuración

```json
{
  "autoCheckpoint": true
}
```

**Ver**: [08-checkpoints/](08-checkpoints/) para ejemplos detallados

---

## Características Avanzadas

### Planning Mode

Crear planes de implementación detallados antes de codificar.

**Activación:**
```bash
/plan Implementar sistema de autenticación de usuarios
```

**Beneficios:**
- Hoja de ruta clara con estimaciones de tiempo
- Evaluación de riesgos
- Desglose sistemático de tareas
- Oportunidad para revisión y modificación

### Extended Thinking

Razonamiento profundo para problemas complejos.

**Activación:**
- Alternar con `Alt+T` (o `Option+T` en macOS) durante una sesión
- Establecer variable de entorno `MAX_THINKING_TOKENS` para control programático

```bash
# Habilitar extended thinking vía variable de entorno
export MAX_THINKING_TOKENS=50000
claude -p "¿Deberíamos usar microservicios o monolito?"
```

**Beneficios:**
- Análisis exhaustivo de compensaciones
- Mejores decisiones arquitectónicas
- Consideración de casos extremos
- Evaluación sistemática

### Background Tasks

Ejecutar operaciones largas sin bloquear la conversación.

**Uso:**
```bash
User: Ejecutar pruebas en segundo plano

Claude: Iniciada tarea bg-1234

/task list           # Mostrar todas las tareas
/task status bg-1234 # Verificar progreso
/task show bg-1234   # Ver salida
/task cancel bg-1234 # Cancelar tarea
```

### Permission Modes

Controlar qué puede hacer Claude.

| Modo | Descripción | Caso de Uso |
|------|-------------|----------|
| **default** | Permisos estándar con prompts para acciones sensibles | Desarrollo general |
| **acceptEdits** | Aceptar automáticamente ediciones de archivo sin confirmación | Flujos de trabajo de edición de confianza |
| **plan** | Solo análisis y planificación, sin modificaciones de archivo | Revisión de código, planificación de arquitectura |
| **auto** | Aprobar automáticamente acciones seguras, preguntar solo por acciones riesgosas | Autonomía equilibrada con seguridad |
| **dontAsk** | Ejecutar todas las acciones sin prompts de confirmación | Usuarios experimentados, automatización |
| **bypassPermissions** | Acceso completo sin restricciones, sin verificaciones de seguridad | Pipelines CI/CD, scripts de confianza |

**Uso:**
```bash
claude --permission-mode plan          # Análisis de solo lectura
claude --permission-mode acceptEdits   # Auto-aceptar ediciones
claude --permission-mode auto          # Auto-aprobar acciones seguras
claude --permission-mode dontAsk       # Sin prompts de confirmación
```

### Headless Mode (Print Mode)

Ejecutar Claude Code sin entrada interactiva para automatización y CI/CD usando la bandera `-p` (print).

**Uso:**
```bash
# Ejecutar tarea específica
claude -p "Ejecutar todas las pruebas"

# Canalizar entrada para análisis
cat error.log | claude -p "explicar este error"

# Integración CI/CD (GitHub Actions)
- name: AI Code Review
  run: claude -p "Revisar cambios de PR y reportar problemas"

# Salida JSON para scripting
claude -p --output-format json "listar todas las funciones en src/"
```

### Scheduled Tasks

Ejecutar tareas en un horario repetitivo usando el command `/loop`.

**Uso:**
```bash
/loop every 30m "Ejecutar pruebas y reportar fallos"
/loop every 2h "Verificar actualizaciones de dependencias"
/loop every 1d "Generar resumen diario de cambios de código"
```

Las tareas programadas se ejecutan en segundo plano y reportan resultados cuando se completan. Son útiles para monitoreo continuo, verificaciones periódicas y flujos de trabajo de mantenimiento automatizado.

### Chrome Integration

Claude Code puede integrarse con el navegador Chrome para tareas de automatización web. Esto permite capacidades como navegar páginas web, completar formularios, tomar capturas de pantalla y extraer datos de sitios web directamente dentro de tu flujo de trabajo de desarrollo.

### Session Management

Gestionar múltiples sesiones de trabajo.

**Commands:**
```bash
/resume                # Reanudar una conversación anterior
/rename "Función"      # Nombrar la sesión actual
/fork                  # Bifurcar en una nueva sesión
claude -c              # Continuar conversación más reciente
claude -r "Función"    # Reanudar sesión por nombre/ID
```

### Interactive Features

**Atajos de Teclado:**
- `Ctrl + R` - Buscar historial de commands
- `Tab` - Autocompletar
- `↑ / ↓` - Historial de commands
- `Ctrl + L` - Limpiar pantalla

**Entrada Multilínea:**
```bash
User: \
> Prompt largo y complejo
> que abarca múltiples líneas
> \end
```

### Configuración

Ejemplo de configuración completa:

```json
{
  "planning": {
    "autoEnter": true,
    "requireApproval": true
  },
  "extendedThinking": {
    "enabled": true,
    "showThinkingProcess": true
  },
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5
  },
  "permissions": {
    "mode": "default"
  }
}
```

**Ver**: [09-advanced-features/](09-advanced-features/) para guía completa

---

## Recursos

- [Documentación de Claude Code](https://code.claude.com/docs/en/overview)
- [Documentación de Anthropic](https://docs.anthropic.com)
- [Servidores MCP de GitHub](https://github.com/modelcontextprotocol/servers)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

---

*Última actualización: Marzo 2026*
*Para Claude Haiku 4.5, Sonnet 4.6, y Opus 4.6*
*Ahora incluye: Hooks, Checkpoints, Planning Mode, Extended Thinking, Background Tasks, Permission Modes (6 modos), Headless Mode, Session Management, Auto Memory, Agent Teams, Scheduled Tasks, Chrome Integration, Channels, Voice Dictation, y Bundled Skills*
