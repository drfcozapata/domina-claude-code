# Guía de Testing

Este documento describe la infraestructura de testing para Claude How To.

## Overview

El proyecto usa GitHub Actions para ejecutar tests automáticamente en cada push y pull request. Los tests cubren:

- **Unit Tests**: Tests de Python usando pytest
- **Code Quality**: Linting y formateo con Ruff
- **Security**: Escaneo de vulnerabilidades con Bandit
- **Type Checking**: Análisis de tipos estático con mypy
- **Build Verification**: Test de generación de EPUB

## Ejecutar Tests Localmente

### Prerequisites

```bash
# Instalar uv (gestor de paquetes rápido para Python)
pip install uv

# O en macOS con Homebrew
brew install uv
```

### Setup Environment

```bash
# Clonar el repositorio
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# Crear entorno virtual
uv venv

# Activarlo
source .venv/bin/activate  # macOS/Linux
# o
.venv\Scripts\activate     # Windows

# Instalar dependencias de desarrollo
uv pip install -r requirements-dev.txt
```

### Ejecutar Tests

```bash
# Ejecutar todos los unit tests
pytest scripts/tests/ -v

# Ejecutar tests con coverage
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# Ejecutar un archivo de test específico
pytest scripts/tests/test_build_epub.py -v

# Ejecutar una función de test específica
pytest scripts/tests/test_build_epub.py::test_function_name -v

# Ejecutar tests en modo watch (requiere pytest-watch)
ptw scripts/tests/
```

### Ejecutar Linting

```bash
# Verificar formateo de código
ruff format --check scripts/

# Auto-corregir problemas de formateo
ruff format scripts/

# Ejecutar linter
ruff check scripts/

# Auto-corregir problemas del linter
ruff check --fix scripts/
```

### Ejecutar Escaneo de Seguridad

```bash
# Ejecutar escaneo de seguridad Bandit
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# Generar reporte en JSON
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/ -f json -o bandit-report.json
```

### Ejecutar Type Checking

```bash
# Verificar tipos con mypy
mypy scripts/ --ignore-missing-imports --no-implicit-optional
```

## Workflow de GitHub Actions

### Activado En

- **Push** a las ramas `main` o `develop` (cuando cambian los scripts)
- **Pull Request** a `main` (cuando cambian los scripts)
- Ejecución manual del workflow

### Jobs

#### 1. Unit Tests (pytest)

- **Se ejecuta en**: Ubuntu latest
- **Versiones de Python**: 3.10, 3.11, 3.12
- **Qué hace**:
  - Instala dependencias desde `requirements-dev.txt`
  - Ejecuta pytest con reporte de coverage
  - Sube coverage a Codecov
  - Archiva resultados de tests y HTML de coverage

**Resultado**: Si algún test falla, el workflow falla (crítico)

#### 2. Code Quality (Ruff)

- **Se ejecuta en**: Ubuntu latest
- **Versión de Python**: 3.11
- **Qué hace**:
  - Verifica formateo de código con `ruff format`
  - Ejecuta linter con `ruff check`
  - Reporta problemas pero no falla el workflow

**Resultado**: No bloqueante (solo advertencia)

#### 3. Security Scan (Bandit)

- **Se ejecuta en**: Ubuntu latest
- **Versión de Python**: 3.11
- **Qué hace**:
  - Escanea vulnerabilidades de seguridad
  - Genera reporte en JSON
  - Sube el reporte como artifact

**Resultado**: No bloqueante (solo advertencia)

#### 4. Type Checking (mypy)

- **Se ejecuta en**: Ubuntu latest
- **Versión de Python**: 3.11
- **Qué hace**:
  - Realiza análisis de tipos estático
  - Reporta inconsistencias de tipos
  - Ayuda a detectar bugs temprano

**Resultado**: No bloqueante (solo advertencia)

#### 5. Build EPUB

- **Se ejecuta en**: Ubuntu latest
- **Depende de**: pytest, lint, security (todos deben pasar)
- **Qué hace**:
  - Construye el archivo EPUB usando `scripts/build_epub.py`
  - Verifica que el EPUB se creó exitosamente
  - Sube EPUB como artifact

**Resultado**: Si el build falla, el workflow falla (crítico)

#### 6. Summary

- **Se ejecuta en**: Ubuntu latest
- **Depende de**: Todos los demás jobs
- **Qué hace**:
  - Genera resumen del workflow
  - Lista todos los artifacts
  - Reporta estado general

## Escribir Tests

### Estructura de Tests

Los tests deben colocarse en `scripts/tests/` con nombres como `test_*.py`:

```python
# scripts/tests/test_example.py
import pytest
from scripts.example_module import some_function

def test_basic_functionality():
    """Test that some_function works correctly."""
    result = some_function("input")
    assert result == "expected_output"

def test_error_handling():
    """Test that some_function handles errors gracefully."""
    with pytest.raises(ValueError):
        some_function("invalid_input")

@pytest.mark.asyncio
async def test_async_function():
    """Test async functions."""
    result = await async_function()
    assert result is not None
```

### Mejores Prácticas para Tests

- **Usar nombres descriptivos**: `test_function_returns_correct_value()`
- **Una aserción por test** (cuando sea posible): Más fácil depurar fallos
- **Usar fixtures** para setup reutilizable: Ver `scripts/tests/conftest.py`
- **Mockear servicios externos**: Usar `unittest.mock` o `pytest-mock`
- **Testear casos borde**: Inputs vacíos, valores None, errores
- **Mantener tests rápidos**: Evitar sleep() e I/O externo
- **Usar marcadores pytest**: `@pytest.mark.slow` para tests lentos

### Fixtures

Los fixtures comunes están definidos en `scripts/tests/conftest.py`:

```python
# Usar fixtures en tus tests
def test_something(tmp_path):
    """tmp_path fixture provides temporary directory."""
    test_file = tmp_path / "test.txt"
    test_file.write_text("content")
    assert test_file.read_text() == "content"
```

## Reportes de Coverage

### Coverage Local

```bash
# Generar reporte de coverage
pytest scripts/tests/ --cov=scripts --cov-report=html

# Abrir el reporte de coverage en tu navegador
open htmlcov/index.html
```

### Objetivos de Coverage

- **Coverage mínimo**: 80%
- **Branch coverage**: Habilitado
- **Áreas de enfoque**: Funcionalidad core y paths de error

## Pre-commit Hooks

El proyecto usa pre-commit hooks para ejecutar checks automáticamente antes de los commits:

```bash
# Instalar pre-commit hooks
pre-commit install

# Ejecutar hooks manualmente
pre-commit run --all-files

# Saltar hooks para un commit (no recomendado)
git commit --no-verify
```

Hooks configurados en `.pre-commit-config.yaml`:
- Ruff formatter
- Ruff linter
- Bandit security scanner
- Validación YAML
- Checks de tamaño de archivo
- Detección de conflictos de merge

## Troubleshooting

### Tests Pasan Localmente pero Fallan en CI

Causas comunes:
1. **Diferencia de versión de Python**: CI usa 3.10, 3.11, 3.12
2. **Dependencias faltantes**: Actualizar `requirements-dev.txt`
3. **Diferencias de plataforma**: Separadores de path, variables de entorno
4. **Tests flaky**: Tests que dependen de timing u orden

Solución:
```bash
# Testear con las mismas versiones de Python
uv python install 3.10 3.11 3.12

# Testear con entorno limpio
rm -rf .venv
uv venv
uv pip install -r requirements-dev.txt
pytest scripts/tests/
```

### Bandit Reporta Falsos Positivos

Algunas advertencias de seguridad pueden ser falsos positivos. Configurar en `pyproject.toml`:

```toml
[tool.bandit]
exclude_dirs = ["scripts/tests"]
skips = ["B101"]  # Saltar advertencia assert_used
```

### Type Checking Demasiado Estricto

Relajar type checking para archivos específicos:

```python
# Agregar al inicio del archivo
# type: ignore

# O para líneas específicas
some_dynamic_code()  # type: ignore
```

## Mejores Prácticas de Continuous Integration

1. **Mantener tests rápidos**: Cada test debe completarse en <1 segundo
2. **No testear APIs externas**: Mockear servicios externos
3. **Testear en aislamiento**: Cada test debe ser independiente
4. **Usar aserciones claras**: `assert x == 5` no `assert x`
5. **Manejar tests async**: Usar `@pytest.mark.asyncio`
6. **Generar reportes**: Coverage, seguridad, type checking

## Resources

- [pytest Documentation](https://docs.pytest.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Bandit Documentation](https://bandit.readthedocs.io/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Contribuir Tests

Al enviar un PR:

1. **Escribir tests** para nueva funcionalidad
2. **Ejecutar tests localmente**: `pytest scripts/tests/ -v`
3. **Verificar coverage**: `pytest scripts/tests/ --cov=scripts`
4. **Ejecutar linting**: `ruff check scripts/`
5. **Escaneo de seguridad**: `bandit -r scripts/ --exclude scripts/tests/`
6. **Actualizar documentación** si los tests cambian

¡Los tests son requeridos para todos los PRs! 🧪

---

Para preguntas o issues con testing, abre un GitHub issue o discusión.
