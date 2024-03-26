Create Database Clase02_20241C
go
Use Clase02_20241C
Go
Create Table Empleados(
    Legajo bigint not null identity (1000, 1),
    IDArea int not null,
    Apellidos varchar(50) not null,
    Nombres varchar(50) not null,
    Nacimiento date null,
    primary key(Legajo)
)
go
Create Table Areas(
    ID int not null,
    Nombre varchar(50) not null,
    Presupuesto money not null,
    Mail varchar(100) not null
)

-- Agregamos Telefono a Empleados
Alter Table Empleados
Add Telefono varchar(15) null

-- Agrega Primary Key a Areas (ID)
Alter Table Areas
Add Constraint PK_Areas Primary Key (ID)

-- Agrega Foreign Key a IDArea en Empleados
Alter Table Empleados
Add Constraint FK_Empleados_Areas Foreign Key (IDArea) References Areas(ID)

-- Agrega Unique a Mail en Areas
Alter Table Areas
Add Constraint UQ_Areas_Mail Unique(Mail)

-- Agrega Check a Presupuesto en Areas que obligue a que el presupuesto sea > 0
Alter Table Areas
Add Constraint CHK_Presupuesto_MayorACero Check (Presupuesto > 0)