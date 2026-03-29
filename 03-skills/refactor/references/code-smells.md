# Catálogo de Code Smells

Una referencia comprehensiva de code smells basada en *Refactoring* (2da Edición) de Martin Fowler. Los code smells son síntomas de problemas más profundos—indican que algo podría estar mal con el diseño de tu código.

> "Un code smell es una indicación superficial que usualmente corresponde a un problema más profundo en el sistema." — Martin Fowler

---

## Bloaters

Code smells representando algo que ha crecido demasiado para ser manejado efectivamente.

### Método Largo

**Signos:**
- El método excede 30-50 líneas
- Necesitas hacer scroll para ver todo el método
- Múltiples niveles de anidación
- Comentarios explicando qué hacen las secciones

**Por qué es malo:**
- Difícil de entender
- Difícil de testear en aislamiento
- Los cambios tienen consecuencias no intencionadas
- Lógica duplicada se esconde dentro

**Refactorings:**
- Extract Method
- Replace Temp with Query
- Introduce Parameter Object
- Replace Method with Method Object
- Decompose Conditional

**Ejemplo (Antes):**
```javascript
function processOrder(order) {
  // Validar orden (20 líneas)
  if (!order.items) throw new Error('Sin items');
  if (order.items.length === 0) throw new Error('Orden vacía');
  // ... más validación

  // Calcular totales (30 líneas)
  let subtotal = 0;
  for (const item of order.items) {
    subtotal += item.price * item.quantity;
  }
  // ... impuestos, envío, descuentos

  // Enviar notificaciones (20 líneas)
  // ... lógica de email
}
```

**Ejemplo (Después):**
```javascript
function processOrder(order) {
  validateOrder(order);
  const totals = calculateOrderTotals(order);
  sendOrderNotifications(order, totals);
  return { order, totals };
}
```

---

### Clase Grande

**Signos:**
- La clase tiene muchas variables de instancia (>7-10)
- La clase tiene muchos métodos (>15-20)
- El nombre de la clase es vago (Manager, Handler, Processor)
- Los métodos no usan todas las variables de instancia

**Por qué es malo:**
- Viola el Principio de Responsabilidad Única
- Difícil de testear
- Los cambios se propagan a través de características no relacionadas
- Difícil de reusar partes

**Refactorings:**
- Extract Class
- Extract Subclass
- Extract Interface

**Detección:**
```
Líneas de código > 300
Número de métodos > 15
Número de campos > 10
```

---

### Obsesión Primitiva

**Signos:**
- Usar primitivos para conceptos de dominio (string para email, int para dinero)
- Arrays de primitivos en lugar de objetos
- Constantes de string para códigos de tipo
- Números/strings mágicos

**Por qué es malo:**
- Sin validación a nivel de tipo
- Lógica dispersa a través del codebase
- Fácil pasar valores incorrectos
- Faltan conceptos de dominio

**Refactorings:**
- Replace Primitive with Object
- Replace Type Code with Class
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**Ejemplo (Antes):**
```javascript
const user = {
  email: 'john@example.com',     // Solo un string
  phone: '1234567890',           // Solo un string
  status: 'active',              // String mágico
  balance: 10050                 // Centavos como entero
};
```

**Ejemplo (Después):**
```javascript
const user = {
  email: new Email('john@example.com'),
  phone: new PhoneNumber('1234567890'),
  status: UserStatus.ACTIVE,
  balance: Money.cents(10050)
};
```

---

### Lista de Parámetros Larga

**Signos:**
- Métodos con 4+ parámetros
- Parámetros que siempre aparecen juntos
- Banderas booleanas cambiando el comportamiento del método
- Null/undefined pasado frecuentemente

**Por qué es malo:**
- Difícil de llamar correctamente
- Confusión de orden de parámetros
- Indica método haciendo demasiado
- Difícil añadir nuevos parámetros

**Refactorings:**
- Introduce Parameter Object
- Preserve Whole Object
- Replace Parameter with Method Call
- Remove Flag Argument

**Ejemplo (Antes):**
```javascript
function createUser(firstName, lastName, email, phone,
                    street, city, state, zip,
                    isAdmin, isActive, createdBy) {
  // ...
}
```

**Ejemplo (Después):**
```javascript
function createUser(personalInfo, address, options) {
  // personalInfo: { firstName, lastName, email, phone }
  // address: { street, city, state, zip }
  // options: { isAdmin, isActive, createdBy }
}
```

---

### Grupos de Datos

**Signos:**
- Mismos 3+ campos aparecen juntos repetidamente
- Parámetros que siempre viajan juntos
- Clases con subconjuntos de campos perteneciendo juntos

**Por qué es malo:**
- Lógica de manejo duplicada
- Falta abstracción
- Más difícil de extender
- Indica clase oculta

**Refactorings:**
- Extract Class
- Introduce Parameter Object
- Preserve Whole Object

**Ejemplo:**
```javascript
// Grupo de datos: coordenadas (x, y, z)
function movePoint(x, y, z, dx, dy, dz) { }
function scalePoint(x, y, z, factor) { }
function distanceBetween(x1, y1, z1, x2, y2, z2) { }

// Extraer clase Point3D
class Point3D {
  constructor(x, y, z) { }
  move(delta) { }
  scale(factor) { }
  distanceTo(other) { }
}
```

---

## Abusadores de Orientación a Objetos

Smells indicando uso incompleto o incorrecto de principios OOP.

### Switch Statements

**Signos:**
- Cadenas largas de switch/case o if/else
- Mismo switch en múltiples lugares
- Switch en códigos de tipo
- Añadir nuevos casos requiere cambios en todos lados

**Por qué es malo:**
- Viola el Principio Abierto/Cerrado
- Los cambios se propagan a todas las ubicaciones de switch
- Difícil de extender
- Usualmente indica polimorfismo faltante

**Refactorings:**
- Replace Conditional with Polymorphism
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**Ejemplo (Antes):**
```javascript
function calculatePay(employee) {
  switch (employee.type) {
    case 'hourly':
      return employee.hours * employee.rate;
    case 'salaried':
      return employee.salary / 12;
    case 'commissioned':
      return employee.sales * employee.commission;
  }
}
```

**Ejemplo (Después):**
```javascript
class HourlyEmployee {
  calculatePay() {
    return this.hours * this.rate;
  }
}

class SalariedEmployee {
  calculatePay() {
    return this.salary / 12;
  }
}
```

---

### Campo Temporal

**Signos:**
- Variables de instancia solo usadas en algunos métodos
- Campos establecidos condicionalmente
- Inicialización compleja para ciertos casos

**Por qué es malo:**
- Confuso—el campo existe pero podría ser null
- Difícil de entender el estado del objeto
- Indica lógica condicional oculta

**Refactorings:**
- Extract Class
- Introduce Null Object
- Replace Temp Field with Local

---

### Legado Rehusado

**Signos:**
- La subclase no usa métodos/datos heredados
- La subclase hace override para no hacer nada
- Herencia usada para reuso de código, no relación ES-UN

**Por qué es malo:**
- Abstracción incorrecta
- Viola el Principio de Sustitución de Liskov
- Jerarquía engañosa

**Refactorings:**
- Push Down Method/Field
- Replace Subclass with Delegate
- Replace Inheritance with Delegation

---

### Clases Alternativas con Diferentes Interfaces

**Signos:**
- Dos clases que hacen cosas similares
- Diferentes nombres de métodos para mismo concepto
- Podrían usarse intercambiablemente

**Por qué es malo:**
- Implementaciones duplicadas
- Sin interfaz común
- Difícil cambiar entre ellas

**Refactorings:**
- Rename Method
- Move Method
- Extract Superclass
- Extract Interface

---

## Preventores de Cambios

Smells que hacen difíciles los cambios—cambiar una cosa requiere cambiar muchas otras.

### Cambio Divergente

**Signos:**
- Una clase cambiada por múltiples razones diferentes
- Cambios en diferentes áreas provocan ediciones de la misma clase
- La clase es una "clase dios"

**Por qué es malo:**
- Viola Responsabilidad Única
- Alta frecuencia de cambio
- Conflictos de merge

**Refactorings:**
- Extract Class
- Extract Superclass
- Extract Subclass

**Ejemplo:**
Una clase `User` cambia para:
- Cambios de autenticación
- Cambios de perfil
- Cambios de facturación
- Cambios de notificación

→ Extraer: `AuthService`, `ProfileService`, `BillingService`, `NotificationService`

---

### Cirugía de Escopeta

**Signos:**
- Un cambio requiere ediciones en muchas clases
- Pequeña característica necesita tocar 10+ archivos
- Los cambios están dispersos, difícil de encontrar todos

**Por qué es malo:**
- Fácil perder un lugar
- Alto acoplamiento
- Cambios son propensos a errores

**Refactorings:**
- Move Method
- Move Field
- Inline Class

**Detección:**
Busca: añadir un campo requiere cambios en >5 archivos.

---

### Jerarquías de Herencia Paralelas

**Signos:**
- Crear subclase en una jerarquía requiere subclase en otra
- Prefijos de clases coinciden (ej. `DatabaseOrder`, `DatabaseProduct`)

**Por qué es malo:**
- Doble el mantenimiento
- Acoplamiento entre jerarquías
- Fácil olvidar un lado

**Refactorings:**
- Move Method
- Move Field
- Eliminar una jerarquía

---

## Desechables

Algo innecesario que debería ser eliminado.

### Comentarios (Excesivos)

**Signos:**
- Comentarios explicando qué hace el código
- Código comentado
- TODO/FIXME que permanecen para siempre
- Disculpas en comentarios

**Por qué es malo:**
- Los comentarios mienten (se desactualizan)
- El código debería ser auto-documentado
- Código muerto causa confusión

**Refactorings:**
- Extract Method (el nombre explica qué)
- Rename (claridad sin comentarios)
- Eliminar código comentado
- Introduce Assertion

**Comentarios Buenos vs Malos:**
```javascript
// MALO: Explicando qué
// Loop a través de usuarios y verifica si activo
for (const user of users) {
  if (user.status === 'active') { }
}

// BUENO: Explicando por qué
// Solo usuarios activos - los inactivos son manejados por el trabajo de limpieza
const activeUsers = users.filter(u => u.isActive);
```

---

### Código Duplicado

**Signos:**
- Mismo código en múltiples lugares
- Código similar con pequeñas variaciones
- Patrones de copy-paste

**Por qué es malo:**
- Fixes de bugs necesarios en múltiples lugares
- Riesgo de inconsistencia
- Codebase inflado

**Refactorings:**
- Extract Method
- Extract Class
- Pull Up Method (en jerarquías)
- Form Template Method

**Regla de Detección:**
Cualquier código duplicado 3+ veces debería ser extraído.

---

### Clase Perezosa

**Signos:**
- La clase no hace lo suficiente para justificar su existencia
- Wrapper sin valor añadido
- Resultado de sobre-ingeniería

**Por qué es malo:**
- Carga de mantenimiento
- Indirección innecesaria
- Complejidad sin beneficio

**Refactorings:**
- Inline Class
- Collapse Hierarchy

---

### Código Muerto

**Signos:**
- Código inalcanzable
- Variables/métodos/clases no usados
- Código comentado
- Código detrás de condiciones imposibles

**Por qué es malo:**
- Confusión
- Carga de mantenimiento
- Ralentiza la comprensión

**Refactorings:**
- Remove Dead Code
- Safe Delete

**Detección:**
```bash
# Busca exports no usados
# Busca funciones no referenciadas
# Warnings "unused" del IDE
```

---

### Generalidad Especulativa

**Signos:**
- Clases abstractas con una subclase
- Parámetros no usados "para uso futuro"
- Métodos que solo delegan
- "Framework" para un caso de uso

**Por qué es malo:**
- Complejidad sin beneficio
- YAGNI (You Ain't Gonna Need It)
- Más difícil de entender

**Refactorings:**
- Collapse Hierarchy
- Inline Class
- Remove Parameter
- Rename Method

---

## Acopladores

Smells que representan acoplamiento excesivo entre clases.

### Envidia de Característica

**Signos:**
- Método usa más datos de otra clase que los suyos
- Muchas llamadas a getters a otro objeto
- Datos y comportamiento están separados

**Por qué es malo:**
- Ubicación incorrecta para comportamiento
- Pobre encapsulamiento
- Difícil de mantener

**Refactorings:**
- Move Method
- Move Field
- Extract Method (luego mover)

**Ejemplo (Antes):**
```javascript
class Order {
  getDiscountedPrice(customer) {
    // Usa datos de customer extensamente
    if (customer.loyaltyYears > 5) {
      return this.price * customer.discountRate;
    }
    return this.price;
  }
}
```

**Ejemplo (Después):**
```javascript
class Customer {
  getDiscountedPriceFor(price) {
    if (this.loyaltyYears > 5) {
      return price * this.discountRate;
    }
    return price;
  }
}
```

---

### Intimidad Inapropiada

**Signos:**
- Las clases acceden a partes privadas de cada otra
- Referencias bidireccionales
- Subclases saben demasiado sobre padres

**Por qué es malo:**
- Alto acoplamiento
- Los cambios se propagan en cascada
- Difícil modificar uno sin el otro

**Refactorings:**
- Move Method
- Move Field
- Change Bidirectional to Unidirectional
- Extract Class
- Hide Delegate

---

### Cadenas de Mensajes

**Signos:**
- Cadenas largas de llamadas a métodos: `a.getB().getC().getD().getValue()`
- Cliente depende de estructura de navegación
- Código "train wreck"

**Por qué es malo:**
- Frágil—cualquier cambio rompe la cadena
- Viola la Ley de Demeter
- Acoplamiento a estructura

**Refactorings:**
- Hide Delegates
- Extract Method
- Move Method

**Ejemplo:**
```javascript
// Malo: Cadena de mensajes
const managerName = employee.getDepartment().getManager().getName();

// Mejor: Ocultar delegación
const managerName = employee.getManagerName();
```

---

### Hombre del Medio

**Signos:**
- Clase que solo delega a otra
- La mitad de los métodos son delegaciones
- Sin valor añadido

**Por qué es malo:**
- Indirección innecesaria
- Carga de mantenimiento
- Arquitectura confusa

**Refactorings:**
- Remove Middle Man
- Inline Method

---

## Guía de Severidad de Smells

| Severidad | Descripción | Acción |
|----------|-------------|--------|
| **Crítico** | Bloquea desarrollo, causa bugs | Arreglar inmediatamente |
| **Alto** | Carga de mantenimiento significativa | Arreglar en sprint actual |
| **Medio** | Notable pero manejable | Planear para futuro cercano |
| **Bajo** | Inconveniencia menor | Arreglar oportunísticamente |

---

## Checklist de Detección Rápida

Usa este checklist cuando escanees código:

- [ ] ¿Algún método > 30 líneas?
- [ ] ¿Alguna clase > 300 líneas?
- [ ] ¿Algún método con > 4 parámetros?
- [ ] ¿Bloques de código duplicado?
- [ ] ¿Algún switch/case en códigos de tipo?
- [ ] ¿Código no usado?
- [ ] ¿Algún método usando datos de otra clase extensamente?
- [ ] ¿Cadenas largas de llamadas a métodos?
- [ ] ¿Comentarios explicando "qué" no "por qué"?
- [ ] ¿Primitivos que deberían ser objetos?

---

## Lectura Adicional

- Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2da ed.)
- Kerievsky, J. (2004). *Refactoring to Patterns*
- Feathers, M. (2004). *Working Effectively with Legacy Code*
