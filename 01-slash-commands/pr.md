---
description: Limpiar código, preparar cambios en stage y preparar un pull request
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(npm test:*), Bash(npm run lint:*)
---

# Lista de Verificación de Preparación de Pull Request

Antes de crear un PR, ejecuta estos pasos:

1. Ejecuta linting: `prettier --write .`
2. Ejecuta tests: `npm test`
3. Revisa git diff: `git diff HEAD`
4. Prepara cambios en stage: `git add .`
5. Crea mensaje de commit siguiendo conventional commits:
   - `fix:` para correcciones de bugs
   - `feat:` para nuevas características
   - `docs:` para documentación
   - `refactor:` para reestructuración de código
   - `test:` para adición de tests
   - `chore:` para mantenimiento

6. Genera resumen de PR incluyendo:
   - Qué cambió
   - Por qué cambió
   - Testing realizado
   - Impactos potenciales
