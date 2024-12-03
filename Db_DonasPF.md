# Documentación de DonasDB

## Descripción General
DonasDB es una base de datos diseñada para gestionar las operaciones de una tienda de donas. Incluye tablas para productos, clientes, empleados, proveedores, inventario, ventas y gastos.

## Tablas y Relaciones
- **Productos**: Almacena información sobre los productos.
- **Clientes**: Almacena información sobre los clientes.
- **Empleados**: Almacena información sobre los empleados.
- **Proveedores**: Almacena información sobre los proveedores.
- **Inventario**: Gestiona los detalles del inventario.
- **Ventas**: Gestiona las transacciones de ventas.
- **Detalle_Ventas**: Almacena los detalles de cada venta.
- **Gastos**: Gestiona los gastos.

## Consultas de Ejemplo
### Partes Importantes a mencionar:
```sql
SELECT * FROM Productos;
SELECT * FROM Clientes;
SELECT * FROM Empleados;
SELECT * FROM Proveedores;

Vistas:
CREATE VIEW ActiveProducts AS
SELECT * FROM Productos WHERE stock_minimo > 0;

Indices
CREATE INDEX idx_product_name ON Productos(nombre);
CREATE INDEX idx_client_name ON Clientes(nombre);

Triggers
CREATE TRIGGER after_sale
AFTER INSERT ON Detalle_Ventas
FOR EACH ROW
BEGIN
    UPDATE Inventario
    SET cantidad = cantidad - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END;

Cómo Ejecutar la Base de Datos
Para ejecutar la base de datos, siga estos pasos:

Instalar MySQL: Asegúrese de tener MySQL instalado en su sistema. Puede descargarlo desde MySQL Downloads.

Conectar a MySQL: Abra su terminal o línea de comandos y conéctese a MySQL usando el siguiente comando:

> mysql -u root -p

Ingrese su contraseña de MySQL cuando se le solicite.

Crear la Base de Datos y Tablas: Ejecute el script SQL Proyecto Donas Bien Completo.sql para crear la base de datos y las tablas. Puede hacerlo usando el siguiente comando:

> source /ruta/al/archivo/Proyecto Donas Bien Completo.sql

Verificar la Creación: Verifique que las tablas se hayan creado correctamente usando el siguiente comando en MySQL:

> SHOW TABLES;

