<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/domina-claude-code-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/domina-claude-code-logo.svg">
</picture>

# Checkpoints y Rewind

Los Checkpoints permiten guardar el estado de la conversación y retroceder a puntos anteriores en tu sesión de Claude Code. Esto es invaluable para explorar diferentes enfoques, recuperarse de errores o comparar soluciones alternativas.

## Descripción General

Los Checkpoints permiten guardar el estado de la conversación y retroceder a puntos anteriores, permitiendo una experimentación segura y la exploración de múltiples enfoques. Son instantáneas del estado de tu conversación, incluyendo:
- Todos los mensajes intercambiados
- Modificaciones de archivos realizadas
- Historial de uso de herramientas
- Contexto de la sesión

Los Checkpoints son invaluables al explorar diferentes enfoques, recuperarse de errores o comparar soluciones alternativas.

## Conceptos Clave

| Concepto | Descripción |
|---------|-------------|
| **Checkpoint** | Instantánea del estado de la conversación incluyendo mensajes, archivos y contexto |
| **Rewind** | Volver a un checkpoint anterior, descartando cambios posteriores |
| **Branch Point** | Checkpoint desde el cual se exploran múltiples enfoques |

## Accediendo a Checkpoints

Puedes acceder y gestionar checkpoints de dos formas principales:

### Usando Atajo de Teclado
Presiona `Esc` dos veces (`Esc` + `Esc`) para abrir la interfaz de checkpoints y navegar por los checkpoints guardados.

### Usando Slash Command
Usa el comando `/rewind` (alias: `/checkpoint`) para acceso rápido:

```bash
# Abrir interfaz de rewind
/rewind

# O usar el alias
/checkpoint
```

## Opciones de Rewind

Cuando retrocedes, se te presenta un menú de cinco opciones:

1. **Restore code and conversation** -- Revertir tanto archivos como mensajes a ese checkpoint
2. **Restore conversation** -- Retroceder solo mensajes, mantener tu código actual tal como está
3. **Restore code** -- Revertir solo cambios de archivos, mantener el historial completo de la conversación
4. **Summarize from here** -- Comprimir la conversación desde ese punto en adelante en un resumen generado por IA en lugar de descartarlo. Los mensajes originales se conservan en la transcripción. Opcionalmente puedes proporcionar instrucciones para enfocar el resumen en temas específicos.
5. **Never mind** -- Cancelar y volver al estado actual

## Checkpoints Automáticos

Claude Code crea checkpoints automáticamente para ti:

- **Cada prompt del usuario** - Se crea un nuevo checkpoint con cada entrada del usuario
- **Persistentes** - Los checkpoints persisten entre sesiones
- **Auto-limpiados** - Los checkpoints se limpian automáticamente después de 30 días

Esto significa que siempre puedes retroceder a cualquier punto anterior en tu conversación, desde hace unos minutos hasta días antes.

## Casos de Uso

| Escenario | Flujo de Trabajo |
|----------|----------|
| **Explorar Enfoques** | Guardar → Probar A → Guardar → Rewind → Probar B → Comparar |
| **Refactorización Segura** | Guardar → Refactorizar → Probar → Si falla: Rewind |
| **Pruebas A/B** | Guardar → Diseño A → Guardar → Rewind → Diseño B → Comparar |
| **Recuperación de Errores** | Notar problema → Rewind al último estado bueno |

## Usando Checkpoints

### Viendo y Retrocediendo

Presiona `Esc` dos veces o usa `/rewind` para abrir el navegador de checkpoints. Verás una lista de todos los checkpoints disponibles con marcas de tiempo. Selecciona cualquier checkpoint para retroceder a ese estado.

### Detalles del Checkpoint

Cada checkpoint muestra:
- Marca de tiempo de cuándo fue creado
- Archivos que fueron modificados
- Número de mensajes en la conversación
- Herramientas que fueron usadas

## Ejemplos Prácticos

### Ejemplo 1: Explorando Diferentes Enfoques

```
User: Let's add a caching layer to the API

Claude: I'll add Redis caching to your API endpoints...
[Makes changes at checkpoint A]

User: Actually, let's try in-memory caching instead

Claude: I'll rewind to explore a different approach...
[User presses Esc+Esc and rewinds to checkpoint A]
[Implements in-memory caching at checkpoint B]

User: Now I can compare both approaches
```

### Ejemplo 2: Recuperándose de Errores

```
User: Refactor the authentication module to use JWT

Claude: I'll refactor the authentication module...
[Makes extensive changes]

User: Wait, that broke the OAuth integration. Let's go back.

Claude: I'll help you rewind to before the refactoring...
[User presses Esc+Esc and selects the checkpoint before the refactor]

User: Let's try a more conservative approach this time
```

### Ejemplo 3: Experimentación Segura

```
User: Let's try rewriting this in a functional style
[Creates checkpoint before experiment]

Claude: [Makes experimental changes]

User: The tests are failing. Let's rewind.
[User presses Esc+Esc and rewinds to the checkpoint]

Claude: I've rewound the changes. Let's try a different approach.
```

### Ejemplo 4: Enfoques de Ramificación

```
User: I want to compare two database designs
[Takes note of checkpoint - call it "Start"]

Claude: I'll create the first design...
[Implements Schema A]

User: Now let me go back and try the second approach
[User presses Esc+Esc and rewinds to "Start"]

Claude: Now I'll implement Schema B...
[Implements Schema B]

User: Great! Now I have both schemas to choose from
```

## Retención de Checkpoints

Claude Code gestiona automáticamente tus checkpoints:

- Los checkpoints se crean automáticamente con cada prompt del usuario
- Los checkpoints antiguos se conservan hasta por 30 días
- Los checkpoints se limpian automáticamente para prevenir crecimiento ilimitado de almacenamiento

## Patrones de Flujo de Trabajo

### Estrategia de Ramificación para Exploración

Al explorar múltiples enfoques:

```
1. Comenzar con implementación inicial → Checkpoint A
2. Probar Enfoque 1 → Checkpoint B
3. Rewind al Checkpoint A
4. Probar Enfoque 2 → Checkpoint C
5. Comparar resultados de B y C
6. Elegir el mejor enfoque y continuar
```

### Patrón de Refactorización Segura

Al hacer cambios significativos:

```
1. Estado actual → Checkpoint (auto)
2. Comenzar refactorización
3. Ejecutar pruebas
4. Si las pruebas pasan → Continuar trabajando
5. Si las pruebas fallan → Rewind e intentar diferente enfoque
```

## Mejores Prácticas

Dado que los checkpoints se crean automáticamente, puedes enfocarte en tu trabajo sin preocuparte por guardar el estado manualmente. Sin embargo, ten en cuenta estas prácticas:

### Usando Checkpoints Efectivamente

✅ **Haz:**
- Revisar checkpoints disponibles antes de retroceder
- Usar rewind cuando quieras explorar diferentes direcciones
- Mantener checkpoints para comparar diferentes enfoques
- Entender qué hace cada opción de rewind (restore code and conversation, restore conversation, restore code, o summarize)

❌ **No hagas:**
- Confiar solo en checkpoints para preservación de código
- Esperar que los checkpoints rastreen cambios externos en el sistema de archivos
- Usar checkpoints como sustituto de commits de git

## Configuración

Puedes activar/desactivar checkpoints automáticos en tu configuración:

```json
{
  "autoCheckpoint": true
}
```

- `autoCheckpoint`: Habilitar o deshabilitar la creación automática de checkpoints en cada prompt del usuario (predeterminado: `true`)

## Limitaciones

Los checkpoints tienen las siguientes limitaciones:

- **Cambios en comandos Bash NO rastreados** - Operaciones como `rm`, `mv`, `cp` en el sistema de archivos no se capturan en checkpoints
- **Cambios externos NO rastreados** - Cambios realizados fuera de Claude Code (en tu editor, terminal, etc.) no se capturan
- **No es un reemplazo para control de versiones** - Usa git para cambios permanentes y auditables en tu código

## Solución de Problemas

### Checkpoints Faltantes

**Problema**: No se encuentra el checkpoint esperado

**Solución**:
- Verifica si los checkpoints fueron borrados
- Verifica que `autoCheckpoint` esté habilitado en tu configuración
- Verifica el espacio en disco

### Rewind Falló

**Problema**: No se puede retroceder al checkpoint

**Solución**:
- Asegúrate de que no haya cambios sin commit que conflictúen
- Verifica si el checkpoint está corrupto
- Intenta retroceder a un checkpoint diferente

## Integración con Git

Los checkpoints complementan (pero no reemplazan) a git:

| Característica | Git | Checkpoints |
|---------|-----|-------------|
| Alcance | Sistema de archivos | Conversación + archivos |
| Persistencia | Permanente | Basado en sesión |
| Granularidad | Commits | Cualquier punto |
| Velocidad | Más lento | Instantáneo |
| Compartir | Sí | Limitado |

Usa ambos juntos:
1. Usa checkpoints para experimentación rápida
2. Usa commits de git para cambios finalizados
3. Crea checkpoint antes de operaciones de git
4. Commit estados exitosos de checkpoints a git

## Guía de Inicio Rápido

### Flujo de Trabajo Básico

1. **Trabaja normalmente** - Claude Code crea checkpoints automáticamente
2. **¿Quieres volver atrás?** - Presiona `Esc` dos veces o usa `/rewind`
3. **Elige checkpoint** - Selecciona de la lista para retroceder
4. **Selecciona qué restaurar** - Elige entre restore code and conversation, restore conversation, restore code, summarize from here, o cancelar
5. **Continúa trabajando** - Estás de vuelta en ese punto

### Atajos de Teclado

- **`Esc` + `Esc`** - Abrir navegador de checkpoints
- **`/rewind`** - Forma alternativa de acceder a checkpoints
- **`/checkpoint`** - Alias para `/rewind`

## Conceptos Relacionados

- **[Advanced Features](../09-advanced-features/)** - Modo de planificación y otras capacidades avanzadas
- **[Memory Management](../02-memory/)** - Gestión del historial de conversaciones y contexto
- **[Slash Commands](../01-slash-commands/)** - Atajos invocados por el usuario
- **[Hooks](../06-hooks/)** - Automatización basada en eventos
- **[Plugins](../07-plugins/)** - Paquetes de extensión incluidos

## Recursos Adicionales

- [Documentación Oficial de Checkpointing](https://code.claude.com/docs/en/checkpointing)
- [Guía de Advanced Features](../09-advanced-features/) - Pensamiento extendido y otras capacidades

## Resumen

Los Checkpoints son una característica automática en Claude Code que te permite explorar diferentes enfoques de forma segura sin miedo a perder trabajo. Cada prompt del usuario crea automáticamente un nuevo checkpoint, por lo que puedes retroceder a cualquier punto anterior en tu sesión.

Beneficios clave:
- Experimenta sin miedo con múltiples enfoques
- Recupérate rápidamente de errores
- Compara diferentes soluciones lado a lado
- Intégrate de forma segura con sistemas de control de versiones

Recuerda: los checkpoints no son un reemplazo para git. Usa checkpoints para experimentación rápida y git para cambios permanentes en el código.
