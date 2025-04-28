-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2025 at 02:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `esthebxn_social`
--

-- --------------------------------------------------------

--
-- Table structure for table `contenido`
--

CREATE TABLE `contenido` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `red_social_id` int(11) NOT NULL,
  `tipo` enum('Video','Imagen','Stream','Reel','Story') NOT NULL,
  `url_contenido` varchar(255) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `duracion` int(11) DEFAULT NULL COMMENT 'Duración en segundos'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estadisticas`
--

CREATE TABLE `estadisticas` (
  `id` int(11) NOT NULL,
  `red_social_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `seguidores` int(11) DEFAULT 0,
  `visualizaciones` int(11) DEFAULT 0,
  `interacciones` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `redes_sociales`
--

CREATE TABLE `redes_sociales` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `plataforma` enum('Kick','Instagram','TikTok','YouTube','Twitter','Facebook') NOT NULL,
  `url_perfil` varchar(255) NOT NULL,
  `seguidores` int(11) DEFAULT 0,
  `verificado` tinyint(1) DEFAULT 0,
  `principal` tinyint(1) DEFAULT 0,
  `orden` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `redes_sociales`
--

INSERT INTO `redes_sociales` (`id`, `usuario_id`, `plataforma`, `url_perfil`, `seguidores`, `verificado`, `principal`, `orden`) VALUES
(1, 1, 'Kick', 'https://kick.com/merz-7', 0, 0, 1, 1),
(2, 1, 'Instagram', 'https://www.instagram.com/esthebxn_/', 0, 0, 1, 2),
(3, 1, 'TikTok', 'https://www.tiktok.com/@esthebxn_', 0, 0, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT '480407663_122181821666055441_3012527653000684500_n_1.jpg',
  `biografia` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `nombre_completo`, `email`, `foto_perfil`, `biografia`, `fecha_registro`, `ultimo_acceso`, `activo`) VALUES
(1, 'esthebxn_', 'Esthebxn', NULL, '480407663_122181821666055441_3012527653000684500_n (1).jpg', '¡Sígueme en mis redes sociales!', '2025-04-28 00:18:01', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `visitas_pagina`
--

CREATE TABLE `visitas_pagina` (
  `id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `pagina_visitada` varchar(50) DEFAULT 'index',
  `clicks_redes_sociales` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `red_social_id` (`red_social_id`);

--
-- Indexes for table `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `red_social_id` (`red_social_id`,`fecha`);

--
-- Indexes for table `redes_sociales`
--
ALTER TABLE `redes_sociales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`,`plataforma`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `visitas_pagina`
--
ALTER TABLE `visitas_pagina`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estadisticas`
--
ALTER TABLE `estadisticas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `redes_sociales`
--
ALTER TABLE `redes_sociales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `visitas_pagina`
--
ALTER TABLE `visitas_pagina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contenido`
--
ALTER TABLE `contenido`
  ADD CONSTRAINT `contenido_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contenido_ibfk_2` FOREIGN KEY (`red_social_id`) REFERENCES `redes_sociales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD CONSTRAINT `estadisticas_ibfk_1` FOREIGN KEY (`red_social_id`) REFERENCES `redes_sociales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `redes_sociales`
--
ALTER TABLE `redes_sociales`
  ADD CONSTRAINT `redes_sociales_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
