Use Clima
-- Ejemplo de inserción
Insert Into Paises (IDPais, Nombre) Values (1000, 'Islandia')

Insert Into Paises (IDPais, Nombre)
Values
(2000, 'China'),
(3000, 'Portugal')

Insert into Paises 
Values (4000, 'Grecia')

-- Ejemplo de modificación de un registro
Update Paises Set Nombre = 'Argentina' Where IDPais = 1

-- Ejemplo de eliminación de uno
Delete From Paises Where IDPais = 1000