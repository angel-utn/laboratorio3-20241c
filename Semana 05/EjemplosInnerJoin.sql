-- Listado con el nombre de la ciudad y su respectivo nombre de país
Select C.Nombre as Ciudad, P.Nombre as Pais from Ciudades C
Inner join Paises P ON P.IDPais = C.IDPais

-- Insert into Paises(IDPAis, Nombre)
-- Values (11000, 'Venezuela')

-- Listado con el nombre de la ciudad y su respectivo nombre de país. Incluye países sin ciudades.
Select C.Nombre as Ciudad, P.Nombre as Pais from Ciudades C
Right join Paises P ON P.IDPais = C.IDPais

-- Paises sin ciudades
Select C.Nombre as Ciudad, P.Nombre as Pais from Ciudades C
Right join Paises P ON P.IDPais = C.IDPais
Where IDCiudad is null

-- Producto cartesiano (no tiene sentido en este caso)
Select C.Nombre, P.Nombre from Ciudades C Cross Join Paises P

-- Todos los datos de mediciones con el nombre del país
Select M.*, P.Nombre From Mediciones M
Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
Inner Join Paises P ON P.IDPais = C.IDPais

-- Todas las alertas met. con su nivel de severidad y color del país Argentina
Select M.*, N.Color, N.Nombre, P.Nombre from Mediciones M
Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
Inner Join Paises P ON P.IDPais = C.IDPais
Inner Join AlertasMeteorologicos AM ON AM.IDMedicion = M.ID
Inner Join NivelesPeligrosidad N ON N.ID = AM.IDNivelPeligrosidad
Where P.Nombre = 'Argentina'
