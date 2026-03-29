<picture>
  <source media="(prefers-color-scheme: dark)" srcset="logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="logos/claude-howto-logo.svg">
</picture>

# Claude How To - Activos de Marca

Colección completa de logotipos, iconos y favicons para el proyecto Claude How To. Todos los activos usan el diseño V3.0: una brújula con símbolo de corchete de código (`>`), que representa navegación guiada a través del código — usando una paleta Negro/Blanco/Gris con acento Verde Brillante (#22C55E).

## Estructura del Directorio

```
resources/
├── logos/
│   ├── claude-howto-logo.svg       # Logotipo principal - Modo claro (520×120px)
│   └── claude-howto-logo-dark.svg  # Logotipo principal - Modo oscuro (520×120px)
├── icons/
│   ├── claude-howto-icon.svg       # Icono de app - Modo claro (256×256px)
│   └── claude-howto-icon-dark.svg  # Icono de app - Modo oscuro (256×256px)
└── favicons/
    ├── favicon-16.svg              # Favicon - 16×16px
    ├── favicon-32.svg              # Favicon - 32×32px (principal)
    ├── favicon-64.svg              # Favicon - 64×64px
    ├── favicon-128.svg             # Favicon - 128×128px
    └── favicon-256.svg             # Favicon - 256×256px
```

Activos adicionales en `assets/logo/`:
```
assets/logo/
├── logo-full.svg       # Marca + logotipo (horizontal)
├── logo-mark.svg       # Símbolo de brújula solamente (120×120px)
├── logo-wordmark.svg   # Texto solamente
├── logo-icon.svg       # Icono de app (512×512, redondeado)
├── favicon.svg         # 16×16 optimizado
├── logo-white.svg      # Versión blanca para fondos oscuros
└── logo-black.svg      # Versión monocromática negra
```

## Descripción de Activos

### Concepto de Diseño (V3.0)

**Brújula con Corchete de Código** — guía encuentra código:
- **Anillo de Brújula** = Navegación, encontrar tu camino
- **Aguja Norte (Verde)** = Dirección, progreso en la ruta de aprendizaje
- **Aguja Sur (Negro)** = Fundamento, base sólida
- **Corchete `>`** = Prompt de terminal, código, contexto CLI
- **Marcas de Tick** = Precisión, aprendizaje estructurado

### Logotipos

**Archivos**:
- `logos/claude-howto-logo.svg` (Modo claro)
- `logos/claude-howto-logo-dark.svg` (Modo oscuro)

**Especificaciones**:
- **Tamaño**: 520×120 px
- **Propósito**: Logotipo principal de encabezado/marca con wordmark
- **Uso**:
  - Encabezados de sitios web
  - Badges de README
  - Materiales de marketing
  - Materiales impresos
- **Formato**: SVG (totalmente escalable)
- **Modos**: Claro (fondo blanco) y Oscuro (fondo #0A0A0A)

### Iconos

**Archivos**:
- `icons/claude-howto-icon.svg` (Modo claro)
- `icons/claude-howto-icon-dark.svg` (Modo oscuro)

**Especificaciones**:
- **Tamaño**: 256×256 px
- **Propósito**: Icono de aplicación, avatares, miniaturas
- **Uso**:
  - Iconos de apps
  - Avatares de perfil
  - Miniaturas de redes sociales
  - Encabezados de documentación
- **Formato**: SVG (totalmente escalable)
- **Modos**: Claro (fondo blanco) y Oscuro (fondo #0A0A0A)

**Elementos de Diseño**:
- Anillo de brújula con marcas de tick cardinales e intercardinales
- Aguja norte verde (dirección/guía)
- Aguja sur negra (fundamento)
- Corchete de código `>` en el centro (terminal/CLI)
- Acento de punto central verde

### Favicons

Versiones optimizadas en múltiples tamaños para uso web:

| Archivo | Tamaño | DPI | Uso |
|------|------|-----|-------|
| `favicon-16.svg` | 16×16 px | 1x | Pestañas de navegador (navegadores antiguos) |
| `favicon-32.svg` | 32×32 px | 1x | Favicon estándar de navegador |
| `favicon-64.svg` | 64×64 px | 1x-2x | Pantallas de alta densidad (High-DPI) |
| `favicon-128.svg` | 128×128 px | 2x | Icono táctil de Apple, marcadores |
| `favicon-256.svg` | 256×256 px | 4x | Navegadores modernos, iconos PWA |

**Notas de Optimización**:
- 16px: Geometría mínima — solo anillo, agujas, chevrón
- 32px: Agrega marcas de tick cardinales
- 64px+: Detalle completo con ticks intercardinales
- Todos mantienen consistencia visual con el icono principal
- El formato SVG asegura visualización nítida a cualquier tamaño

## Integración HTML

### Configuración Básica de Favicon

```html
<!-- Favicon de navegador -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

<!-- Icono táctil de Apple (pantalla de inicio móvil) -->
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

<!-- PWA y navegadores modernos -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
```

### Configuración Completa

```html
<head>
  <!-- Favicon principal -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

  <!-- Icono táctil de Apple -->
  <link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

  <!-- Iconos PWA -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">

  <!-- Android -->
  <link rel="shortcut icon" href="/resources/favicons/favicon-256.svg">

  <!-- Referencia de manifiesto PWA (si se usa manifest.json) -->
  <meta name="theme-color" content="#000000">
</head>
```

## Paleta de Colores

### Colores Principales
- **Negro**: `#000000` (Texto principal, trazos, aguja sur)
- **Blanco**: `#FFFFFF` (Fondos claros)
- **Gris**: `#6B7280` (Texto secundario, marcas de tick menores)

### Color de Acento
- **Verde Brillante**: `#22C55E` (Aguja norte, punto central, líneas de acento — solo resaltados, nunca como fondo)

### Modo Oscuro
- **Fondo**: `#0A0A0A` (Casi negro)

### Variables CSS
```css
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

### Configuración Tailwind
```js
colors: {
  brand: {
    primary: '#000000',
    secondary: '#6B7280',
    accent: '#22C55E',
  }
}
```

### Directrices de Uso
- Usar negro para texto principal y elementos estructurales
- Usar gris para elementos secundarios/de soporte
- Usar verde **solo** para resaltados — aguja, puntos, líneas de acento
- Nunca usar verde como color de fondo
- Mantener contraste WCAG AA (mínimo 4.5:1)

## Directrices de Diseño

### Uso del Logotipo
- Usar sobre fondos blancos u oscuros (#0A0A0A)
- Escalar proporcionalmente
- Incluir espacio libre alrededor del logotipo (mínimo: altura del logotipo / 2)
- Usar variantes claras/oscuras proporcionadas para fondos apropiados

### Uso de Iconos
- Usar en tamaños estándar: 16, 32, 64, 128, 256px
- Mantener las proporciones de la brújula
- Escalar proporcionalmente

### Uso de Favicons
- Usar el tamaño apropiado para el contexto
- 16-32px: Pestañas de navegador, marcadores
- 64px: Iconos de sitio de favicon
- 128px+: Pantallas de inicio de Apple/Android

## Optimización SVG

Todos los archivos SVG son de diseño plano sin gradientes ni filtros:
- Geometría limpia basada en trazos
- Sin rásters incrustados
- Rutas optimizadas
- ViewBox responsivo

Para optimización web:
```bash
# Comprimir SVG manteniendo la calidad
svgo --config='{
  "js2svg": {
    "indent": 2
  },
  "plugins": [
    "convertStyleToAttrs",
    "removeRasterImages"
  ]
}' input.svg -o output.svg
```

## Conversión a PNG

Para convertir SVG a PNG para soporte de navegadores antiguos:

```bash
# Usando ImageMagick
convert -density 300 -background none favicon-256.svg favicon-256.png

# Usando Inkscape
inkscape -D -z --file=favicon-256.svg --export-png=favicon-256.png
```

## Accesibilidad

- Relaciones de color de alto contraste (cumple WCAG AA — mínimo 4.5:1)
- Formas geométricas limpias reconocibles a todos los tamaños
- Formato de vector escalable
- Sin texto en iconos (texto agregado por separado en wordmark)
- Sin dependencia de color rojo-verde para significado

## Atribución

Estos activos son parte del proyecto Claude How To.

**Licencia**: MIT (ver archivo LICENSE del proyecto)

## Historial de Versiones

- **v3.0** (febrero 2026): Diseño de brújula-corchete con paleta Negro/Blanco/Gris + acento Verde
- **v2.0** (enero 2026): Diseño de explosión estelar de 12 rayos inspirado en Claude con paleta esmeralda
- **v1.0** (enero 2026): Diseño original de icono de progresión basado en hexágono

---

**Última Actualización**: Febrero 2026
**Versión Actual**: 3.0 (Brújula-Corchete)
**Todos los Activos**: SVG listos para producción, totalmente escalables, accesibles WCAG AA
