Create Database Univ
Go
Use Univ
Go
Create Table Niveles(
    ID smallint not null primary key,
    Nombre varchar(50) not null
)
Go
Create Table Idiomas(
    ID smallint not null primary key,
    Nombre varchar(50) not null
)
Go
Create Table Cursos(
    ID int not null primary key,
    Nombre varchar(100) not null,
    CostoCurso money not null,
    CostoCertificacion money not null,
    FechaEstreno date not null,
    IDNivel smallint null foreign key references Niveles(ID)
)
Go
Create Table FormatosIdioma(
    ID smallint not null primary key,
    Nombre varchar(50) not null
)
Go
Create Table Idiomas_x_Curso(
    IDIdioma smallint not null foreign key references Idiomas(ID),
    IDCurso int not null foreign key references Cursos(ID),
    IDFormatoIdioma smallint not null foreign key references FormatosIdioma(ID),
    primary key (IDIdioma, IDCurso, IDFormatoIdioma)   
)
Go
Create Table Clases(
    ID bigint not null primary key,
    IDCurso int not null foreign key references Cursos(ID),
    Nombre varchar(100) not null,
    Numero smallint not null,
    Duracion int not null check (Duracion > 0)
)
Go
Create Table TiposContenido(
    ID smallint not null primary key,
    Nombre varchar(50) not null
)
Go
Create Table Contenidos(
    ID bigint not null primary key,
    IDClase bigint not null foreign key references Clases(ID),
    IDTipoContenido smallint not null foreign key references TiposContenido(ID),
    Tamaño int not null, -- MB
)
Go
Create Table Categorias(
    ID smallint not null primary key,
    Nombre varchar(100) not null
)
Go
Create Table Categorias_x_Curso(
    IDCurso int not null foreign key references Cursos(ID),
    IDCategoria smallint not null foreign key references Categorias(ID),
    primary key (IDCurso, IDCategoria)
)