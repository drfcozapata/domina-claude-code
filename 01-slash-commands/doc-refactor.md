---
name: Refactor de Documentación
description: Reestructurar la documentación del proyecto para claridad y accesibilidad
tags: documentation, refactoring, organization
---

# Refactor de Documentación

Refactoriza la estructura de documentación del proyecto adaptada al tipo de proyecto:

1. **Analizar proyecto**: Identificar tipo (librería/API/web app/CLI/microservicios), arquitectura y user personas
2. **Centralizar docs**: Mover documentación técnica a `docs/` con referencias cruzadas apropiadas
3. **Root README.md**: Optimizar como punto de entrada con visión general, quickstart, resumen de módulos/componentes, licencia, contactos
4. **Docs de componentes**: Agregar archivos README a nivel de módulo/paquete/servicio con instrucciones de setup y testing
5. **Organizar `docs/`** por categorías relevantes:
   - Arquitectura, Referencia de API, Base de Datos, Diseño, Troubleshooting, Despliegue, Contributing (adaptar a necesidades del proyecto)
6. **Crear guías** (seleccionar aplicables):
   - Guía de Usuario: Documentación para usuarios finales de aplicaciones
   - Documentación de API: Endpoints, autenticación, ejemplos para APIs
   - Guía de Desarrollo: Setup, testing, flujo de contribución
   - Guía de Despliegue: Despliegue a producción para servicios/apps
7. **Usar Mermaid** para todos los diagramas (arquitectura, flujos, esquemas)

Mantén las docs concisas, escaneables y contextuales al tipo de proyecto.
