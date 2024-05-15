-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-05-2024 a las 11:12:14
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

-- Borramos la base de datos si existe
DROP DATABASE IF EXISTS `codesnap`;
-- Creamos la base de datos
CREATE DATABASE `codesnap`;
-- Seleccionamos la base de datos
USE `codesnap`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `codesnap`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `forums`
--

CREATE TABLE `forums` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `question` varchar(255) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT current_timestamp(),
  `response_number` INT(255) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Disparadores `forums`
--
DELIMITER $$
CREATE TRIGGER `actualizar_foroscreados` AFTER INSERT ON `forums` FOR EACH ROW BEGIN
    UPDATE users
    SET foroscreados = foroscreados + 1
    WHERE id = NEW.idUser;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_foroscreados_delete` AFTER DELETE ON `forums` FOR EACH ROW BEGIN
    UPDATE users
    SET foroscreados = foroscreados - 1
    WHERE id = OLD.idUser;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idPhoto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `photos`
--

CREATE TABLE `photos` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `foto` longtext NOT NULL,
  `description` varchar(255) NOT NULL,
  `numLikes` INT(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responses`
--

CREATE TABLE `responses` (
  `id` int(11) NOT NULL,
  `idForum` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `response` longtext NOT NULL,
  `response_Date` DATETIME DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
--
-- Disparadores `forums`
--
DELIMITER $$
CREATE TRIGGER `actualizar_response_number_insert` AFTER INSERT ON `responses` FOR EACH ROW BEGIN
    UPDATE forums
    SET response_number = response_number + 1
    WHERE id = NEW.idForum;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_response_number_delete` AFTER DELETE ON `responses` FOR EACH ROW BEGIN
    UPDATE forums
    SET response_number = response_number - 1
    WHERE id = OLD.idForum;
END
$$
DELIMITER ;

--
-- Estructura de tabla para la tabla `scripts`
--

CREATE TABLE `scripts` (
  `id` int(255) NOT NULL,
  `idUser` varchar(255) NOT NULL,
  `code` longtext NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `fecha_creacion` date DEFAULT current_timestamp(),
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Disparadores `scripts`
--
DELIMITER $$
CREATE TRIGGER `update_numCodigo_after_delete` AFTER DELETE ON `scripts` FOR EACH ROW BEGIN
    UPDATE users
    SET numCodigo = numCodigo - 1
    WHERE id = OLD.idUser;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_numCodigo_after_insert` AFTER INSERT ON `scripts` FOR EACH ROW BEGIN
    UPDATE users
    SET numCodigo = numCodigo + 1
    WHERE id = NEW.idUser;
END
$$
DELIMITER ;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `token` varchar(200) NOT NULL,
  `username` varchar(65) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `sexo` int(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL DEFAULT current_timestamp(),
  `nombrecompleto` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `foto` longtext DEFAULT NULL,
  `numfotos` int(11) DEFAULT 0,
  `numcodigo` int(11) DEFAULT 0,
  `foroscreados` int(11) DEFAULT 0,
  `role` varchar(50) DEFAULT 'USER'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `forums`
--
ALTER TABLE `forums`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `responses`
--
ALTER TABLE `responses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `scripts`
--
ALTER TABLE `scripts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `forums`
--
ALTER TABLE `forums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT de la tabla `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT de la tabla `photos`
--
ALTER TABLE `photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT de la tabla `responses`
--
ALTER TABLE `responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT de la tabla `scripts`
--
ALTER TABLE `scripts`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
