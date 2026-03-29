# Catálogo de Refactoring

Un catálogo curado de técnicas de refactoring de *Refactoring* (2da Edición) de Martin Fowler. Cada refactoring incluye motivación, mecánicas paso a paso, y ejemplos.

> "Un refactoring se define por sus mecánicas—la secuencia precisa de pasos que sigues para llevar a cabo el cambio." — Martin Fowler

---

## Cómo Usar Este Catálogo

1. **Identifica el smell** usando la referencia de code smells
2. **Encuentra el refactoring coincidente** en este catálogo
3. **Sigue las mecánicas** paso a paso
4. **Testea después de cada paso** para asegurar que el comportamiento se preserva

**Regla de Oro**: Si algún paso toma más de 10 minutos, divídelo en pasos más pequeños.

---

## Refactorings Más Comunes

### Extract Method

**Cuándo usar**: Método largo, código duplicado, necesidad de nombrar un concepto

**Motivación**: Convierte un fragmento de código en un método cuyo nombre explica el propósito.

**Mecánicas**:
1. Crea un nuevo método nombrado por lo que hace (no cómo)
2. Copia el fragmento de código en el nuevo método
3. Escanea variables locales usadas en el fragmento
4. Pasa variables locales como parámetros (o declara en el método)
5. Maneja valores de retorno apropiadamente
6. Reemplaza el fragmento original con una llamada al nuevo método
7. Testea

**Antes**:
```javascript
function printOwing(invoice) {
  let outstanding = 0;

  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");

  // Calcular pendiente
  for (const order of invoice.orders) {
    outstanding += order.amount;
  }

  // Imprimir detalles
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

**Después**:
```javascript
function printOwing(invoice) {
  printBanner();
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice, outstanding);
}

function printBanner() {
  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");
}

function calculateOutstanding(invoice) {
  return invoice.orders.reduce((sum, order) => sum + order.amount, 0);
}

function printDetails(invoice, outstanding) {
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

---

### Inline Method

**Cuándo usar**: El cuerpo del método es tan claro como su nombre, delegación excesiva

**Motivación**: Elimina indirección innecesaria cuando el método no añade valor.

**Mecánicas**:
1. Verifica que el método no sea polimórfico
2. Encuentra todas las llamadas al método
3. Reemplaza cada llamada con el cuerpo del método
4. Testea después de cada reemplazo
5. Elimina la definición del método

**Antes**:
```javascript
function getRating(driver) {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
  return driver.numberOfLateDeliveries > 5;
}
```

**Después**:
```javascript
function getRating(driver) {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

---

### Extract Variable

**Cuándo usar**: Expresión compleja difícil de entender

**Motivación**: Da un nombre a una pieza de una expresión compleja.

**Mecánicas**:
1. Asegura que la expresión no tenga efectos secundarios
2. Declara una variable inmutable
3. Establécela al resultado de la expresión (o parte)
4. Reemplaza la expresión original con la variable
5. Testea

**Antes**:
```javascript
return order.quantity * order.itemPrice -
  Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
  Math.min(order.quantity * order.itemPrice * 0.1, 100);
```

**Después**:
```javascript
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
const shipping = Math.min(basePrice * 0.1, 100);
return basePrice - quantityDiscount + shipping;
```

---

### Inline Variable

**Cuándo usar**: El nombre de la variable no comunica más que la expresión

**Motivación**: Elimina indirección innecesaria.

**Mecánicas**:
1. Verifica que el lado derecho no tenga efectos secundarios
2. Si la variable no es inmutable, hazla inmutable y testea
3. Encuentra la primera referencia y reemplaza con la expresión
4. Testea
5. Repite para todas las referencias
6. Elimina la declaración y asignación
7. Testea

---

### Rename Variable

**Cuándo usar**: El nombre no comunica claramente el propósito

**Motivación**: Buenos nombres son cruciales para código limpio.

**Mecánicas**:
1. Si la variable es ampliamente usada, considera encapsular
2. Encuentra todas las referencias
3. Cambia cada referencia
4. Testea

**Consejos**:
- Usa nombres que revelen intención
- Evita abreviaciones
- Usa terminología de dominio

```javascript
// Malo
const d = 30;
const x = users.filter(u => u.a);

// Bueno
const daysSinceLastLogin = 30;
const activeUsers = users.filter(user => user.isActive);
```

---

### Change Function Declaration

**Cuándo usar**: El nombre de la función no explica el propósito, los parámetros necesitan cambio

**Motivación**: Buenos nombres de funciones hacen el código auto-documentado.

**Mecánicas (Simple)**:
1. Elimina parámetros no necesarios
2. Cambia el nombre
3. Añade parámetros necesarios
4. Testea

**Mecánicas (Migración - para cambios complejos)**:
1. Si eliminas parámetro, asegúrate de que no se usa
2. Crea nueva función con la declaración deseada
3. Haz que la función vieja llame a la nueva función
4. Testea
5. Cambia los llamadores para usar la nueva función
6. Testea después de cada uno
7. Elimina la función vieja

**Antes**:
```javascript
function circum(radius) {
  return 2 * Math.PI * radius;
}
```

**Después**:
```javascript
function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

---

### Encapsulate Variable

**Cuándo usar**: Acceso directo a datos desde múltiples lugares

**Motivación**: Proporciona un punto de acceso claro para manipulación de datos.

**Mecánicas**:
1. Crea funciones getter y setter
2. Encuentra todas las referencias
3. Reemplaza lecturas con getter
4. Reemplaza escrituras con setter
5. Testea después de cada cambio
6. Restringe visibilidad de la variable

**Antes**:
```javascript
let defaultOwner = { firstName: "Martin", lastName: "Fowler" };

// Usado en muchos lugares
spaceship.owner = defaultOwner;
```

**Después**:
```javascript
let defaultOwnerData = { firstName: "Martin", lastName: "Fowler" };

function defaultOwner() { return defaultOwnerData; }
function setDefaultOwner(arg) { defaultOwnerData = arg; }

spaceship.owner = defaultOwner();
```

---

### Introduce Parameter Object

**Cuándo usar**: Varios parámetros que frecuentemente van juntos

**Motivación**: Agrupa datos que naturalmente pertenecen juntos.

**Mecánicas**:
1. Crea una nueva clase/estructura para los parámetros agrupados
2. Testea
3. Usa Change Function Declaration para añadir el nuevo objeto
4. Testea
5. Para cada parámetro en el grupo, elimínalo de la función y usa el nuevo objeto
6. Testea después de cada uno

**Antes**:
```javascript
function amountInvoiced(startDate, endDate) { ... }
function amountReceived(startDate, endDate) { ... }
function amountOverdue(startDate, endDate) { ... }
```

**Después**:
```javascript
class DateRange {
  constructor(start, end) {
    this.start = start;
    this.end = end;
  }
}

function amountInvoiced(dateRange) { ... }
function amountReceived(dateRange) { ... }
function amountOverdue(dateRange) { ... }
```

---

### Combine Functions into Class

**Cuándo usar**: Varias funciones operan sobre los mismos datos

**Motivación**: Agrupa funciones con los datos sobre los que operan.

**Mecánicas**:
1. Aplica Encapsulate Record a los datos comunes
2. Mueve cada función a la clase
3. Testea después de cada movimiento
4. Reemplaza argumentos de datos con usos de campos de clase

**Antes**:
```javascript
function base(reading) { ... }
function taxableCharge(reading) { ... }
function calculateBaseCharge(reading) { ... }
```

**Después**:
```javascript
class Reading {
  constructor(data) { this._data = data; }

  get base() { ... }
  get taxableCharge() { ... }
  get calculateBaseCharge() { ... }
}
```

---

### Split Phase

**Cuándo usar**: El código trata con dos cosas diferentes

**Motivación**: Separa el código en fases distintas con límites claros.

**Mecánicas**:
1. Crea una segunda función para la segunda fase
2. Testea
3. Introduce una estructura de datos intermedia entre fases
4. Testea
5. Extrae la primera fase en su propia función
6. Testea

**Antes**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = quantity * shippingPerCase;
  return basePrice - discount + shippingCost;
}
```

**Después**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const priceData = calculatePricingData(product, quantity);
  return applyShipping(priceData, shippingMethod);
}

function calculatePricingData(product, quantity) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  return { basePrice, quantity, discount };
}

function applyShipping(priceData, shippingMethod) {
  const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = priceData.quantity * shippingPerCase;
  return priceData.basePrice - priceData.discount + shippingCost;
}
```

---

## Moviendo Características

### Move Method

**Cuándo usar**: El método usa más características de otra clase que las suyas

**Motivación**: Pon funciones con los datos que más usan.

**Mecánicas**:
1. Examina todos los elementos de programa usados por el método en su clase
2. Verifica si el método es polimórfico
3. Copia el método a la clase objetivo
4. Ajusta para el nuevo contexto
5. Haz que el método original delegue al objetivo
6. Testea
7. Considera eliminar el método original

---

### Move Field

**Cuándo usar**: El campo es usado más por otra clase

**Motivación**: Mantén datos con las funciones que los usan.

**Mecánicas**:
1. Encapsula el campo si no lo está ya
2. Testea
3. Crea campo en el objetivo
4. Actualiza referencias para usar el campo objetivo
5. Testea
6. Elimina el campo original

---

### Move Statements into Function

**Cuándo usar**: El mismo código siempre aparece con una llamada a función

**Motivación**: Elimina duplicación moviendo código repetido a la función.

**Mecánicas**:
1. Extrae el código repetido en una función si no lo está ya
2. Mueve statements a esa función
3. Testea
4. Si los llamadores ya no necesitan statements independientes, elimínalos

---

### Move Statements to Callers

**Cuándo usar**: Comportamiento común varía entre llamadores

**Motivación**: Cuando el comportamiento necesita diferir, muévelo fuera de la función.

**Mecánicas**:
1. Usa Extract Method en el código a mover
2. Usa Inline Method en la función original
3. Elimina la llamada ahora-inlineada
4. Mueve código extraído a cada llamador
5. Testea

---

## Organizando Datos

### Replace Primitive with Object

**Cuándo usar**: Ítem de datos necesita más comportamiento que un valor simple

**Motivación**: Encapsula datos con su comportamiento.

**Mecánicas**:
1. Aplica Encapsulate Variable
2. Crea una clase de valor simple
3. Cambia el setter para crear una nueva instancia
4. Cambia el getter para retornar el valor
5. Testea
6. Añade comportamiento más rico a la nueva clase

**Antes**:
```javascript
class Order {
  constructor(data) {
    this.priority = data.priority; // string: "high", "rush", etc.
  }
}

// Uso
if (order.priority === "high" || order.priority === "rush") { ... }
```

**Después**:
```javascript
class Priority {
  constructor(value) {
    if (!Priority.legalValues().includes(value))
      throw new Error(`Invalid priority: ${value}`);
    this._value = value;
  }

  static legalValues() { return ['low', 'normal', 'high', 'rush']; }
  get value() { return this._value; }

  higherThan(other) {
    return Priority.legalValues().indexOf(this._value) >
           Priority.legalValues().indexOf(other._value);
  }
}

// Uso
if (order.priority.higherThan(new Priority("normal"))) { ... }
```

---

### Replace Temp with Query

**Cuándo usar**: Variable temporal tiene resultado de una expresión

**Motivación**: Haz el código más claro extrayendo la expresión en una función.

**Mecánicas**:
1. Verifica que la variable se asigne solo una vez
2. Extrae el lado derecho de la asignación en un método
3. Reemplaza referencias a la temp con la llamada al método
4. Testea
5. Elimina la declaración y asignación de la temp

**Antes**:
```javascript
const basePrice = this._quantity * this._itemPrice;
if (basePrice > 1000) {
  return basePrice * 0.95;
} else {
  return basePrice * 0.98;
}
```

**Después**:
```javascript
get basePrice() {
  return this._quantity * this._itemPrice;
}

// En el método
if (this.basePrice > 1000) {
  return this.basePrice * 0.95;
} else {
  return this.basePrice * 0.98;
}
```

---

## Simplificando Lógica Condicional

### Decompose Conditional

**Cuándo usar**: Statement condicional complejo (if-then-else)

**Motivación**: Haz clara la intención extrayendo condiciones y acciones.

**Mecánicas**:
1. Aplica Extract Method en la condición
2. Aplica Extract Method en la rama then
3. Aplica Extract Method en la rama else (si está presente)

**Antes**:
```javascript
if (!aDate.isBefore(plan.summerStart) && !aDate.isAfter(plan.summerEnd)) {
  charge = quantity * plan.summerRate;
} else {
  charge = quantity * plan.regularRate + plan.regularServiceCharge;
}
```

**Después**:
```javascript
if (isSummer(aDate, plan)) {
  charge = summerCharge(quantity, plan);
} else {
  charge = regularCharge(quantity, plan);
}

function isSummer(date, plan) {
  return !date.isBefore(plan.summerStart) && !date.isAfter(plan.summerEnd);
}

function summerCharge(quantity, plan) {
  return quantity * plan.summerRate;
}

function regularCharge(quantity, plan) {
  return quantity * plan.regularRate + plan.regularServiceCharge;
}
```

---

### Consolidate Conditional Expression

**Cuándo usar**: Múltiples condiciones con el mismo resultado

**Motivación**: Haz claro que las condiciones son un solo check.

**Mecánicas**:
1. Verifica sin efectos secundarios en condiciones
2. Combina condiciones usando `and` u `or`
3. Considera Extract Method en la condición combinada

**Antes**:
```javascript
if (employee.seniority < 2) return 0;
if (employee.monthsDisabled > 12) return 0;
if (employee.isPartTime) return 0;
```

**Después**:
```javascript
if (isNotEligibleForDisability(employee)) return 0;

function isNotEligibleForDisability(employee) {
  return employee.seniority < 2 ||
         employee.monthsDisabled > 12 ||
         employee.isPartTime;
}
```

---

### Replace Nested Conditional with Guard Clauses

**Cuándo usar**: Condicionales anidados profundamente haciendo el flujo difícil de seguir

**Motivación**: Usa guard clauses para casos especiales, manteniendo el flujo normal claro.

**Mecánicas**:
1. Encuentra las condiciones de caso especial
2. Reemplázalas con guard clauses que retornan temprano
3. Testea después de cada cambio

**Antes**:
```javascript
function payAmount(employee) {
  let result;
  if (employee.isSeparated) {
    result = { amount: 0, reasonCode: "SEP" };
  } else {
    if (employee.isRetired) {
      result = { amount: 0, reasonCode: "RET" };
    } else {
      result = calculateNormalPay(employee);
    }
  }
  return result;
}
```

**Después**:
```javascript
function payAmount(employee) {
  if (employee.isSeparated) return { amount: 0, reasonCode: "SEP" };
  if (employee.isRetired) return { amount: 0, reasonCode: "RET" };
  return calculateNormalPay(employee);
}
```

---

### Replace Conditional with Polymorphism

**Cuándo usar**: Switch/case basado en tipo, lógica condicional variando por tipo

**Motivación**: Deja que los objetos manejen su propio comportamiento.

**Mecánicas**:
1. Crea jerarquía de clases (si no existe)
2. Usa Factory Function para creación de objetos
3. Mueve lógica condicional al método de superclase
4. Crea método de subclase para cada caso
5. Elimina el condicional original

**Antes**:
```javascript
function plumages(birds) {
  return birds.map(b => plumage(b));
}

function plumage(bird) {
  switch (bird.type) {
    case 'EuropeanSwallow':
      return "average";
    case 'AfricanSwallow':
      return (bird.numberOfCoconuts > 2) ? "tired" : "average";
    case 'NorwegianBlueParrot':
      return (bird.voltage > 100) ? "scorched" : "beautiful";
    default:
      return "unknown";
  }
}
```

**Después**:
```javascript
class Bird {
  get plumage() { return "unknown"; }
}

class EuropeanSwallow extends Bird {
  get plumage() { return "average"; }
}

class AfricanSwallow extends Bird {
  get plumage() {
    return (this.numberOfCoconuts > 2) ? "tired" : "average";
  }
}

class NorwegianBlueParrot extends Bird {
  get plumage() {
    return (this.voltage > 100) ? "scorched" : "beautiful";
  }
}

function createBird(data) {
  switch (data.type) {
    case 'EuropeanSwallow': return new EuropeanSwallow(data);
    case 'AfricanSwallow': return new AfricanSwallow(data);
    case 'NorwegianBlueParrot': return new NorwegianBlueParrot(data);
    default: return new Bird(data);
  }
}
```

---

### Introduce Special Case (Null Object)

**Cuándo usar**: Checks de null repetidos para casos especiales

**Motivación**: Retorna un objeto especial que maneja el caso especial.

**Mecánicas**:
1. Crea clase de caso especial con la interfaz esperada
2. Añade check isSpecialCase
3. Introduce método factory
4. Reemplaza checks de null con uso de objeto de caso especial
5. Testea

**Antes**:
```javascript
const customer = site.customer;
// ... muchos lugares verificando
if (customer === "unknown") {
  customerName = "occupant";
} else {
  customerName = customer.name;
}
```

**Después**:
```javascript
class UnknownCustomer {
  get name() { return "occupant"; }
  get billingPlan() { return registry.defaultPlan; }
}

// Método factory
function customer(site) {
  return site.customer === "unknown"
    ? new UnknownCustomer()
    : site.customer;
}

// Uso - sin checks de null necesarios
const customerName = customer.name;
```

---

## Refactorizando APIs

### Separate Query from Modifier

**Cuándo usar**: Función tanto retorna un valor como tiene efectos secundarios

**Motivación**: Haz claro qué operaciones tienen efectos secundarios.

**Mecánicas**:
1. Crea una nueva función de consulta
2. Copia lógica de retorno de la función original
3. Modifica la original para retornar void
4. Reemplaza llamadas que usan valor de retorno
5. Testea

**Antes**:
```javascript
function alertForMiscreant(people) {
  for (const p of people) {
    if (p === "Don") {
      setOffAlarms();
      return "Don";
    }
    if (p === "John") {
      setOffAlarms();
      return "John";
    }
  }
  return "";
}
```

**Después**:
```javascript
function findMiscreant(people) {
  for (const p of people) {
    if (p === "Don") return "Don";
    if (p === "John") return "John";
  }
  return "";
}

function alertForMiscreant(people) {
  if (findMiscreant(people) !== "") setOffAlarms();
}
```

---

### Parameterize Function

**Cuándo usar**: Varias funciones haciendo cosas similares con diferentes valores

**Motivación**: Elimina duplicación añadiendo un parámetro.

**Mecánicas**:
1. Selecciona una función
2. Añade parámetro para el literal variable
3. Cambia el cuerpo para usar el parámetro
4. Testea
5. Cambia llamadores para usar la versión parametrizada
6. Elimina funciones ahora no usadas

**Antes**:
```javascript
function tenPercentRaise(person) {
  person.salary = person.salary * 1.10;
}

function fivePercentRaise(person) {
  person.salary = person.salary * 1.05;
}
```

**Después**:
```javascript
function raise(person, factor) {
  person.salary = person.salary * (1 + factor);
}

// Uso
raise(person, 0.10);
raise(person, 0.05);
```

---

### Remove Flag Argument

**Cuándo usar**: Parámetro booleano que cambia el comportamiento de la función

**Motivación**: Haz el comportamiento explícito a través de funciones separadas.

**Mecánicas**:
1. Crea función explícita para cada valor de bandera
2. Reemplaza cada llamada con la nueva función apropiada
3. Testea después de cada cambio
4. Elimina función original

**Antes**:
```javascript
function bookConcert(customer, isPremium) {
  if (isPremium) {
    // lógica de reserva premium
  } else {
    // lógica de reserva regular
  }
}

bookConcert(customer, true);
bookConcert(customer, false);
```

**Después**:
```javascript
function bookPremiumConcert(customer) {
  // lógica de reserva premium
}

function bookRegularConcert(customer) {
  // lógica de reserva regular
}

bookPremiumConcert(customer);
bookRegularConcert(customer);
```

---

## Tratando con Herencia

### Pull Up Method

**Cuándo usar**: Mismo método en múltiples subclases

**Motivación**: Elimina duplicación en jerarquía de clases.

**Mecánicas**:
1. Inspecciona métodos para asegurar que son idénticos
2. Verifica que las firmas son las mismas
3. Crea nuevo método en superclase
4. Copia cuerpo de una subclase
5. Elimina un método de subclase, testea
6. Elimina otros métodos de subclase, testea cada uno

---

### Push Down Method

**Cuándo usar**: Comportamiento relevante solo para un subconjunto de subclases

**Motivación**: Pon el método donde se usa.

**Mecánicas**:
1. Copia método a cada subclase que lo necesita
2. Elimina método de la superclase
3. Testea
4. Elimina de subclases que no lo necesitan
5. Testea

---

### Replace Subclass with Delegate

**Cuándo usar**: Herencia está siendo usada incorrectamente, necesitas más flexibilidad

**Motivación**: Prefiere composición sobre herencia cuando sea apropiado.

**Mecánicas**:
1. Crea clase vacía para delegate
2. Añade campo en clase host manteniendo delegate
3. Crea constructor para delegate, llamado desde host
4. Mueve características a delegate
5. Testea después de cada movimiento
6. Reemplaza herencia con delegación

---

## Extract Class

**Cuándo usar**: Clase grande con múltiples responsabilidades

**Motivación**: Divide clase para mantener responsabilidad única.

**Mecánicas**:
1. Decide cómo dividir responsabilidades
2. Crea nueva clase
3. Mueve campo de original a nueva clase
4. Testea
5. Mueve métodos de original a nueva clase
6. Testea después de cada movimiento
7. Revisa y renombra ambas clases
8. Decide cómo exponer nueva clase

**Antes**:
```javascript
class Person {
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get officeAreaCode() { return this._officeAreaCode; }
  set officeAreaCode(arg) { this._officeAreaCode = arg; }
  get officeNumber() { return this._officeNumber; }
  set officeNumber(arg) { this._officeNumber = arg; }

  get telephoneNumber() {
    return `(${this._officeAreaCode}) ${this._officeNumber}`;
  }
}
```

**Después**:
```javascript
class Person {
  constructor() {
    this._telephoneNumber = new TelephoneNumber();
  }
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get telephoneNumber() { return this._telephoneNumber.toString(); }
  get officeAreaCode() { return this._telephoneNumber.areaCode; }
  set officeAreaCode(arg) { this._telephoneNumber.areaCode = arg; }
}

class TelephoneNumber {
  get areaCode() { return this._areaCode; }
  set areaCode(arg) { this._areaCode = arg; }
  get number() { return this._number; }
  set number(arg) { this._number = arg; }
  toString() { return `(${this._areaCode}) ${this._number}`; }
}
```

---

## Referencia Rápida: Smell a Refactoring

| Code Smell | Refactoring Primario | Alternativo |
|------------|-------------------|-------------|
| Long Method | Extract Method | Replace Temp with Query |
| Duplicate Code | Extract Method | Pull Up Method |
| Large Class | Extract Class | Extract Subclass |
| Long Parameter List | Introduce Parameter Object | Preserve Whole Object |
| Feature Envy | Move Method | Extract Method + Move |
| Data Clumps | Extract Class | Introduce Parameter Object |
| Primitive Obsession | Replace Primitive with Object | Replace Type Code |
| Switch Statements | Replace Conditional with Polymorphism | Replace Type Code |
| Temporary Field | Extract Class | Introduce Null Object |
| Message Chains | Hide Delegate | Extract Method |
| Middle Man | Remove Middle Man | Inline Method |
| Divergent Change | Extract Class | Split Phase |
| Shotgun Surgery | Move Method | Inline Class |
| Dead Code | Remove Dead Code | - |
| Speculative Generality | Collapse Hierarchy | Inline Class |

---

## Lectura Adicional

- Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2da ed.)
- Catálogo online: https://refactoring.com/catalog/
