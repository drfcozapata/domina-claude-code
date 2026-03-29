---
name: code-review-specialist
description: Revisión de código comprehensiva con análisis de seguridad, rendimiento y calidad. Usa cuando los usuarios pidan revisar código, analizar calidad de código, evaluar pull requests, o mencionen code review, análisis de seguridad, u optimización de rendimiento.
---

# Skill de Code Review

Este skill proporciona capacidades comprehensivas de code review enfocándose en:

1. **Análisis de Seguridad**
   - Problemas de autenticación/autorización
   - Riesgos de exposición de datos
   - Vulnerabilidades de inyección
   - Debilidades criptográficas
   - Logging de datos sensibles

2. **Revisión de Rendimiento**
   - Eficiencia de algoritmos (análisis Big O)
   - Optimización de memoria
   - Optimización de queries de base de datos
   - Oportunidades de caching
   - Problemas de concurrencia

3. **Calidad de Código**
   - Principios SOLID
   - Patrones de diseño
   - Convenciones de nombres
   - Documentación
   - Cobertura de tests

4. **Mantenibilidad**
   - Legibilidad de código
   - Tamaño de funciones (debería ser < 50 líneas)
   - Complejidad ciclomática
   - Gestión de dependencias
   - Seguridad de tipos

## Plantilla de Review

Para cada pieza de código revisada, proporciona:

### Resumen
- Evaluación de calidad general (1-5)
- Cantidad de hallazgos clave
- Áreas de prioridad recomendadas

### Issues Críticos (si los hay)
- **Issue**: Descripción clara
- **Ubicación**: Archivo y número de línea
- **Impacto**: Por qué esto importa
- **Severidad**: Crítico/Alto/Medio
- **Fix**: Ejemplo de código

### Hallazgos por Categoría

#### Seguridad (si se encuentran issues)
Lista vulnerabilidades de seguridad con ejemplos

#### Rendimiento (si se encuentran issues)
Lista problemas de rendimiento con análisis de complejidad

#### Calidad (si se encuentran issues)
Lista issues de calidad de código con sugerencias de refactoring

#### Mantenibilidad (si se encuentran issues)
Lista problemas de mantenibilidad con mejoras

## Historial de Versiones

- v1.0.0 (2024-12-10): Lanzamiento inicial con análisis de seguridad, rendimiento, calidad y mantenibilidad
