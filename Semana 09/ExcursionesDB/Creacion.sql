Create Database ExcursionesDB Collate Latin1_general_CI_AI
Go
Use ExcursionesDB
Go
Create Table Vehiculos(
    ID_Vehiculo int not null primary key identity (1, 1),
    Patente varchar(10) not null unique,
    AñoPatentamiento int not null,
    Cupo_Maximo smallint not null,
    Eliminado bit not null default (0)
)
Go
Create Table Destinos(
    ID_Destino int not null primary key identity (1, 1),
    Nombre varchar(50) not null,
    DificultadDelCamino tinyint not null,
    Pais varchar(20) not null,
    Costo money not null
)
Go
Create Table Excursiones(
    ID_Excursion int not null primary key identity (1, 1),
    ID_Destino int not null foreign key references Destinos (ID_Destino),
    ID_Vehiculo int not null foreign key references Vehiculos (ID_Vehiculo),
    FechaHora datetime not null,
    Costo money not null,
    Cancelada bit not null default (0)
)
Go
Create Table Clientes(
    ID_Cliente int not null primary key identity (1, 1),
    Apellido varchar(100) not null,
    Nombre varchar(100) not null,
    FechaNacimiento date not null,
    Celular varchar(20) null,
    Telefono varchar(15) null,
    Mail varchar(250) not null,
    Saldo money not null default (0)
)
Go
Create Table Ventas(
    ID_Venta bigint not null primary key identity (1, 1),
    ID_Cliente int not null foreign key references Clientes(ID_Cliente),
    ID_Excursion int not null foreign key references Excursiones(ID_Excursion),
    Fecha datetime not null,
    CantidadPasajes int not null,
    Total money not null,
    Cancelada bit not null default(0)
)
Go
Create Table FormasPagos(
    ID_FormaPago tinyint not null primary key identity (1, 1),
    Nombre varchar(50) not null,
    Electronica bit not null
)
Go
Create Table Pagos(
    ID_Pago bigint not null primary key identity (1, 1),
    ID_Venta bigint not null foreign key references Ventas(ID_Venta),
    ID_FormaPago tinyint not null foreign key references FormasPagos(ID_FormaPago),
    FechaHora datetime not null,
    Importe money not null,
    Cancelado bit not null
)