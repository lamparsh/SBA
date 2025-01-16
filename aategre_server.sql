-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-01-2025 a las 18:43:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aategre_server`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficiarios`
--

CREATE TABLE `beneficiarios` (
  `id` int(11) NOT NULL,
  `cedula` varchar(30) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int(11) NOT NULL,
  `sexo` enum('Masculino','Femenino') NOT NULL,
  `tipo_pension` varchar(100) NOT NULL,
  `monto_pension` decimal(15,2) NOT NULL,
  `cuota_pension` decimal(15,2) NOT NULL,
  `epicrisis_nombre` varchar(255) NOT NULL,
  `epicrisis_tipo` varchar(50) NOT NULL,
  `epicrisis_contenido` longblob NOT NULL,
  `constancia_nombre` varchar(255) NOT NULL,
  `constancia_tipo` varchar(50) NOT NULL,
  `constancia_contenido` longblob NOT NULL,
  `reglamento_nombre` varchar(255) NOT NULL,
  `reglamento_tipo` varchar(50) NOT NULL,
  `reglamento_contenido` longblob NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora_ingresos`
--

CREATE TABLE `bitacora_ingresos` (
  `id` int(11) NOT NULL,
  `fecha_hora_ingreso` datetime NOT NULL,
  `fecha_hora_salida` datetime DEFAULT NULL,
  `nombre_user` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora_movimientos`
--

CREATE TABLE `bitacora_movimientos` (
  `id` int(11) NOT NULL,
  `detalle` text NOT NULL,
  `fecha_hora_movimiento` datetime NOT NULL,
  `tipo_movimiento` varchar(50) NOT NULL,
  `nombre_user` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expedientes`
--

CREATE TABLE `expedientes` (
  `id_expe` int(11) NOT NULL,
  `cedula` varchar(50) NOT NULL,
  `fecha_incidente` date DEFAULT NULL,
  `descripcion_incidente` text DEFAULT NULL,
  `acciones_tomadas` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `estado` enum('Activo','Cerrado','En revisión') DEFAULT 'En revisión',
  `Nota` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permisos` int(11) NOT NULL,
  `nombre_permiso` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permisos`, `nombre_permiso`) VALUES
(1, 'Beneficiarios'),
(2, 'Usuarios'),
(3, 'Reportes'),
(4, 'Roles y permisos'),
(5, 'Bitácoras'),
(6, 'Ayuda'),
(7, 'Acerca de'),
(8, 'Salir'),
(9, 'actualizar_beneficiario'),
(10, 'actualizar_expediente'),
(11, 'eliminar_beneficiario'),
(12, 'editar_beneficiarios'),
(13, 'agregar_beneficiarios'),
(14, 'agregar_expediente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_roles` int(11) NOT NULL,
  `nombre_rol` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_roles`, `nombre_rol`) VALUES
(1, 'Admin'),
(2, 'Gestor'),
(3, 'Usuario'),
(9, 'Consulta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permisos`
--

CREATE TABLE `rol_permisos` (
  `id_rol_permisos` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permisos`
--

INSERT INTO `rol_permisos` (`id_rol_permisos`, `id_rol`, `id_permiso`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 2, 1),
(11, 2, 5),
(12, 2, 6),
(13, 2, 7),
(14, 3, 3),
(16, 3, 6),
(17, 3, 7),
(24, 2, 12),
(26, 1, 10),
(27, 1, 9),
(28, 1, 11),
(43, 1, 12),
(45, 1, 13),
(47, 3, 8),
(48, 1, 14),
(50, 2, 8),
(51, 2, 3),
(57, 2, 14),
(58, 9, 1),
(59, 9, 6),
(60, 9, 7),
(61, 9, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre_user` varchar(50) NOT NULL,
  `nombre_empleado` varchar(30) NOT NULL,
  `correo` varchar(200) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_roles` int(11) DEFAULT NULL,
  `token_password` varchar(100) DEFAULT NULL,
  `token_expira` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre_user`, `nombre_empleado`, `correo`, `contrasena`, `id_roles`, `token_password`, `token_expira`) VALUES
(8, 'Taty', '', '', '$2y$10$uBfQhHFmew5O1XqUcroQ7.WQ4OhdBf5qv5aVxnOpjks8suc9tsOHO', 3, NULL, NULL),
(9, 'Beto', '', '', '$2y$10$bINOW.eSGZxZEreIOTQDh..mGVB8SUJcKcB4kHrtKxmQRrjQnKNV.', 2, NULL, NULL),
(13, 'Juan Perez', '', '', '$2y$10$GazOv2RT4dauTUe8M4NVmO1W0bVN/3NhNnRcRgeZcQw9ua4NU5Za.', 9, NULL, NULL),
(19, 'ECH04', 'Esteban Codero', 'ch04esteban@gmail.com', '$2y$10$AZbXQ95MPDYsbSQyk2RN8OWvgDjvULJ/kQCvmW9WIK/9oecrTQEA6', 1, '0a9a31764d7b1d3b9d402988d63e02150348ebcd0adf19dc70442f43e577f82e0d0006f727116b352c5d5f7b5afac5b61f7f', '2024-12-28 19:01:16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `beneficiarios`
--
ALTER TABLE `beneficiarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cedula` (`cedula`);

--
-- Indices de la tabla `bitacora_ingresos`
--
ALTER TABLE `bitacora_ingresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `bitacora_movimientos`
--
ALTER TABLE `bitacora_movimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `expedientes`
--
ALTER TABLE `expedientes`
  ADD PRIMARY KEY (`id_expe`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permisos`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_roles`);

--
-- Indices de la tabla `rol_permisos`
--
ALTER TABLE `rol_permisos`
  ADD PRIMARY KEY (`id_rol_permisos`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_roles` (`id_roles`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `beneficiarios`
--
ALTER TABLE `beneficiarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `bitacora_ingresos`
--
ALTER TABLE `bitacora_ingresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `bitacora_movimientos`
--
ALTER TABLE `bitacora_movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT de la tabla `expedientes`
--
ALTER TABLE `expedientes`
  MODIFY `id_expe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permisos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_roles` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `rol_permisos`
--
ALTER TABLE `rol_permisos`
  MODIFY `id_rol_permisos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `rol_permisos`
--
ALTER TABLE `rol_permisos`
  ADD CONSTRAINT `rol_permisos_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_roles`) ON DELETE CASCADE,
  ADD CONSTRAINT `rol_permisos_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permisos`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_roles`) REFERENCES `roles` (`id_roles`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
