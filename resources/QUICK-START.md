# Inicio Rápido - Activos de Marca

## Copiar Activos a Tu Proyecto

```bash
# Copiar todos los recursos a tu proyecto web
cp -r resources/ /path/to/your/website/

# O solo los favicons para web
cp resources/favicons/* /path/to/your/website/public/
```

## Agregar a HTML (Copiar y Pegar)

```html
<!-- Favicons -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
<meta name="theme-color" content="#000000">
```

## Usar en Markdown/Documentación

```markdown
# Claude How To

![Logotipo de Claude How To](resources/logos/domina-claude-code-logo.svg)

![Icono](resources/icons/domina-claude-code-icon.svg)
```

## Tamaños Recomendados

| Propósito | Tamaño | Archivo |
|---------|------|------|
| Encabezado de sitio web | 520×120 | `logos/domina-claude-code-logo.svg` |
| Icono de app | 256×256 | `icons/domina-claude-code-icon.svg` |
| Pestaña de navegador | 32×32 | `favicons/favicon-32.svg` |
| Pantalla de inicio móvil | 128×128 | `favicons/favicon-128.svg` |
| App de escritorio | 256×256 | `favicons/favicon-256.svg` |
| Avatar pequeño | 64×64 | `favicons/favicon-64.svg` |

## Valores de Color

```css
/* Usar estos en tu CSS */
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

## Significado del Diseño del Icono

**Brújula con Corchete de Código**:
- Anillo de brújula = Navegación, ruta de aprendizaje estructurada
- Aguja norte verde = Dirección, progreso, guía
- Aguja sur negra = Fundamento, base sólida
- Corchete `>` = Prompt de terminal, código, contexto CLI
- Marcas de tick = Precisión, pasos estructurados

Esto simboliza "encontrar tu camino a través del código con guía clara."

## Qué Usar y Dónde

### Sitio Web
- **Encabezado**: Logotipo (`logos/domina-claude-code-logo.svg`)
- **Favicon**: 32px (`favicons/favicon-32.svg`)
- **Vista previa social**: Icono (`icons/domina-claude-code-icon.svg`)

### GitHub
- **Badge de README**: Icono (`icons/domina-claude-code-icon.svg`) a 64-128px
- **Avatar de repositorio**: Icono (`icons/domina-claude-code-icon.svg`)

### Redes Sociales
- **Imagen de perfil**: Icono (`icons/domina-claude-code-icon.svg`)
- **Banner**: Logotipo (`logos/domina-claude-code-logo.svg`)
- **Miniatura**: Icono a 256×256px

### Documentación
- **Encabezados de capítulo**: Logotipo o icono (escalado para ajustar)
- **Iconos de navegación**: Favicon (32-64px)

---

Ver [README.md](README.md) para documentación completa.
