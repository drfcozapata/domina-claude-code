---
name: blog-draft
description: Redactar un borrador de blog post desde ideas y recursos. Usa cuando los usuarios quieran escribir un blog post, crear contenido desde investigación, o redactar artículos. Guía a través de investigación, lluvia de ideas, creación de esquemas y redacción iterativa con control de versiones.
---

## Input del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar el input del usuario antes de proceder. El usuario debería proporcionar:
- **Idea/Tema**: El concepto o tema principal del blog post
- **Recursos**: URLs, archivos, o referencias a investigación (opcional pero recomendado)
- **Audiencia objetivo**: Para quién es el blog post (opcional)
- **Tono/Estilo**: Formal, casual, técnico, etc. (opcional)

**IMPORTANTE**: Si el usuario está solicitando actualizaciones a un **blog post existente**, salta los pasos 0-8 y comienza directamente en el **Paso 9**. Lee el(los) archivo(s) de borrador existente(s) primero, luego procede con el proceso de iteración.

## Flujo de Ejecución

Sigue estos pasos secuencialmente. **No saltes pasos ni procedas sin aprobación del usuario donde se indique.**

### Paso 0: Crear Carpeta de Proyecto

1. Genera un nombre de carpeta usando el formato: `YYYY-MM-DD-nombre-corto-tema`
   - Usa la fecha de hoy
   - Crea un slug URL-friendly corto del tema (minúsculas, guiones, máx 5 palabras)

2. Crea la estructura de carpetas:
   ```
   blog-posts/
   └── YYYY-MM-DD-nombre-corto-tema/
       └── resources/
   ```

3. Confirma la creación de la carpeta con el usuario antes de proceder.

### Paso 1: Investigación y Recolección de Recursos

1. Crea subcarpeta `resources/` en el directorio del blog post

2. Para cada recurso proporcionado:
   - **URLs**: Obten y guarda información clave en `resources/` como archivos markdown
   - **Archivos**: Lee y resume en `resources/`
   - **Temas**: Usa búsqueda web para recopilar información actualizada

3. Para cada recurso, crea un archivo de resumen en `resources/`:
   - `resources/source-1-[nombre-corto].md`
   - `resources/source-2-[nombre-corto].md`
   - etc.

4. Cada resumen debería incluir:
   ```markdown
   # Fuente: [Título/URL]

   ## Puntos Clave
   - Punto 1
   - Punto 2

   ## Citas/Datos Relevantes
   - Cita o estadística 1
   - Cita o estadística 2

   ## Cómo Esto Se Relaciona con el Tema
   Explicación breve de relevancia
   ```

5. Presenta el resumen de investigación al usuario.

### Paso 2: Lluvia de Ideas y Clarificación

1. Basado en la idea y recursos investigados, presenta:
   - **Temas principales** identificados de la investigación
   - **Ángulos potenciales** para el blog post
   - **Puntos clave** que deberían cubrirse
   - **Brechas** en información que necesitan clarificación

2. Haz preguntas de clarificación:
   - ¿Cuál es el mensaje principal que quieres que los lectores tengan?
   - ¿Hay puntos específicos de la investigación que quieras enfatizar?
   - ¿Cuál es la longitud objetivo? (corto: 500-800 palabras, medio: 1000-1500, largo: 2000+)
   - ¿Algunos puntos que quieras excluir?

3. **Espera las respuestas del usuario antes de proceder.**

### Paso 3: Proponer Esquema

1. Crea un esquema estructurado incluyendo:

   ```markdown
   # Esquema de Blog Post: [Título]

   ## Información Meta
   - **Audiencia Objetivo**: [quién]
   - **Tono**: [estilo]
   - **Longitud Objetivo**: [cantidad de palabras]
   - **Mensaje Principal**: [mensaje clave]

   ## Estructura Propuesta

   ### Hook/Introducción
   - Idea de apertura gancho
   - Establecimiento de contexto
   - Declaración de tesis

   ### Sección 1: [Título]
   - Punto clave A
   - Punto clave B
   - Evidencia de apoyo de [fuente]

   ### Sección 2: [Título]
   - Punto clave A
   - Punto clave B

   [Continúa para todas las secciones...]

   ### Conclusión
   - Resumen de puntos clave
   - Call to action o pensamiento final

   ## Fuentes a Citar
   - Fuente 1
   - Fuente 2
   ```

2. Presenta el esquema al usuario y **pide aprobación o modificaciones**.

### Paso 4: Guardar Esquema Aprobado

1. Una vez que el usuario apruebe el esquema, guárdalo en `OUTLINE.md` en la carpeta del blog post.

2. Confirma que el esquema ha sido guardado.

### Paso 5: Commit del Esquema (si está en repo git)

1. Verifica si el directorio actual es un repositorio git.

2. Si sí:
   - Staging de los nuevos archivos: carpeta del blog post, resources, y OUTLINE.md
   - Crea commit con mensaje: `docs: Add outline for blog post - [nombre-tema]`
   - Push al remoto

3. Si no es un repo git, salta este paso e informa al usuario.

### Paso 6: Escribir Borrador

1. Basado en el esquema aprobado, escribe el borrador completo del blog post.

2. Sigue la estructura de OUTLINE.md exactamente.

3. Incluye:
   - Introducción atractiva con hook
   - Encabezados de sección claros
   - Evidencia de apoyo y ejemplos de la investigación
   - Transiciones suaves entre secciones
   - Conclusión fuerte con mensaje clave
   - **Citas**: Todas las comparaciones, estadísticas, datos, y afirmaciones factuales DEBEN citar la fuente original

4. Guarda el borrador como `draft-v0.1.md` en la carpeta del blog post.

5. Formato:
   ```markdown
   # [Título del Blog Post]

   *[Subtítulo o tagline opcional]*

   [Contenido completo con citas inline...]

   ---

   ## Referencias
   - [1] Título de Fuente 1 - URL o Citación
   - [2] Título de Fuente 2 - URL o Citación
   - [3] Título de Fuente 3 - URL o Citación
   ```

6. **Requisitos de Citación**:
   - Cada dato, estadística, o comparación DEBE tener una citación inline
   - Usa referencias numeradas [1], [2], etc., o citas nombradas [Nombre de Fuente]
   - Vincula las citas a la sección de Referencias al final
   - Ejemplo: "Estudios muestran que el 65% de desarrolladores prefieren TypeScript [1]"
   - Ejemplo: "React supera a Vue en velocidad de renderizado por 20% [React Benchmarks 2024]"

### Paso 7: Commit del Borrador (si está en repo git)

1. Verifica si está en repositorio git.

2. Si sí:
   - Staging del archivo de borrador
   - Crea commit con mensaje: `docs: Add draft v0.1 for blog post - [nombre-tema]`
   - Push al remoto

3. Si no es un repo git, salta e informa al usuario.

### Paso 8: Presentar Borrador para Revisión

1. Presenta el contenido del borrador al usuario.

2. Pide feedback:
   - ¿Impresión general?
   - ¿Secciones que necesitan expansión o reducción?
   - ¿Ajustes de tono necesarios?
   - ¿Información faltante?
   - ¿Ediciones o reescrituras específicas?

3. **Espera la respuesta del usuario.**

### Paso 9: Iterar o Finalizar

**Si el usuario solicita cambios:**
1. Nota todas las modificaciones solicitadas
2. Regresa al Paso 6 con los siguientes ajustes:
   - Incrementa el número de versión (v0.2, v0.3, etc.)
   - Incorpora todo el feedback
   - Guarda como `draft-v[X.Y].md`
   - Repite los Pasos 7-8

**Si el usuario aprueba:**
1. Confirma la versión final del borrador
2. Opcionalmente renombra a `final.md` si el usuario lo solicita
3. Resume el proceso de creación del blog post:
   - Total de versiones creadas
   - Cambios clave entre versiones
   - Cantidad de palabras final
   - Archivos creados

## Rastreo de Versiones

Todos los borradores se preservan con versionado incremental:
- `draft-v0.1.md` - Borrador inicial
- `draft-v0.2.md` - Después de primera ronda de feedback
- `draft-v0.3.md` - Después de segunda ronda de feedback
- etc.

Esto permite rastrear la evolución del blog post y revertir si es necesario.

## Estructura de Archivos de Salida

```
blog-posts/
└── YYYY-MM-DD-nombre-tema/
    ├── resources/
    │   ├── source-1-nombre.md
    │   ├── source-2-nombre.md
    │   └── ...
    ├── OUTLINE.md
    ├── draft-v0.1.md
    ├── draft-v0.2.md (si hay iteraciones)
    └── draft-v0.3.md (si hay más iteraciones)
```

## Consejos para Calidad

- **Hook**: Comienza con una pregunta, dato sorprendente, o escenario relatable
- **Flujo**: Cada párrafo debería conectar con el siguiente
- **Evidencia**: Apoya afirmaciones con datos de la investigación
- **Citas**: SIEMPRE cita fuentes para:
  - Todas las estadísticas y datos (ej. "Según [Fuente], el 75% de...")
  - Comparaciones entre productos, servicios, o enfoques (ej. "X tiene 2x mejor rendimiento que Y [Fuente]")
  - Afirmaciones factuales sobre tendencias de mercado, hallazgos de investigación, o benchmarks
  - Usa citas inline con formato: [Nombre de Fuente] o [Autor, Año]
- **Voz**: Mantén tono consistente a través de todo
- **Longitud**: Respeta la cantidad de palabras objetivo
- **Legibilidad**: Usa párrafos cortos, listas de puntos donde sea apropiado
- **CTA**: Termina con un call-to-action claro o pregunta provocativa

## Notas

- Siempre espera aprobación del usuario en los puntos de control indicados
- Preserva todas las versiones de borrador para historial
- Usa búsqueda web para información actualizada cuando se proporcionen URLs
- Si los recursos son insuficientes, pide al usuario más o sugiere investigación adicional
- Adapta el tono basado en la audiencia objetivo (técnico, general, negocio, etc.)
