# RetailChain — Consolidación de Inventarios con UNION y UNION ALL

## 📋 Respuestas a la Consigna

### 1. ¿Cuántas filas devuelve cada consulta y por qué son distintas?
* **`UNION` devuelve 11 filas.**
* **`UNION ALL` devuelve 14 filas.**

**Explicación de los datos:**
Al ejecutar `UNION` sobre las columnas de catálogo (`id_producto`, `nombre_producto`, `categoria`), el operador busca filas idénticas entre ambas sucursales y elimina las duplicadas.

En nuestro conjunto de datos, existen **3 productos exactos** que están cargados tanto en la Sucursal Norte como en la Sucursal Sur:
* **ID 103:** *Monitor 4K 27"* (`Computación`)
* **ID 104:** *Teclado Mecánico* (`Accesorios`)
* **ID 106:** *SSD Externo 1TB* (`Almacenamiento`)

Al hacer el `UNION`, estas 3 coincidencias se consolidan en una sola entrada cada una. Por eso, de un total de 14 registros iniciales (7 de Norte + 7 de Sur), se restan los 3 duplicados, dando como resultado **11 filas únicas**.

Por el contrario, `UNION ALL` no realiza ningún filtro ni comparación: combina directamente los dos conjuntos de datos ($7 + 7 = 14$ filas), preservando la trazabilidad del stock de cada sucursal.

---

### 2. ¿Por qué UNION ALL es más eficiente que UNION?
`UNION ALL` es técnicamente más eficiente porque realiza una concatenación directa de los conjuntos de datos sin procesar las filas.

**Operación adicional que realiza `UNION`:**
Para poder eliminar los duplicados, el motor de SQL debe ejecutar internamente un proceso de **ordenamiento y comparación de filas** (*Sort / Distinct Scan*):
1. Junta los resultados de ambas tablas en memoria/disco.
2. Ordena los datos por todas las columnas seleccionadas.
3. Compara cada fila con la siguiente para identificar y descartar coincidencias idénticas.

Esta operación de deduplicación requiere un alto consumo de memoria RAM y tiempo de CPU. En tablas con millones de registros, un `UNION` puede volver la consulta significativamente lenta, mientras que `UNION ALL` se ejecuta de forma casi instantánea.

---

### 3. Casos de uso de negocio para cada operador

#### Usos para `UNION` (Consolidación sin duplicados)
1. **Padrón / Maestro Unificado de Clientes:** Al integrar clientes provenientes de dos plataformas distintas (por ejemplo, clientes de una tienda e-commerce y clientes de un sistema de facturación de tienda física) para generar una lista limpia de correos únicos para una campaña de marketing.
2. **Catálogo de Proveedores Homologados:** Al unificar las listas de proveedores de distintas filiales regionales para obtener un directorio global sin repeticiones de razón social o CUIT.

#### Usos para `UNION ALL` (Consolidación total de volumen)
1. **Consolidado Histórico de Ventas:** Al unir las tablas de ventas mensuales (`ventas_enero`, `ventas_febrero`, etc.) para calcular la facturación anual global o el ticket promedio. En este caso, si dos clientes compraron el mismo producto al mismo precio el mismo día, eliminar esa fila con `UNION` alteraría gravemente los estados financieros.
2. **Auditoría de Logs de Seguridad / Accesos:** Al consolidar los registros de inicio de sesión de servidores web en distintas regiones para contabilizar el tráfico total y detectar posibles intentos de intrusión.

---

### 4. ¿Qué pasa si las columnas no coinciden en número o tipo?

Para que `UNION` o `UNION ALL` funcionen, se debe cumplir de forma estricta la **compatibilidad de esquemas**:
1. Ambos `SELECT` deben devolver la **misma cantidad de columnas**.
2. Las columnas en el mismo orden deben tener **tipos de datos compatibles** o convertibles de forma implícita.

**Errores que genera SQL Server:**

* **Si la cantidad de columnas no coincide:**
  SQL interrumpe la ejecución antes de procesar la consulta y devuelve el siguiente error de sintaxis:
  > `Msg 205, Level 16, State 1: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.`

* **Si los tipos de datos no son compatibles:**
  Si intentas combinar en la misma posición una columna de tipo texto (`VARCHAR`) con una de tipo fecha (`DATE`) o numérico que no se puedan convertir automáticamente, SQL devolverá un error de conversión de tipos:
  > `Msg 245, Level 16, State 1: Conversion failed when converting the varchar value '...' to data type int.`