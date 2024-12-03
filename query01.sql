SELECT * FROM Productos;

SELECT * FROM Empleados;

SELECT * FROM Proveedores;

/* Vistas */

CREATE VIEW ActiveProducts AS
SELECT * FROM Productos WHERE stock_minimo > 0;

/* Indices */

CREATE INDEX idx_product_name ON Productos(nombre);

CREATE INDEX idx_client_name ON Clientes(nombre);



/* Triggers */

CREATE TRIGGER after_sale
AFTER INSERT ON Detalle_Ventas
FOR EACH ROW
BEGIN
    UPDATE Inventario
    SET cantidad = cantidad - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END;

