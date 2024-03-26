Create Table Telefonos(
    DNI varchar(12) not null foreign key references Personas(DNI),
    Telefono varchar(25) not null,
    Primary key (DNI, Telefono)
)

----------------------------------------------------------
-- No se puede repetir la combinación de DNI y Teléfono --
----------------------------------------------------------

-- DNI  Telefono
-----------------------
-- 1     1111  OK
-- 2     1111  OK
-- 1     3333  OK
-- 1     1111  ERROR
