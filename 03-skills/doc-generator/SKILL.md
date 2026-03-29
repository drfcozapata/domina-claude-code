---
name: api-documentation-generator
description: Generar documentación de API comprehensiva y precisa desde código fuente. Usa cuando crees o actualices documentación de API, generes specs OpenAPI, o cuando los usuarios mencionen docs de API, endpoints, o documentación.
---

# Skill de Generador de Documentación de API

## Genera

- Especificaciones OpenAPI/Swagger
- Documentación de endpoints de API
- Ejemplos de uso de SDK
- Guías de integración
- Referencias de códigos de error
- Guías de autenticación

## Estructura de Documentación

### Para Cada Endpoint

```markdown
## GET /api/v1/users/:id

### Descripción
Breve explicación de lo que hace este endpoint

### Parámetros

| Nombre | Tipo | Requerido | Descripción |
|------|------|----------|-------------|
| id | string | Sí | ID de Usuario |

### Respuesta

**200 Éxito**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 No Encontrado**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "El usuario no existe"
}
```

### Ejemplos

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```
```
