# Reporte de Vulnerabilidades de Seguridad

Este archivo explica cómo reportar vulnerabilidades de seguridad al proyecto Claude How To.

## Enlaces Rápidos

- **Reporte Privado**: https://github.com/luongnv89/claude-howto/security/advisories
- **Política de Seguridad**: [SECURITY.md](../SECURITY.md)
- **Plantilla de Reporte**: Ver abajo

## Reportar una Vulnerabilidad

### Opción 1: GitHub Private Vulnerability Report (RECOMENDADO)

Este es el método preferido para reportar vulnerabilidades de seguridad.

**Pasos:**
1. Ir a: https://github.com/luongnv89/claude-howto/security/advisories
2. Hacer clic en "Report a vulnerability"
3. Completar los detalles (usar plantilla abajo)
4. Enviar

**Ventajas:**
- Mantiene la vulnerabilidad privada hasta que se lance el fix
- Notificaciones automáticas a maintainers
- Funciones de colaboración integradas
- Integrado con herramientas de seguridad de GitHub

### Opción 2: GitHub Security Alert (Para Dependencias)

Si descubres una vulnerabilidad en una dependencia:

1. Ir a: https://github.com/luongnv89/claude-howto/security/dependabot/alerts
2. Revisar la alerta
3. Crear un pull request con el fix
4. Etiquetar con label `security`

### Opción 3: Email Privado (Si GitHub no está disponible)

Si no puedes usar el sistema de reporte de GitHub:

**Próximamente**: El email de contacto de seguridad será agregado aquí

Por ahora, usa el reporte de vulnerabilidad privado de GitHub como se describe arriba.

## Plantilla de Reporte de Vulnerabilidad

Usa esta plantilla al reportar una vulnerabilidad:

```
**Título**: [Descripción breve de la vulnerabilidad]

**Severidad**: [Crítica/Alta/Media/Baja]
Puntaje CVSS Estimado: [0-10]

**Tipo**: [Código/Documentación/Dependencia/Configuración]

**Componente Afectado**:
- Archivo: [path/to/file.py]
- Sección: [Nombre de sección si es documentación]
- Versión: [latest/versión específica]

**Descripción**:
[Explicación clara de qué es la vulnerabilidad]

**Impacto Potencial**:
[¿Qué podría hacer un atacante con esta vulnerabilidad?]
[¿Quién podría verse afectado?]

**Pasos para Reproducir**:
1. [Primer paso]
2. [Segundo paso]
3. [Tercer paso]
[Resultado esperado vs resultado real]

**Prueba de Concepto** (si está disponible):
[Código o pasos para demostrar la vulnerabilidad]

**Fix Sugerido**:
[Tu solución recomendada, si tienes una]

**Contexto Adicional**:
[Cualquier otra información relevante]

**Tu Información**:
- Nombre: [Tu nombre o anónimo]
- Email: [Tu email]
- Crédito: [Cómo te gustaría ser acreditado, si es que lo deseas]
```

## Qué Sucede Después de Reportar

### Timeline

1. **Inmediato (< 1 hora)**
   - Notificación automática enviada a project maintainers

2. **Dentro de 24 horas**
   - Evaluación inicial del reporte
   - Confirmación de que lo recibimos
   - Evaluación preliminar de severidad

3. **Dentro de 48 horas**
   - Respuesta detallada del equipo de seguridad
   - Preguntas para clarificación (si es necesario)
   - Timeline para el fix (si la vulnerabilidad es confirmada)

4. **Dentro de 1-7 días** (depende de la severidad)
   - Fix desarrollado y testeado
   - Security advisory preparado
   - Fix lanzado y advisory público publicado

### Comunicación

Te mantendremos informado a través de:
- Discusión de vulnerabilidad privada de GitHub
- Email (si es proporcionado)
- Actualizaciones en el hilo de discusión

Puedes:
- Hacer preguntas de clarificación
- Proporcionar información adicional
- Sugerir mejoras al fix
- Solicitar ajustes de timeline

### Timeline de Divulgación

**Issues Críticos (CVSS 9.0-10.0)**
- Fix: Lanzado inmediatamente (dentro de 24 horas)
- Divulgación: Advisory público emitido el mismo día
- Noticia: 24 horas de aviso previo al reporter

**Issues Altos (CVSS 7.0-8.9)**
- Fix: Lanzado dentro de 48-72 horas
- Divulgación: Advisory público en el lanzamiento
- Noticia: 5 días de aviso previo al reporter

**Issues Medios (CVSS 4.0-6.9)**
- Fix: Incluido en la próxima actualización regular
- Divulgación: Advisory público en el lanzamiento
- Noticia: Timing coordinado

**Issues Bajos (CVSS 0.1-3.9)**
- Fix: Incluido en la próxima actualización regular
- Divulgación: Advisory en el lanzamiento
- Noticia: Mismo día que el lanzamiento

## Criterios de Vulnerabilidad de Seguridad

### In Scope

Aceptamos reportes sobre:

- **Vulnerabilidades de Código**
  - Ataques de inyección (comando, SQL, etc.)
  - Cross-site scripting (XSS) en ejemplos
  - Fallos de autenticación/autorización
  - Vulnerabilidades de path traversal
  - Problemas de criptografía

- **Seguridad de Documentación**
  - Secrets o credenciales expuestas
  - Patrones de código inseguro
  - Security anti-patterns
  - Afirmaciones de seguridad engañosas

- **Vulnerabilidades de Dependencias**
  - CVEs conocidos en dependencias
  - Ataques de supply chain
  - Dependencias maliciosas

- **Problemas de Configuración**
  - Defaults inseguros
  - Security headers faltantes
  - Exposición de credenciales en ejemplos

### Out of Scope

NO aceptamos reportes sobre:

- Vulnerabilidades en Claude Code mismo (contactar a Anthropic)
- Vulnerabilidades en servicios externos
- Vulnerabilidades teóricas sin prueba
- Issues ya reportados a proyectos upstream
- Ingeniería social o phishing
- Problemas de educación/entrenamiento de usuarios

## Guías de Responsible Disclosure

### Do's ✅

- **Reportar privadamente** antes de la divulgación pública
- **Ser específico** con paths de archivos y números de línea
- **Proporcionar prueba** de la vulnerabilidad
- **Darnos tiempo** para fix (divulgación coordinada)
- **Actualizar** si descubres más detalles
- **Ser profesional** en todas las comunicaciones
- **Respetar confidencialidad** hasta que publiquemos

### Don'ts ❌

- **No divulgar públicamente** antes de que hagamos el fix
- **No explotar** la vulnerabilidad más allá del testing
- **No modificar** datos de otros usuarios
- **No exigir** pago o favores
- **No compartir** la vulnerabilidad con otros
- **No usar** de ninguna manera dañina
- **No hacer spam** con issues no relacionados con seguridad

## Divulgación Coordinada

Practicamos responsible disclosure:

1. **Reporte Privado**: Nos reportas privadamente
2. **Nuestra Evaluación**: Evaluamos y assessamos la severidad
3. **Desarrollo del Fix**: Desarrollamos y testeamos un fix
4. **Aviso Previo**: Te damos aviso previo antes de la divulgación pública
5. **Lanzamiento Público**: Lanzamos fix y advisory juntos
6. **Tu Crédito**: Reconocemos tu contribución (si lo deseas)

**El timeline varía según la severidad** (ver sección arriba)

## Después de que se Lanza el Fix

### Advisory Público

Un security advisory público incluirá:
- Descripción de la vulnerabilidad
- Versiones afectadas
- Severidad (puntaje CVSS)
- Pasos para remediar
- Enlace al fix
- Crédito al reporter (con permiso)

### Tu Reconocimiento

Si deseas ser acreditado:
- Tu nombre/handle en el advisory
- Enlace a tu perfil/sitio web
- Mención en release notes
- Adición al hall of fame (si se crea)

### Sin Compensación

Por favor nota:
- Este es un proyecto open-source dirigido por voluntarios
- No podemos ofrecer recompensas financieras
- Ofrecemos reconocimiento y crédito
- Tu contribución ayuda a la comunidad

## Security Research

Si estás conduciendo security research:

1. **Obtener Permiso**: Contactar maintainers primero
2. **Definir Scope**: Acordar qué testearás
3. **Reportar Hallazgos**: Usar este proceso
4. **Respetar Timeline**: Permitir tiempo para fixes
5. **Publicar Responsablemente**: Coordinar con nosotros

## ¿Preguntas?

Para preguntas sobre este proceso:

1. Revisar [SECURITY.md](../SECURITY.md) para política detallada
2. Mirar sección [FAQ](#faq) abajo
3. Abrir una discusión con label `[SECURITY]`
4. Usar reporte de vulnerabilidad privado para preguntas sensibles

## FAQ

**P: ¿Mi reporte se mantendrá confidencial?**
R: Sí, hasta que se lance el fix. Solo compartimos detalles con aquellos trabajando en el fix.

**P: ¿Cuánto tiempo debo esperar antes de la divulgación pública?**
R: Seguimos timelines de responsible disclosure basados en severidad (24 horas a 7 días). Puedes acordar extender esto si es necesario.

**P: ¿Recibiré crédito?**
R: Sí, en el security advisory y release notes (a menos que prefieras anonimato).

**P: ¿Qué pasa si la vulnerabilidad es menor?**
R: Todos los issues de seguridad legítimos se toman en serio. Incluso los fixes menores serán reconocidos.

**P: ¿Puedo reportar vulnerabilidades solo en documentación?**
R: ¡Sí! La seguridad de documentación es importante también. Los ejemplos con patrones inseguros están en scope.

**P: ¿Qué pasa si no estoy seguro si algo es un issue de seguridad?**
R: ¡Repórtalo de todos modos! Si no es un issue de seguridad, te lo haremos saber. ¡Los falsos positivos están bien!

**P: ¿Puedo discutir públicamente la vulnerabilidad después de reportar?**
R: No, por favor manténlo privado hasta que publiquemos el advisory. La divulgación prematura podría poner a los usuarios en riesgo.

**P: ¿Cómo sé que recibiste mi reporte?**
R: GitHub enviará una notificación automática, y haremos seguimiento dentro de 24 horas.

**P: ¿Qué pasa si no recibo respuesta?**
R: Revisa la página de security advisories de GitHub. Si aún no ves una respuesta, puedes hacer seguimiento con un comentario en el reporte privado.

## Resources

- [SECURITY.md](../SECURITY.md) - Política de seguridad completa
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Guías de contribución
- [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md) - Estándares de comunidad
- [OWASP Vulnerability Disclosure](https://cheatsheetseries.owasp.org/cheatsheets/Vulnerability_Disclosure_Cheat_Sheet.html) - Mejores prácticas de responsible disclosure
- [Coordinated Vulnerability Disclosure](https://cheatsheetseries.owasp.org/cheatsheets/Vulnerable_Dependency_Management_Cheat_Sheet.html)

---

¡Gracias por ayudar a mantener este proyecto seguro! 🔒
