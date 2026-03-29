# Estándares del Módulo de API

Este archivo anula el CLAUDE.md raíz para todo lo que está en /src/api/

## Estándares Específicos de API

### Validación de Requests
- Usar Zod para validación de esquemas
- Siempre validar la entrada
- Devolver 400 con errores de validación
- Incluir detalles de errores a nivel de campo

### Autenticación
- Todos los endpoints requieren token JWT
- Token en el header Authorization
- El token expira después de 24 horas
- Implementar mecanismo de refresh token

### Formato de Respuesta

Todas las respuestas deben seguir esta estructura:

```json
{
  "success": true,
  "data": { /* datos reales */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

Respuestas de error:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Mensaje de usuario",
    "details": { /* errores de campo */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Paginación
- Usar paginación basada en cursor (no offset)
- Incluir booleano `hasMore`
- Limitar tamaño máximo de página a 100
- Tamaño de página predeterminado: 20

### Rate Limiting
- 1000 requests por hora para usuarios autenticados
- 100 requests por hora para endpoints públicos
- Devolver 429 cuando se exceda
- Incluir header retry-after

### Caching
- Usar Redis para session caching
- Duración de caché: 5 minutos predeterminado
- Invalidar en operaciones de escritura
- Etiquetar cache keys con tipo de recurso
