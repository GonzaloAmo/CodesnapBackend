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
  `type` varchar(30) NOT NULL,
  `dateCreated` DATETIME DEFAULT current_timestamp(),
  `numAnswers` INT(255) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Disparadores `forums`
--
DELIMITER $$
CREATE TRIGGER `actualizar_foroscreados` AFTER INSERT ON `forums` FOR EACH ROW BEGIN
    UPDATE users
    SET numForums = numForums + 1
    WHERE id = NEW.idUser;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_foroscreados_delete` AFTER DELETE ON `forums` FOR EACH ROW BEGIN
    UPDATE users
    SET numForums = numForums - 1
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
  `photo` longtext NOT NULL,
  `description` varchar(255) NOT NULL,
  `numLikes` INT(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
--
-- Disparadores `photos`
--
DELIMITER $$
CREATE TRIGGER `actualizar_photos_number_insert` AFTER INSERT ON `photos` FOR EACH ROW BEGIN
    UPDATE users
    SET numPhotos = numPhotos + 1
    WHERE id = NEW.idUser;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_photos_number_delete` AFTER DELETE ON `photos` FOR EACH ROW BEGIN
    UPDATE users
    SET numPhotos = numPhotos - 1
    WHERE id = OLD.idUser;
END
$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `answer`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `idForum` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `answer` longtext NOT NULL,
  `answerDate` DATETIME DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
--
-- Disparadores `answers`
--
DELIMITER $$
CREATE TRIGGER `actualizar_answer_number_insert` AFTER INSERT ON `answers` FOR EACH ROW BEGIN
    UPDATE forums
    SET numAnswers = numAnswers + 1
    WHERE id = NEW.idForum;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_answer_number_delete` AFTER DELETE ON `answers` FOR EACH ROW BEGIN
    UPDATE forums
    SET numAnswers = numAnswers - 1
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
  `title` varchar(255) NOT NULL,
  `dateCreated` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Disparadores `scripts`
--
DELIMITER $$
CREATE TRIGGER `update_numCodigo_after_delete` AFTER DELETE ON `scripts` FOR EACH ROW BEGIN
    UPDATE users
    SET numCodes = numCodes - 1
    WHERE id = OLD.idUser;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_numCodigo_after_insert` AFTER INSERT ON `scripts` FOR EACH ROW BEGIN
    UPDATE users
    SET numCodes = numCodes + 1
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
  `token` varchar(200),
  `username` varchar(65) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `birthdate` date DEFAULT '0000-00-00',
  `gender` int(255) DEFAULT 0,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT current_timestamp(),
  `fullname` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `profilePicture` longtext DEFAULT 'usuario.png',
  `numPhotos` int(11) DEFAULT 0,
  `numCodes` int(11) DEFAULT 0,
  `numForums` int(11) DEFAULT 0,
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
-- Indices de la tabla `answers`
--
ALTER TABLE `answers`
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
-- AUTO_INCREMENT de la tabla `answers`
--
ALTER TABLE `answers`
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
