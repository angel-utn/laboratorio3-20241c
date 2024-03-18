Create Database Clase01_20241C
Go
Use Clase01_20241C
Go
Create Table Areas(
    ID int not null primary key,
    Nombre varchar(50) not null,
    Presupuesto money not null check (Presupuesto > 0),
    Mail varchar(100) not null unique
)
go
Create Table Empleados(
    Legajo int not null primary key identity (1000, 1),
    IDArea int not null foreign key references Areas(ID),
    Apellido varchar(50) not null,
    Nombre varchar(50) not null,
    Nacimiento date null
)