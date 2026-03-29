# Plantilla de Hallazgo de Code Review

Usa esta plantilla cuando documentes cada issue encontrado durante el code review.

---

## Issue: [TÍTULO]

### Severidad
- [ ] Crítico (bloquea el deployment)
- [ ] Alto (debería arreglarse antes del merge)
- [ ] Medio (debería arreglarse pronto)
- [ ] Bajo (nice to have)

### Categoría
- [ ] Seguridad
- [ ] Rendimiento
- [ ] Calidad de Código
- [ ] Mantenibilidad
- [ ] Testing
- [ ] Patrón de Diseño
- [ ] Documentación

### Ubicación
**Archivo:** `src/components/UserCard.tsx`

**Líneas:** 45-52

**Función/Método:** `renderUserDetails()`

### Descripción del Issue

**Qué:** Describe cuál es el issue.

**Por qué importa:** Explica el impacto y por qué necesita ser arreglado.

**Comportamiento actual:** Muestra el código o comportamiento problemático.

**Comportamiento esperado:** Describe qué debería pasar en su lugar.

### Ejemplo de Código

#### Actual (Problemático)

```typescript
// Muestra el problema N+1 query
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // ¡Query por usuario!
  renderUserPosts(posts);
});
```

#### Fix Sugerido

```typescript
// Optimizado con JOIN query
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Análisis de Impacto

| Aspecto | Impacto | Severidad |
|--------|--------|----------|
| Rendimiento | 100+ queries para 20 usuarios | Alto |
| Experiencia de Usuario | Carga lenta de página | Alto |
| Escalabilidad | Se rompe a escala | Crítico |
| Mantenibilidad | Difícil de debuggear | Medio |

### Issues Relacionados

- Issue similar en `AdminUserList.tsx` línea 120
- PR relacionado: #456
- Issue relacionado: #789

### Recursos Adicionales

- [Problema de Query N+1](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Documentación de Database Join](https://docs.example.com/joins)
- [Guía de Optimización de Rendimiento](./docs/performance.md)

### Notas del Reviewer

- Este es un patrón común en este codebase
- Considera añadir esto a la guía de estilo de código
- Podría valer la pena crear una función helper

### Respuesta del Autor (para feedback)

*Por ser completado por el autor del código:*

- [ ] Fix implementado en commit: `abc123`
- [ ] Estado del fix: Completo / En Progreso / Necesita Discusión
- [ ] Preguntas o preocupaciones: (describe)

---

## Estadísticas de Hallazgos (para Reviewer)

Cuando revises múltiples hallazgos, rastrea:

- **Total de Issues Encontrados:** X
- **Críticos:** X
- **Altos:** X
- **Medios:** X
- **Bajos:** X

**Recomendación:** ✅ Aprobar / ⚠️ Solicitar Cambios / 🔄 Necesita Discusión

**Calidad General del Código:** 1-5 estrellas
