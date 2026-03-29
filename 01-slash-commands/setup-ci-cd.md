---
name: Configurar Pipeline CI/CD
description: Implementar hooks de pre-commit y GitHub Actions para aseguramiento de calidad
tags: ci-cd, devops, automation
---

# Configurar Pipeline CI/CD

Implementa puertas de calidad de DevOps comprehensivas adaptadas al tipo de proyecto:

1. **Analizar proyecto**: Detectar lenguaje(s), framework, sistema de build y herramientas existentes
2. **Configurar hooks de pre-commit** con herramientas específicas del lenguaje:
   - Formateo: Prettier/Black/gofmt/rustfmt/etc.
   - Linting: ESLint/Ruff/golangci-lint/Clippy/etc.
   - Seguridad: Bandit/gosec/cargo-audit/npm audit/etc.
   - Type checking: TypeScript/mypy/flow (si aplica)
   - Tests: Ejecutar suites de tests relevantes
3. **Crear workflows de GitHub Actions** (.github/workflows/):
   - Reflejar verificaciones de pre-commit en push/PR
   - Matriz multi-versión/plataforma (si aplica)
   - Verificación de build y tests
   - Pasos de despliegue (si se necesita)
4. **Verificar pipeline**: Probar localmente, crear PR de prueba, confirmar que todas las verificaciones pasan

Usa herramientas gratuitas/open-source. Respeta configuraciones existentes. Mantén la ejecución rápida.
