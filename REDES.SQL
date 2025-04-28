-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS esthebxn_social;
USE esthebxn_social;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    foto_perfil VARCHAR(255) DEFAULT '480407663_122181821666055441_3012527653000684500_n (1).jpg',
    biografia TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de redes sociales
CREATE TABLE redes_sociales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    plataforma ENUM('Kick', 'Instagram', 'TikTok', 'YouTube', 'Twitter', 'Facebook') NOT NULL,
    url_perfil VARCHAR(255) NOT NULL,
    seguidores INT DEFAULT 0,
    verificado BOOLEAN DEFAULT FALSE,
    principal BOOLEAN DEFAULT FALSE,
    orden INT DEFAULT 0,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    UNIQUE KEY (usuario_id, plataforma)
);

-- Tabla de estadísticas
CREATE TABLE estadisticas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    red_social_id INT NOT NULL,
    fecha DATE NOT NULL,
    seguidores INT DEFAULT 0,
    visualizaciones INT DEFAULT 0,
    interacciones INT DEFAULT 0,
    FOREIGN KEY (red_social_id) REFERENCES redes_sociales(id) ON DELETE CASCADE,
    UNIQUE KEY (red_social_id, fecha)
);

-- Tabla de contenido
CREATE TABLE contenido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    red_social_id INT NOT NULL,
    tipo ENUM('Video', 'Imagen', 'Stream', 'Reel', 'Story') NOT NULL,
    url_contenido VARCHAR(255) NOT NULL,
    titulo VARCHAR(255),
    descripcion TEXT,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duracion INT COMMENT 'Duración en segundos',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (red_social_id) REFERENCES redes_sociales(id) ON DELETE CASCADE
);

-- Tabla de visitas a la página
CREATE TABLE visitas_pagina (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    pagina_visitada VARCHAR(50) DEFAULT 'index',
    clicks_redes_sociales INT DEFAULT 0
);

-- Insertar datos iniciales para Esthebxn
INSERT INTO usuarios (username, nombre_completo, foto_perfil, biografia) 
VALUES ('esthebxn_', 'Esthebxn', '480407663_122181821666055441_3012527653000684500_n (1).jpg', '¡Sígueme en mis redes sociales!');

INSERT INTO redes_sociales (usuario_id, plataforma, url_perfil, principal, orden) VALUES
(1, 'Kick', 'https://kick.com/merz-7', TRUE, 1),
(1, 'Instagram', 'https://www.instagram.com/esthebxn_/', TRUE, 2),
(1, 'TikTok', 'https://www.tiktok.com/@esthebxn_', TRUE, 3);

-- Crear usuario para la aplicación
CREATE USER 'esthebxn_web'@'localhost' IDENTIFIED BY 'password_seguro';
GRANT SELECT, INSERT, UPDATE ON esthebxn_social.* TO 'esthebxn_web'@'localhost';
FLUSH PRIVILEGES;