---
name: code-refactor
description: Refactoring sistemático de código basado en la metodología de Martin Fowler. Usa cuando los usuarios pidan refactorizar código, mejorar estructura de código, reducir deuda técnica, limpiar código legacy, eliminar code smells, o mejorar mantenibilidad de código. Este skill guía a través de un enfoque por fases con investigación, planificación e implementación incremental segura.
---

# Skill de Refactoring de Código

Un enfoque sistemático para refactorizar código basado en *Refactoring: Improving the Design of Existing Code* (2da Edición) de Martin Fowler. Este skill enfatiza cambios incrementales seguros respaldados por tests.

> "El refactoring es el proceso de cambiar un sistema de software de tal manera que no altere el comportamiento externo del código pero mejore su estructura interna." — Martin Fowler

## Principios Fundamentales

1. **Preservación de Comportamiento**: El comportamiento externo debe permanecer sin cambios
2. **Pasos Pequeños**: Haz cambios pequeños y testeables
3. **Test-Driven**: Los tests son la red de seguridad
4. **Continuo**: El refactoring es continuo, no un evento único
5. **Colaborativo**: Aprobación del usuario requerida en cada fase

## Visión General del Flujo de Trabajo

```
Fase 1: Investigación y Análisis
    ↓
Fase 2: Evaluación de Cobertura de Tests
    ↓
Fase 3: Identificación de Code Smells
    ↓
Fase 4: Creación de Plan de Refactoring
    ↓
Fase 5: Implementación Incremental
    ↓
Fase 6: Revisión e Iteración
```

---

## Fase 1: Investigación y Análisis

### Objetivos
- Entender la estructura y propósito del codebase
- Identificar el scope del refactoring
- Recopilar contexto sobre requisitos de negocio

### Preguntas para Hacer al Usuario
Antes de comenzar, clarifica:

1. **Scope**: ¿Qué archivos/módulos/funciones necesitan refactoring?
2. **Objetivos**: ¿Qué problemas estás tratando de resolver? (legibilidad, rendimiento, mantenibilidad)
3. **Restricciones**: ¿Hay alguna área que NO debería cambiarse?
4. **Presión de tiempo**: ¿Esto está bloqueando otro trabajo?
5. **Estado de tests**: ¿Existen tests? ¿Están pasando?

### Acciones
- [ ] Lee y entiende el código objetivo
- [ ] Identifica dependencias e integraciones
- [ ] Documenta la arquitectura actual
- [ ] Nota cualquier marcador de deuda técnica existente (TODOs, FIXMEs)

### Salida
Presenta hallazgos al usuario:
- Resumen de estructura de código
- Áreas problemáticas identificadas
- Recomendaciones iniciales
- **Solicita aprobación para proceder**

---

## Fase 2: Evaluación de Cobertura de Tests

### Por Qué Importan los Tests
> "Refactoring sin tests es como conducir sin cinturón de seguridad." — Martin Fowler

Los tests son el **habilitador clave** del refactoring seguro. Sin ellos, arriesgas introducir bugs.

### Pasos de Evaluación

1. **Verifica tests existentes**
   ```bash
   # Busca archivos de test
   find . -name "*test*" -o -name "*spec*" | head -20
   ```

2. **Ejecuta tests existentes**
   ```bash
   # JavaScript/TypeScript
   npm test

   # Python
   pytest -v

   # Java
   mvn test
   ```

3. **Verifica cobertura (si está disponible)**
   ```bash
   # JavaScript
   npm run test:coverage

   # Python
   pytest --cov=.
   ```

### Punto de Decisión: Pregunta al Usuario

**Si los tests existen y pasan:**
- Procede a Fase 3

**Si los tests faltan o están incompletos:**
Presenta opciones:
1. Escribe tests primero (recomendado)
2. Añade tests incrementalmente durante el refactoring
3. Procede sin tests (riesgoso - requiere reconocimiento del usuario)

**Si los tests están fallando:**
- DETENTE. Arregla tests fallando antes de refactorizar
- Pregunta al usuario: ¿Deberíamos arreglar los tests primero?

### Guías de Escritura de Tests (si es necesario)

Para cada función siendo refactorizada, asegura que los tests cubran:
- Camino feliz (operación normal)
- Casos edge (inputs vacíos, null, boundaries)
- Escenarios de error (inputs inválidos, excepciones)

Usa el ciclo "red-green-refactor":
1. Escribe test fallando (red)
2. Haz que pase (green)
3. Refactoriza

---

## Fase 3: Identificación de Code Smells

### Qué Son los Code Smells
Síntomas de problemas más profundos en el código. No son bugs, pero indicadores de que el código podría mejorarse.

### Code Smells Comunes a Verificar

Ver [references/code-smells.md](references/code-smells.md) para el catálogo completo.

#### Referencia Rápida

| Smell | Signos | Impacto |
|-------|-------|--------|
| **Método Largo** | Métodos > 30-50 líneas | Difícil de entender, testear, mantener |
| **Código Duplicado** | Misma lógica en múltiples lugares | Fixes de bugs necesarios en múltiples lugares |
| **Clase Grande** | Clase con demasiadas responsabilidades | Viola Principio de Responsabilidad Única |
| **Envidia de Característica** | Método usa datos de otra clase más | Pobre encapsulamiento |
| **Obsesión Primitiva** | Sobrecuso de primitivos en lugar de objetos | Faltan conceptos de dominio |
| **Lista de Parámetros Larga** | Métodos con 4+ parámetros | Difícil de llamar correctamente |
| **Grupos de Datos** | Mismos ítems de datos apareciendo juntos | Falta abstracción |
| **Switch Statements** | Cadenas complejas de switch/if-else | Difícil de extender |
| **Generalidad Especulativa** | Código "por si acaso" | Complejidad innecesaria |
| **Código Muerto** | Código no usado | Confusión, carga de mantenimiento |

### Pasos de Análisis

1. **Análisis Automatizado** (si los scripts están disponibles)
   ```bash
   python scripts/detect-smells.py <archivo>
   ```

2. **Revisión Manual**
   - Recorre el código sistemáticamente
   - Nota cada smell con ubicación y severidad
   - Categoriza por impacto (Crítico/Alto/Medio/Bajo)

3. **Priorización**
   Enfócate en smells que:
   - Bloquean desarrollo actual
   - Causan bugs o confusión
   - Afectan rutas de código más cambiadas

### Salida: Reporte de Smells

Presenta al usuario:
- Lista de smells identificados con ubicaciones
- Evaluación de severidad para cada uno
- Orden de prioridad recomendado
- **Solicita aprobación en prioridades**

---

## Fase 4: Creación de Plan de Refactoring

### Seleccionando Refactorings

Para cada smell, selecciona un refactoring apropiado del catálogo.

Ver [references/refactoring-catalog.md](references/refactoring-catalog.md) para la lista completa.

#### Mapeo de Smell-a-Refactoring

| Code Smell | Refactoring(s) Recomendado(s) |
|------------|---------------------------|
| Método Largo | Extract Method, Replace Temp with Query |
| Código Duplicado | Extract Method, Pull Up Method, Form Template Method |
| Clase Grande | Extract Class, Extract Subclass |
| Envidia de Característica | Move Method, Move Field |
| Obsesión Primitiva | Replace Primitive with Object, Replace Type Code with Class |
| Lista de Parámetros Larga | Introduce Parameter Object, Preserve Whole Object |
| Grupos de Datos | Extract Class, Introduce Parameter Object |
| Switch Statements | Replace Conditional with Polymorphism |
| Generalidad Especulativa | Collapse Hierarchy, Inline Class, Remove Dead Code |
| Código Muerto | Remove Dead Code |

### Estructura del Plan

Usa la plantilla en [templates/refactoring-plan.md](templates/refactoring-plan.md).

Para cada refactoring:
1. **Objetivo**: Qué código cambiará
2. **Smell**: Qué problema aborda
3. **Refactoring**: Qué técnica aplicar
4. **Pasos**: Micro-pasos detallados
5. **Riesgos**: Qué podría salir mal
6. **Rollback**: Cómo deshacer si es necesario

### Enfoque por Fases

**CRÍTICO**: Introduce el refactoring gradualmente en fases.

**Fase A: Victorias Rápidas** (Bajo riesgo, alto valor)
- Renombra variables por claridad
- Extrae código duplicado obvio
- Elimina código muerto

**Fase B: Mejoras Estructurales** (Riesgo medio)
- Extrae métodos de funciones largas
- Introduce objetos de parámetros
- Mueve métodos a clases apropiadas

**Fase C: Cambios Arquitectónicos** (Riesgo más alto)
- Reemplaza condicionales con polimorfismo
- Extrae clases
- Introduce patrones de diseño

### Punto de Decisión: Presenta el Plan al Usuario

Antes de la implementación:
- Muestra el plan de refactoring completo
- Explica cada fase y sus riesgos
- Obten aprobación explícita para cada fase
- **Pregunta**: "¿Debería proceder con la Fase A?"

---

## Fase 5: Implementación Incremental

### La Regla de Oro
> "Cambio → Test → ¿Verde? → Commit → Siguiente paso"

### Ritmo de Implementación

Para cada paso de refactoring:

1. **Pre-check**
   - Los tests están pasando (green)
   - El código compila

2. **Haz UN cambio pequeño**
   - Sigue las mecánicas del catálogo
   - Mantén los cambios mínimos

3. **Verifica**
   - Ejecuta tests inmediatamente
   - Verifica errores de compilación

4. **Si los tests pasan (green)**
   - Haz commit con mensaje descriptivo
   - Mueve al siguiente paso

5. **Si los tests fallan (red)**
   - DETENTE inmediatamente
   - Deshaz el cambio
   - Analiza qué salió mal
   - Pregunta al usuario si no estás seguro

### Estrategia de Commits

Cada commit debería ser:
- **Atómico**: Un cambio lógico
- **Reversible**: Fácil de revertir
- **Descriptivo**: Mensaje de commit claro

Ejemplo de mensajes de commit:
```
refactor: Extraer calculateTotal() de processOrder()
refactor: Renombrar 'x' a 'customerCount' por claridad
refactor: Eliminar método unused validateOldFormat()
```

### Reporte de Progreso

Después de cada sub-fase, reporta al usuario:
- Cambios realizados
- ¿Tests aún pasando?
- ¿Algunos issues encontrados?
- **Pregunta**: "¿Continuar con el siguiente lote?"

---

## Fase 6: Revisión e Iteración

### Checklist Post-Refactoring

- [ ] Todos los tests pasando
- [ ] Sin nuevos warnings/errores
- [ ] Código compila exitosamente
- [ ] Comportamiento sin cambios (verificación manual)
- [ ] Documentación actualizada si es necesario
- [ ] Historial de commits limpio

### Comparación de Métricas

Ejecuta análisis de complejidad antes y después:
```bash
python scripts/analyze-complexity.py <archivo>
```

Presenta mejoras:
- Cambio en líneas de código
- Cambio en complejidad ciclomática
- Cambio en índice de mantenibilidad

### Revisión del Usuario

Presenta resultados finales:
- Resumen de todos los cambios
- Comparación de código antes/después
- Mejoras de métricas
- Deuda técnica restante
- **Pregunta**: "¿Estás satisfecho con estos cambios?"

### Próximos Pasos

Discute con el usuario:
- ¿Smells adicionales para abordar?
- ¿Programar refactoring de seguimiento?
- ¿Aplicar cambios similares en otro lugar?

---

## Guías Importantes

### Cuándo DETENERSE y Preguntar

Siempre pausa y consulta al usuario cuando:
- No estés seguro sobre lógica de negocio
- El cambio pueda afectar APIs externas
- La cobertura de tests sea inadecuada
- Se necesite decisión arquitectónica significativa
- El nivel de riesgo aumente
- Encuentres complejidad inesperada

### Reglas de Seguridad

1. **Nunca refactorices sin tests** (a menos que el usuario explícitamente reconozca el riesgo)
2. **Nunca hagas cambios grandes** - divídelos en pasos pequeños
3. **Nunca saltes la ejecución de tests** después de cada cambio
4. **Nunca continúes si los tests fallan** - arregla o haz rollback primero
5. **Nunca asumas** - cuando dudes, pregunta

### Qué NO Hacer

- No combines refactoring con adición de features
- No refactorices durante emergencias de producción
- No refactorices código que no entiendes
- No sobre-ingenierices - manténlo simple
- No refactorices todo a la vez

---

## Ejemplo de Inicio Rápido

### Escenario: Método Largo con Duplicación

**Antes:**
```javascript
function processOrder(order) {
  // 150 líneas de código con:
  // - Lógica de validación duplicada
  // - Cálculos inline
  // - Responsabilidades mezcladas
}
```

**Pasos de Refactoring:**

1. **Asegura que existan tests** para processOrder()
2. **Extrae** validación en validateOrder()
3. **Test** - debería pasar
4. **Extrae** cálculo en calculateOrderTotal()
5. **Test** - debería pasar
6. **Extrae** notificación en notifyCustomer()
7. **Test** - debería pasar
8. **Revisa** - processOrder() ahora orquesta 3 funciones claras

**Después:**
```javascript
function processOrder(order) {
  validateOrder(order);
  const total = calculateOrderTotal(order);
  notifyCustomer(order, total);
  return { order, total };
}
```

---

## Referencias

- [Catálogo de Code Smells](references/code-smells.md) - Lista completa de code smells
- [Catálogo de Refactoring](references/refactoring-catalog.md) - Técnicas de refactoring
- [Plantilla de Plan de Refactoring](templates/refactoring-plan.md) - Plantilla de planificación

## Scripts

- `scripts/analyze-complexity.py` - Analiza métricas de complejidad de código
- `scripts/detect-smells.py` - Detección automatizada de smells

## Historial de Versiones

- v1.0.0 (2025-01-15): Lanzamiento inicial con metodología Fowler, enfoque por fases, puntos de consulta al usuario
