-- Crear base de datos
CREATE DATABASE IF NOT EXISTS DonasDB;  -- Crear la base de datos 'DonasDB' si no existe
USE DonasDB;  -- Seleccionar la base de datos 'DonasDB' para su uso

-- Crear tabla Productos
CREATE TABLE IF NOT EXISTS Productos (  -- Crear la tabla 'Productos' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    nombre VARCHAR(255) NOT NULL,  -- Columna 'nombre': cadena de caracteres variable, longitud máxima 255, no puede ser nulo
    descripcion TEXT,  -- Columna 'descripcion': tipo texto, puede almacenar cadenas largas
    precio DECIMAL(10, 2) NOT NULL,  -- Columna 'precio': tipo decimal con precisión 10 y escala 2, no puede ser nulo
    categoria VARCHAR(100),  -- Columna 'categoria': cadena de caracteres variable, longitud máxima 100
    stock_minimo INT NOT NULL  -- Columna 'stock_minimo': tipo entero, no puede ser nulo
);

-- Crear tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (  -- Crear la tabla 'Clientes' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    nombre VARCHAR(255) NOT NULL  -- Columna 'nombre': cadena de caracteres variable, longitud máxima 255, no puede ser nulo
);

-- Crear tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (  -- Crear la tabla 'Empleados' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    nombre VARCHAR(255) NOT NULL,  -- Columna 'nombre': cadena de caracteres variable, longitud máxima 255, no puede ser nulo
    puesto VARCHAR(100) NOT NULL,  -- Columna 'puesto': cadena de caracteres variable, longitud máxima 100, no puede ser nulo
    salario DECIMAL(10, 2),  -- Columna 'salario': tipo decimal con precisión 10 y escala 2
    fecha_contratacion DATE,  -- Columna 'fecha_contratacion': tipo fecha
    fecha_final_contrato DATE,  -- Columna 'fecha_final_contrato': tipo fecha
    NSS VARCHAR(20),  -- Columna 'NSS': cadena de caracteres variable, longitud máxima 20
    direccion TEXT  -- Columna 'direccion': tipo texto, puede almacenar cadenas largas
);

-- Crear tabla Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (  -- Crear la tabla 'Proveedores' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    nombre VARCHAR(255) NOT NULL,  -- Columna 'nombre': cadena de caracteres variable, longitud máxima 255, no puede ser nulo
    telefono VARCHAR(20),  -- Columna 'telefono': cadena de caracteres variable, longitud máxima 20
    direccion TEXT,  -- Columna 'direccion': tipo texto, puede almacenar cadenas largas
    correo VARCHAR(255),  -- Columna 'correo': cadena de caracteres variable, longitud máxima 255
    pago_quincenal DECIMAL(10, 2)  -- Columna 'pago_quincenal': tipo decimal con precisión 10 y escala 2
);

-- Crear tabla Inventario
CREATE TABLE IF NOT EXISTS Inventario (  -- Crear la tabla 'Inventario' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    producto_id INT,  -- Columna 'producto_id': tipo entero, clave foránea que referencia la tabla 'Productos'
    cantidad INT,  -- Columna 'cantidad': tipo entero
    proveedor_id INT,  -- Columna 'proveedor_id': tipo entero, clave foránea que referencia la tabla 'Proveedores'
    fecha_ultima_entrada DATE,  -- Columna 'fecha_ultima_entrada': tipo fecha
    FOREIGN KEY (producto_id) REFERENCES Productos(id),  -- Restricción de clave foránea en 'producto_id' que referencia 'id' en la tabla 'Productos'
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)  -- Restricción de clave foránea en 'proveedor_id' que referencia 'id' en la tabla 'Proveedores'
);

-- Crear tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (  -- Crear la tabla 'Ventas' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    total DECIMAL(10, 2),  -- Columna 'total': tipo decimal con precisión 10 y escala 2
    cliente_id INT,  -- Columna 'cliente_id': tipo entero, clave foránea que referencia la tabla 'Clientes'
    empleado_id INT,  -- Columna 'empleado_id': tipo entero, clave foránea que referencia la tabla 'Empleados'
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),  -- Restricción de clave foránea en 'cliente_id' que referencia 'id' en la tabla 'Clientes'
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id)  -- Restricción de clave foránea en 'empleado_id' que referencia 'id' en la tabla 'Empleados'
);

-- Crear tabla Detalle_Ventas
CREATE TABLE IF NOT EXISTS Detalle_Ventas (  -- Crear la tabla 'Detalle_Ventas' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    venta_id INT,  -- Columna 'venta_id': tipo entero, clave foránea que referencia la tabla 'Ventas'
    producto_id INT,  -- Columna 'producto_id': tipo entero, clave foránea que referencia la tabla 'Productos'
    cantidad INT,  -- Columna 'cantidad': tipo entero
    precio_unitario DECIMAL(10, 2),  -- Columna 'precio_unitario': tipo decimal con precisión 10 y escala 2
    FOREIGN KEY (venta_id) REFERENCES Ventas(id),  -- Restricción de clave foránea en 'venta_id' que referencia 'id' en la tabla 'Ventas'
    FOREIGN KEY (producto_id) REFERENCES Productos(id)  -- Restricción de clave foránea en 'producto_id' que referencia 'id' en la tabla 'Productos'
);

-- Crear tabla Gastos
CREATE TABLE IF NOT EXISTS Gastos (  -- Crear la tabla 'Gastos' si no existe
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Columna 'id': entero, auto-incrementado, clave primaria
    concepto VARCHAR(255) NOT NULL,  -- Columna 'concepto': cadena de caracteres variable, longitud máxima 255, no puede ser nulo
    monto DECIMAL(10, 2),  -- Columna 'monto': tipo decimal con precisión 10 y escala 2
    fecha DATE,  -- Columna 'fecha': tipo fecha
    tipo_gasto VARCHAR(100)  -- Columna 'tipo_gasto': cadena de caracteres variable, longitud máxima 100
);

-- Insertar datos en la tabla Productos
INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_minimo) VALUES
('PoolDonut Simple', 'Dona con chocolate Hersheys, Nutella o Kitkat', 45.00, 'Dona', 50),  -- Insertar un producto con valores especificados
('PoolDonut Glaseada', 'Dona cubierta con glaseado dulce (Cualquier sabor para la cascada y relleno)', 35.00, 'Dona', 50),  -- Insertar otro producto
('PoolDonut de Canela', 'Dona espolvoreada con azúcar y canela (Cualquier sabor para la cascada y relleno)', 40.00, 'Dona', 40),  -- Insertar otro producto
('PoolDonut con Mermelada de Fresa', 'Dona rellena con mermelada de fresa natural(Cualquier sabor para la cascada y relleno)', 45.00, 'Dona', 50),  -- Insertar otro producto
('PoolDonut con Crema de Vainilla', 'Dona rellena con suave crema de vainilla (Cualquier sabor para la cascada y relleno)', 42.00, 'Dona', 50);  -- Insertar otro producto

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (nombre) VALUES
('Carlos López'),  -- Insertar un cliente con nombre especificado
('Ana González'),  -- Insertar otro cliente
('Pedro Martínez'),  -- Insertar otro cliente
('Lucía Ramírez'),  -- Insertar otro cliente
('Miguel Herrera');  -- Insertar otro cliente

-- Insertar datos en la tabla Empleados
INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion, fecha_final_contrato, NSS, direccion) VALUES
('Juan Pérez', 'Encargado de Aseo', 1200.00, '2023-01-15', '2024-01-15', '123-45-6789', 'Romer 123, Tampico'),  -- Insertar un empleado con valores especificados
('Roberto Jiménez', 'Encargado de Aseo', 1200.00, '2023-05-01', '2024-05-01', '987-65-4321', 'Avenida Siempre Viva 456, Villareal'),  -- Insertar otro empleado
('Laura Mendoza', 'Gerente', 1800.00, '2022-11-01', '2025-11-01', '234-56-7890', 'Boulevard de los Árboles 789, Floresta'),  -- Insertar otro empleado
('Sofía Torres', 'Vendedor', 1200.00, '2023-03-10', '2024-03-10', '345-67-8901', 'Sol 101, Tlalpan'),  -- Insertar otro empleado
('Carlos Ruiz', 'Vendedor', 1200.00, '2023-06-15', '2024-06-15', '456-78-9012', 'Luna 202, Polanco');  -- Insertar otro empleado

-- Insertar datos en la tabla Proveedores
INSERT INTO Proveedores (nombre, telefono, direccion, correo, pago_quincenal) VALUES
('Proveedora Donut SA', '555-2345', 'Paseo de la Reforma 1000, Peña Blanca', 'contacto@proveedoradonut.com', 500.00),  -- Insertar un proveedor con valores especificados
('Distribuidora Dulce', '555-6789', 'Londres 136, Juarez', 'info@distribuidoradulce.com', 450.00),  -- Insertar otro proveedor
('The Hershey Company', '555-3456', 'Av. Constitucion 245, Polanco', 'support@hersheycompany.com', 600.00),  -- Insertar otro proveedor
('Ferrero', '555-7890', 'Av. Mexico 142, Coyoacan', 'contact@ferrero.com', 550.00),  -- Insertar otro proveedor
('Nestle', '555-4567', 'Moliere 55, Polanco', 'info@nestle.com', 700.00),  -- Insertar otro proveedor
('Servicios y Mantenimiento', '555-0011', 'Avenida del Sol 500, Villareal', 'contacto@serviciosdesdecasa.com', 300.00),  -- Insertar otro proveedor
('Seguridad 24/7', '555-1122', 'Panuco 85, Montereal', 'contacto@seguridad247.com', 350.00),  -- Insertar otro proveedor
('Home Publicity', '555-1122', 'Lazaro Cardenas 700, Buenavista', 'contacto@hpublicity98.com', 400.00);  -- Insertar otro proveedor

-- Insertar datos en la tabla Inventario
INSERT INTO Inventario (producto_id, cantidad, proveedor_id, fecha_ultima_entrada) VALUES
(1, 100, 1, '2024-10-01'),  -- Insertar un registro de inventario con valores especificados
(2, 150, 2, '2024-10-05'),  -- Insertar otro registro de inventario
(3, 120, 3, '2024-10-10'),  -- Insertar otro registro de inventario
(4, 80, 4, '2024-10-12'),  -- Insertar otro registro de inventario
(5, 200, 5, '2024-10-15');  -- Insertar otro registro de inventario

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (total, cliente_id, empleado_id) VALUES
(90.00, 1, 4),  -- Insertar un registro de venta con valores especificados
(70.00, 2, 5),  -- Insertar otro registro de venta
(120.00, 3, 3),  -- Insertar otro registro de venta
(135.00, 4, 4),  -- Insertar otro registro de venta
(126.00, 5, 3);  -- Insertar otro registro de venta

-- Insertar datos en la tabla Detalle_Ventas
INSERT INTO Detalle_Ventas (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 3, 45.00),  -- Insertar un registro de detalle de venta con valores especificados
(2, 2, 2, 35.00),  -- Insertar otro registro de detalle de venta
(3, 3, 3, 40.00),  -- Insertar otro registro de detalle de venta
(4, 4, 3, 45.00),  -- Insertar otro registro de detalle de venta
(5, 5, 3, 42.00);  -- Insertar otro registro de detalle de venta

-- Insertar datos en la tabla Gastos
INSERT INTO Gastos (concepto, monto, fecha, tipo_gasto) VALUES
('Pago quincenal Proveedora Donut SA', 500.00, '2024-10-01', 'Proveedor'),  -- Insertar un registro de gasto con valores especificados
('Pago quincenal Distribuidora Dulce', 450.00, '2024-10-05', 'Proveedor'),  -- Insertar otro registro de gasto
('Pago quincenal The Hershey Company', 600.00, '2024-10-10', 'Proveedor'),  -- Insertar otro registro de gasto
('Pago quincenal Ferrero', 550.00, '2024-10-12', 'Proveedor'),  -- Insertar otro registro de gasto
('Pago quincenal Nestle', 700.00, '2024-10-15', 'Proveedor'),  -- Insertar otro registro de gasto
('Pago quincenal Servicios y Mantenimiento', 300.00, '2024-10-05', 'Proveedor'),  -- Insertar otro registro de gasto
('Pago quincenal Seguridad 24/7', 350.00, '2024-10-10', 'Proveedor'),  -- Insertar otro registro de gasto
('Salario de empleados (quincenal)', 1200.00, '2024-10-10', 'Sueldos'),  -- Insertar otro registro de gasto
('Gasto en publicidad para campaña promocional', 400.00, '2024-10-15', 'Publicidad');  -- Insertar otro registro de gasto

-- Crear vistas
CREATE VIEW ActiveProducts AS  -- Crear una vista llamada 'ActiveProducts'
SELECT * FROM Productos WHERE stock_minimo > 0;  -- Seleccionar todos los productos donde 'stock_minimo' sea mayor que 0

-- Crear índices
CREATE INDEX idx_product_name ON Productos(nombre);  -- Crear un índice en la columna 'nombre' de la tabla 'Productos'
CREATE INDEX idx_client_name ON Clientes(nombre);  -- Crear un índice en la columna 'nombre' de la tabla 'Clientes'

-- Crear triggers
CREATE TRIGGER after_sale  -- Crear un trigger llamado 'after_sale'
AFTER INSERT ON Detalle_Ventas  -- Trigger para ejecutar después de una inserción en la tabla 'Detalle_Ventas'
FOR EACH ROW  -- Para cada fila insertada
BEGIN
    UPDATE Inventario  -- Actualizar la tabla 'Inventario'
    SET cantidad = cantidad - NEW.cantidad  -- Disminuir la 'cantidad' por la 'cantidad' de la nueva fila
    WHERE producto_id = NEW.producto_id;  -- Donde 'producto_id' coincida con el 'producto_id' de la nueva fila
END;