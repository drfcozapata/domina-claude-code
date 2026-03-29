# Plantilla de Plan de Refactoring

Usa esta plantilla para documentar y rastrear tu esfuerzo de refactoring.

---

## Información del Proyecto

| Campo | Valor |
|-------|-------|
| **Proyecto/Módulo** | [Nombre del proyecto] |
| **Archivos Objetivo** | [Lista de archivos a refactorizar] |
| **Fecha de Creación** | [Fecha] |
| **Autor** | [Nombre] |
| **Estado** | Borrador / En Revisión / Aprobado / En Progreso / Completado |

---

## Resumen Ejecutivo

### Objetivos
- [ ] [Objetivo principal: ej. Mejorar legibilidad del procesamiento de pagos]
- [ ] [Objetivo secundario: ej. Reducir duplicación de código]
- [ ] [Objetivo terciario: ej. Mejorar testeabilidad]

### Restricciones
- [ ] [Restricción 1: ej. No se puede cambiar la API pública]
- [ ] [Restricción 2: ej. Debe mantener compatibilidad hacia atrás]
- [ ] [Restricción 3: ej. Sin cambios al esquema de base de datos]

### Nivel de Riesgo
- [ ] Bajo - Cambios menores, código bien testeado
- [ ] Medio - Cambios moderados, algo de riesgo
- [ ] Alto - Cambios significativos, atención cuidadosa necesaria

---

## Checklist Pre-Refactoring

### Evaluación de Cobertura de Tests

| Métrica | Actual | Objetivo | Estado |
|--------|---------|--------|--------|
| Cobertura de Tests Unitarios | __%  | ≥80% | |
| Tests de Integración | Sí/No | Sí | |
| Todos los Tests Pasando | Sí/No | Sí | |

### Requeridos Antes de Comenzar
- [ ] Todos los tests pasando
- [ ] Código revisado y entendido
- [ ] Backup/control de versiones en su lugar
- [ ] Aprobación del usuario obtenida

---

## Code Smells Identificados

### Resumen

| # | Smell | Ubicación | Severidad | Prioridad |
|---|-------|----------|----------|----------|
| 1 | [ej. Método Largo] | [archivo:línea] | Alto | P1 |
| 2 | [ej. Código Duplicado] | [archivo:línea] | Medio | P2 |
| 3 | [ej. Envidia de Característica] | [archivo:línea] | Bajo | P3 |

### Análisis Detallado

#### Smell #1: [Nombre]

**Ubicación**: `ruta/al/archivo.js:45-120`

**Descripción**: [Descripción detallada del problema]

**Impacto**:
- [Impacto 1]
- [Impacto 2]

**Solución Propuesta**: [Visión general breve de cómo arreglar]

---

## Fases de Refactoring

### Fase A: Victorias Rápidas (Bajo Riesgo)

**Objetivo**: Mejoras simples con valor inmediato

**Cambios Estimados**: [X archivos, Y métodos]

**Aprobación de Usuario Requerida**: Sí / No

| # | Tarea | Archivo | Refactoring | Estado |
|---|------|------|-------------|--------|
| A1 | Renombrar variable `x` a `userCount` | utils.js:15 | Renombrar Variable | [ ] |
| A2 | Eliminar `oldHandler()` no usado | api.js:89 | Eliminar Código Muerto | [ ] |
| A3 | Extraer validación duplicada | form.js:23,67 | Extract Method | [ ] |

**Plan de Rollback**: Revertir commits A1-A3

---

### Fase B: Mejoras Estructurales (Riesgo Medio)

**Objetivo**: Mejorar organización y claridad del código

**Cambios Estimados**: [X archivos, Y métodos]

**Aprobación de Usuario Requerida**: Sí

**Dependencias**: La Fase A debe estar completa

| # | Tarea | Archivo | Refactoring | Estado |
|---|------|------|-------------|--------|
| B1 | Extraer `calculatePrice()` de método largo | order.js:45 | Extract Method | [ ] |
| B2 | Introducir objeto de parámetros `OrderDetails` | order.js:12 | Introduce Parameter Object | [ ] |
| B3 | Mover `formatAddress()` a clase Address | customer.js:78 | Move Method | [ ] |

**Plan de Rollback**: Revertir al commit post-Fase-A

---

### Fase C: Cambios Arquitectónicos (Riesgo Más Alto)

**Objetivo**: Abordar problemas estructurales más profundos

**Cambios Estimados**: [X archivos, Y métodos]

**Aprobación de Usuario Requerida**: Sí

**Dependencias**: Fases A y B deben estar completas

| # | Tarea | Archivo | Refactoring | Estado |
|---|------|------|-------------|--------|
| C1 | Reemplazar switch de precio con polimorfismo | pricing.js:30 | Replace Conditional with Polymorphism | [ ] |
| C2 | Extraer clase `NotificationService` | user.js:100 | Extract Class | [ ] |

**Plan de Rollback**: Revertir al commit post-Fase-B

---

## Pasos Detallados de Refactoring

### Tarea [ID]: [Nombre de Tarea]

**Smell Abordado**: [Nombre del smell]

**Técnica de Refactoring**: [Nombre de técnica]

**Nivel de Riesgo**: Bajo / Medio / Alto

#### Contexto

**Antes** (Estado Actual):
```javascript
// Pega el código actual aquí
```

**Después** (Estado Esperado):
```javascript
// Pega el código esperado aquí
```

#### Mecánicas Paso a Paso

1. [ ] **Paso 1**: [Descripción]
   - Test: Ejecuta tests después de este paso
   - Esperado: Todos los tests pasan

2. [ ] **Paso 2**: [Descripción]
   - Test: Ejecuta tests después de este paso
   - Esperado: Todos los tests pasan

3. [ ] **Paso 3**: [Descripción]
   - Test: Ejecuta tests después de este paso
   - Esperado: Todos los tests pasan

#### Verificación

- [ ] Todos los tests pasando
- [ ] Comportamiento sin cambios
- [ ] Código compila
- [ ] Sin nuevos warnings

#### Mensaje de Commit
```
refactor: [Describe el refactoring]
```

---

## Rastreo de Progreso

### Estado de Fases

| Fase | Estado | Iniciado | Completado | Tests Pasando |
|-------|--------|---------|-----------|---------------|
| A | No Iniciado / En Progreso / Hecho | | | |
| B | No Iniciado / En Progreso / Hecho | | | |
| C | No Iniciado / En Progreso / Hecho | | | |

### Issues Encontrados

| # | Issue | Resolución | Estado |
|---|-------|------------|--------|
| 1 | [Descripción] | [Cómo se resolvió] | Abierto / Resuelto |

---

## Comparación de Métricas

### Antes del Refactoring

| Métrica | Archivo 1 | Archivo 2 | Total |
|--------|--------|--------|-------|
| Líneas de Código | | | |
| Complejidad Ciclomática | | | |
| Índice de Mantenibilidad | | | |
| Número de Métodos | | | |
| Longitud Promedio de Método | | | |

### Después del Refactoring

| Métrica | Archivo 1 | Archivo 2 | Total | Cambio |
|--------|--------|--------|-------|--------|
| Líneas de Código | | | | |
| Complejidad Ciclomática | | | | |
| Índice de Mantenibilidad | | | | |
| Número de Métodos | | | | |
| Longitud Promedio de Método | | | | |

---

## Checklist Post-Refactoring

- [ ] Todos los tests pasando
- [ ] Sin nuevos warnings o errores
- [ ] Código compila exitosamente
- [ ] Verificación manual completada
- [ ] Documentación actualizada (si es necesario)
- [ ] Código revisado
- [ ] Métricas mejoradas
- [ ] Aprobación del usuario obtenida

---

## Lecciones Aprendidas

### Qué Salió Bien
- [Ítem 1]
- [Ítem 2]

### Qué Podría Mejorarse
- [Ítem 1]
- [Ítem 2]

### Recomendaciones para el Futuro
- [Ítem 1]
- [Ítem 2]

---

## Aprobaciones

| Rol | Nombre | Fecha | Firma |
|------|------|------|-----------|
| Autor del Plan | | | |
| Líder Técnico | | | |
| Product Owner | | | |

---

## Apéndice

### A. Documentación Relacionada
- [Link a docs relevantes]

### B. Materiales de Referencia
- [Link a catálogo de code smells]
- [Link a catálogo de refactoring]

### C. Herramientas Usadas
- [Framework de testing]
- [Herramientas de linting]
- [Herramientas de análisis de complejidad]
