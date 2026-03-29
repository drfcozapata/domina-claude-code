# Mis Preferencias de Desarrollo

## Sobre Mí
- **Nivel de Experiencia**: 8 años desarrollo full-stack
- **Lenguajes Preferidos**: TypeScript, Python
- **Estilo de Comunicación**: Directo, con ejemplos
- **Estilo de Aprendizaje**: Diagramas visuales con código

## Preferencias de Código

### Manejo de Errores
Prefiero manejo explícito de errores con bloques try-catch y mensajes de error significativos.
Evitar errores genéricos. Siempre registrar errores para debugging.

### Comentarios
Usar comentarios para el POR QUÉ, no para el QUÉ. El código debe ser auto-documentado.
Los comentarios deben explicar la lógica de negocio o decisiones no obvias.

### Testing
Prefiero TDD (test-driven development).
Escribir tests primero, luego implementación.
Enfocarse en comportamiento, no en detalles de implementación.

### Arquitectura
Prefiero diseño modular y débilmente acoplado.
Usar inyección de dependencias para testabilidad.
Separar responsabilidades (Controllers, Services, Repositories).

## Preferencias de Debugging
- Usar console.log con prefijo: `[DEBUG]`
- Incluir contexto: nombre de función, variables relevantes
- Usar stack traces cuando estén disponibles
- Siempre incluir timestamps en los logs

## Comunicación
- Explicar conceptos complejos con diagramas
- Mostrar ejemplos concretos antes de explicar teoría
- Incluir fragmentos de código antes/después
- Resumir puntos clave al final

## Organización de Proyectos
Organizo mis proyectos así:
```
project/
  ├── src/
  │   ├── api/
  │   ├── services/
  │   ├── models/
  │   └── utils/
  ├── tests/
  ├── docs/
  └── docker/
```

## Herramientas
- **IDE**: VS Code con vim keybindings
- **Terminal**: Zsh con Oh-My-Zsh
- **Formato**: Prettier (100 caracteres de longitud de línea)
- **Linter**: ESLint con configuración airbnb
- **Framework de Test**: Jest con React Testing Library
