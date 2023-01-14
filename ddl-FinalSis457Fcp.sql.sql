CREATE DATABASE FinalSis457Fcp
USE master
GO

CREATE LOGIN [usrfinal] WITH PASSWORD = N'12345678',
	DEFAULT_DATABASE = [FinalSis457Fcp],
	CHECK_EXPIRATION = OFF,
	CHECK_POLICY = ON
GO

USE [FinalSis457Fcp]
GO

CREATE USER [usrfinal] FOR LOGIN [usrfinal]
GO

ALTER ROLE [db_owner] ADD MEMBER [usrfinal]
GO

CREATE TABLE Serie(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(250) NOT NULL,
	sinopsis VARCHAR(5000) NOT NULL,
	director VARCHAR(100) NOT NULL,
	duracion INT NOT NULL,
);

CREATE TABLE Usuario(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	usuario VARCHAR(12) NOT NULL,
	clave VARCHAR(250) NOT NULL,
	rol VARCHAR(20) NOT NULL,
);

ALTER TABLE Serie ADD fechaEstreno DATETIME NULL DEFAULT GETDATE();
ALTER TABLE Serie ADD usuarioRegistro VARCHAR(12) NULL DEFAULT SUSER_SNAME();
ALTER TABLE Serie ADD registroActivo BIT NULL DEFAULT 1;

ALTER TABLE Usuario ADD registroActivo BIT NULL DEFAULT 1;

CREATE PROC paSerieListar @parametro VARCHAR(250)
AS
  SELECT id, titulo, sinopsis, director, duracion,usuarioRegistro
  FROM Serie
  WHERE registroActivo=1 AND titulo+director LIKE '%'+@parametro+'%'



EXEC paSerieListar 'The Walking Dead'
GO

INSERT INTO Serie(titulo, sinopsis, director, duracion)
VALUES ('The Simpson', 'La serie es una sátira hacia la sociedad estadounidense que narra la vida y el día a día de una familia de clase media de ese país', 'Frank Darabont',90);

INSERT INTO Usuario(usuario, clave, rol, registroActivo)
VALUES ('Franklin', '12345678' , 'Admin','true');

CREATE PROC paUsuarioListar @parametro VARCHAR(20)
AS
  SELECT id, usuario, rol
  FROM Usuario
  WHERE registroActivo=1 AND usuario+rol LIKE '%'+@parametro+'%'

  CREATE PROC paUsuarioListar @parametro VARCHAR(50)
AS
  SELECT id, usuario, clave, rol
  FROM Usuario
  WHERE id=1 AND usuario+clave LIKE '%'+@parametro+'%'
EXEC paUsuarioListar ''
GO