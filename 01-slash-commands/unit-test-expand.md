---
name: Expandir Tests Unitarios
description: Incrementar la cobertura de tests apuntando a ramas no testeadas y casos borde
tags: testing, coverage, unit-tests
---

# Expandir Tests Unitarios

Expande tests unitarios existentes adaptados al framework de testing del proyecto:

1. **Analizar cobertura**: Ejecuta reporte de cobertura para identificar ramas no testeadas, casos borde y áreas de baja cobertura
2. **Identificar brechas**: Revisa el código en busca de ramas lógicas, rutas de error, condiciones de frontera, entradas null/vacías
3. **Escribir tests** usando el framework del proyecto:
   - Jest/Vitest/Mocha (JavaScript/TypeScript)
   - pytest/unittest (Python)
   - Go testing/testify (Go)
   - Rust test framework (Rust)
4. **Apuntar a escenarios específicos**:
   - Manejo de errores y excepciones
   - Valores de frontera (mín/máx, vacío, null)
   - Casos borde y casos esquina
   - Transiciones de estado y efectos secundarios
5. **Verificar mejora**: Ejecuta cobertura nuevamente, confirma aumento medible

Presenta solo bloques de código de nuevos tests. Sigue patrones de tests existentes y convenciones de nombres.
