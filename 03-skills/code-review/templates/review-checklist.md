# Checklist de Code Review

## Checklist de Seguridad
- [ ] Sin credenciales o secretos hardcodeados
- [ ] Validación de input en todos los inputs de usuario
- [ ] Prevención de inyección SQL (queries parametrizadas)
- [ ] Protección CSRF en operaciones que cambian estado
- [ ] Prevención de XSS con escaping apropiado
- [ ] Checks de autenticación en endpoints protegidos
- [ ] Checks de autorización en recursos
- [ ] Hashing seguro de passwords (bcrypt, argon2)
- [ ] Sin datos sensibles en logs
- [ ] HTTPS forzado

## Checklist de Rendimiento
- [ ] Sin queries N+1
- [ ] Uso apropiado de índices
- [ ] Caching implementado donde sea beneficioso
- [ ] Sin operaciones bloqueantes en el hilo principal
- [ ] Async/await usado correctamente
- [ ] Datasets grandes paginados
- [ ] Conexiones de base de datos pooled
- [ ] Expresiones regulares optimizadas
- [ ] Sin creación de objetos innecesaria
- [ ] Memory leaks prevenidos

## Checklist de Calidad
- [ ] Funciones < 50 líneas
- [ ] Nombres de variables claros
- [ ] Sin código duplicado
- [ ] Manejo de errores apropiado
- [ ] Comentarios explican POR QUÉ, no QUÉ
- [ ] Sin console.logs en producción
- [ ] Type checking (TypeScript/JSDoc)
- [ ] Principios SOLID seguidos
- [ ] Patrones de diseño aplicados correctamente
- [ ] Código auto-documentado

## Checklist de Testing
- [ ] Tests unitarios escritos
- [ ] Casos edge cubiertos
- [ ] Escenarios de error testeados
- [ ] Tests de integración presentes
- [ ] Cobertura > 80%
- [ ] Sin tests flaky
- [ ] Mock de dependencias externas
- [ ] Nombres de tests claros
