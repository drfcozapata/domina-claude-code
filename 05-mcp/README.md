<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# MCP (Model Context Protocol)

Esta carpeta contiene documentación y ejemplos exhaustivos sobre configuraciones y uso de servidores MCP con Claude Code.

## Overview

MCP (Model Context Protocol) es una forma estandarizada para que Claude acceda a herramientas externas, APIs y fuentes de datos en tiempo real. A diferencia de Memory, MCP proporciona acceso en vivo a datos cambiantes.

Características clave:
- Acceso en tiempo real a servicios externos
- Sincronización de datos en vivo
- Arquitectura extensible
- Autenticación segura
- Interacciones basadas en herramientas

## MCP Architecture

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["External Service"]

    A -->|Request: list_issues| B
    B -->|Query| C
    C -->|Data| B
    B -->|Response| A

    A -->|Request: create_issue| B
    B -->|Action| C
    C -->|Result| B
    B -->|Response| A

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#e8f5e9,stroke:#333,color:#333
```

## MCP Ecosystem

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#f3e5f5,stroke:#333,color:#333
    style G fill:#e8f5e9,stroke:#333,color:#333
    style H fill:#e8f5e9,stroke:#333,color:#333
    style I fill:#e8f5e9,stroke:#333,color:#333
    style J fill:#e8f5e9,stroke:#333,color:#333
    style K fill:#e8f5e9,stroke:#333,color:#333
```

## MCP Installation Methods

Claude Code soporta múltiples protocolos de transporte para conexiones a servidores MCP:

### HTTP Transport (Recommended)

```bash
# Basic HTTP connection
claude mcp add --transport http notion https://mcp.notion.com/mcp

# HTTP with authentication header
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### Stdio Transport (Local)

Para servidores MCP que se ejecutan localmente:

```bash
# Local Node.js server
claude mcp add --transport stdio myserver -- npx @myorg/mcp-server

# With environment variables
claude mcp add --transport stdio myserver --env KEY=value -- npx server
```

### SSE Transport (Deprecated)

El transporte Server-Sent Events está obsoleto en favor de `http` pero aún se soporta:

```bash
claude mcp add --transport sse legacy-server https://example.com/sse
```

### WebSocket Transport

Transporte WebSocket para conexiones persistentes bidireccionales:

```bash
claude mcp add --transport ws realtime-server wss://example.com/mcp
```

### Windows-Specific Note

En Windows nativo (no WSL), usa `cmd /c` para comandos npx:

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

### OAuth 2.0 Authentication

Claude Code soporta OAuth 2.0 para servidores MCP que lo requieren. Al conectarse a un servidor habilitado para OAuth, Claude Code maneja todo el flujo de autenticación:

```bash
# Connect to an OAuth-enabled MCP server (interactive flow)
claude mcp add --transport http my-service https://my-service.example.com/mcp

# Pre-configure OAuth credentials for non-interactive setup
claude mcp add --transport http my-service https://my-service.example.com/mcp \
  --client-id "your-client-id" \
  --client-secret "your-client-secret" \
  --callback-port 8080
```

| Feature | Description |
|---------|-------------|
| **Interactive OAuth** | Usa `/mcp` para activar el flujo de OAuth basado en navegador |
| **Pre-configured OAuth clients** | Clientes OAuth integrados para servicios comunes como Notion, Stripe y otros (v2.1.30+) |
| **Pre-configured credentials** | Flags `--client-id`, `--client-secret`, `--callback-port` para configuración automatizada |
| **Token storage** | Los tokens se almacenan de forma segura en el llavero de tu sistema |
| **Step-up auth** | Soporta autenticación escalonada para operaciones privilegiadas |
| **Discovery caching** | Los metadatos de descubrimiento OAuth se almacenan en caché para reconexiones más rápidas |
| **Metadata override** | `oauth.authServerMetadataUrl` en `.mcp.json` para anular el descubrimiento predeterminado de metadatos OAuth |

#### Overriding OAuth Metadata Discovery

Si tu servidor MCP devuelve errores en el endpoint de metadatos OAuth estándar (`/.well-known/oauth-authorization-server`) pero expone un endpoint OIDC funcional, puedes indicarle a Claude Code que obtenga los metadatos OAuth desde una URL específica. Establece `authServerMetadataUrl` en el objeto `oauth` de tu configuración del servidor:

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "oauth": {
        "authServerMetadataUrl": "https://auth.example.com/.well-known/openid-configuration"
      }
    }
  }
}
```

La URL debe usar `https://`. Esta opción requiere Claude Code v2.1.64 o posterior.

### Claude.ai MCP Connectors

Los servidores MCP configurados en tu cuenta de Claude.ai están automáticamente disponibles en Claude Code. Esto significa que cualquier conexión MCP que configures a través de la interfaz web de Claude.ai será accesible sin configuración adicional.

Los conectores MCP de Claude.ai también están disponibles en modo `--print` (v2.1.83+), lo que permite el uso no interactivo y mediante scripts.

Para deshabilitar los servidores MCP de Claude.ai en Claude Code, establece la variable de entorno `ENABLE_CLAUDEAI_MCP_SERVERS` en `false`:

```bash
ENABLE_CLAUDEAI_MCP_SERVERS=false claude
```

> **Note:** Esta función solo está disponible para usuarios que han iniciado sesión con cuentas de Claude.ai.

## MCP Setup Process

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Config File
    participant Service as External Service

    User->>Claude: Type /mcp
    Claude->>Claude: List available MCP servers
    Claude->>User: Show options
    User->>Claude: Select GitHub MCP
    Claude->>Config: Update configuration
    Config->>Claude: Activate connection
    Claude->>Service: Test connection
    Service-->>Claude: Authentication successful
    Claude->>User: ✅ MCP connected!
```

## MCP Tool Search

Cuando las descripciones de herramientas MCP superan el 10% de la ventana de contexto, Claude Code habilita automáticamente la búsqueda de herramientas para seleccionar eficientemente las herramientas correctas sin abrumar el contexto del modelo.

| Setting | Value | Description |
|---------|-------|-------------|
| `ENABLE_TOOL_SEARCH` | `auto` (default) | Se habilita automáticamente cuando las descripciones de herramientas superan el 10% del contexto |
| `ENABLE_TOOL_SEARCH` | `auto:<N>` | Se habilita automáticamente en un umbral personalizado de `N` herramientas |
| `ENABLE_TOOL_SEARCH` | `true` | Siempre habilitado independientemente del número de herramientas |
| `ENABLE_TOOL_SEARCH` | `false` | Deshabilitado; todas las descripciones de herramientas se envían completas |

> **Note:** La búsqueda de herramientas requiere Sonnet 4 o posterior, u Opus 4 o posterior. Los modelos Haiku no son compatibles con la búsqueda de herramientas.

## Dynamic Tool Updates

Claude Code soporta notificaciones `list_changed` de MCP. Cuando un servidor MCP agrega, elimina o modifica dinámicamente sus herramientas disponibles, Claude Code recibe la actualización y ajusta su lista de herramientas automáticamente, sin necesidad de reconexión o reinicio.

## MCP Elicitation

Los servidores MCP pueden solicitar entrada estructurada del usuario mediante diálogos interactivos (v2.1.49+). Esto permite que un servidor MCP solicite información adicional a mitad del flujo de trabajo, por ejemplo, pedir una confirmación, seleccionar entre una lista de opciones o completar campos requeridos, agregando interactividad a las interacciones del servidor MCP.

## Tool Description and Instruction Cap

A partir de la v2.1.84, Claude Code aplica un límite de **2 KB** en descripciones e instrucciones de herramientas por servidor MCP. Esto evita que servidores individuales consuman contexto excesivo con definiciones de herramientas demasiado verbosas, reduciendo la hinchazón del contexto y manteniendo las interacciones eficientes.

## MCP Prompts as Slash Commands

Los servidores MCP pueden exponer prompts que aparecen como comandos de barra en Claude Code. Los prompts son accesibles usando la convención de nomenclatura:

```
/mcp__<server>__<prompt>
```

Por ejemplo, si un servidor llamado `github` expone un prompt llamado `review`, puedes invocarlo como `/mcp__github__review`.

## Server Deduplication

Cuando el mismo servidor MCP está definido en múltiples ámbitos (local, project, user), la configuración local tiene prioridad. Esto te permite anular configuraciones de MCP a nivel de proyecto o usuario con personalizaciones locales sin conflictos.

## MCP Resources via @ Mentions

Puedes hacer referencia a recursos MCP directamente en tus prompts usando la sintaxis de mención `@`:

```
@server-name:protocol://resource/path
```

Por ejemplo, para hacer referencia a un recurso de base de datos específico:

```
@database:postgres://mydb/users
```

Esto permite que Claude obtenga e incluya contenido de recursos MCP en línea como parte del contexto de la conversación.

## MCP Scopes

Las configuraciones MCP se pueden almacenar en diferentes ámbitos con varios niveles de compartición:

| Scope | Location | Description | Shared With | Requires Approval |
|-------|----------|-------------|-------------|------------------|
| **Local** (default) | `~/.claude.json` (bajo la ruta del proyecto) | Privado para el usuario actual, solo para el proyecto actual (se llamaba `project` en versiones anteriores) | Solo tú | No |
| **Project** | `.mcp.json` | Verificado en el repositorio git | Miembros del equipo | Sí (primer uso) |
| **User** | `~/.claude.json` | Disponible en todos los proyectos (se llamaba `global` en versiones anteriores) | Solo tú | No |

### Using Project Scope

Almacena configuraciones MCP específicas del proyecto en `.mcp.json`:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.github.com/mcp"
    }
  }
}
```

Los miembros del equipo verán un prompt de aprobación en el primer uso de MCPs del proyecto.

## MCP Configuration Management

### Adding MCP Servers

```bash
# Add HTTP-based server
claude mcp add --transport http github https://api.github.com/mcp

# Add local stdio server
claude mcp add --transport stdio database -- npx @company/db-server

# List all MCP servers
claude mcp list

# Get details on specific server
claude mcp get github

# Remove an MCP server
claude mcp remove github

# Reset project-specific approval choices
claude mcp reset-project-choices

# Import from Claude Desktop
claude mcp add-from-claude-desktop
```

## Available MCP Servers Table

| MCP Server | Purpose | Common Tools | Auth | Real-time |
|------------|---------|--------------|------|-----------|
| **Filesystem** | File operations | read, write, delete | OS permissions | ✅ Yes |
| **GitHub** | Repository management | list_prs, create_issue, push | OAuth | ✅ Yes |
| **Slack** | Team communication | send_message, list_channels | Token | ✅ Yes |
| **Database** | SQL queries | query, insert, update | Credentials | ✅ Yes |
| **Google Docs** | Document access | read, write, share | OAuth | ✅ Yes |
| **Asana** | Project management | create_task, update_status | API Key | ✅ Yes |
| **Stripe** | Payment data | list_charges, create_invoice | API Key | ✅ Yes |
| **Memory** | Persistent memory | store, retrieve, delete | Local | ❌ No |

## Practical Examples

### Example 1: GitHub MCP Configuration

**File:** `.mcp.json` (project root)

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

**Available GitHub MCP Tools:**

#### Pull Request Management
- `list_prs` - Listar todos los PRs en el repositorio
- `get_pr` - Obtener detalles del PR incluyendo diff
- `create_pr` - Crear nuevo PR
- `update_pr` - Actualizar descripción/título del PR
- `merge_pr` - Fusionar PR a la rama main
- `review_pr` - Agregar comentarios de revisión

**Example request:**
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

#### Issue Management
- `list_issues` - Listar todos los issues
- `get_issue` - Obtener detalles del issue
- `create_issue` - Crear nuevo issue
- `close_issue` - Cerrar issue
- `add_comment` - Agregar comentario al issue

#### Repository Information
- `get_repo_info` - Detalles del repositorio
- `list_files` - Estructura del árbol de archivos
- `get_file_content` - Leer contenidos de archivos
- `search_code` - Buscar en todo el código base

#### Commit Operations
- `list_commits` - Historial de commits
- `get_commit` - Detalles de un commit específico
- `create_commit` - Crear nuevo commit

**Setup**:
```bash
export GITHUB_TOKEN="your_github_token"
# Or use the CLI to add directly:
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

### Environment Variable Expansion in Configuration

Las configuraciones MCP soportan expansión de variables de entorno con valores predeterminados de respaldo. La sintaxis `${VAR}` y `${VAR:-default}` funciona en los siguientes campos: `command`, `args`, `env`, `url`, y `headers`.

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_HEADER:-default-value}"
      }
    },
    "local-server": {
      "command": "${MCP_BIN_PATH:-npx}",
      "args": ["${MCP_PACKAGE:-@company/mcp-server}"],
      "env": {
        "DB_URL": "${DATABASE_URL:-postgresql://localhost/dev}"
      }
    }
  }
}
```

Las variables se expanden en tiempo de ejecución:
- `${VAR}` - Usa la variable de entorno, error si no está establecida
- `${VAR:-default}` - Usa la variable de entorno, usa el valor predeterminado si no está establecida

### Example 2: Database MCP Setup

**Configuration:**

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

**Example Usage:**

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

**Setup**:
```bash
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
# Or use the CLI to add directly:
claude mcp add --transport stdio database -- npx @modelcontextprotocol/server-database
```

### Example 3: Multi-MCP Workflow

**Scenario: Daily Report Generation**

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

**Setup**:
```bash
export GITHUB_TOKEN="your_github_token"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="your_slack_token"
# Add each MCP server via the CLI or configure them in .mcp.json
```

### Example 4: Filesystem MCP Operations

**Configuration:**

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

**Available Operations:**

| Operation | Command | Purpose |
|-----------|---------|---------|
| List files | `ls ~/projects` | Show directory contents |
| Read file | `cat src/main.ts` | Read file contents |
| Write file | `create docs/api.md` | Create new file |
| Edit file | `edit src/app.ts` | Modify file |
| Search | `grep "async function"` | Search in files |
| Delete | `rm old-file.js` | Delete file |

**Setup**:
```bash
# Use the CLI to add directly:
claude mcp add --transport stdio filesystem -- npx @modelcontextprotocol/server-filesystem /home/user/projects
```

## MCP vs Memory: Decision Matrix

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style A fill:#fff3e0,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#fff3e0,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#e8f5e9,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
```

## Request/Response Pattern

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Database

    App->>MCP: Request: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Execute query
    DB-->>MCP: Result set
    MCP-->>App: Return parsed data
    App->>App: Process result
    App->>App: Continue task

    Note over MCP,DB: Real-time access<br/>No caching
```

## Environment Variables

Almacena credenciales sensibles en variables de entorno:

```bash
# ~/.bashrc or ~/.zshrc
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxx"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="xoxb-xxxxxxxxxxxxx"
```

Luego haz referencia a ellas en la configuración MCP:

```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

## Claude as MCP Server (`claude mcp serve`)

Claude Code mismo puede actuar como un servidor MCP para otras aplicaciones. Esto permite que herramientas externas, editores y sistemas de automatización aprovechen las capacidades de Claude a través del protocolo MCP estándar.

```bash
# Start Claude Code as an MCP server on stdio
claude mcp serve
```

Otras aplicaciones pueden conectarse luego a este servidor como lo harían con cualquier servidor MCP basado en stdio. Por ejemplo, para agregar Claude Code como un servidor MCP en otra instancia de Claude Code:

```bash
claude mcp add --transport stdio claude-agent -- claude mcp serve
```

Esto es útil para construir flujos de trabajo multi-agente donde una instancia de Claude orquesta a otra.

## Managed MCP Configuration (Enterprise)

Para despliegues empresariales, los administradores de TI pueden aplicar políticas de servidores MCP a través del archivo de configuración `managed-mcp.json`. Este archivo proporciona control exclusivo sobre qué servidores MCP están permitidos o bloqueados en toda la organización.

**Location:**
- macOS: `/Library/Application Support/ClaudeCode/managed-mcp.json`
- Linux: `~/.config/ClaudeCode/managed-mcp.json`
- Windows: `%APPDATA%\ClaudeCode\managed-mcp.json`

**Features:**
- `allowedMcpServers` -- lista blanca de servidores permitidos
- `deniedMcpServers` -- lista negra de servidores prohibidos
- Soporta coincidencia por nombre de servidor, comando y patrones de URL
- Políticas de MCP en toda la organización aplicadas antes de la configuración del usuario
- Previene conexiones de servidores no autorizados

**Example configuration:**

```json
{
  "allowedMcpServers": [
    {
      "serverName": "github",
      "serverUrl": "https://api.github.com/mcp"
    },
    {
      "serverName": "company-internal",
      "serverCommand": "company-mcp-server"
    }
  ],
  "deniedMcpServers": [
    {
      "serverName": "untrusted-*"
    },
    {
      "serverUrl": "http://*"
    }
  ]
}
```

> **Note:** Cuando tanto `allowedMcpServers` como `deniedMcpServers` coinciden con un servidor, la regla de denegación tiene prioridad.

## Plugin-Provided MCP Servers

Los plugins pueden incluir sus propios servidores MCP, haciéndolos disponibles automáticamente cuando se instala el plugin. Los servidores MCP proporcionados por plugins se pueden definir de dos formas:

1. **`.mcp.json` independiente** -- Coloca un archivo `.mcp.json` en el directorio raíz del plugin
2. **En línea en `plugin.json`** -- Define servidores MCP directamente en el manifiesto del plugin

Usa la variable `${CLAUDE_PLUGIN_ROOT}` para hacer referencia a rutas relativas al directorio de instalación del plugin:

```json
{
  "mcpServers": {
    "plugin-tools": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/dist/mcp-server.js"],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config.json"
      }
    }
  }
}
```

## Subagent-Scoped MCP

Los servidores MCP se pueden definir en línea dentro del frontmatter del agente usando la clave `mcpServers:`, limitándolos a un subagente específico en lugar de todo el proyecto. Esto es útil cuando un agente necesita acceso a un servidor MCP particular que otros agentes en el flujo de trabajo no requieren.

```yaml
---
mcpServers:
  my-tool:
    type: http
    url: https://my-tool.example.com/mcp
---

You are an agent with access to my-tool for specialized operations.
```

Los servidores MCP de ámbito de subagente solo están disponibles dentro del contexto de ejecución de ese agente y no se comparten con el agente padre o agentes hermanos.

## MCP Output Limits

Claude Code aplica límites en la salida de herramientas MCP para prevenir desbordamiento del contexto:

| Limit | Threshold | Behavior |
|-------|-----------|----------|
| **Warning** | 10,000 tokens | Se muestra una advertencia de que la salida es grande |
| **Default max** | 25,000 tokens | La salida se trunca más allá de este límite |
| **Disk persistence** | 50,000 characters | Los resultados de herramientas que exceden 50K caracteres se persisten en disco |

El límite máximo de salida es configurable a través de la variable de entorno `MAX_MCP_OUTPUT_TOKENS`:

```bash
# Increase the max output to 50,000 tokens
export MAX_MCP_OUTPUT_TOKENS=50000
```

## Solving Context Bloat with Code Execution

A medida que la adopción de MCP escala, conectarse a docenas de servidores con cientos o miles de herramientas crea un desafío significativo: **hinchazón del contexto (context bloat)**. Este es probablemente el mayor problema con MCP a escala, y el equipo de ingeniería de Anthropic ha propuesto una solución elegante: usar ejecución de código en lugar de llamadas directas a herramientas.

> **Source**: [Code Execution with MCP: Building More Efficient Agents](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic Engineering Blog

### The Problem: Two Sources of Token Waste

**1. Tool definitions overload the context window**

La mayoría de los clientes MCP cargan todas las definiciones de herramientas por adelantado. Cuando se conecta a miles de herramientas, el modelo debe procesar cientos de miles de tokens antes de que siquiera lea la solicitud del usuario.

**2. Intermediate results consume additional tokens**

Cada resultado intermedio de herramienta pasa a través del contexto del modelo. Considera transferir una transcripción de reunión de Google Drive a Salesforce: la transcripción completa fluye a través del contexto **dos veces**: una vez al leerla y nuevamente al escribirla en el destino. Una transcripción de reunión de 2 horas podría significar más de 50,000 tokens adicionales.

```mermaid
graph LR
    A["Model"] -->|"Tool Call: getDocument"| B["MCP Server"]
    B -->|"Full transcript (50K tokens)"| A
    A -->|"Tool Call: updateRecord<br/>(re-sends full transcript)"| B
    B -->|"Confirmation"| A

    style A fill:#ffcdd2,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
```

### The Solution: MCP Tools as Code APIs

En lugar de pasar definiciones de herramientas y resultados a través de la ventana de contexto, el agente **escribe código** que llama a las herramientas MCP como APIs. El código se ejecuta en un entorno de ejecución aislado (sandboxed), y solo el resultado final regresa al modelo.

```mermaid
graph LR
    A["Model"] -->|"Writes code"| B["Code Execution<br/>Environment"]
    B -->|"Calls tools directly"| C["MCP Servers"]
    C -->|"Data stays in<br/>execution env"| B
    B -->|"Only final result<br/>(minimal tokens)"| A

    style A fill:#c8e6c9,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
```

#### How It Works

Las herramientas MCP se presentan como un árbol de archivos de funciones tipadas:

```
servers/
├── google-drive/
│   ├── getDocument.ts
│   └── index.ts
├── salesforce/
│   ├── updateRecord.ts
│   └── index.ts
└── ...
```

Cada archivo de herramienta contiene un wrapper tipado:

```typescript
// ./servers/google-drive/getDocument.ts
import { callMCPTool } from "../../../client.js";

interface GetDocumentInput {
  documentId: string;
}

interface GetDocumentResponse {
  content: string;
}

export async function getDocument(
  input: GetDocumentInput
): Promise<GetDocumentResponse> {
  return callMCPTool<GetDocumentResponse>(
    'google_drive__get_document', input
  );
}
```

El agente luego escribe código para orquestar las herramientas:

```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

// Data fl... [truncated]
const transcript = (
  await gdrive.getDocument({ documentId: 'abc123' })
).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

**Result: Token usage drops from ~150,000 to ~2,000 — a 98.7% reduction.**

### Key Benefits

| Benefit | Description |
|---------|-------------|
| **Progressive Disclosure** | El agente navega el sistema de archivos para cargar solo las definiciones de herramientas que necesita, en lugar de todas las herramientas por adelantado |
| **Context-Efficient Results** | Los datos se filtran/transforman en el entorno de ejecución antes de regresar al modelo |
| **Powerful Control Flow** | Bucles, condicionales y manejo de errores se ejecutan en código sin viajes de ida y vuelta a través del modelo |
| **Privacy Preservation** | Los datos intermedios (PII, registros sensibles) permanecen en el entorno de ejecución; nunca entran al contexto del modelo |
| **State Persistence** | Los agentes pueden guardar resultados intermedios en archivos y construir funciones de habilidad reutilizables |

#### Example: Filtering Large Datasets

```typescript
// Without code execution — all 10,000 rows flow through context
// TOOL CALL: gdrive.getSheet(sheetId: 'abc123')
//   -> returns 10,000 rows in context

// With code execution — filter in the execution environment
const allRows = await gdrive.getSheet({ sheetId: 'abc123' });
const pendingOrders = allRows.filter(
  row => row["Status"] === 'pending'
);
console.log(`Found ${pendingOrders.length} pending orders`);
console.log(pendingOrders.slice(0, 5)); // Only 5 rows reach the model
```

#### Example: Loop Without Round-Tripping

```typescript
// Poll for a deployment notification — runs entirely in code
let found = false;
while (!found) {
  const messages = await slack.getChannelHistory({
    channel: 'C123456'
  });
  found = messages.some(
    m => m.text.includes('deployment complete')
  );
  if (!found) await new Promise(r => setTimeout(r, 5000));
}
console.log('Deployment notification received');
```

### Trade-offs to Consider

La ejecución de código introduce su propia complejidad. Ejecutar código generado por el agente requiere:

- Un **entorno de ejecución aislado (sandboxed) seguro** con límites de recursos apropiados
- **Monitoreo y registro** del código ejecutado
- **Sobrecarga de infraestructura adicional** en comparación con llamadas directas a herramientas

Los beneficios: reducción de costos de tokens, menor latencia, mejor composición de herramientas, deben sopesarse contra estos costos de implementación. Para agentes con solo unos pocos servidores MCP, las llamadas directas a herramientas pueden ser más simples. Para agentes a escala (docenas de servidores, cientos de herramientas), la ejecución de código es una mejora significativa.

### MCPorter: A Runtime for MCP Tool Composition

[MCPorter](https://github.com/steipete/mcporter) es un runtime de TypeScript y conjunto de herramientas CLI que hace práctico llamar a servidores MCP sin boilerplate, y ayuda a reducir la hinchazón del contexto mediante exposición selectiva de herramientas y wrappers tipados.

**What it solves:** En lugar de cargar todas las definiciones de herramientas de todos los servidores MCP por adelantado, MCPorter te permite descubrir, inspeccionar y llamar a herramientas específicas bajo demanda, manteniendo tu contexto ágil.

**Key features:**

| Feature | Description |
|---------|-------------|
| **Zero-config discovery** | Auto-descubre servidores MCP desde Cursor, Claude, Codex o configuraciones locales |
| **Typed tool clients** | `mcporter emit-ts` genera interfaces `.d.ts` y wrappers listos para ejecutar |
| **Composable API** | `createServerProxy()` expone herramientas como métodos camelCase con helpers `.text()`, `.json()`, `.markdown()` |
| **CLI generation** | `mcporter generate-cli` convierte cualquier servidor MCP en un CLI independiente con filtrado `--include-tools` / `--exclude-tools` |
| **Parameter hiding** | Los parámetros opcionales permanecen ocultos por defecto, reduciendo la verbosidad del esquema |

**Installation:**

```bash
npx mcporter list          # No install required — discover servers instantly
pnpm add mcporter          # Add to a project
brew install steipete/tap/mcporter  # macOS via Homebrew
```

**Example — composing tools in TypeScript:**

```typescript
import { createRuntime, createServerProxy } from "mcporter";

const runtime = await createRuntime();
const gdrive = createServerProxy(runtime, "google-drive");
const salesforce = createServerProxy(runtime, "salesforce");

// Data flows between tools without passing through the model context
const doc = await gdrive.getDocument({ documentId: "abc123" });
await salesforce.updateRecord({
  objectType: "SalesMeeting",
  recordId: "00Q5f000001abcXYZ",
  data: { Notes: doc.text() }
});
```

**Example — CLI tool call:**

```bash
# Call a specific tool directly
npx mcporter call linear.create_comment issueId:ENG-123 body:'Looks good!'

# List available servers and tools
npx mcporter list
```

MCPorter complementa el enfoque de ejecución de código descrito anteriormente al proporcionar la infraestructura de runtime para llamar a herramientas MCP como APIs tipadas, haciendo sencillo mantener datos intermedios fuera del contexto del modelo.

## Best Practices

### Security Considerations

#### Do's ✅
- Usa variables de entorno para todas las credenciales
- Rota tokens y claves API regularmente (mensual recomendado)
- Usa tokens de solo lectura cuando sea posible
- Limita el alcance de acceso del servidor MCP al mínimo requerido
- Monitorea el uso del servidor MCP y los registros de acceso
- Usa OAuth para servicios externos cuando esté disponible
- Implementa limitación de tasa en solicitudes MCP
- Prueba las conexiones MCP antes del uso en producción
- Documenta todas las conexiones MCP activas
- Mantén los paquetes de servidores MCP actualizados

#### Don'ts ❌
- No codifiques credenciales directamente en archivos de configuración
- No hagas commit de tokens o secretos a git
- No compartas tokens en chats de equipo o correos electrónicos
- No uses tokens personales para proyectos de equipo
- No otorgues permisos innecesarios
- No ignores errores de autenticación
- No expongas endpoints MCP públicamente
- No ejecutes servidores MCP con privilegios de root/admin
- No almacenes en caché datos sensibles en registros
- No deshabilites mecanismos de autenticación

### Configuration Best Practices

1. **Version Control**: Mantén `.mcp.json` en git pero usa variables de entorno para secretos
2. **Least Privilege**: Otorga los permisos mínimos necesarios para cada servidor MCP
3. **Isolation**: Ejecuta diferentes servidores MCP en procesos separados cuando sea posible
4. **Monitoring**: Registra todas las solicitudes y errores de MCP para auditorías
5. **Testing**: Prueba todas las configuraciones MCP antes de desplegar a producción

### Performance Tips

- Almacena en caché datos accedidos frecuentemente a nivel de aplicación
- Usa consultas MCP específicas para reducir la transferencia de datos
- Monitorea los tiempos de respuesta de las operaciones MCP
- Considera la limitación de tasa para APIs externas
- Usa agrupación (batching) al realizar múltiples operaciones

## Installation Instructions

### Prerequisites
- Node.js y npm instalados
- Claude Code CLI instalado
- Tokens/credenciales de API para servicios externos

### Step-by-Step Setup

1. **Agrega tu primer servidor MCP** usando la CLI (ejemplo: GitHub):
```bash
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

   O crea un archivo `.mcp.json` en la raíz de tu proyecto:
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

2. **Establece las variables de entorno:**
```bash
export GITHUB_TOKEN="your_github_personal_access_token"
```

3. **Prueba la conexión:**
```bash
claude /mcp
```

4. **Usa las herramientas MCP:**
```bash
/mcp__github__list_prs
/mcp__github__create_issue "Title" "Description"
```

### Installation for Specific Services

**GitHub MCP:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**Database MCP:**
```bash
npm install -g @modelcontextprotocol/server-database
```

**Filesystem MCP:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Slack MCP:**
```bash
npm install -g @modelcontextprotocol/server-slack
```

## Troubleshooting

### MCP Server Not Found
```bash
# Verify MCP server is installed
npm list -g @modelcontextprotocol/server-github

# Install if missing
npm install -g @modelcontextprotocol/server-github
```

### Authentication Failed
```bash
# Verify environment variable is set
echo $GITHUB_TOKEN

# Re-export if needed
export GITHUB_TOKEN="your_token"

# Verify token has correct permissions
# Check GitHub token scopes at: https://github.com/settings/tokens
```

### Connection Timeout
- Verifica la conectividad de red: `ping api.github.com`
- Verifica que el endpoint de la API sea accesible
- Verifica los límites de tasa en la API
- Intenta aumentar el tiempo de espera en la configuración
- Verifica problemas de firewall o proxy

### MCP Server Crashes
- Verifica los registros del servidor MCP: `~/.claude/logs/`
- Verifica que todas las variables de entorno estén establecidas
- Asegura los permisos de archivo apropiados
- Intenta reinstalar el paquete del servidor MCP
- Verifica procesos conflictivos en el mismo puerto

## Related Concepts

### Memory vs MCP
- **Memory**: Almacena datos persistentes e inmutables (preferencias, contexto, historial)
- **MCP**: Accede a datos cambiantes y en vivo (APIs, bases de datos, servicios en tiempo real)

### When to Use Each
- **Usa Memory** para: Preferencias de usuario, historial de conversación, contexto aprendido
- **Usa MCP** para: Issues actuales de GitHub, consultas de base de datos en vivo, datos en tiempo real

### Integration with Other Claude Features
- Combina MCP con Memory para un contexto enriquecido
- Usa herramientas MCP en prompts para mejor razonamiento
- Aprovecha múltiples MCPs para flujos de trabajo complejos

## Additional Resources

- [Official MCP Documentation](https://code.claude.com/docs/en/mcp)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [MCP GitHub Repository](https://github.com/modelcontextprotocol/servers)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCPorter](https://github.com/steipete/mcporter) — Runtime de TypeScript y CLI para llamar a servidores MCP sin boilerplate
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) — Blog de ingeniería de Anthropic sobre cómo resolver la hinchazón del contexto
- [Claude Code CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Claude API Documentation](https://docs.anthropic.com)
