
-- Este script de base de datos crea una estructura para una aplicación de blog sencilla.
-- Incluye tablas para usuarios, roles, publicaciones y comentarios, con sus relaciones.

-- Crear la tabla 'roles', que define los tipos de roles que los usuarios pueden tener.
CREATE TABLE roles (
    id SERIAL PRIMARY KEY, -- Identificador único para cada rol.
    nombre VARCHAR(50) NOT NULL -- Nombre del rol (por ejemplo, 'Administrador', 'Editor').
);

-- Crear la tabla 'usuarios', que almacena la información básica de los usuarios del blog.
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY, -- Identificador único para cada usuario.
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE, -- Nombre único del usuario para inicio de sesión.
    contrasena VARCHAR(255) NOT NULL, -- Contraseña cifrada del usuario.
    correo_electronico VARCHAR(100) NOT NULL UNIQUE, -- Correo electrónico único del usuario.
    rol_id INT NOT NULL, -- Referencia al rol del usuario.
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de creación del usuario.
    FOREIGN KEY (rol_id) REFERENCES roles (id) -- Relación con la tabla 'roles'.
);

-- Crear la tabla 'publicaciones', que almacena los artículos o entradas del blog.
CREATE TABLE publicaciones (
    id SERIAL PRIMARY KEY, -- Identificador único para cada publicación.
    titulo VARCHAR(255) NOT NULL, -- Título de la publicación.
    contenido TEXT NOT NULL, -- Contenido completo de la publicación.
    autor_id INT NOT NULL, -- Referencia al autor de la publicación.
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de publicación.
    FOREIGN KEY (autor_id) REFERENCES usuarios (id) -- Relación con la tabla 'usuarios'.
);

-- Crear la tabla 'comentarios', que almacena los comentarios realizados en las publicaciones.
CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY, -- Identificador único para cada comentario.
    contenido TEXT NOT NULL, -- Contenido del comentario.
    autor_id INT NOT NULL, -- Referencia al autor del comentario.
    publicacion_id INT NOT NULL, -- Referencia a la publicación a la que pertenece el comentario.
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del comentario.
    FOREIGN KEY (autor_id) REFERENCES usuarios (id), -- Relación con la tabla 'usuarios'.
    FOREIGN KEY (publicacion_id) REFERENCES publicaciones (id) -- Relación con la tabla 'publicaciones'.
);

-- Insertar roles iniciales en la tabla 'roles'.
INSERT INTO roles (nombre) VALUES ('Administrador'), ('Editor'), ('Lector');

-- Crear un usuario administrador inicial.
INSERT INTO usuarios (nombre_usuario, contrasena, correo_electronico, rol_id)
VALUES ('admin', 'contrasena_cifrada', 'admin@ejemplo.com', 1);

-- Ejemplo de inserción de una publicación inicial.
INSERT INTO publicaciones (titulo, contenido, autor_id)
VALUES ('Primera publicación', 'Contenido de ejemplo de la primera publicación.', 1);

-- Ejemplo de inserción de un comentario inicial.
INSERT INTO comentarios (contenido, autor_id, publicacion_id)
VALUES ('Este es un comentario de ejemplo.', 1, 1);

-- Fin del script de base de datos.
