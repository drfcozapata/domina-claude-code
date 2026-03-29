# Reglas de Código Limpio para Generación de Código con IA

Estas reglas guían la generación de código para producir código de calidad profesional y mantenible.

## Nombres Significativos
- Usar nombres que revelen la intención y expliquen por qué algo existe
- Evitar desinformación y distinciones sin significado (e.g., `data`, `info`, `manager`)
- Usar nombres pronunciables y buscables
- Nombres de clases: sustantivos (e.g., `UserAccount`, `PaymentProcessor`)
- Nombres de métodos: verbos (e.g., `calculateTotal`, `sendEmail`)
- Evitar mapeo mental y codificaciones (notación Húngara, prefijos)

## Funciones
- Mantener las funciones pequeñas (< 20 líneas ideal)
- Hacer una sola cosa - Principio de Responsabilidad Única
- Un nivel de abstracción por función
- Limitar argumentos: 0-2 ideal, 3 máximo, evitar argumentos bandera
- Sin efectos secundarios - la función debe hacer lo que su nombre indica
- Separar comandos (cambian estado) de consultas (retornan información)
- Preferir excepciones sobre códigos de error

## Comentarios
- El código debe ser autoexplicativo - evitar comentarios cuando sea posible
- Buenos comentarios: información legal, advertencias, TODOs, documentación de API pública
- Malos comentarios: redundantes, engañosos, o que explican código malo
- Nunca comentar código - eliminarlo (el control de versiones preserva el historial)
- Si necesitas un comentario, considera refactorizar el código en su lugar

## Formato
- Mantener archivos pequeños y enfocados
- Formato vertical: conceptos relacionados cercanos, líneas en blanco separan conceptos
- Formato horizontal: limitar longitud de línea (80-120 caracteres)
- Usar indentación consistente y estilo del equipo
- Agrupar funciones relacionadas juntas

## Objetos y Estructuras de Datos
- Objetos: ocultar datos detrás de abstracciones, exponer comportamiento mediante métodos
- Estructuras de datos: exponer datos, tener comportamiento mínimo
- Ley de Demeter: solo hablar con amigos inmediatos, evitar `a.getB().getC().doSomething()`
- No exponer estructura interna mediante getters/setters ciegamente

## Manejo de Errores
- Usar excepciones, no códigos de retorno o banderas de error
- Escribir `try-catch-finally` primero cuando el código pueda fallar
- Proveer contexto en mensajes de excepción
- No retornar `null` - retornar colecciones vacías o usar Optional/Maybe
- No pasar `null` como argumentos

## Clases
- Clases pequeñas: medidas por responsabilidades, no por líneas
- Principio de Responsabilidad Única: una razón para cambiar
- Alta cohesión: variables de clase usadas por muchos métodos
- Bajo acoplamiento: dependencias mínimas entre clases
- Principio Abierto/Cerrado: abierto para extensión, cerrado para modificación

## Pruebas Unitarias
- Rápidas, Independientes, Repetibles, Auto-validadas, Oportunas (F.I.R.S.T.)
- Un assert por prueba (o un concepto)
- Calidad del código de prueba igual a calidad del código de producción
- Nombres de pruebas legibles que describan qué se está probando
- Patrón Arrange-Act-Assert

## Principios de Calidad de Código
- **DRY (Don't Repeat Yourself)**: Sin duplicación
- **YAGNI (You Aren't Gonna Need It)**: No construir para futuros hipotéticos
- **KISS (Keep It Simple)**: Evitar complejidad innecesaria
- **Regla del Boy Scout**: Dejar el código más limpio de como lo encontraste

## Code Smells a Evitar
- Funciones o clases largas
- Código duplicado
- Código muerto (variables, funciones, parámetros no usados)
- Envidia de características (método más interesado en otra clase)
- Intimidad inapropiada (clases sabiendo demasiado una de otra)
- Listas largas de parámetros
- Obsesión por primitivos (uso excesivo de primitivos en lugar de objetos pequeños)
- Sentencias switch/case (considerar polimorfismo)
- Campos temporales (variables de clase usadas solo a veces)

## Concurrencia
- Mantener código concurrente separado de otro código
- Limitar alcance de datos sincronizados/bloqueados
- Usar colecciones thread-safe
- Mantener secciones sincronizadas pequeñas
- Conocer modelos de ejecución y primitivas

## Diseño del Sistema
- Separar construcción de uso (inyección de dependencias)
- Usar factories, builders para creación compleja de objetos
- Programar a interfaces, no a implementaciones
- Favorecer composición sobre herencia
- Aplicar design patterns cuando simplifiquen, no para presumir

## Refactoring
- Refactorizar continuamente, no en lotes grandes
- Siempre tener pruebas pasando antes y después
- Pasos pequeños: un cambio a la vez
- Refactorizaciones comunes: Extract Method, Rename, Move, Inline

## Documentación
- Código auto-documentado > comentarios > documentación externa
- APIs públicas necesitan documentación clara
- Incluir ejemplos en documentación
- Mantener docs cerca del código (idealmente en el código)

---

**Filosofía Central**: El código se lee 10x más de lo que se escribe. Optimizar para legibilidad y mantenibilidad, no para astucia.
