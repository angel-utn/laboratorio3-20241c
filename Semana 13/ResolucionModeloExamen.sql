-- 1)
--  La fábrica quiere evitar que empleados sin experiencia mayor a 5 años puedan
--  generar producciones de piezas cuyo costo unitario de producción supere los $ 15.
--  Hacer un trigger que asegure esta comprobación para registros de producción cuya
--  fecha sea mayor a la actual. En caso de poder registrar la información, calcular el
--  costo total de producción.
Create Trigger TR_Punto1 ON Produccion
After Insert
As
Begin
    Begin Try
        Declare @FechaProduccion date
        Declare @IDPieza bigint
        Declare @Cantidad int
        Declare @CostoUnitario money
        Declare @CostoTotal money
        Declare @IDProduccion bigint
        Declare @Antiguedad smallint
        Declare @IDOperario bigint
        Declare @AnioIngreso smallint

        Select 
            @FechaProduccion = Fecha, 
            @IDPieza = IDPieza, 
            @Cantidad = Cantidad,
            @IDProduccion = IDProduccion,
            @IDOperario = IDOperario
        from inserted

        Select @CostoUnitario = CostoUnitarioProduccion from Piezas where IDPieza = @IDPieza
        Select @AnioIngreso = AnioAlta from Operarios Where IDOperario = @IDOperario
        Set @CostoTotal = @CostoUnitario * @Cantidad
        Set @Antiguedad = (Year(getdate()) - @AnioIngreso)

        begin transaction
        if getdate() < @FechaProduccion Begin
            if @CostoUnitario > 15 And @Antiguedad <= 5 begin
                raiserror('No se puede registrar la orden de produccion', 16, 1)
            end
        End

        Update Produccion Set CostoTotal = @CostoTotal Where IDProduccion = @IDProduccion
        
        commit transaction
    End Try
    Begin Catch
        ROLLBACK transaction
        Declare @mensaje varchar(4000)
        Set @mensaje = error_message()
        RAISERROR(@mensaje, 16, 1)
    End Catch

End
Go

-- 2
--  Hacer un listado que permita visualizar el nombre del material, el nombre de todas las piezas
--  y la cantidad de operarios que nunca produjeron esta pieza.
Declare @CantidadOperarios Integer
Select @CantidadOperarios = Count(*) From Operarios
Select 
    M.Nombre as Material, 
    P.Nombre as Pieza,
    @CantidadOperarios - (Select Count(distinct IDOperario) From Produccion Where IDPieza = P.IDPieza) as CantOperarios
From Materiales M Inner Join Piezas P ON M.IDMaterial = P.IDMaterial

Go
-- 3
--  Hacer un procedimiento almacenado llamado Punto_3 que reciba el nombre de un
--  material y un valor porcentual (admite 2 decimales) y modifique el precio unitario de
--  producción a partir de este valor porcentual a todas las piezas que sean de este
--  material.

--  Por ejemplo:
--  Si el procedimiento recibe 'Acero' y 50. Debe aumentar el precio unitario de
--  producción de todas las piezas de acero en un 50%.
--  Si el procedimiento recibe 'Vidrio' y -25. Debe disminuir el precio unitario de
--  producción de todas las piezas de vidrio en un 25%.
--  NOTA: No se debe permitir hacer un descuento del 100% ni un aumento mayor al
--  1000%.

Create Procedure Punto_3 (
    @NombreMaterial varchar(50),
    @Porcentaje decimal(6, 2)
) As
Begin
    If @Porcentaje <= -100 Or @Porcentaje > 1000 Begin
        Raiserror('Valor porcentual incorrecto', 16, 1)
        Return
    End

    Declare @IDMaterial int
    Select @IDMaterial = IDMaterial from Materiales Where Nombre Like @NombreMaterial

    Update Piezas Set CostoUnitarioProduccion = CostoUnitarioProduccion * (@Porcentaje / 100 + 1)  
    Where IDMaterial = @IDMaterial

End

-- 4
--  Hacer un procedimiento almacenado llamado Punto_4 que reciba dos fechas y
--  calcule e informe el costo total de todas las producciones que se registraron entre
--  esas fechas.
Go
Create Procedure Punto_4(
    @Desde date,
    @Hasta date
)
As Begin
    Select IsNull(Sum(CostoTotal), 0) From Produccion Where Fecha Between @Desde And @Hasta
End

-- 5
--  Hacer un listado que permita visualizar el nombre de cada material y el costo total de
--  las producciones estropeadas de ese material. Sólo listar aquellos registros que
--  totalicen un costo total mayor a $100.
Select M.Nombre as Material, Sum(PRO.CostoTotal) As CostoTotalEstropeado
From Materiales M
Inner Join Piezas P ON M.IDMaterial = P.IDMaterial
Inner Join Produccion PRO ON PRO.IDPieza = P.IDPieza
Where PRO.Medida Not Between P.MedidaMinima And P.MedidaMaxima
Group by M.Nombre
Having SUM(PRO.CostoTotal) > 100

