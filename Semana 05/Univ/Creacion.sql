Create Database Univ
go
Use Univ
Go
Create Table Niveles(
    ID tinyint not null primary key identity (1, 1),
    Nombre varchar(50) not null
)
GO
Create Table Idiomas(
    ID smallint not null primary key identity (1, 1),
    Nombre varchar(50) not null
)
GO
Create Table FormatosIdioma(
    ID tinyint not null primary key identity (1, 1),
    Nombre varchar(50) not null
)
Go
Create Table Categorias(
    ID smallint not null primary key identity (1, 1),
    Nombre varchar(100) not null
)
GO
Create Table TiposContenido(
    ID int not null primary key identity (1, 1),
    Nombre varchar(100) not null
)
Go
Create Table Cursos(
    ID bigint not null primary key identity (1, 1),
    IDNivel tinyint null foreign key references Niveles(ID),
    Nombre varchar(100) not null,
    CostoCurso money not null check (CostoCurso >= 0),
    CostoCertificacion money not null check (CostoCertificacion >= 0),
    Estreno date not null
)
Go
Create Table Clases(
    ID bigint not null primary key identity (1, 1),
    IDCurso bigint not null foreign key references Cursos(ID),
    Nombre varchar(100) not null,
    Numero smallint null check (Numero >= 0),
    Duracion int not null check (Duracion > 0)
)
Go
Create Table Contenidos(
    ID bigint not null primary key identity (1, 1),
    IDClase bigint not null foreign key references Clases(ID),
    IDTipo int not null foreign key references TiposContenido(ID),
    Tamaño int not null check (Tamaño > 0)
)
Go
Create Table Idiomas_x_Curso(
    IDCurso bigint not null foreign key references Cursos(ID),
    IDIdioma smallint not null foreign key references Idiomas(ID),
    IDFormatoIdioma tinyint not null foreign key references FormatosIdioma(ID),
    Primary key (IDCurso, IDIdioma, IDFormatoIdioma)
)
go
Create Table Categorias_x_Curso(
    IDCurso bigint not null foreign key references Cursos(ID),
    IDCategoria smallint not null foreign key references Categorias(ID),
    Primary Key (IDCurso, IDCategoria)
)
go
Create Table Paises(
    ID smallint not null primary key,
    Nombre varchar(50) not null
)
go
Create Table Localidades(
    ID int not null primary key,
    IDPais smallint not null foreign key references Paises(ID),
    Nombre varchar(50) not null
)
go
Create Table Usuarios(
    ID bigint not null primary key identity (1, 1),
    NombreUsuario varchar(50) not null unique,
)
go
Create Table Datos_Personales(
    ID bigint not null primary key foreign key references Usuarios(ID),
    Apellidos varchar(100) not null,
    Nombres varchar(100) not null,
    Nacimiento date not null,
    Genero char null,
    Telefono varchar(15) null,
    Celular varchar(15) null,
    Email varchar(140) null,
    Domicilio varchar(200) not null,
    IDLocalidad int not null foreign key references Localidades(ID)
)
go
Create Table Inscripciones(
    ID bigint not null primary key identity (1, 1),
    IDUsuario bigint not null foreign key references Usuarios(ID),
    IDCurso bigint not null foreign key references Cursos(ID),
    Fecha date not null default(getdate()),
    Costo money not null check (Costo >= 0)
)
go
Create Table Pagos(
    ID bigint not null primary key identity (1, 1),
    IDInscripcion bigint not null foreign key references Inscripciones(ID),
    Fecha date not null default(getdate()),
    Importe money not null check(Importe > 0)
)
go
Create Table Certificaciones(
    IDInscripcion bigint not null primary key foreign key references Inscripciones(ID),
    Fecha date not null default(getdate()),
    Costo money not null check(Costo >= 0)
)
go
Create Table Reseñas(
    IDInscripcion bigint not null primary key foreign key references Inscripciones(ID),
    Fecha date not null default(getdate()),
    Observaciones varchar(MAX) not null,
    Puntaje decimal(3, 1) not null,
    Inapropiada bit not null default(0)
)
go
Create Table Instructores_x_Curso(
    IDUsuario bigint not null foreign key references Usuarios(ID),
    IDCurso bigint not null foreign key references Cursos(ID),
    Primary Key (IDUsuario, IDCurso)
)