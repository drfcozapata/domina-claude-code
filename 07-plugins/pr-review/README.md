<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# Plugin de Revisión de PR

Flujo de trabajo completo de revisión de PR con verificaciones de seguridad, pruebas y documentación.

## Características

✅ Análisis de seguridad
✅ Verificación de cobertura de pruebas
✅ Verificación de documentación
✅ Evaluación de calidad de código
✅ Análisis de impacto en el rendimiento

## Instalación

```bash
/plugin install pr-review
```

## Qué está Incluido

### Comandos Slash
- `/review-pr` - Revisión completa de PR
- `/check-security` - Revisión enfocada en seguridad
- `/check-tests` - Análisis de cobertura de pruebas

### Subagentes
- `security-reviewer` - Detección de vulnerabilidades de seguridad
- `test-checker` - Análisis de cobertura de pruebas
- `performance-analyzer` - Evaluación de impacto en el rendimiento

### Servidores MCP
- Integración con GitHub para datos de PR

### Hooks
- `pre-review.js` - Validación pre-revisión

## Uso

### Revisión Básica de PR
```
/review-pr
```

### Solo Verificación de Seguridad
```
/check-security
```

### Verificación de Cobertura de Pruebas
```
/check-tests
```

## Requisitos

- Claude Code 1.0+
- Acceso a GitHub
- Repositorio Git

## Configuración

Configura tu token de GitHub:
```bash
export GITHUB_TOKEN="your_github_token"
```

## Ejemplo de Flujo de Trabajo

```
Usuario: /review-pr

Claude:
1. Ejecuta hook pre-revisión (valida repositorio git)
2. Obtiene datos de PR vía MCP de GitHub
3. Delega revisión de seguridad al subagente security-reviewer
4. Delega pruebas al subagente test-checker
5. Delega rendimiento al subagente performance-analyzer
6. Sintetiza todos los hallazgos
7. Proporciona informe de revisión completo

Resultado:
✅ Seguridad: No se encontraron issues críticos
⚠️  Pruebas: La cobertura es 65%, se recomienda 80%+
✅ Rendimiento: Sin impacto significativo
📝 Recomendaciones: Agregar pruebas para casos edge
```
