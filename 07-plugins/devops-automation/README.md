<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/domina-claude-code-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/domina-claude-code-logo.svg">
</picture>

# Plugin de Automatización DevOps

Automatización DevOps completa para despliegue, monitoreo y respuesta a incidentes.

## Características

✅ Despliegues automatizados
✅ Procedimientos de rollback
✅ Monitoreo de salud del sistema
✅ Flujos de trabajo de respuesta a incidentes
✅ Integración con Kubernetes

## Instalación

```bash
/plugin install devops-automation
```

## Qué está Incluido

### Comandos Slash
- `/deploy` - Desplegar a producción o staging
- `/rollback` - Rollback a versión anterior
- `/status` - Verificar salud del sistema
- `/incident` - Manejar incidentes de producción

### Subagentes
- `deployment-specialist` - Operaciones de despliegue
- `incident-commander` - Coordinación de incidentes
- `alert-analyzer` - Análisis de salud del sistema

### Servidores MCP
- Integración con Kubernetes

### Scripts
- `deploy.sh` - Automatización de despliegue
- `rollback.sh` - Automatización de rollback
- `health-check.sh` - Utilidades de verificación de salud

### Hooks
- `pre-deploy.js` - Validación pre-despliegue
- `post-deploy.js` - Tareas post-despliegue

## Uso

### Desplegar a Staging
```
/deploy staging
```

### Desplegar a Producción
```
/deploy production
```

### Rollback
```
/rollback production
```

### Verificar Estado
```
/status
```

### Manejar Incidente
```
/incident
```

## Requisitos

- Claude Code 1.0+
- Kubernetes CLI (kubectl)
- Acceso a cluster configurado

## Configuración

Configura tu Kubernetes config:
```bash
export KUBECONFIG=~/.kube/config
```

## Ejemplo de Flujo de Trabajo

```
Usuario: /deploy production

Claude:
1. Ejecuta hook pre-deploy (valida kubectl, conexión al cluster)
2. Delega al subagente deployment-specialist
3. Ejecuta script deploy.sh
4. Monitorea progreso del despliegue vía Kubernetes MCP
5. Ejecuta hook post-deploy (espera pods, smoke tests)
6. Proporciona resumen del despliegue

Resultado:
✅ Despliegue completado
📦 Versión: v2.1.0
🚀 Pods: 3/3 listos
⏱️  Tiempo: 2m 34s
```
