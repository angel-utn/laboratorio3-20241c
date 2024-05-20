-- No permitir insertar una excursión si:
    -- El vehículo se encuentra en otra excursión en la misma fecha
    -- El vehículo se encuentra eliminado
Create or Alter Trigger TR_NuevaExcursion ON Excursiones
After Insert
as Begin

    Begin Try
    Begin transaction
    Declare @CantidadExcursiones int
    Declare @ID_Vehiculo int
    Declare @VehiculoEliminado bit
    Declare @FechaExcursion date

    -- inserted
    Select @ID_Vehiculo = ID_Vehiculo, @FechaExcursion = cast(FechaHora as Date) From inserted
    Select @VehiculoEliminado = Eliminado From Vehiculos Where ID_Vehiculo = @ID_Vehiculo

    If @VehiculoEliminado = 1 begin
        Raiserror('Vehiculo eliminado', 16, 0)
    End

    Select @CantidadExcursiones = count(*) From Excursiones
    Where 
    ID_Vehiculo = @ID_Vehiculo And 
    cast(FechaHora as Date) = @FechaExcursion And
    Cancelada = 0

    If @CantidadExcursiones > 1 begin
        Raiserror('Vehiculo no disponible en esa fecha', 16, 0)
    End

    Commit Transaction
    End Try
    Begin Catch
        print error_message()
        rollback transaction
    End Catch
End