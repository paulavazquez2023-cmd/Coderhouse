-- ══════════════════════════════════════════
-- RetailChain — Inventario por Sucursal
-- ══════════════════════════════════════════

DROP TABLE IF EXISTS inventario_sucursal_norte;
DROP TABLE IF EXISTS inventario_sucursal_sur;

CREATE TABLE inventario_sucursal_norte (
    id_producto     INT,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50),
    stock           INT          NOT NULL
);

CREATE TABLE inventario_sucursal_sur (
    id_producto     INT,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50),
    stock           INT          NOT NULL
);

-- Sucursal Norte
INSERT INTO inventario_sucursal_norte VALUES (101, 'Laptop Pro 15',      'Computación',  8);
INSERT INTO inventario_sucursal_norte VALUES (102, 'Mouse Inalámbrico',  'Accesorios',  30);
INSERT INTO inventario_sucursal_norte VALUES (103, 'Monitor 4K 27"',     'Computación',  5);
INSERT INTO inventario_sucursal_norte VALUES (104, 'Teclado Mecánico',   'Accesorios',  20);
INSERT INTO inventario_sucursal_norte VALUES (105, 'Auriculares BT Pro', 'Audio',       15);
-- Estos productos también existen en la Sucursal Sur (importantes para UNION)
INSERT INTO inventario_sucursal_norte VALUES (106, 'SSD Externo 1TB',    'Almacenamiento', 10);
INSERT INTO inventario_sucursal_norte VALUES (107, 'Webcam HD 1080p',    'Accesorios',  12);

-- Sucursal Sur
INSERT INTO inventario_sucursal_sur VALUES (103, 'Monitor 4K 27"',     'Computación',   3);
INSERT INTO inventario_sucursal_sur VALUES (104, 'Teclado Mecánico',   'Accesorios',   18);
INSERT INTO inventario_sucursal_sur VALUES (106, 'SSD Externo 1TB',    'Almacenamiento', 7);
-- Estos productos son exclusivos de la Sucursal Sur
INSERT INTO inventario_sucursal_sur VALUES (108, 'Laptop Basic 14',    'Computación',   6);
INSERT INTO inventario_sucursal_sur VALUES (109, 'Parlante Bluetooth', 'Audio',        22);
INSERT INTO inventario_sucursal_sur VALUES (110, 'Hub USB-C 7p',       'Accesorios',   35);
INSERT INTO inventario_sucursal_sur VALUES (111, 'Webcam HD 1080p',    'Accesorios',    9);

-- ════════════════════════════════════════════════════════════════════════════
-- RetailChain — UNION y UNION ALL
-- Autor: Paula Vazquez
-- Fecha: 4 de Octubre de 2026
-- ════════════════════════════════════════════════════════════════════════════

USE Ventas_Tech_DB;
GO

-- ── CONSULTA 1: UNION ───────────────────────────────────────────────────────
-- Reporte de Catálogo Unificado
-- Pregunta de negocio: ¿Qué productos únicos comercializa la empresa en toda su red?
-- Operador: UNION (elimina duplicados basándose en los atributos del catálogo)

SELECT 
    id_producto,
    nombre_producto,
    categoria
FROM inventario_sucursal_norte

UNION

SELECT 
    id_producto,
    nombre_producto,
    categoria
FROM inventario_sucursal_sur
ORDER BY id_producto ASC;
GO


-- ── CONSULTA 2: UNION ALL ───────────────────────────────────────────────────
-- Auditoría de Stock Total
-- Pregunta de negocio: ¿Cuántos registros físicos de stock existen en total?
-- Operador: UNION ALL (mantiene todos los registros y permite sumar/auditar el stock por sucursal)

SELECT 
    'Sucursal Norte' AS sucursal,
    id_producto,
    nombre_producto,
    categoria,
    stock
FROM inventario_sucursal_norte

UNION ALL

SELECT 
    'Sucursal Sur' AS sucursal,
    id_producto,
    nombre_producto,
    categoria,
    stock
FROM inventario_sucursal_sur;
GO


-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS ──────────────────────────────────
-- Compara el número de filas generadas por cada operador

SELECT COUNT(*) AS filas_union FROM (
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_norte
    UNION
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_sur
) AS resultado_union;

SELECT COUNT(*) AS filas_union_all FROM (
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_norte
    UNION ALL
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_sur
) AS resultado_union_all;
GO