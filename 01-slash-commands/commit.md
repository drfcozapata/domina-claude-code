---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
argument-hint: [mensaje]
description: Crear un commit de git con contexto
---

## Contexto

- Estado actual de git: !`git status`
- Diff actual de git: !`git diff HEAD`
- Rama actual: !`git branch --show-current`
- Commits recientes: !`git log --oneline -10`

## Tu tarea

Basado en los cambios anteriores, crea un único commit de git.

Si se proporcionó un mensaje vía argumentos, úsalo: $ARGUMENTS

De lo contrario, analiza los cambios y crea un mensaje de commit apropiado siguiendo el formato de conventional commits:
- `feat:` para nuevas características
- `fix:` para correcciones de bugs
- `docs:` para cambios de documentación
- `refactor:` para refactorización de código
- `test:` para agregar tests
- `chore:` para tareas de mantenimiento
