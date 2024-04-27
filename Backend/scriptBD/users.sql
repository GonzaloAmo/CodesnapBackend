-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-04-2024 a las 21:32:37
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
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `username` varchar(65) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `sexo` int(255) DEFAULT NULL,
  `telefono` int(255) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL DEFAULT current_timestamp(),
  `nombrecompleto` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `numfotos` int(11) DEFAULT 0,
  `numcodigo` int(11) DEFAULT 0,
  `foroscreados` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `fechanacimiento`, `sexo`, `telefono`, `fecha_ingreso`, `nombrecompleto`, `descripcion`, `ubicacion`, `foto`, `numfotos`, `numcodigo`, `foroscreados`) VALUES
(1, 'usuario1', 'usuario1@example.com', '1234', '1990-01-01', 1, 123456789, '2024-04-24', 'Usuario Uno', 'Descripción del usuario uno', 'Ciudad Uno', 'null', 0, 0, 0);

--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
