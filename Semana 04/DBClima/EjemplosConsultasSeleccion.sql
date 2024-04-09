Use Clima
Go
-- Todos los registros con todas las columnas de medicion
Select * From Mediciones

-- IDCiudad, FechaHora, Temperatura y Lluvia de todos los registros de medicion
Select IDCiudad As CodigoCiudad, FechaHora, Temperatura, Lluvia From Mediciones

-- Todos los registros de medicion de la ciudad 1 y la temperatura debajo del cero
Select * From Mediciones Where IDCiudad = 1 And Temperatura < 0

-- Todos los registros de medicion de la ciudad 1 y la temperatura debajo del cero
-- ordenado por Temperatura de la más fría a la más cálida
Select * From Mediciones 
Where IDCiudad = 1 And Temperatura < 0
Order by Lluvia desc, Temperatura asc

-- Todos los registros de temperatura de los años 2022 y 2024
Select * From Mediciones
Where Year(FechaHora) = 2022 Or Year(FechaHora) = 2024

Select * From Mediciones
Where Year(FechaHora) In (2022, 2024)

-- Todos los registros de medicion con temperatura entre 10 y 25 C°
Select * From Mediciones
Where Temperatura >= 10 And Temperatura <= 25

Select * From Mediciones
Where Temperatura between 10 and 25

-- Todos los registros donde Lluvia es null
Select * From Mediciones
Where Lluvia is null

-- Ejemplo de una generación de columna en el listado
Select *, Datepart(Year, FechaHora) as Año From Mediciones

-- Todos los registros de medicion en los que no se haya 
-- registrado medición de lluvia reemplazando el valor null por 0
Select ID, IsNull(Lluvia, 0) as Lluvia From Mediciones

-- Cambiar valores a partir de una o más condiciones
Select Nombre, Severidad, 
Case 
When Severidad between 1 and 2 then 'Green'
When Severidad between 3 and 5 then 'Yellow'
Else 'Red'
End As Colour
From NivelesPeligrosidad

-- Uso de distinct
Select distinct DuracionMinutosEstimada, IDNivelPeligrosidad From AlertasMeteorologicos
Order by 1 Asc

