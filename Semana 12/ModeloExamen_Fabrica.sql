Create Database ModeloExamenIntegrador_20241C Collate Latin1_general_CI_AI
Go
Use ModeloExamenIntegrador_20241C
Go
Create Table Materiales(
    IDMaterial smallint not null primary key identity,
    Nombre varchar(50) not null
)
Go
Create Table Piezas(
    IDPieza bigint not null primary key identity,
    Nombre varchar(500) not null,
    IDMaterial smallint not null foreign key references Materiales(IDMaterial),
    MedidaMinima decimal (5,2 ) not null,
    MedidaMaxima decimal (5,2 ) not null,
    CostoUnitarioProduccion money not null
)
Go
Create Table Operarios(
    IDOperario bigint not null primary key identity,
    Nombres varchar(50) not null,
    Apellidos varchar(50) not null,
    AnioNacimiento smallint not null,
    AnioAlta smallint not null
)
Go
Create Table Produccion(
    IDProduccion bigint not null primary key identity,
    IDOperario bigint not null foreign key references Operarios(IDOperario),
    IDPieza bigint not null foreign key references Piezas(IDPieza),
    Fecha date not null,
    Medida decimal(5, 2) not null,
    Cantidad int not null,
    CostoTotal money not null    
)

Set Dateformat 'YMD'

INSERT INTO Materiales (Nombre) VALUES
('Acero'),
('Aluminio'),
('Cobre'),
('Plástico'),
('Vidrio'),
('Madera'),
('Hormigón'),
('Fibra de vidrio'),
('Cerámica'),
('Titanio');

INSERT INTO Operarios (Nombres, Apellidos, AnioNacimiento, AnioAlta) VALUES
('Juan', 'Pérez', 1980, 2010),
('María', 'González', 1985, 2012),
('Carlos', 'Rodríguez', 1978, 2008),
('Ana', 'López', 1990, 2015),
('Luis', 'Martínez', 1982, 2011),
('Marta', 'Gómez', 1988, 2013),
('José', 'Hernández', 1975, 2005),
('Laura', 'Díaz', 1992, 2016),
('David', 'Fernández', 1983, 2012),
('Isabel', 'Torres', 1979, 2009),
('Pedro', 'Ramírez', 1981, 2010),
('Sofía', 'Flores', 1991, 2017),
('Jorge', 'Moreno', 1984, 2013),
('Lucía', 'Ortiz', 1987, 2014),
('Miguel', 'Jiménez', 1980, 2010),
('Raquel', 'Ruiz', 1993, 2018),
('Sergio', 'Suárez', 1976, 2006),
('Patricia', 'Romero', 1986, 2011),
('Fernando', 'Navarro', 1977, 2024),
('Elena', 'Molina', 1990, 2020);

INSERT INTO Piezas (Nombre, IDMaterial, MedidaMinima, MedidaMaxima, CostoUnitarioProduccion) VALUES
('Tornillo M4', 1, 0.50, 1.00, 0.10),
('Tornillo M6', 1, 0.60, 1.20, 0.15),
('Tuerca M4', 1, 0.40, 0.90, 0.08),
('Tuerca M6', 1, 0.50, 1.00, 0.12),
('Arandela M4', 1, 0.30, 0.80, 0.05),
('Arandela M6', 1, 0.40, 0.90, 0.07),
('Perno 8mm', 2, 1.00, 2.00, 0.50),
('Perno 10mm', 2, 1.20, 2.20, 0.60),
('Chapa de acero 1m', 1, 50.00, 100.00, 10.00),
('Chapa de aluminio 1m', 2, 40.00, 90.00, 12.00),
('Tubo de cobre 1m', 3, 30.00, 80.00, 15.00),
('Válvula de plástico', 4, 2.00, 5.00, 1.50),
('Vidrio templado 1m', 5, 20.00, 70.00, 25.00),
('Tabla de madera 1m', 6, 100.00, 200.00, 20.00),
('Bloque de hormigón', 7, 15.00, 25.00, 5.00);

INSERT INTO Produccion (IDOperario, IDPieza, Fecha, Medida, Cantidad, CostoTotal) VALUES
(1, 1, '2023-01-15', 0.60, 100, 10.00),  
(1, 1, '2024-01-15', 0.60, 200, 20.00),  
(2, 1, '2023-01-15', 0.60, 100, 10.00),  
(2, 3, '2023-02-20', 0.45, 150, 12.00),  
(3, 7, '2023-03-10', 1.50, 200, 100.00), 
(4, 12, '2023-04-05', 3.00, 50, 75.00),  
(5, 10, '2023-05-25', 95.00, 30, 360.00);

