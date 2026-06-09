use master
go 

create database empresaSQL
go

use empresaSQL

CREATE SCHEMA Personal;
GO
CREATE SCHEMA Operaciones;
GO


CREATE TABLE Personal.TDepartamento (           
    nDepartamentoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreDepartamento VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE Personal.TCargo (
    nCargoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreCargo VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE Personal.TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF NVARCHAR(20) UNIQUE NOT NULL,
    cNombre NVARCHAR(50),
    cApellido NVARCHAR(50),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE DEFAULT GETDATE(), -- 7. Restricción DEFAULT
    nSalario DECIMAL(10,2) CHECK (nSalario > 300), -- 6. Restricción CHECK
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (nDepartamentoID) REFERENCES Personal.TDepartamento(nDepartamentoID), -- 8. Llave foránea
    CONSTRAINT FK_Empleado_Cargo FOREIGN KEY (nCargoID) REFERENCES Personal.TCargo(nCargoID) -- 9. Llave foránea
);


CREATE TABLE Operaciones.TProyecto (
    nProyectoID INT IDENTITY(1,1) PRIMARY KEY, 
    cNombreProyecto VARCHAR(150) NOT NULL,    
    dFechaInicio DATE NOT NULL,                
    dFechaFin DATE                             
);


CREATE TABLE Operaciones.TEmpleadoProyecto (
    nEmpleadoID INT,
    nProyectoID INT,
    PRIMARY KEY (nEmpleadoID, nProyectoID),
    FOREIGN KEY (nEmpleadoID) REFERENCES Personal.TEmpleado(nEmpleadoID),
    FOREIGN KEY (nProyectoID) REFERENCES Operaciones.TProyecto(nProyectoID)
);

ALTER TABLE Personal.TEmpleado ADD cEmail NVARCHAR(100);

ALTER TABLE Personal.TEmpleado ADD cTelefono NVARCHAR(20);

ALTER TABLE Personal.TEmpleado ALTER COLUMN cNombre NVARCHAR(100);

ALTER TABLE Personal.TEmpleado ALTER COLUMN cApellido NVARCHAR(100);


ALTER TABLE Personal.TEmpleado ADD cDireccion NVARCHAR(255);


ALTER TABLE Personal.TEmpleado ADD nEdad INT;


ALTER TABLE Personal.TEmpleado ADD CONSTRAINT CHK_Empleado_Edad CHECK (nEdad BETWEEN 18 AND 65);


ALTER TABLE Personal.TEmpleado ADD CONSTRAINT UQ_Empleado_Email UNIQUE (cEmail);


ALTER TABLE Personal.TEmpleado ADD bActivo BIT DEFAULT 1;


ALTER TABLE Personal.TEmpleado DROP COLUMN cDireccion;


ALTER TABLE Personal.TEmpleado ALTER COLUMN cTelefono NVARCHAR(20);


ALTER TABLE Personal.TEmpleado ADD cGenero CHAR(1);


ALTER TABLE Personal.TEmpleado ADD CONSTRAINT CHK_Empleado_Genero CHECK (cGenero IN ('M', 'F'));


ALTER TABLE Personal.TEmpleado ADD dFechaNacimiento DATE;


CREATE TABLE Personal.TSucursal (
    nSucursalID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreSucursal VARCHAR(100) NOT NULL,
    cUbicacion VARCHAR(150)
);


INSERT INTO Personal.TDepartamento (cNombreDepartamento) VALUES 
('Recursos Humanos'), ('Contabilidad'), ('Tecnología'), ('Ventas'), ('Marketing');


INSERT INTO Personal.TCargo (cNombreCargo) VALUES 
('Gerente'), ('Analista'), ('Desarrollador'), ('Contador'), ('Asistente');


INSERT INTO Personal.TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, bActivo, cGenero, dFechaNacimiento) VALUES
('12345678A', 'Juan', 'García', 3, 3, '2025-01-15', 1500.00, 'juan.garcia@empresa.com', '123456789', 30, 1, 'M', '1995-05-12'),
('23456789B', 'María', 'López', 1, 1, '2024-03-22', 2500.00, 'maria.lopez@empresa.com', '987654321', 40, 1, 'F', '1985-08-24'),
('34567890C', 'Carlos', 'Gómez', 2, 4, '2026-02-10', 1200.00, 'carlos.gomez@empresa.com', '456123789', 28, 1, 'M', '1997-11-02'),
('45678901D', 'Ana', 'Martínez', 4, 2, '2023-06-01', 950.00, 'ana.martinez@empresa.com', '789456123', 35, 1, 'F', '1990-04-15'),
('56789012E', 'Luis', 'Rodríguez', 3, 3, '2025-09-18', 1600.00, 'luis.rodriguez@empresa.com', '321654987', 32, 1, 'M', '1993-01-30'),
('67890123F', 'Elena', 'Sánchez', 5, 5, '2026-01-05', 450.00, 'elena.sanchez@empresa.com', '654987321', 23, 0, 'F', '2003-07-19'),
('78901234G', 'Pedro', 'Fernández', 2, 5, '2025-11-12', 400.00, 'pedro.fernandez@empresa.com', '147258369', 25, 0, 'M', '2000-10-05'),
('89012345H', 'Sofía', 'Pérez', 1, 2, '2024-07-19', 1100.00, 'sofia.perez@empresa.com', '369258147', 45, 1, 'F', '1980-12-12'),
('90123456I', 'Miguel', 'González', 4, 3, '2026-03-01', 1350.00, 'miguel.gonzalez@empresa.com', '258369147', 29, 1, 'M', '1997-03-25'),
('01234567J', 'Lucía', 'Díaz', 3, 2, '2025-05-20', 1700.00, 'lucia.diaz@empresa.com', '951753456', 38, 1, 'F', '1987-09-14');


INSERT INTO Operaciones.TProyecto (cNombreProyecto, dFechaInicio, dFechaFin) VALUES
('Sistema ERP', '2026-01-10', '2026-08-30'),
('Campaña Navideña', '2026-10-01', '2026-12-24'),
('Migración Cloud', '2026-02-15', NULL);


INSERT INTO Operaciones.TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES
(1, 1), (1, 3), (2, 1), (5, 1), (9, 3), (10, 1);

INSERT INTO Personal.TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, bActivo, cGenero) VALUES
('11223344K', 'Jorge', 'Gutiérrez', 3, 3, 1400.00, 'jorge.gutierrez@empresa.com', 27, 1, 'M');

INSERT INTO Personal.TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, nEdad, bActivo, cGenero) VALUES
('55667788L', 'Laura', 'Torres', 4, 5, '2026-04-01', 600.00, 'laura.torres@empresa.com', 24, 1, 'F');


INSERT INTO Personal.TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, nEdad, cGenero) VALUES
('99001122M', 'Andrés', 'Castro', 2, 4, '2026-04-10', 1250.00, 'andres.castro@empresa.com', 31, 'M');

INSERT INTO Personal.TCargo (cNombreCargo) VALUES 
('Director Ejecutivo'), ('Supervisor de Planta');

UPDATE Personal.TEmpleado SET nSalario = nSalario * 1.10;

UPDATE Personal.TEmpleado SET nSalario = nSalario * 1.20 WHERE nDepartamentoID = 3;

UPDATE Personal.TEmpleado SET cEmail = 'juan.g_actualizado@empresa.com' WHERE nEmpleadoID = 1;

UPDATE Personal.TEmpleado SET nCargoID = 1 WHERE nEmpleadoID = 5;

UPDATE Personal.TEmpleado SET nDepartamentoID = 2 WHERE nEmpleadoID IN (4, 9);

UPDATE Personal.TEmpleado SET bActivo = 0 WHERE nSalario < 500;

UPDATE Operaciones.TProyecto SET dFechaFin = '2026-09-15' WHERE nProyectoID = 1;

INSERT INTO Operaciones.TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES (3, 3);

-- 49. Eliminar un empleado específico mediante su NIF (Removiendo dependencias en el esquema Operaciones primero).
DELETE FROM Operaciones.TEmpleadoProyecto WHERE nEmpleadoID = (SELECT nEmpleadoID FROM Personal.TEmpleado WHERE cNIF = '12345678A');
DELETE FROM Personal.TEmpleado WHERE cNIF = '12345678A';

-- 50. Eliminar todos los empleados inactivos.
DELETE FROM Operaciones.TEmpleadoProyecto WHERE nEmpleadoID IN (SELECT nEmpleadoID FROM Personal.TEmpleado WHERE bActivo = 0);
DELETE FROM Personal.TEmpleado WHERE bActivo = 0;

-- 51. Eliminar un proyecto específico (ej: ID 2).
DELETE FROM Operaciones.TEmpleadoProyecto WHERE nProyectoID = 2;
DELETE FROM Operaciones.TProyecto WHERE nProyectoID = 2;

-- 52. Eliminar las asignaciones de un empleado (ej: ID 1) en la tabla intermedia.
DELETE FROM Operaciones.TEmpleadoProyecto WHERE nEmpleadoID = 1;

-- 53. Eliminar un departamento que no tenga empleados asociados.
DELETE FROM Personal.TDepartamento WHERE nDepartamentoID NOT IN (SELECT DISTINCT nDepartamentoID FROM Personal.TEmpleado WHERE nDepartamentoID IS NOT NULL);