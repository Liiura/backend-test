CREATE DATABASE universidad;
use universidad;
CREATE TABLE mentores(idmentor VARCHAR(255) NOT NULL PRIMARY KEY, Nombre varchar(255), Apellido varchar(255), Edad int, Experiencia int, Correo varchar(255));
CREATE TABLE clases(nombreclase VARCHAR(255) NOT NULL PRIMARY KEY, Descripcion varchar(255), Duracion float);
CREATE TABLE estudiantes(idestudiante varchar(255) NOT NULL PRIMARY KEY, Nombre varchar(255), Apellido varchar(255), Edad int, Correo varchar(255));
CREATE TABLE carreras(nombrecarrera varchar(255) NOT NULL PRIMARY KEY, descripcion varchar(255), duracion float);
CREATE TABLE detalle_clases(nombreclase varchar(255), CONSTRAINT fkNombreClase FOREIGN KEY (nombreclase) REFERENCES clases(nombreclase), idmentor varchar(255), CONSTRAINT fkIdmentor FOREIGN KEY (idmentor) REFERENCES mentores(idmentor));
CREATE TABLE detalle_mentores(idmentor varchar(255), nombreclase varchar(255), CONSTRAINT fk_IdMentor FOREIGN KEY (idmentor) REFERENCES mentores(idmentor), CONSTRAINT fk_NombreClase FOREIGN KEY (nombreclase) REFERENCES clases(nombreclase));
CREATE TABLE detalle_estudiantes(idmentor varchar(255), idestudiante varchar(255), CONSTRAINT fk_IdMentorr FOREIGN KEY (idmentor) REFERENCES mentores(idmentor), CONSTRAINT fk_IdEstudianter FOREIGN KEY (idestudiante) REFERENCES estudiantes(idestudiante));
CREATE TABLE detalle_carreras(idestudiante varchar(255), nombrecarrera varchar(255), CONSTRAINT fk_IdEstudianter FOREIGN KEY (idestudiante) REFERENCES estudiantes(idestudiante), CONSTRAINT fk_NombreCarreraf FOREIGN KEY (nombrecarrera) REFERENCES carreras(nombrecarrera));

DELIMITER //
CREATE PROCEDURE insertStudent(IN P_idestudiante varchar(255), IN P_nombre varchar(255), IN P_apellido varchar(255), IN P_edad int,IN P_correo varchar(255))
BEGIN
INSERT INTO `estudiantes`(`idestudiante`, `Nombre`, `Apellido`, `Edad`, `Correo`) VALUES (P_idestudiante,P_nombre,P_apellido,P_edad,P_correo);
END //

DELIMITER //
CREATE PROCEDURE insertStudent(IN P_idestudiante varchar(255), IN P_nombre varchar(255), IN P_apellido varchar(255), IN P_edad int,IN P_correo varchar(255))
BEGIN
UPDATE `estudiantes` SET `Nombre`=P_Nombre,`Apellido`=P_apellido,`Edad`=p_edad,`Correo`=P_correo WHERE `idestudiante` = P_idestudiante;
END //

SELECT mentores.Nombre, clases.nombreclase, carreras.nombrecarrera, estudiantes.Nombre as 'nombre-estudiante'
FROM mentores INNER JOIN detalle_mentores ON detalle_mentores.idmentor=mentores.idmentor
INNER JOIN clases on detalle_mentores.nombreclase=clases.nombreclase
INNER JOIN detalle_clases ON detalle_clases.nombreclase=clases.nombreclase
INNER JOIN carreras ON carreras.nombrecarrera=detalle_clases.nombrecarrera
INNER JOIN detalle_carreras ON detalle_carreras.nombrecarrera=carreras.nombrecarrera
INNER JOIN estudiantes ON estudiantes.idestudiante=detalle_carreras.idestudiante
WHERE clases.nombreclase='ortografia';

delimiter //
CREATE PROCEDURE granInnerJoin(IN P_nombreclase varchar(255)) BEGIN SELECT mentores.Nombre as 'nombreMentor', clases.nombreclase, carreras.nombrecarrera, estudiantes.Nombre as 'nombreEstudiante' FROM mentores INNER JOIN detalle_mentores ON detalle_mentores.idmentor=mentores.idmentor INNER JOIN clases on detalle_mentores.nombreclase=clases.nombreclase INNER JOIN detalle_clases ON detalle_clases.nombreclase=clases.nombreclase INNER JOIN carreras ON carreras.nombrecarrera=detalle_clases.nombrecarrera INNER JOIN detalle_carreras ON detalle_carreras.nombrecarrera=carreras.nombrecarrera INNER JOIN estudiantes ON estudiantes.idestudiante=detalle_carreras.idestudiante WHERE clases.nombreclase=P_nombreclase; END //