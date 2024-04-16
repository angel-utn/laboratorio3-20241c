Use Univ2
Go
Create Table Usuarios(
    ID bigint not null primary key identity (1, 1),
    NombreUsuario varchar(50) not null unique,
    Clave varchar(512) not null default ('') --- Text Plano --> ??? --> Hash Encriptado
)
Go
Create Table Paises(
    ID smallint not null primary key identity (1, 1),
    Nombre varchar(50) not null
)
Go
Create Table Localidades(
    ID int not null primary key,
    IDPais smallint not null foreign key references Paises(ID),
    Nombre varchar(50) not null
)
Go
Create Table Datos_Personales(
    ID bigint not null primary key foreign key references Usuarios(ID),
    Apellidos varchar(100) not null,
    Nombres varchar(100) not null,
    Nacimiento datetime not null,
    IDGenero char null, -- Foreign Key References Generos(ID)
    Telefono varchar(15) null,
    Celular varchar(15) null,
    Email varchar(140) null,
    Domicilio varchar(200) null,
    IDLocalidad int not null foreign key references Localidades(ID)
)
Go
Create Table Inscripciones(
    ID bigint not null primary key identity (1, 1),
    IDUsuario bigint not null foreign key references Usuarios(ID),
    IDCurso int not null foreign key references Cursos(ID),
    Fecha date not null,
    Costo money not null
)
Go
Create Table Certificaciones(
    IDInscripcion bigint not null primary key foreign key references Inscripciones(ID),
    Fecha date not null,
    Costo money not null
)
Go
Create Table Instructores_x_Curso(
    IDUsuario bigint not null foreign key references Usuarios(ID),
    IDCurso int not null foreign key references Cursos(ID),
    primary key (IDUsuario, IDCurso)
)
Go
Create Table Pagos(
    ID bigint not null primary key identity (1, 1),
    IDInscripcion bigint not null foreign key references Inscripciones(ID),
    Fecha date not null,
    Importe money not null check (Importe > 0)
)
Create Table Reseñas(
    IDInscripcion bigint not null primary key foreign key references Inscripciones(ID),
    Fecha date not null,
    Observacion text not null,
    Puntaje decimal(3, 1) not null check(Puntaje Between 0 and 10),
    Inapropiada bit not null default(0)
)

