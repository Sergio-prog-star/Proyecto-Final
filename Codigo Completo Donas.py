import mysql.connector
from mysql.connector import Error

# Configuración de la conexión a la base de datos
def connect():
    try:
        connection = mysql.connector.connect(
            host='localhost',  # Cambiar según tu configuración
            user='root',       # Cambiar según tu usuario
            password='Gordito1705',  # Cambiar según tu configuración
            database='DonasDB'
        )
        if connection.is_connected():
            print("Conexión exitosa a la base de datos")
            return connection
    except Error as e:
        print(f"Error: {e}")
        return None

# Menús principales para cada tabla
def menu_principal():
    connection = connect()
    if not connection:
        return
    while True:
        print("\n--- Menú Principal ---")
        print("1. Gestión de Productos")
        print("2. Gestión de Clientes")
        print("3. Gestión de Empleados")
        print("4. Gestión de Proveedores")
        print("5. Salir")
        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            menu_productos(connection)
        elif opcion == '2':
            menu_clientes(connection)
        elif opcion == '3':
            menu_empleados(connection)
        elif opcion == '4':
            menu_proveedores(connection)
        elif opcion == '5':
            print("Saliendo del programa...")
            connection.close()
            break
        else:
            print("Opción no válida")

# Funciones comunes para manejar las tablas
def ejecutar_consulta(connection, query, values=None):
    try:
        cursor = connection.cursor()
        cursor.execute(query, values)
        connection.commit()
    except Error as e:
        print(f"Error al ejecutar la consulta: {e}")

def leer_tabla(connection, tabla):
    try:
        cursor = connection.cursor()
        cursor.execute(f"SELECT * FROM {tabla}")
        results = cursor.fetchall()
        for row in results:
            print(row)
    except Error as e:
        print(f"Error al leer la tabla {tabla}: {e}")

# Menú y funciones para Productos
def menu_productos(connection):
    while True:
        print("\n--- Gestión de Productos ---")
        print("1. Crear producto")
        print("2. Leer productos")
        print("3. Actualizar producto")
        print("4. Eliminar producto")
        print("5. Regresar al menú principal")
        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            nombre = input("Nombre del producto: ")
            descripcion = input("Descripción: ")
            precio = float(input("Precio: "))
            categoria = input("Categoría: ")
            stock_minimo = int(input("Stock mínimo: "))
            query = """
                INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_minimo)
                VALUES (%s, %s, %s, %s, %s)
            """
            ejecutar_consulta(connection, query, (nombre, descripcion, precio, categoria, stock_minimo))
            print("Producto creado exitosamente")
        elif opcion == '2':
            leer_tabla(connection, "Productos")
        elif opcion == '3':
            id_producto = int(input("ID del producto a actualizar: "))
            nombre = input("Nuevo nombre: ")
            descripcion = input("Nueva descripción: ")
            precio = float(input("Nuevo precio: "))
            categoria = input("Nueva categoría: ")
            stock_minimo = int(input("Nuevo stock mínimo: "))
            query = """
                UPDATE Productos
                SET nombre = %s, descripcion = %s, precio = %s, categoria = %s, stock_minimo = %s
                WHERE id = %s
            """
            ejecutar_consulta(connection, query, (nombre, descripcion, precio, categoria, stock_minimo, id_producto))
            print("Producto actualizado exitosamente")
        elif opcion == '4':
            id_producto = int(input("ID del producto a eliminar: "))
            query = "DELETE FROM Productos WHERE id = %s"
            ejecutar_consulta(connection, query, (id_producto,))
            print("Producto eliminado exitosamente")
        elif opcion == '5':
            break
        else:
            print("Opción no válida")

# Menú y funciones para Clientes
def menu_clientes(connection):
    while True:
        print("\n--- Gestión de Clientes ---")
        print("1. Crear cliente")
        print("2. Leer clientes")
        print("3. Actualizar cliente")
        print("4. Eliminar cliente")
        print("5. Regresar al menú principal")
        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            nombre = input("Nombre del cliente: ")
            query = "INSERT INTO Clientes (nombre) VALUES (%s)"
            ejecutar_consulta(connection, query, (nombre,))
            print("Cliente creado exitosamente")
        elif opcion == '2':
            leer_tabla(connection, "Clientes")
        elif opcion == '3':
            id_cliente = int(input("ID del cliente a actualizar: "))
            nombre = input("Nuevo nombre: ")
            query = "UPDATE Clientes SET nombre = %s WHERE id = %s"
            ejecutar_consulta(connection, query, (nombre, id_cliente))
            print("Cliente actualizado exitosamente")
        elif opcion == '4':
            id_cliente = int(input("ID del cliente a eliminar: "))
            query = "DELETE FROM Clientes WHERE id = %s"
            ejecutar_consulta(connection, query, (id_cliente,))
            print("Cliente eliminado exitosamente")
        elif opcion == '5':
            break
        else:
            print("Opción no válida")

# Menú y funciones para Empleados
def menu_empleados(connection):
    while True:
        print("\n--- Gestión de Empleados ---")
        print("1. Crear empleado")
        print("2. Leer empleados")
        print("3. Actualizar empleado")
        print("4. Eliminar empleado")
        print("5. Regresar al menú principal")
        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            nombre = input("Nombre del empleado: ")
            puesto = input("Puesto: ")
            salario = float(input("Salario: "))
            fecha_contratacion = input("Fecha de contratación (YYYY-MM-DD): ")
            fecha_final_contrato = input("Fecha final de contrato (YYYY-MM-DD): ")
            NSS = input("Número de Seguridad Social: ")
            direccion = input("Dirección: ")
            query = """
                INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion, fecha_final_contrato, NSS, direccion)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            ejecutar_consulta(connection, query, (nombre, puesto, salario, fecha_contratacion, fecha_final_contrato, NSS, direccion))
            print("Empleado creado exitosamente")
        elif opcion == '2':
            leer_tabla(connection, "Empleados")
        elif opcion == '3':
            id_empleado = int(input("ID del empleado a actualizar: "))
            nombre = input("Nuevo nombre: ")
            puesto = input("Nuevo puesto: ")
            salario = float(input("Nuevo salario: "))
            fecha_contratacion = input("Nueva fecha de contratación (YYYY-MM-DD): ")
            fecha_final_contrato = input("Nueva fecha final de contrato (YYYY-MM-DD): ")
            NSS = input("Nuevo NSS: ")
            direccion = input("Nueva dirección: ")
            query = """
                UPDATE Empleados
                SET nombre = %s, puesto = %s, salario = %s, fecha_contratacion = %s, fecha_final_contrato = %s, NSS = %s, direccion = %s
                WHERE id = %s
            """
            ejecutar_consulta(connection, query, (nombre, puesto, salario, fecha_contratacion, fecha_final_contrato, NSS, direccion, id_empleado))
            print("Empleado actualizado exitosamente")
        elif opcion == '4':
            id_empleado = int(input("ID del empleado a eliminar: "))
            query = "DELETE FROM Empleados WHERE id = %s"
            ejecutar_consulta(connection, query, (id_empleado,))
            print("Empleado eliminado exitosamente")
        elif opcion == '5':
            break
        else:
            print("Opción no válida")

# Menú y funciones para Proveedores
def menu_proveedores(connection):
    while True:
        print("\n--- Gestión de Proveedores ---")
        print("1. Crear proveedor")
        print("2. Leer proveedores")
        print("3. Actualizar proveedor")
        print("4. Eliminar proveedor")
        print("5. Regresar al menú principal")
        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            nombre = input("Nombre del proveedor: ")
            telefono = input("Teléfono: ")
            direccion = input("Dirección: ")
            correo = input("Correo electrónico: ")
            pago_quincenal = float(input("Pago quincenal: "))
            query = """
                INSERT INTO Proveedores (nombre, telefono, direccion, correo, pago_quincenal)
                VALUES (%s, %s, %s, %s, %s)
            """
            ejecutar_consulta(connection, query, (nombre, telefono, direccion, correo, pago_quincenal))
            print("Proveedor creado exitosamente")
        elif opcion == '2':
            leer_tabla(connection, "Proveedores")
        elif opcion == '3':
            id_proveedor = int(input("ID del proveedor a actualizar: "))
            nombre = input("Nuevo nombre: ")
            telefono = input("Nuevo teléfono: ")
            direccion = input("Nueva dirección: ")
            correo = input("Nuevo correo electrónico: ")
            pago_quincenal = float(input("Nuevo pago quincenal: "))
            query = """
                UPDATE Proveedores
                SET nombre = %s, telefono = %s, direccion = %s, correo = %s, pago_quincenal = %s
                WHERE id = %s
            """
            ejecutar_consulta(connection, query, (nombre, telefono, direccion, correo, pago_quincenal, id_proveedor))
            print("Proveedor actualizado exitosamente")
        elif opcion == '4':
            id_proveedor = int(input("ID del proveedor a eliminar: "))
            query = "DELETE FROM Proveedores WHERE id = %s"
            ejecutar_consulta(connection, query, (id_proveedor,))
            print("Proveedor eliminado exitosamente")
        elif opcion == '5':
            break
        else:
            print("Opción no válida")

# Ejecutar el programa
if __name__ == "__main__":
    menu_principal()
