<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# Plugin de Documentación

Generación y mantenimiento comprehensivo de documentación para tu proyecto.

## Características

✅ Generación de documentación de API
✅ Creación y actualización de README
✅ Sincronización de documentación
✅ Mejoras de comentarios de código
✅ Generación de ejemplos

## Instalación

```bash
/plugin install documentation
```

## Qué está Incluido

### Comandos Slash
- `/generate-api-docs` - Generar documentación de API
- `/generate-readme` - Crear o actualizar README
- `/sync-docs` - Sincronizar docs con cambios de código
- `/validate-docs` - Validar documentación

### Subagentes
- `api-documenter` - Especialista en documentación de API
- `code-commentator` - Mejoras de comentarios de código
- `example-generator` - Creación de ejemplos de código

### Templates
- `api-endpoint.md` - Template de documentación de endpoint de API
- `function-docs.md` - Template de documentación de función
- `adr-template.md` - Template de Registro de Decisión de Arquitectura

### Servidores MCP
- Integración con GitHub para sincronización de documentación

## Uso

### Generar Documentación de API
```
/generate-api-docs
```

### Crear README
```
/generate-readme
```

### Sincronizar Documentación
```
/sync-docs
```

### Validar Documentación
```
/validate-docs
```

## Requisitos

- Claude Code 1.0+
- Acceso a GitHub (opcional)

## Ejemplo de Flujo de Trabajo

```
Usuario: /generate-api-docs

Claude:
1. Escanea todos los endpoints de API en /src/api/
2. Delega al subagente api-documenter
3. Extrae firmas de funciones y JSDoc
4. Organiza por módulo/endpoint
5. Usa el template api-endpoint.md
6. Genera docs markdown comprehensivas
7. Incluye ejemplos en curl, JavaScript y Python

Resultado:
✅ Documentación de API generada
📄 Archivos creados:
   - docs/api/users.md
   - docs/api/auth.md
   - docs/api/products.md
📊 Cobertura: 23/23 endpoints documentados
```

## Uso de Templates

### Template de Endpoint de API
Usar para documentar endpoints REST API con ejemplos completos.

### Template de Documentación de Función
Usar para documentar funciones/métodos individuales.

### Template ADR
Usar para documentar decisiones arquitectónicas.

## Configuración

Configura el token de GitHub para sincronización de documentación:
```bash
export GITHUB_TOKEN="your_github_token"
```

## Mejores Prácticas

- Mantener la documentación cerca del código
- Actualizar docs con cambios de código
- Incluir ejemplos prácticos
- Validar regularmente
- Usar templates para consistencia
