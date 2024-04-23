use Clima
GO
-- Cantidad de Países
Select Count(*) As CantPaises From Paises

-- Cantidad de Mediciones
Select Count(*) As CantMediciones From Mediciones

-- Cantidad de Mediciones en las que se registró lluvia
Select Count(Lluvia) From Mediciones

-- Equivalente
Select Count(*) From Mediciones Where Lluvia is not null

-- Cantidad de Mediciones con temperatura entre 10 y 15
Select Count(*) From Mediciones Where Temperatura Between 10 And 15

-- Temperatura promedio del 2020 -- No tiene datos y devuelve NULL
Select Avg(Temperatura) From Mediciones Where Year(FechaHora) = 2020

-- Temperatura promedio del 2022
Select Avg(Temperatura) From Mediciones Where Year(FechaHora) = 2022

Select Sum(Temperatura) / Count(*) From Mediciones Where Year(FechaHora) = 2022

-- Temperatura máxima en 2023
Select Max(Temperatura) From Mediciones Where Year(FechaHora) = 2023

-- Temperatura mínima en 2023
Select Min(Temperatura) From Mediciones Where Year(FechaHora) = 2023

-- Temperatura máxima y mínima en 2023
Select Max(Temperatura) as MaxTemp, Min(Temperatura) as MinTemp From Mediciones Where Year(FechaHora) = 2023

-- Amplitud térmica del año 2023
Select Max(Temperatura) - Min(Temperatura) as AmplitudTerm From Mediciones Where Year(FechaHora) = 2023

-- La suma de milimetros de lluvia de la Ciudad 1 en el año 2022
Select SUM(Lluvia) as SumaMM From Mediciones Where IDCiudad = 1 And Year(FechaHora) = 2022

-- La suma de los minutos de alerta meteorológica de Septiembre de 2022 del País 'Argentina'
Select Sum(AM.DuracionMinutosEstimada) As SumaMinutos From AlertasMeteorologicos AM
Inner Join Mediciones M ON AM.IDMedicion = M.ID
Inner Join Ciudades C ON C.IDCiudad = M.IDCiudad
Inner Join Paises P ON P.IDPais = C.IDPais
Where Year(M.FechaHora) = 2022 And Month(M.FechaHora) = 9 And P.Nombre = 'Argentina'

-- Cantidad de AlertasMeteorológicos por país. Debe mostrar Nombre de país y Cantidad de Alertas.
Select PA.Nombre, Count(*) As CantMediciones From Paises PA
Inner Join Ciudades C ON C.IDPais = PA.IDPais
Inner Join Mediciones M ON M.IDCiudad = C.IDCiudad
Inner Join AlertasMeteorologicos AM ON AM.IDMedicion = M.ID
Group By PA.Nombre

-- Cantidad de AlertasMeteorológicos por Nivel de Peligrosidad y Año
Select N.Nombre, Year(M.FechaHora) As Año, Count(*) As CantAlertas From NivelesPeligrosidad N
Inner Join AlertasMeteorologicos AM ON AM.IDNivelPeligrosidad = N.ID
Inner Join Mediciones M ON AM.IDMedicion = M.ID
Group By N.Nombre, Year(M.FechaHora)

-- Por cada país, la cantidad de ciudades distinct en las que llovió en el 2023
Select PA.Nombre, Count(distinct C.IDCiudad) As CantCiudades
From PAises PA
Inner Join Ciudades C ON PA.IDPais = C.IDPais
Inner Join Mediciones M ON M.IDCiudad = C.IDCiudad
Where M.Lluvia > 0 And Year(M.FechaHora) = 2023
Group By PA.Nombre
Order by PA.Nombre asc

-- Los nombres de ciudades que hayan registrado más de 25°C promedio en 2023
Select C.Nombre, AVG(M.Temperatura) as Promedio From Ciudades C
Inner Join Mediciones M ON M.IDCiudad = C.IDCiudad
Where Year(M.FechaHora) = 2023
Group By C.Nombre
Having Avg(M.Temperatura) > 25





