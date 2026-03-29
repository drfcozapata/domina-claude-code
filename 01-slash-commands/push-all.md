---
description: Preparar todos los cambios en stage, crear commit y hacer push al remoto (usar con precaución)
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git diff:*), Bash(git log:*), Bash(git pull:*)
---

# Commit y Push de Todo

⚠️ **PRECAUCIÓN**: Prepara TODOS los cambios en stage, haz commit y push al remoto. Usa solo cuando estés seguro de que todos los cambios pertenecen juntos.

## Flujo de Trabajo

### 1. Analizar Cambios
Ejecuta en paralelo:
- `git status` - Mostrar archivos modificados/agregados/eliminados/no rastreados
- `git diff --stat` - Mostrar estadísticas de cambios
- `git log -1 --oneline` - Mostrar commit reciente para estilo de mensaje

### 2. Verificaciones de Seguridad

**❌ DETENERSE y ADVERTIR si se detecta:**
- Secretos: `.env*`, `*.key`, `*.pem`, `credentials.json`, `secrets.yaml`, `id_rsa`, `*.p12`, `*.pfx`, `*.cer`
- Claves de API: Cualquier variable `*_API_KEY`, `*_SECRET`, `*_TOKEN` con valores reales (no marcadores de posición como `your-api-key`, `xxx`, `placeholder`)
- Archivos grandes: `>10MB` sin Git LFS
- Artefactos de build: `node_modules/`, `dist/`, `build/`, `__pycache__/`, `*.pyc`, `.venv/`
- Archivos temporales: `.DS_Store`, `thumbs.db`, `*.swp`, `*.tmp`

**Validación de Claves de API:**
Verifica archivos modificados en busca de patrones como:
```bash
OPENAI_API_KEY=sk-proj-xxxxx  # ❌ Clave real detectada!
AWS_SECRET_KEY=AKIA...         # ❌ Clave real detectada!
STRIPE_API_KEY=sk_live_...    # ❌ Clave real detectada!

# ✅ Marcadores de posición aceptables:
API_KEY=your-api-key-here
SECRET_KEY=placeholder
TOKEN=xxx
API_KEY=<your-key>
SECRET=${YOUR_SECRET}
```

**✅ Verificar:**
- `.gitignore` configurado apropiadamente
- Sin conflictos de merge
- Rama correcta (advertir si es main/master)
- Claves de API son solo marcadores de posición

### 3. Solicitar Confirmación

Presentar resumen:
```
📊 Resumen de Cambios:
- X archivos modificados, Y agregados, Z eliminados
- Total: +AAA inserciones, -BBB eliminaciones

🔒 Seguridad: ✅ Sin secretos | ✅ Sin archivos grandes | ⚠️ [advertencias]
🌿 Rama: [nombre] → origin/[nombre]

Haré: git add . → commit → push

Escribe 'yes' para proceder o 'no' para cancelar.
```

**ESPERA confirmación explícita de "yes" antes de proceder.**

### 4. Ejecutar (Después de Confirmación)

Ejecuta secuencialmente:
```bash
git add .
git status  # Verificar staging
```

### 5. Generar Mensaje de Commit

Analiza cambios y crea commit convencional:

**Formato:**
```
[tipo]: Breve resumen (máx 72 caracteres)

- Cambio clave 1
- Cambio clave 2
- Cambio clave 3
```

**Tipos:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`

**Ejemplo:**
```
docs: Actualizar archivos README de conceptos con documentación comprehensiva

- Agregar diagramas de arquitectura y tablas
- Incluir ejemplos prácticos
- Expandir secciones de mejores prácticas
```

### 6. Commit y Push

```bash
git commit -m "$(cat <<'EOF'
[Mensaje de commit generado]
EOF
)"
git push  # Si falla: git pull --rebase && git push
git log -1 --oneline --decorate  # Verificar
```

### 7. Confirmar Éxito

```
✅ ¡Push al remoto exitoso!

Commit: [hash] [mensaje]
Rama: [rama] → origin/[rama]
Archivos cambiados: X (+inserciones, -eliminaciones)
```

## Manejo de Errores

- **git add falla**: Verifica permisos, archivos bloqueados, verifica que el repo esté inicializado
- **git commit falla**: Corrige hooks de pre-commit, verifica configuración de git (user.name/email)
- **git push falla**:
  - Non-fast-forward: `git pull --rebase && git push`
  - Sin rama remota: `git push -u origin [rama]`
  - Rama protegida: Usa flujo de PR en su lugar

## Cuándo Usar

✅ **Bueno:**
- Actualizaciones de documentación multi-archivo
- Característica con tests y docs
- Correcciones de bugs a través de archivos
- Refactorización/formateo a nivel de proyecto
- Cambios de configuración

❌ **Evitar:**
- Incierto de qué se está confirmando
- Contiene secretos/datos sensibles
- Ramas protegidas sin revisión
- Conflictos de merge presentes
- Se desea historial de commits granular
- Hooks de pre-commit fallando

## Alternativas

Si el usuario quiere control, sugiere:
1. **Staging selectivo**: Revisar/preparar en stage archivos específicos
2. **Staging interactivo**: `git add -p` para selección de patches
3. **Flujo de PR**: Crear rama → push → PR (usar comando `/pr`)

**⚠️ Recuerda**: Siempre revisa los cambios antes de hacer push. En caso de duda, usa comandos git individuales para más control.
