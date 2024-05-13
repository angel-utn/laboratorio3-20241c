Use ExcursionesDB
Go
-- Ejemplo de creación de función de usuario

-- Función que devuelve la cantidad total de pasajes vendidos por ID excursión

Create or Alter Function FN_TotalPasajesxExcursion(
    @ID_Excursion INT
)
returns int
as
Begin
    Declare @TotalPasajes int
    
    Select @TotalPasajes = Coalesce(SUM(CantidadPasajes), 0) From Ventas 
    Where ID_Excursion = @ID_Excursion

    Return @TotalPasajes
End
Go
-- Uso de la función
Select E.ID_Destino, E.FechaHora, 
dbo.FN_TotalPasajesxExcursion(E.ID_Excursion) As CantTicketsVendidos
From Excursiones E
Go

-- Ejemplo de Vista
--------------------

Create or Alter View VW_Excursiones
as
select 
    E.ID_Excursion,
    D.Nombre as Destino,
    E.ID_Vehiculo,
    E.FechaHora,
    E.Costo,
    dbo.FN_TotalPasajesxExcursion(E.ID_Excursion) as CantVendidos,
    Case When
        Cancelada = 1 Then 'Cancelada'
        Else 'No Cancelada'
    End As Estado
 from Excursiones E
Inner Join Destinos D ON D.ID_Destino = E.ID_Destino

Go
-- Ejemplo de Procedimiento Almacenado con parámetros que selecciona datos

-- Obtener todas las ventas de una excursión específica (ID_EXCURSION)
GO
Create or Alter Procedure SP_VentasxExcursion(
    @ID_Excursion int = 1
)
As
Begin
    Select * From Ventas Where ID_Excursion = @ID_Excursion
End

Exec SP_VentasxExcursion -- Usa el parámetro opcional

Exec SP_VentasxExcursion 2

Go

-- Creación de un nuevo cliente mediante un SP
Create or Alter Procedure SP_NuevoCliente(
    @Apellido varchar(100),
    @Nombre varchar(100),
    @FechaNacimiento date,
    @Celular varchar(20),
    @Telefono varchar(20),
    @Mail varchar(250)
)
As Begin

    if @Celular Is Null And @Telefono Is Null begin
        Raiserror('Debe suministrar un valor para telefono o celular', 16, 0)    
        return
    End

    -- Cálculo de edad mejorable (ver Actividad en Notion)
    Declare @Edad int
    Set @Edad = Year(getdate()) - Year(@FechaNacimiento)

    If @Edad < 21 begin
        RAISERROR('Debe ser mayor de 21 para ser cliente', 16, 0)
        return
    end

    Insert into Clientes (Apellido, Nombre, FechaNacimiento, Celular, Telefono, Mail, Saldo)
    Values (@Apellido, @Nombre, @FechaNacimiento, @Celular, @Telefono, @Mail, 0)

End

Exec SP_NuevoCliente 'Simon', 'Angel', '1986-10-02', '12345678', null, 'asimon@docentes.frgp.utn.edu.ar'

Exec SP_NuevoCliente 'SimonB', 'AngelB', '2010-10-02', '12345678', null, 'asimon@docentes.frgp.utn.edu.ar'

Exec SP_NuevoCliente 'SimonC', 'AngelC', '1986-10-02', null, null, 'asimon@docentes.frgp.utn.edu.ar'

Go
