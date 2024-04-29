Use Clima
go
-- Insertamos ciudades nuevas
Insert into Ciudades(IDCiudad, Nombre, IDPais)
Values
(43, 'Bari', 10),
(44, 'Udine', 10),
(45, 'Canelones', 4)
Go
---- Las ciudades que no tengan mediciones

-- Alternativa con joins
Select C.Nombre From Ciudades C
Left Join Mediciones M ON C.IDCiudad = M.IDCiudad
Where M.ID is null

-- Subconsultas
select Nombre from ciudades Where IDCiudad not in (
    Select Distinct C.IDCiudad From Ciudades C Inner Join Mediciones M ON C.IDCiudad = M.IDCiudad
)

---- Las ciudades que tengan en promedio mayor temperatura que el promedio de temperatura general.
-- Alternativa usando una variable
Declare @TempPromGeneral Decimal(9, 6)
Select @TempPromGeneral = AVG(Temperatura) From Mediciones

Select C.IDCiudad, C.Nombre, AVG(M.Temperatura) As TempProm
From Ciudades C
Inner Join Mediciones M ON M.IDCiudad = C.IDCiudad
Group By C.IDCiudad, C.Nombre
Having AVG(M.Temperatura) > @TempPromGeneral

-- Subconsulta
Select C.IDCiudad, C.Nombre, AVG(M.Temperatura) As TempProm
From Ciudades C
Inner Join Mediciones M ON M.IDCiudad = C.IDCiudad
Group By C.IDCiudad, C.Nombre
Having AVG(M.Temperatura) > (Select AVG(Temperatura) As PromGeneral From Mediciones)

---- Las mediciones en las que se hayan registrado una temperatura mayor a la de cualquier ciudad de Italia.
-- Alternativa 1
Select * From Mediciones Where Temperatura > (
    Select Max(M.Temperatura) From Mediciones M
    Inner Join Ciudades C ON C.IDCiudad = M.IDCiudad
    Inner Join Paises P ON P.IDPais = C.IDPais
    Where P.Nombre Like 'Italia'
)

-- Alternativa 2
Select * From Mediciones Where Temperatura > ALL (
    Select M.Temperatura From Mediciones M
    Inner Join Ciudades C ON C.IDCiudad = M.IDCiudad
    Inner Join Paises P ON P.IDPais = C.IDPais
    Where P.Nombre Like 'Italia' And M.Temperatura is not null
)

---- Las mediciones en las que se hayan registrado una temperatura mayor a la de alguna ciudad de Argentina.
-- Alternativa 1
Select * From Mediciones Where Temperatura > (
    Select Min(M.Temperatura) From Mediciones M
    Inner Join Ciudades C ON C.IDCiudad = M.IDCiudad
    Inner Join Paises P ON P.IDPais = C.IDPais
    Where P.Nombre Like 'Argentina'
)

-- Alternativa 2
Select * From Mediciones Where Temperatura > ANY (
    Select M.Temperatura From Mediciones M
    Inner Join Ciudades C ON C.IDCiudad = M.IDCiudad
    Inner Join Paises P ON P.IDPais = C.IDPais
    Where P.Nombre Like 'Argentina'
)

-- Por cada ciudad listar el nombre y la suma total de mm de lluvia registrado por la mañana, 
-- por la tarde y por la noche.
-- Mañana: de 05 a 12. Tarde: de 13 a 19. Noche de 20 a 04
Select C.IDCiudad, C.Nombre,
(
    Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Between 5 and 12 And IDCiudad = C.IDCiudad
) as MM_Mañana,
(
    Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Between 13 and 19 And IDCiudad = C.IDCiudad
) as MM_Tarde,
(
    Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Not Between 5 and 19 And IDCiudad = C.IDCiudad
) as MM_Noche
From Ciudades C

-- Por cada país, su nombre y los promedios de temperatura de los años 2022, 2023 y 2024.
Select P.IDPais, P.Nombre,
(
    Select AVG(M.Temperatura) From Mediciones M
    Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
    Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2022
) As Prom2022,
(
    Select AVG(M.Temperatura) From Mediciones M
    Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
    Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2023
) As Prom2023,
(
    Select AVG(M.Temperatura) From Mediciones M
    Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
    Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2024
) As Prom2024
From Paises P

-- Listar los países que hayan registrado mayor temperatura promedio en 2024 que en 2023 y 2023 que en 2022
Select Aux.* From (
    Select P.IDPais, P.Nombre,
    (
        Select AVG(M.Temperatura) From Mediciones M
        Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
        Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2022
    ) As Prom2022,
    (
        Select AVG(M.Temperatura) From Mediciones M
        Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
        Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2023
    ) As Prom2023,
    (
        Select AVG(M.Temperatura) From Mediciones M
        Inner Join Ciudades C ON M.IDCiudad = C.IDCiudad
        Where C.IDPais = P.IDPais And Year(M.FechaHora) = 2024
    ) As Prom2024
    From Paises P
) As Aux
Where Aux.Prom2024 > Aux.Prom2023 And Aux.Prom2023 > Aux.Prom2022


-- Listar las ciudades que hayan registrado en total más de 10mm de lluvia por la 
-- mañana o por la noche pero 0mm en total por la tarde.
Select EstadisticasLluvia.* From (
    Select C.IDCiudad, C.Nombre,
    (
        Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Between 5 and 12 And IDCiudad = C.IDCiudad
    ) as MM_Mañana,
    (
        Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Between 13 and 19 And IDCiudad = C.IDCiudad
    ) as MM_Tarde,
    (
        Select SUM(Lluvia) From Mediciones Where DatePart(Hour, FechaHora) Not Between 5 and 19 And IDCiudad = C.IDCiudad
    ) as MM_Noche
    From Ciudades C
) As EstadisticasLluvia
Where (EstadisticasLluvia.MM_Mañana > 10 Or EstadisticasLluvia.MM_Noche > 10) And EstadisticasLluvia.MM_Tarde = 0


-- Algo que me olvidé pero preguntaron en el chat
Select Avg(Temperatura) as PromTempCiudad1 From Mediciones Where IDCiudad = 1

-- Esto no funciona
Select Avg((Select Temperatura From Mediciones Where IDCiudad = 1)) as PromTempCiudad1

-- Esto sí pero es preferible el primer caso
Select Avg(Aux.Temperatura) as PromTempCiudad1 From (
    Select Temperatura From Mediciones Where IDCiudad = 1
) As Aux