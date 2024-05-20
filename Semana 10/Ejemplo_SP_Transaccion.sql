Create or Alter Procedure SP_NuevaVenta(
    @ID_Cliente int,
    @ID_Excursion int,
    @Cantidad tinyint,
    @Fecha datetime = null
)
as begin 
    begin try
        Begin transaction
        Declare @FechaExcursion datetime
        Declare @ExcursionCancelada bit
        Declare @AsientosVendidos int
        Declare @CupoMaximo int

        Declare @PrecioUnitario money
        Declare @Total money
        
        -- Asigna los valores asociados a la excursión a variables
        Select 
            @PrecioUnitario = E.Costo, 
            @FechaExcursion = E.FechaHora, 
            @ExcursionCancelada = E.Cancelada,
            @CupoMaximo = V.Cupo_Maximo
        From Excursiones E
        Inner Join Vehiculos V On E.ID_Vehiculo = V.ID_Vehiculo
        Where E.ID_Excursion = @ID_Excursion

        -- Verifica si la excursión fue cancelada o ya ocurrió
        If (@ExcursionCancelada = 1) Or (getdate() > @FechaExcursion) begin
            Raiserror('Excursion cancelada o vencida', 16, 0)
        end

        -- Verifica si supera stock máximo de asientos
        Select @AsientosVendidos = dbo.FN_TotalPasajesxExcursion(@ID_Excursion)

        If @AsientosVendidos + @Cantidad > @CupoMaximo Begin
            Raiserror('Excursion completa', 16, 0)
        End

        Set @Fecha = Isnull(@Fecha, getdate())
        Set @Total = @PrecioUnitario * @Cantidad

        insert into ventas(ID_Cliente, ID_Excursion, Fecha, CantidadPasajes, Total, Cancelada)
        Values (@ID_Cliente, @ID_Excursion, @Fecha, @Cantidad, @Total, 0)

        update Clientes set Saldo = Saldo - @Total Where ID_Cliente = @ID_Cliente

        commit transaction
        print 'Todo OK'
    end try
    begin catch 
        print Error_Message()
        rollback transaction
    end catch
end