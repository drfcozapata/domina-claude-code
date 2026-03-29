# Política de Seguridad

## Resumen

La seguridad del proyecto Claude How To es importante para nosotros. Este documento describe nuestras prácticas de seguridad y explica cómo reportar vulnerabilidades de seguridad de manera responsable.

## Versiones Soportadas

Proporcionamos actualizaciones de seguridad para las siguientes versiones:

| Versión | Estado | Soporte Hasta |
|---------|--------|---------------|
| Latest (main) | ✅ Activa | Actual + 6 meses |
| Versiones 1.x | ✅ Activa | Hasta la próxima versión mayor |

**Nota**: Como proyecto de guía educativa, nos enfocamos en mantener las mejores prácticas actuales y la seguridad de la documentación en lugar del soporte tradicional de versiones. Las actualizaciones se aplican directamente a la rama main.

## Prácticas de Seguridad

### Seguridad del Código

1. **Gestión de Dependencias**
   - Todas las dependencias de Python están fijadas en `requirements.txt`
   - Actualizaciones regulares vía dependabot y revisión manual
   - Escaneo de seguridad con Bandit en cada commit
   - Hooks de pre-commit para verificaciones de seguridad

2. **Calidad del Código**
   - Linting con Ruff detecta problemas comunes
   - Type checking con mypy previene vulnerabilidades relacionadas con tipos
   - Hooks de pre-commit aplican estándares
   - Todos los cambios son revisados antes de merge

3. **Control de Acceso**
   - Branch protection en la rama `main`
   - Reviews requeridas antes de merge
   - Status checks deben pasar antes de merge
   - Acceso de escritura limitado al repositorio

### Seguridad de la Documentación

1. **Sin Secrets en Ejemplos**
   - Todas las API keys en ejemplos son placeholders
   - Las credenciales nunca están hardcodeadas
   - Los archivos `.env.example` muestran las variables requeridas
   - Advertencias claras sobre gestión de secrets

2. **Mejores Prácticas de Seguridad**
   - Los ejemplos demuestran patrones seguros
   - Advertencias de seguridad destacadas en la documentación
   - Enlaces a guías oficiales de seguridad
   - Manejo de credenciales discutido en secciones relevantes

3. **Revisión de Contenido**
   - Toda la documentación es revisada por problemas de seguridad
   - Consideraciones de seguridad en las guías de contribución
   - Validación de enlaces externos y referencias

### Seguridad de Dependencias

1. **Escaneo**
   - Bandit escanea todo el código Python en busca de vulnerabilidades
   - Verificaciones de vulnerabilidades de dependencias vía GitHub security alerts
   - Auditorías de seguridad manuales regulares

2. **Actualizaciones**
   - Parches de seguridad aplicados rápidamente
   - Versiones mayores evaluadas cuidadosamente
   - Changelog incluye actualizaciones relacionadas con seguridad

3. **Transparencia**
   - Actualizaciones de seguridad documentadas en commits
   - Divulgaciones de vulnerabilidades manejadas responsablemente
   - Security advisories públicos cuando es apropiado

## Reportar una Vulnerabilidad

### Problemas de Seguridad que Nos Importan

Apreciamos los reportes sobre:
- **Vulnerabilidades de código** en scripts o ejemplos
- **Vulnerabilidades de dependencias** en paquetes de Python
- **Problemas de criptografía** en cualquier ejemplo de código
- **Fallas de autenticación/autorización** en documentación
- **Riesgos de exposición de datos** en ejemplos de configuración
- **Vulnerabilidades de inyección** (SQL, command, etc.)
- **Problemas de SSRF/XXE/Path traversal**

### Problemas de Seguridad Fuera de Alcance

Estos están fuera del alcance de este proyecto:
- Vulnerabilidades en Claude Code mismo (reportar a Anthropic)
- Problemas con servicios o librerías externas (reportar al upstream)
- Ingeniería social o educación del usuario (no aplicable a esta guía)
- Vulnerabilidades teóricas sin proof of concept
- Vulnerabilidades en dependencias reportadas a través de canales oficiales

## Cómo Reportar

### Reporte Privado (Preferido)

**Para problemas de seguridad sensibles, por favor use el reporte privado de vulnerabilidades de GitHub:**

1. Visite: https://github.com/luongnv89/domina-claude-code/security/advisories
2. Haga clic en "Report a vulnerability"
3. Complete los detalles de la vulnerabilidad
4. Incluya:
   - Descripción clara de la vulnerabilidad
   - Componente afectado (archivo, sección, ejemplo)
   - Impacto potencial
   - Pasos para reproducir (si aplica)
   - Sugerencia de fix (si tiene una)

**Qué sucede después:**
- Reconoceremos la recepción dentro de 48 horas
- Investigaremos y evaluaremos la severidad
- Trabajaremos con usted para desarrollar un fix
- Coordinaremos el timeline de divulgación
- Le daremos crédito en el security advisory (a menos que prefiera anonimato)

### Reporte Público

Para problemas no sensibles o aquellos que ya son públicos:

1. **Abra un GitHub Issue** con la etiqueta `security`
2. Incluya:
   - Título: `[SECURITY]` seguido de una descripción breve
   - Descripción detallada
   - Archivo o sección afectada
   - Impacto potencial
   - Sugerencia de fix

## Proceso de Respuesta a Vulnerabilidades

### Evaluación (24 horas)

1. Reconocemos la recepción del reporte
2. Evaluamos la severidad usando [CVSS v3.1](https://www.first.org/cvss/v3.1/specification-document)
3. Determinamos si está dentro del alcance
4. Lo contactamos con la evaluación inicial

### Desarrollo (1-7 días)

1. Desarrollamos un fix
2. Revisamos y testeamos el fix
3. Creamos un security advisory
4. Preparamos las release notes

### Divulgación (varía según severidad)

**Crítica (CVSS 9.0-10.0)**
- Fix liberado inmediatamente
- Advisory público emitido
- Aviso anticipado de 24 horas a los reporteros

**Alta (CVSS 7.0-8.9)**
- Fix liberado dentro de 48-72 horas
- Aviso anticipado de 5 días a los reporteros
- Advisory público en el release

**Media (CVSS 4.0-6.9)**
- Fix liberado en la próxima actualización regular
- Advisory público en el release

**Baja (CVSS 0.1-3.9)**
- Fix incluido en la próxima actualización regular
- Advisory en el release

### Publicación

Publicamos security advisories que incluyen:
- Descripción de la vulnerabilidad
- Componentes afectados
- Evaluación de severidad (CVSS score)
- Versión del fix
- Workarounds (si aplica)
- Crédito al reportero (con permiso)

## Mejores Prácticas para Reporteros

### Antes de Reportar

- **Verifique el problema**: ¿Puede reproducirlo consistentemente?
- **Busque issues existentes**: ¿Ya está reportado?
- **Revise la documentación**: ¿Hay guía sobre uso seguro?
- **Testee el fix**: ¿Su sugerencia de fix funciona?

### Al Reportar

- **Sea específico**: Proporcione rutas de archivo exactas y números de línea
- **Incluya contexto**: ¿Por qué esto es un problema de seguridad?
- **Muestre impacto**: ¿Qué podría hacer un atacante?
- **Proporcione pasos**: ¿Cómo podemos reproducirlo?
- **Sugiera fixes**: ¿Cómo lo fixaría usted?

### Después de Reportar

- **Sea paciente**: Tenemos recursos limitados
- **Sea responsivo**: Responda preguntas de seguimiento rápidamente
- **Manténgalo confidencial**: No divulgue públicamente antes del fix
- **Respete la coordinación**: Siga nuestro timeline para divulgación

## Security Headers y Configuración

### Seguridad del Repositorio

- **Branch protection**: La rama main requiere 2 approvals para cambios
- **Status checks**: Todos los checks de CI/CD deben pasar
- **CODEOWNERS**: Reviewers designados para archivos clave
- **Signed commits**: Recomendado para contribuidores

### Seguridad de Desarrollo

```bash
# Instalar hooks de pre-commit
pre-commit install

# Ejecutar security scans localmente
bandit -c pyproject.toml -r scripts/
mypy scripts/ --ignore-missing-imports
ruff check scripts/
```

### Seguridad de Dependencias

```bash
# Verificar vulnerabilidades conocidas
pip install safety
safety check

# O usar pip-audit
pip install pip-audit
pip-audit
```

## Guías de Seguridad para Contribuidores

### Al Escribir Ejemplos

1. **Nunca hardcodee secrets**
   ```python
   # ❌ Mal
   api_key = "sk-1234567890"

   # ✅ Bien
   api_key = os.getenv("API_KEY")
   ```

2. **Advierta sobre implicaciones de seguridad**
   ```markdown
   ⚠️ **Nota de Seguridad**: Nunca haga commit de archivos `.env` a git.
   Agréguelos a `.gitignore` inmediatamente.
   ```

3. **Use defaults seguros**
   - Habilitar autenticación por defecto
   - Usar HTTPS donde aplique
   - Validar y sanitizar inputs
   - Usar parameterized queries

4. **Documente consideraciones de seguridad**
   - Explique por qué la seguridad importa
   - Muestre patrones seguros vs. inseguros
   - Enlace a fuentes autoritativas
   - Incluya advertencias prominentemente

### Al Revisar Contribuciones

1. **Verifique secrets expuestos**
   - Escanee patrones comunes (api_key=, password=)
   - Revise archivos de configuración
   - Verifique variables de entorno

2. **Verifique prácticas de coding seguro**
   - Sin credenciales hardcodeadas
   - Validación apropiada de inputs
   - Autenticación/autorización segura
   - Manejo seguro de archivos

3. **Testee implicaciones de seguridad**
   - ¿Esto puede ser mal utilizado?
   - ¿Cuál es el peor caso?
   - ¿Hay edge cases?

## Recursos de Seguridad

### Estándares Oficiales
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [CVSS Calculator](https://www.first.org/cvss/calculator/3.1)

### Seguridad de Python
- [Python Security Advisories](https://www.python.org/dev/security/)
- [PyPI Security](https://pypi.org/help/#security)
- [Bandit Documentation](https://bandit.readthedocs.io/)

### Gestión de Dependencias
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)
- [GitHub Security Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)

### Seguridad General
- [Anthropic Security](https://www.anthropic.com/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

## Archivo de Security Advisories

Los security advisories pasados están disponibles en la pestaña [GitHub Security Advisories](https://github.com/luongnv89/domina-claude-code/security/advisories).

## Contacto

Para preguntas relacionadas con seguridad o para discutir prácticas de seguridad:

1. **Reporte de Seguridad Privado**: Use el reporte privado de vulnerabilidades de GitHub
2. **Preguntas Generales de Seguridad**: Abra una discusión con la etiqueta `[SECURITY]`
3. **Feedback de Política de Seguridad**: Cree un issue con la etiqueta `security`

## Agradecimientos

Apreciamos a los investigadores de seguridad y miembros de la comunidad que ayudan a mantener este proyecto seguro. Los contribuidores que reportan vulnerabilidades responsablemente serán reconocidos en nuestros security advisories (a menos que prefieran anonimato).

## Actualizaciones de la Política

Esta política de seguridad es revisada y actualizada:
- Cuando se descubren nuevas vulnerabilidades
- Cuando las mejores prácticas de seguridad evolucionan
- Cuando el alcance del proyecto cambia
- Anualmente como mínimo

**Última Actualización**: Enero 2026
**Próxima Revisión**: Enero 2027

---

¡Gracias por ayudar a mantener Claude How To seguro! 🔒
