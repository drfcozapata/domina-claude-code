<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/domina-claude-code-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/domina-claude-code-logo.svg">
</picture>

# Script de Construcción de EPUB

Construye un libro electrónico en formato EPUB a partir de los archivos markdown de Claude How-To.

## Características

- Organiza los capítulos por estructura de carpetas (01-slash-commands, 02-memory, etc.)
- Renderiza diagramas Mermaid como imágenes PNG mediante la API de Kroki.io
- Obtención asíncrona concurrente - renderiza todos los diagramas en paralelo
- Genera una imagen de portada a partir del logotipo del proyecto
- Convierte enlaces internos de markdown a referencias de capítulos EPUB
- Modo de error estricto - falla si no se puede renderizar algún diagrama

## Requisitos

- Python 3.10+
- [uv](https://github.com/astral-sh/uv)
- Conexión a Internet para el renderizado de diagramas Mermaid

## Inicio Rápido

```bash
# La forma más simple - uv se encarga de todo
uv run scripts/build_epub.py
```

## Configuración de Desarrollo

```bash
# Crear entorno virtual
uv venv

# Activar e instalar dependencias
source .venv/bin/activate
uv pip install -r requirements-dev.txt

# Ejecutar pruebas
pytest scripts/tests/ -v

# Ejecutar el script
python scripts/build_epub.py
```

## Opciones de Línea de Comandos

```
usage: build_epub.py [-h] [--root ROOT] [--output OUTPUT] [--verbose]
                     [--timeout TIMEOUT] [--max-concurrent MAX_CONCURRENT]

options:
  -h, --help            show this help message and exit
  --root, -r ROOT       Root directory (default: repo root)
  --output, -o OUTPUT   Output path (default: domina-claude-code-guide.epub)
  --verbose, -v         Enable verbose logging
  --timeout TIMEOUT     API timeout in seconds (default: 30)
  --max-concurrent N    Max concurrent requests (default: 10)
```

## Ejemplos

```bash
# Construir con salida detallada
uv run scripts/build_epub.py --verbose

# Ubicación de salida personalizada
uv run scripts/build_epub.py --output ~/Desktop/claude-guide.epub

# Limitar solicitudes concurrentes (si hay limitación de tasa)
uv run scripts/build_epub.py --max-concurrent 5
```

## Salida

Crea `domina-claude-code-guide.epub` en el directorio raíz del repositorio.

El EPUB incluye:
- Imagen de portada con el logotipo del proyecto
- Tabla de contenidos con secciones anidadas
- Todo el contenido markdown convertido a HTML compatible con EPUB
- Diagramas Mermaid renderizados como imágenes PNG

## Ejecución de Pruebas

```bash
# Con entorno virtual
source .venv/bin/activate
pytest scripts/tests/ -v

# O directamente con uv
uv run --with pytest --with pytest-asyncio \
    --with ebooklib --with markdown --with beautifulsoup4 \
    --with httpx --with pillow --with tenacity \
    pytest scripts/tests/ -v
```

## Dependencias

Gestionadas mediante metadatos en línea de script PEP 723:

| Paquete | Propósito |
|---------|---------|
| `ebooklib` | Generación de EPUB |
| `markdown` | Conversión de Markdown a HTML |
| `beautifulsoup4` | Análisis de HTML |
| `httpx` | Cliente HTTP asíncrono |
| `pillow` | Generación de imagen de portada |
| `tenacity` | Lógica de reintentos |

## Solución de Problemas

**La construcción falla con error de red**: Verifica la conectividad a Internet y el estado de Kroki.io. Intenta con `--timeout 60`.

**Limitación de tasa**: Reduce las solicitudes concurrentes con `--max-concurrent 3`.

**Logotipo faltante**: El script genera una portada solo con texto si no se encuentra `domina-claude-code-logo.png`.
