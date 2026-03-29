<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Contribuir a Claude How To

¡Gracias por tu interés en contribuir a este proyecto! Esta guía te ayudará a entender cómo contribuir de manera efectiva.

## Acerca de Este Proyecto

Claude How To es una guía visual, basada en ejemplos, para Claude Code. Proporcionamos:
- **Diagramas Mermaid** que explican cómo funcionan las características
- **Plantillas listas para producción** que puedes usar inmediatamente
- **Ejemplos del mundo real** con contexto y mejores prácticas
- **Rutas de aprendizaje progresivas** desde principiante hasta avanzado

## Tipos de Contribuciones

### 1. Nuevos Ejemplos o Plantillas
Agrega ejemplos para características existentes (Slash Commands, Skills, Hooks, etc.):
- Código listo para copiar y pegar
- Explicaciones claras de cómo funciona
- Casos de uso y beneficios
- Consejos de solución de problemas

### 2. Mejoras de Documentación
- Clarificar secciones confusas
- Corregir errores tipográficos y gramática
- Agregar información faltante
- Mejorar ejemplos de código

### 3. Guías de Características
Crea guías para nuevas características de Claude Code:
- Tutoriales paso a paso
- Diagramas de arquitectura
- Patrones comunes y anti-patrones
- Flujos de trabajo del mundo real

### 4. Reportes de Errores
Reporta problemas que encuentres:
- Describe lo que esperabas
- Describe lo que realmente sucedió
- Incluye pasos para reproducir
- Agrega la versión relevante de Claude Code y sistema operativo

### 5. Comentarios y Sugerencias
Ayuda a mejorar la guía:
- Sugiere mejores explicaciones
- Señala vacíos en la cobertura
- Recomienda nuevas secciones o reorganización

## Primeros Pasos

### 1. Bifurcar y Clonar
```bash
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto
```

### 2. Crear una Rama
Usa un nombre descriptivo para la rama:
```bash
git checkout -b add/feature-name
git checkout -b fix/issue-description
git checkout -b docs/improvement-area
```

### 3. Configurar tu Entorno
```bash
# Crear entorno virtual
python3 -m venv .venv
source .venv/bin/activate

# Instalar hooks de pre-commit (opcional pero recomendado)
pip install pre-commit
pre-commit install

# Ejecutar verificaciones de pre-commit manualmente
pre-commit run --all-files
```

## Estructura de Directorios

```
├── 01-slash-commands/      # Atajos invocados por el usuario
├── 02-memory/              # Ejemplos de contexto persistente
├── 03-skills/              # Capacidades reutilizables
├── 04-subagents/           # Asistentes de IA especializados
├── 05-mcp/                 # Ejemplos de Model Context Protocol
├── 06-hooks/               # Automatización basada en eventos
├── 07-plugins/             # Características agrupadas
├── 08-checkpoints/         # Instantáneas de sesión
├── 09-advanced-features/   # Planning, thinking, backgrounds
├── 10-cli/                 # Referencia de CLI
├── scripts/                # Scripts de construcción y utilidades
└── README.md               # Guía principal
```

## Cómo Contribuir con Ejemplos

### Agregar un Slash Command
1. Crea un archivo `.md` en `01-slash-commands/`
2. Incluye:
   - Descripción clara de lo que hace
   - Casos de uso
   - Instrucciones de instalación
   - Ejemplos de uso
   - Consejos de personalización
3. Actualiza `01-slash-commands/README.md`

### Agregar un Skill
1. Crea un directorio en `03-skills/`
2. Incluye:
   - `SKILL.md` - Documentación principal
   - `scripts/` - Scripts auxiliares si es necesario
   - `templates/` - Plantillas de prompt
   - Ejemplo de uso en README
3. Actualiza `03-skills/README.md`

### Agregar un Subagent
1. Crea un archivo `.md` en `04-subagents/`
2. Incluye:
   - Propósito y capacidades del agente
   - Estructura del prompt del sistema
   - Casos de uso de ejemplo
   - Ejemplos de integración
3. Actualiza `04-subagents/README.md`

### Agregar Configuración MCP
1. Crea un archivo `.json` en `05-mcp/`
2. Incluye:
   - Explicación de la configuración
   - Variables de entorno requeridas
   - Instrucciones de configuración
   - Ejemplos de uso
3. Actualiza `05-mcp/README.md`

### Agregar un Hook
1. Crea un archivo `.sh` en `06-hooks/`
2. Incluye:
   - Shebang y descripción
   - Comentarios claros explicando la lógica
   - Manejo de errores
   - Consideraciones de seguridad
3. Actualiza `06-hooks/README.md`

## Directrices de Escritura

### Estilo Markdown
- Usa encabezados claros (H2 para secciones, H3 para subsecciones)
- Mantén los párrafos cortos y enfocados
- Usa viñetas para listas
- Incluye bloques de código con especificación de lenguaje
- Agrega líneas en blanco entre secciones

### Ejemplos de Código
- Haz que los ejemplos estén listos para copiar y pegar
- Comenta la lógica no obvia
- Incluye versiones simples y avanzadas
- Muestra casos de uso del mundo real
- Destaca problemas potenciales

### Documentación
- Explica el "por qué", no solo el "qué"
- Incluye prerrequisitos
- Agrega secciones de solución de problemas
- Enlaza a temas relacionados
- Manténlo amigable para principiantes

### JSON/YAML
- Usa indentación apropiada (2 o 4 espacios consistentemente)
- Agrega comentarios explicando la configuración
- Incluye ejemplos de validación

### Diagramas
- Usa Mermaid cuando sea posible
- Mantén los diagramas simples y legibles
- Incluye descripciones debajo de los diagramas
- Enlaza a secciones relevantes

## Directrices de Commits

Sigue el formato convencional de commits:
```
tipo(alcance): descripción

[cuerpo opcional]
```

Tipos:
- `feat`: Nueva característica o ejemplo
- `fix`: Corrección de errores
- `docs`: Cambios de documentación
- `refactor`: Reestructuración de código
- `style`: Cambios de formato
- `test`: Adiciones o cambios de pruebas
- `chore`: Construcción, dependencias, etc.

Ejemplos:
```
feat(slash-commands): Agregar generador de documentación de API
docs(memory): Mejorar ejemplo de preferencias personales
fix(README): Corregir enlace de tabla de contenidos
docs(skills): Agregar skill exhaustivo de revisión de código
```

## Antes de Enviar

### Lista de Verificación
- [ ] El código sigue el estilo y convenciones del proyecto
- [ ] Los nuevos ejemplos incluyen documentación clara
- [ ] Los archivos README están actualizados (local y raíz)
- [ ] No hay información sensible (claves de API, credenciales)
- [ ] Los ejemplos están probados y funcionando
- [ ] Los enlaces están verificados y son correctos
- [ ] Los archivos tienen los permisos apropiados (los scripts son ejecutables)
- [ ] El mensaje de commit es claro y descriptivo

### Pruebas Locales
```bash
# Verificar formato de archivos
pre-commit run --all-files

# Verificar que los enlaces funcionen (si aplica)
# Probar ejemplos manualmente con Claude Code

# Revisar tus cambios
git diff

# Probar la generación de EPUB (si cambiaste docs)
uv run scripts/build_epub.py
```

## Proceso de Pull Request

1. **Crear PR con descripción clara**:
   - ¿Qué agrega/corrige esto?
   - ¿Por qué es necesario?
   - Problemas relacionados (si los hay)

2. **Incluir detalles relevantes**:
   - ¿Nueva característica? Incluye casos de uso
   - ¿Documentación? Explica las mejoras
   - ¿Ejemplos? Muestra antes/después

3. **Enlazar a problemas**:
   - Usa `Closes #123` para cerrar automáticamente problemas relacionados

4. **Ser paciente con las revisiones**:
   - Los mantenedores pueden sugerir mejoras
   - Itera basado en los comentarios
   - La decisión final recae en los mantenedores

## Proceso de Revisión de Código

Los revisores verificarán:
- **Precisión**: ¿Funciona como se describe?
- **Calidad**: ¿Está listo para producción?
- **Consistencia**: ¿Sigue los patrones del proyecto?
- **Documentación**: ¿Es clara y completa?
- **Seguridad**: ¿Hay alguna vulnerabilidad?

## Reportar Problemas

### Reportes de Errores
Incluye:
- Versión de Claude Code
- Sistema operativo
- Pasos para reproducir
- Comportamiento esperado
- Comportamiento real
- Capturas de pantalla si aplica

### Solicitudes de Características
Incluye:
- Caso de uso o problema a resolver
- Solución propuesta
- Alternativas que has considerado
- Contexto adicional

### Problemas de Documentación
Incluye:
- Qué es confuso o faltante
- Mejoras sugeridas
- Ejemplos o referencias

## Políticas del Proyecto

### Información Sensible
- Nunca hagas commit de claves de API, tokens o credenciales
- Usa valores de marcador de posición en ejemplos
- Incluye `.env.example` para archivos de configuración
- Documenta las variables de entorno requeridas

### Calidad de Código
- Mantén los ejemplos enfocados y legibles
- Evita soluciones de ingeniería excesiva
- Incluye comentarios para lógica no obvia
- Prueba exhaustivamente antes de enviar

### Propiedad Intelectual
- Contenido original propiedad del autor
- El proyecto usa licencia educativa
- Respeta los derechos de autor existentes
- Proporciona atribución donde sea necesario

## Obtener Ayuda

- **Preguntas**: Abre una discusión en GitHub Issues
- **Ayuda General**: Revisa la documentación existente
- **Ayuda de Desarrollo**: Revisa ejemplos similares
- **Revisión de Código**: Etiqueta a los mantenedores en los PRs

## Reconocimiento

Los contribuyentes son reconocidos en:
- Sección de Contribuyentes del README.md
- Página de contribuyentes de GitHub
- Historial de commits

## Seguridad

Al contribuir con ejemplos y documentación, sigue prácticas de codificación segura:

- **Nunca codifiques secretos o claves de API** - Usa variables de entorno
- **Advierte sobre implicaciones de seguridad** - Destaca riesgos potenciales
- **Usa valores predeterminados seguros** - Habilita características de seguridad por defecto
- **Valida entradas** - Muestra validación y saneamiento apropiados de entradas
- **Incluye notas de seguridad** - Documenta consideraciones de seguridad

Para problemas de seguridad, consulta [SECURITY.md](SECURITY.md) para nuestro proceso de reporte de vulnerabilidades.

## Código de Conducta

Estamos comprometidos a proporcionar una comunidad acogedora e inclusiva. Por favor, lee [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) para nuestros estándares completos de la comunidad.

En resumen:
- Sé respetuoso e inclusivo
- Acepta los comentarios con gracia
- Ayuda a otros a aprender y crecer
- Evita el acoso o la discriminación
- Reporta problemas a los mantenedores

Se espera que todos los contribuyentes mantengan este código y se traten unos a otros con amabilidad y respeto.

## Licencia

Al contribuir a este proyecto, aceptas que tus contribuciones estarán licenciadas bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

## ¿Preguntas?

- Consulta el [README](README.md)
- Revisa [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md)
- Mira los ejemplos existentes
- Abre un problema para discusión

¡Gracias por contribuir! 🙏
