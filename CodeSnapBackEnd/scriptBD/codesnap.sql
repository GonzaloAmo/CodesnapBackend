-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-05-2024 a las 17:01:05
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

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
  `creation_date` date NOT NULL,
  `response_number` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `forums`
--

INSERT INTO `forums` (`id`, `idUser`, `title`, `question`, `creation_date`, `response_number`) VALUES
(1, 2, 'Titulo del foro', 'Alguien sabe como realizar...? ', '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idPhoto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `likes`
--

INSERT INTO `likes` (`id`, `idUser`, `idPhoto`) VALUES
(1, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `photos`
--

CREATE TABLE `photos` (
  `id` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `route` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `numLikes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `photos`
--

INSERT INTO `photos` (`id`, `idUser`, `route`, `description`, `numLikes`) VALUES
(1, 0, 'asdasd', '', 0),
(2, 0, 'Hola Mundo', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responses`
--

CREATE TABLE `responses` (
  `id` int(11) NOT NULL,
  `idForum` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `response` varchar(500) NOT NULL,
  `response_Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `responses`
--

INSERT INTO `responses` (`id`, `idForum`, `idUser`, `response`, `response_Date`) VALUES
(1, 1, 2, 'Se puede hacer de tal manera...', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `scripts`
--

CREATE TABLE `scripts` (
  `id` int(255) NOT NULL,
  `idUser` varchar(255) NOT NULL,
  `code` longtext DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `fecha_creacion` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `scripts`
--

INSERT INTO `scripts` (`id`, `idUser`, `code`, `titulo`, `fecha_creacion`) VALUES
(1, '2', 'Code example', NULL, '2024-05-12'),
(3, '4', 'vale', 'cc', '2024-05-12'),
(4, '4', 'vale', 'cc', '2024-05-12'),
(5, '4', 'vale', 'cc', '2024-05-12'),
(6, '4', 'vale', 'cc', '2024-05-12');

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
  `telefono` int(255) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL DEFAULT current_timestamp(),
  `nombrecompleto` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `numfotos` int(11) DEFAULT 0,
  `numcodigo` int(11) DEFAULT 0,
  `foroscreados` int(11) DEFAULT 0,
  `role` varchar(50) DEFAULT 'USER'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `token`, `username`, `email`, `password`, `fechanacimiento`, `sexo`, `telefono`, `fecha_ingreso`, `nombrecompleto`, `descripcion`, `ubicacion`, `foto`, `numfotos`, `numcodigo`, `foroscreados`, `role`) VALUES
(2, '', 'usuario2', 'usuario2@example.com', '1234', '2000-01-01', 1, 628742007, '2024-04-24', 'Usuario Dos', 'Descripci del usuario dos', 'Ciudad Dos', NULL, 0, 0, 0, 'USER'),
(3, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTUxOTA3NzYsImRhdGEiOnsiaWQiOiIzIiwiZW1haWwiOiJ1c3VhcmlvM0BnbWFpbC5jb20ifX0.mZljW00UvPmu_bgbuEWA3NvtsgA32sHC2DiHYsQ0JhQ', 'nico2', 'usuario3@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, 1, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(4, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTU1MDkwMzQsImRhdGEiOnsiaWQiOiI0IiwiZW1haWwiOiJuaWNvQGdtYWlsLmNvbSJ9fQ.xGIVFh51R_EBUa6yC5GzeOlRZlFYLwQlyiCXNmf0KwU', 'nico', 'nico@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 4, 0, 'USER'),
(5, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTUxOTEzMjUsImRhdGEiOnsiaWQiOiI1IiwiZW1haWwiOiJ1c2VyNEBkZS5jb20ifX0.eOWEMY1I5rB0ztz7m3uPK4RBJLz_ZoYeAsc3d38Rgmw', 'user4', 'user4@de.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(6, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTU1MDg4ODksImRhdGEiOnsiaWQiOiI2IiwiZW1haWwiOiJyb290QGdtYWlsLmNvbSJ9fQ.HkhdqNaE7huUHvcRdkLMvLRtpWax5rPE_Zwtzke7XlQ', 'root', 'root@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '0000-00-00', 0, 0, '2024-05-08', 'NULL', 'NULL', 'NULL', NULL, 0, 0, 0, 'USER'),
(11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTUyOTAzOTQsImRhdGEiOnsiaWQiOiIxMSIsImVtYWlsIjoicm9vdDJAZ21haWwuY29tIn19.vvfxG5p6vpscVffwutRLlllPjN2iqApJjoy7bgoMaHc', 'root2', 'root2@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '0000-00-00', 0, 0, '2024-05-08', '', '', '', NULL, 0, 0, 0, 'USER'),
(12, '', 'root3', 'root3@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(13, '', 'root5', 'root5@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(14, '', 'root6', 'root6@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(18, '', 'root7', 'root7@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(19, '', 'root12', 'root12@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER'),
(20, '', 'root10', 'root10@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL, '2024-05-08', NULL, NULL, NULL, NULL, 0, 0, 0, 'USER');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `photos`
--
ALTER TABLE `photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `responses`
--
ALTER TABLE `responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `scripts`
--
ALTER TABLE `scripts`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
