# Configuración del Proyecto

## Visión General del Proyecto
- **Nombre**: Plataforma de Comercio Electrónico
- **Tech Stack**: Node.js, PostgreSQL, React 18, Docker
- **Tamaño del Equipo**: 5 desarrolladores
- **Fecha Límite**: Q4 2025

## Arquitectura
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Estándares de Desarrollo

### Estilo de Código
- Usar Prettier para formato
- Usar ESLint con configuración airbnb
- Longitud máxima de línea: 100 caracteres
- Usar indentación de 2 espacios

### Convenciones de Nomenclatura
- **Archivos**: kebab-case (user-controller.js)
- **Clases**: PascalCase (UserService)
- **Funciones/Variables**: camelCase (getUserById)
- **Constantes**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Tablas de Base de Datos**: snake_case (user_accounts)

### Flujo de Git
- Nombres de rama: `feature/descripcion` o `fix/descripcion`
- Mensajes de commit: Seguir conventional commits
- PR requerido antes de merge
- Todos los checks de CI/CD deben pasar
- Mínimo 1 aprobación requerida

### Requisitos de Testing
- Mínimo 80% de cobertura de código
- Todos los caminos críticos deben tener tests
- Usar Jest para unit tests
- Usar Cypress para tests E2E
- Nombres de archivos de test: `*.test.ts` o `*.spec.ts`

### Estándares de API
- Solo endpoints RESTful
- Request/response JSON
- Usar códigos de estado HTTP correctamente
- Versionar endpoints de API: `/api/v1/`
- Documentar todos los endpoints con ejemplos

### Base de Datos
- Usar migraciones para cambios de esquema
- Nunca hardcodear credenciales
- Usar connection pooling
- Habilitar query logging en desarrollo
- Backups regulares requeridos

### Deployment
- Deployment basado en Docker
- Orquestación Kubernetes
- Estrategia de deployment blue-green
- Rollback automático en fallo
- Las migraciones de base de datos se ejecutan antes del deploy

## Comandos Comunes

| Comando | Propósito |
|---------|---------|
| `npm run dev` | Iniciar servidor de desarrollo |
| `npm test` | Ejecutar suite de tests |
| `npm run lint` | Verificar estilo de código |
| `npm run build` | Construir para producción |
| `npm run migrate` | Ejecutar migraciones de base de datos |

## Contactos del Equipo
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Problemas Conocidos y Workarounds
- Connection pooling de PostgreSQL limitado a 20 durante horas pico
- Workaround: Implementar query queuing
- Problemas de compatibilidad con Safari 14 con generadores asíncronos
- Workaround: Usar transpilador Babel

## Proyectos Relacionados
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`
