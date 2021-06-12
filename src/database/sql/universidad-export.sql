-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2021 a las 06:08:46
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `universidad`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `granInnerJoin` (IN `P_nombreclase` VARCHAR(255))  BEGIN
SELECT mentores.Nombre as 'nombreMentor', clases.nombreclase, carreras.nombrecarrera, estudiantes.Nombre as 'nombreEstudiante'
FROM mentores INNER JOIN detalle_mentores ON detalle_mentores.idmentor=mentores.idmentor
INNER JOIN clases on detalle_mentores.nombreclase=clases.nombreclase
INNER JOIN detalle_clases ON detalle_clases.nombreclase=clases.nombreclase
INNER JOIN carreras ON carreras.nombrecarrera=detalle_clases.nombrecarrera
INNER JOIN detalle_carreras ON detalle_carreras.nombrecarrera=carreras.nombrecarrera
INNER JOIN estudiantes ON estudiantes.idestudiante=detalle_carreras.idestudiante
WHERE clases.nombreclase=P_nombreclase;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStudent` (IN `P_idestudiante` VARCHAR(255), IN `P_nombre` VARCHAR(255), IN `P_apellido` VARCHAR(255), IN `P_edad` INT, IN `P_correo` VARCHAR(255), IN `P_nombrecarrera` VARCHAR(255))  BEGIN
INSERT INTO `estudiantes`(`idestudiante`, `Nombre`, `Apellido`, `Edad`, `Correo`) VALUES (P_idestudiante,P_nombre,P_apellido,P_edad,P_correo);
INSERT INTO `detalle_carreras`(`idestudiante`, `nombrecarrera`) VALUES (P_idestudiante,P_nombrecarrera);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStudent` (IN `P_idestudiante` VARCHAR(255), IN `P_nombre` VARCHAR(255), IN `P_apellido` VARCHAR(255), IN `P_edad` INT, IN `P_correo` VARCHAR(255))  BEGIN
UPDATE `estudiantes` SET `idestudiante` = P_idestudiante, `Nombre`=P_Nombre,`Apellido`=P_apellido,`Edad`=p_edad,`Correo`=P_correo WHERE `idestudiante` = P_idestudiante;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

CREATE TABLE `carreras` (
  `nombrecarrera` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `duracion` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `carreras`
--

INSERT INTO `carreras` (`nombrecarrera`, `descripcion`, `duracion`) VALUES
('español', 'clase espa', 6),
('matematicas', 'clase mate', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

CREATE TABLE `clases` (
  `nombreclase` varchar(255) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Duracion` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clases`
--

INSERT INTO `clases` (`nombreclase`, `Descripcion`, `Duracion`) VALUES
('basicas', 'aprende basicas', 2),
('diptongo', 'aprende diptongo', 2),
('ortografia', 'aprende ortografia', 2),
('trigonometria', 'aprende trigonometria', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_carreras`
--

CREATE TABLE `detalle_carreras` (
  `idestudiante` varchar(255) DEFAULT NULL,
  `nombrecarrera` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_carreras`
--

INSERT INTO `detalle_carreras` (`idestudiante`, `nombrecarrera`) VALUES
('1007110961', 'matematicas'),
('1007110961', 'español'),
('1007110962', 'matematicas'),
('1007110962', 'español'),
('1007110964', 'matematicas'),
('1007110964', 'español'),
('1549a', 'matematicas'),
('14411s', 'matematicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_clases`
--

CREATE TABLE `detalle_clases` (
  `nombreclase` varchar(255) DEFAULT NULL,
  `nombrecarrera` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_clases`
--

INSERT INTO `detalle_clases` (`nombreclase`, `nombrecarrera`) VALUES
('diptongo', 'español'),
('ortografia', 'español'),
('trigonometria', 'matematicas'),
('basicas', 'matematicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_estudiantes`
--

CREATE TABLE `detalle_estudiantes` (
  `idmentor` varchar(255) DEFAULT NULL,
  `idestudiante` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_estudiantes`
--

INSERT INTO `detalle_estudiantes` (`idmentor`, `idestudiante`) VALUES
('102313ab', '1007110961'),
('102313ab', '1007110962'),
('102313ab', '1007110964');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_mentores`
--

CREATE TABLE `detalle_mentores` (
  `idmentor` varchar(255) DEFAULT NULL,
  `nombreclase` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_mentores`
--

INSERT INTO `detalle_mentores` (`idmentor`, `nombreclase`) VALUES
('102313ab', 'diptongo'),
('102313ab', 'ortografia'),
('123bba', 'trigonometria'),
('123bba', 'basicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `idestudiante` varchar(255) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido` varchar(255) DEFAULT NULL,
  `Edad` int(11) DEFAULT NULL,
  `Correo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`idestudiante`, `Nombre`, `Apellido`, `Edad`, `Correo`) VALUES
('1007110961', 'meiya', 'caleb', 18, 'meiya@correo.com'),
('1007110962', 'sifido', 'caleb', 18, 'sifido@correo.com'),
('1007110964', 'daivd', 'caleb', 18, 'daivd@correo.com'),
('1031441', 'oscar', 'fabricior car', 1, 'fabricio@gmail.com'),
('10551', 'viva e', 'hermano', 9, 'viva@correo.com'),
('1055779', 'pispo', 'por', 5, 'pispo@correo.com'),
('10557792', 'per', 'perls', 6, 'perl@correo.com'),
('10557796', 'asdas', 'adasd', 55, 'sadasdas'),
('122', 'karrl', 'pers', 153, 'pers@correo.com'),
('12355', 'asda', 'asdad', 2, 'aaa@correo.com'),
('14411s', 'styles', 'aaa', 5, 'styles@correo.com'),
('1549a', 'carlos1', 'c', 2, 'alvaroandres1@correo.com'),
('1904', 'martha', 'valencia', 50, 'martha@correo.com'),
('5652', 'pipe', 'asd', 6, 'uno@correo.com'),
('77332', 'aasd', 'asdasd', 7874, 'ggardfdd'),
('884334', 'dfsdf', 'sdfsdf', 6, 'asdagg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mentores`
--

CREATE TABLE `mentores` (
  `idmentor` varchar(255) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido` varchar(255) DEFAULT NULL,
  `Edad` int(11) DEFAULT NULL,
  `Experiencia` int(11) DEFAULT NULL,
  `Correo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mentores`
--

INSERT INTO `mentores` (`idmentor`, `Nombre`, `Apellido`, `Edad`, `Experiencia`, `Correo`) VALUES
('102313ab', 'alvaro', 'garon', 20, 3, 'alvaro@correo.com'),
('123bba', 'carlos', 'sosa', 20, 4, 'carlos@correo.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD PRIMARY KEY (`nombrecarrera`);

--
-- Indices de la tabla `clases`
--
ALTER TABLE `clases`
  ADD PRIMARY KEY (`nombreclase`);

--
-- Indices de la tabla `detalle_carreras`
--
ALTER TABLE `detalle_carreras`
  ADD KEY `fk_IdEstudianter` (`idestudiante`),
  ADD KEY `fk_NombreCarreraf` (`nombrecarrera`);

--
-- Indices de la tabla `detalle_clases`
--
ALTER TABLE `detalle_clases`
  ADD KEY `fkNombreClase` (`nombreclase`),
  ADD KEY `fknombreCarrera` (`nombrecarrera`);

--
-- Indices de la tabla `detalle_estudiantes`
--
ALTER TABLE `detalle_estudiantes`
  ADD KEY `fk_IdMentor` (`idmentor`),
  ADD KEY `fk_IdEstudiante` (`idestudiante`);

--
-- Indices de la tabla `detalle_mentores`
--
ALTER TABLE `detalle_mentores`
  ADD KEY `fk_IdMentorr` (`idmentor`),
  ADD KEY `fk_NombreClaser` (`nombreclase`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`idestudiante`);

--
-- Indices de la tabla `mentores`
--
ALTER TABLE `mentores`
  ADD PRIMARY KEY (`idmentor`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_carreras`
--
ALTER TABLE `detalle_carreras`
  ADD CONSTRAINT `fk_IdEstudianter` FOREIGN KEY (`idestudiante`) REFERENCES `estudiantes` (`idestudiante`),
  ADD CONSTRAINT `fk_NombreCarreraf` FOREIGN KEY (`nombrecarrera`) REFERENCES `carreras` (`nombrecarrera`);

--
-- Filtros para la tabla `detalle_clases`
--
ALTER TABLE `detalle_clases`
  ADD CONSTRAINT `fkNombreClase` FOREIGN KEY (`nombreclase`) REFERENCES `clases` (`nombreclase`),
  ADD CONSTRAINT `fknombreCarrera` FOREIGN KEY (`nombrecarrera`) REFERENCES `carreras` (`nombrecarrera`);

--
-- Filtros para la tabla `detalle_estudiantes`
--
ALTER TABLE `detalle_estudiantes`
  ADD CONSTRAINT `fk_IdEstudiante` FOREIGN KEY (`idestudiante`) REFERENCES `estudiantes` (`idestudiante`),
  ADD CONSTRAINT `fk_IdMentor` FOREIGN KEY (`idmentor`) REFERENCES `mentores` (`idmentor`);

--
-- Filtros para la tabla `detalle_mentores`
--
ALTER TABLE `detalle_mentores`
  ADD CONSTRAINT `fk_IdMentorr` FOREIGN KEY (`idmentor`) REFERENCES `mentores` (`idmentor`),
  ADD CONSTRAINT `fk_NombreClaser` FOREIGN KEY (`nombreclase`) REFERENCES `clases` (`nombreclase`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
