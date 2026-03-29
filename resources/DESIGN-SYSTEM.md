# Claude How To - Sistema de Diseño

## Identidad Visual

### Concepto de Diseño de Icono: Brújula con Corchete de Código

El icono de Claude How To usa una **brújula con un corchete de código `>`** para representar navegación guiada a través del código:

```
     N (verde)
     ▲
     │
W ───>─── E     Brújula = Guía/Dirección
     │          Corchete > = Código/Terminal/CLI
     ▼
     S (negro)
```

Esto crea:
- **Claridad Visual**: Comunica inmediatamente "guía de navegación de código"
- **Significado Simbólico**: Brújula = encontrar tu camino; `>` = código/terminal
- **Escalabilidad**: Funciona a cualquier tamaño desde 16px hasta 512px
- **Alineación de Marca**: Coincide con la estética de herramientas de desarrollador con paleta mínima

---

## Sistema de Color

### Paleta

| Color | Hex | RGB | Uso |
|-------|-----|-----|-------|
| Negro (Principal) | `#000000` | 0, 0, 0 | Trazos principales, texto, aguja sur |
| Blanco (Fondo) | `#FFFFFF` | 255, 255, 255 | Fondos claros |
| Gris (Secundario) | `#6B7280` | 107, 114, 128 | Marcas de tick menores, texto secundario |
| Verde Brillante (Acento) | `#22C55E` | 34, 197, 94 | Aguja norte, punto central, líneas de acento |
| Casi Negro (Fondo Oscuro) | `#0A0A0A` | 10, 10, 10 | Fondos de modo oscuro |

### Relaciones de Contraste (WCAG)

- Negro sobre Blanco: **21:1** AAA
- Gris sobre Blanco: **4.6:1** AA
- Verde sobre Blanco: **3.2:1** (solo decorativo, no para texto)
- Blanco sobre Oscuro: **19.5:1** AAA

### Regla de Color de Acento

**El Verde Brillante (#22C55E) está reservado solo para resaltados:**
- Aguja norte de la brújula
- Punto central
- Subrayados/bordes de acento
- Nunca como color de fondo
- Nunca para texto de cuerpo

---

## Tipografía

### Fuente del Logotipo
- **Familia**: Inter, SF Pro Display, -apple-system, Segoe UI, sans-serif
- **"Claude"**: 42px, peso 700 (negrita), Negro
- **"How-To"**: 32px, peso 500 (medio), Gris (#6B7280)
- **Subtítulo**: 10px, peso 500, Gris, espaciado de letras 1.5px, mayúsculas

### Fuente de Interfaz
- **Familia**: Inter, SF Pro, fuentes del sistema (sans-serif)
- **Peso**: 400-600
- **Estilo**: Limpio, legible

---

## Detalles del Icono

### Especificaciones de la Brújula

La marca de brújula está construida con estos elementos geométricos:

```
Elemento            | Trazo/Relleno    | Color
--------------------|------------------|------------------
Anillo exterior     | trazo 3px        | Negro / Blanco (modo oscuro)
Tick norte          | trazo 2.5px      | Negro / Blanco (modo oscuro)
Otros ticks cardinales| trazo 2px      | Gris / Blanco 50% (modo oscuro)
Ticks intercardinales| trazo 1.5px     | Gris / Blanco 40% (modo oscuro)
Aguja norte         | polígono relleno | #22C55E (siempre verde)
Aguja sur           | polígono relleno | Negro / Blanco (modo oscuro)
Corchete >          | trazo 3px        | Negro / Blanco (modo oscuro)
Punto central       | círculo relleno  | #22C55E (siempre verde)
```

### Progresión de Tamaño

```
16px  → Solo anillo + agujas + chevrón (mínimo)
32px  → Agrega marcas de tick cardinales
64px  → Agrega marcas de tick intercardinales
128px → Detalle completo, todos los elementos nítidos
256px → Máximo detalle, trazos gruesos
```

---

## Directrices de Tamaño

### Tamaño de Logotipo

- **Mínimo**: 200px de ancho (para web)
- **Recomendado**: 520px (tamaño nativo)
- **Máximo**: Ilimitado (formato vectorial)
- **Relación de Aspecto**: ~4.3:1 (ancho:alto)

### Tamaño de Icono

- **Mínimo**: 16px (favicon)
- **Recomendado**: 64-256px (apps, avatares)
- **Máximo**: Ilimitado (formato vectorial)
- **Relación de Aspecto**: 1:1 (cuadrado)

---

## Espaciado y Alineación

### Espaciado de Logotipo

```
┌─────────────────────────────────────┐
│                                     │
│        Espacio Libre Mínimo         │
│         (altura del logotipo / 2)   │
│                                     │
│    [BRÚJULA]  Claude                │
│               How-To                │
│                                     │
└─────────────────────────────────────┘
```

### Punto Central del Icono

Todos los iconos se centran en el punto medio de su lienzo:
- 128×128 para lienzo de 256px
- 64×64 para lienzo de 128px
- Mantiene alineación con otros elementos de UI

---

## Accesibilidad

### Contraste de Color
- Todo el texto cumple WCAG AA (mínimo 4.5:1)
- El acento verde es decorativo, no informativo
- Sin dependencia de color rojo-verde

### Escalabilidad
- El formato vectorial asegura claridad a cualquier tamaño
- Las formas geométricas permanecen reconocibles a 16px
- Detalle progresivo basado en el tamaño disponible

---

## Ejemplos de Aplicación

### Encabezado Web
- Tamaño: logotipo de 520×120px
- Archivo: `logos/domina-claude-code-logo.svg`
- Fondo: Blanco u oscuro (#0A0A0A)
- Relleno: 20px mínimo

### Icono de App
- Tamaño: 256×256px
- Archivo: `icons/domina-claude-code-icon.svg`
- Fondo: Blanco u oscuro
- Uso: Accesos directos de apps, avatares

### Favicon de Navegador
- Tamaño: 32px (principal), 16px (alternativa)
- Archivo: `favicons/favicon-32.svg`
- Formato: SVG para visualización nítida

### Redes Sociales
- Perfil: icono de 256×256px
- Banner: logotipo de 520×120px (centrado)

### Documentación
- Encabezados de Capítulo: Logotipo escalado para ajustar
- Iconos de Sección: favicon de 64×64px
- En línea: favicon de 32×32px

---

## Detalles de Formato de Archivo

### Estructura SVG

Todos los archivos SVG son de diseño plano:
- Sin gradientes (solo colores sólidos)
- Sin efectos de filtro (sin desenfoque, brillo o sombra)
- Geometría limpia de trazo y relleno
- ViewBox para escalado responsivo
- Código legible y comentado

### Compatibilidad entre Navegadores

- Chrome/Edge: Soporte completo
- Firefox: Soporte completo
- Safari: Soporte completo
- iOS Safari: Soporte completo
- Todos los navegadores modernos: Soporte completo

---

## Personalización

### Cambiar el Color de Acento

Para crear variantes con un acento diferente:

1. Reemplazar todas las instancias de `#22C55E` con tu color de acento
2. Asegurar que la relación de contraste se mantenga por encima de 3:1 para elementos decorativos
3. Mantener la estructura negro/blanco/gris sin cambios

### Escalado

```css
svg {
  width: 256px;
  height: 256px;
}
```

Los SVG escalan automáticamente vía viewBox — no se necesitan transformaciones.

---

## Control de Versiones

Seguimiento de cambios de diseño en git:
- Versionar archivos SVG normalmente (son texto)
- Etiquetar lanzamientos con cambios de diseño
- Incluir DESIGN-SYSTEM.md en commits

---

**Última Actualización**: Febrero 2026
**Versión del Sistema de Diseño**: 3.0
