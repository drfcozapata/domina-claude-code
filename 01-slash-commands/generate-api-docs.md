---
description: Crear documentación de API comprehensiva desde el código fuente
---

# Generador de Documentación de API

Genera documentación de API mediante:

1. Escanear todos los archivos en `/src/api/`
2. Extraer firmas de funciones y comentarios JSDoc
3. Organizar por endpoint/módulo
4. Crear markdown con ejemplos
5. Incluir esquemas de request/response
6. Agregar documentación de errores

Formato de salida:
- Archivo Markdown en `/docs/api.md`
- Incluir ejemplos de curl para todos los endpoints
- Agregar tipos de TypeScript
