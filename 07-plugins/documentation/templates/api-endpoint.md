# [METHOD] /api/v1/[endpoint]

## Descripción
Breve explicación de lo que hace este endpoint.

## Autenticación
Método de autenticación requerido (ej. Bearer token).

## Parámetros

### Parámetros de Path
| Nombre | Tipo | Requerido | Descripción |
|------|------|----------|-------------|
| id | string | Sí | ID del recurso |

### Parámetros de Query
| Nombre | Tipo | Requerido | Descripción |
|------|------|----------|-------------|
| page | integer | No | Número de página (predeterminado: 1) |
| limit | integer | No | Elementos por página (predeterminado: 20) |

### Body del Request
```json
{
  "field": "value"
}
```

## Respuestas

### 200 OK
```json
{
  "success": true,
  "data": {
    "id": "123",
    "name": "Example"
  }
}
```

### 400 Bad Request
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Entrada inválida"
  }
}
```

### 404 Not Found
```json
{
  "success": false,
  "error": {
    "code": "NOT_FOUND",
    "message": "Recurso no encontrado"
  }
}
```

## Ejemplos

### cURL
```bash
curl -X GET "https://api.example.com/api/v1/endpoint" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### JavaScript
```javascript
const response = await fetch('/api/v1/endpoint', {
  headers: {
    'Authorization': 'Bearer token',
    'Content-Type': 'application/json'
  }
});
const data = await response.json();
```

### Python
```python
import requests

response = requests.get(
    'https://api.example.com/api/v1/endpoint',
    headers={'Authorization': 'Bearer token'}
)
data = response.json()
```

## Rate Limits
- 1000 requests por hora para usuarios autenticados
- 100 requests por hora para endpoints públicos

## Endpoints Relacionados
- [GET /api/v1/related](#)
- [POST /api/v1/related](#)
