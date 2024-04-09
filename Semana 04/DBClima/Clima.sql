Create Database Clima
GO
Use Clima
Go
Create Table Paises(
 IDPais int not null primary key,
 Nombre varchar(50) not null
)
Go
Create Table Ciudades(
 IDCiudad int not null primary key,
 IDPais int not null foreign key references Paises(IDPais),
 Nombre varchar(100) not null
)
Go
Create Table Mediciones(
 ID int not null primary key identity(1, 1),
 IDCiudad int not null foreign key references Ciudades(IDCiudad),
 FechaHora datetime not null,
 Temperatura decimal(5, 2) null,
 Viento decimal(5, 2) null,
 Lluvia decimal(5, 2) null 
)
Go
Create Table NivelesPeligrosidad(
    ID int not null primary key,
    Nombre varchar(50) not null,
    Severidad int not null,
    Color varchar(20) not null,
    Instrucciones varchar(250) not null
)
Go
Create Table AlertasMeteorologicos(
    ID int not null primary key identity (1, 1),
    IDMedicion int not null unique foreign key references Mediciones(ID),
    IDNivelPeligrosidad int not null foreign key references NivelesPeligrosidad(ID),
    DuracionMinutosEstimada int not null check (DuracionMinutosEstimada > 0)
)