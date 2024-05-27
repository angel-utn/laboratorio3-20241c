Use ExcursionesDB
Go
Create or Alter Trigger TR_Nuevo_Pago On Pagos
After Insert
As
Begin
    -- Ya sabemos que el registro de Pago está insertado aunque
    -- podría ser incorrecto (Superar el monto de la venta)
    
    Declare @SumaPagos money -- La suma total de los pagos de esa venta
    Declare @Importe money
    Declare @ImporteVenta money
    Declare @ID_Cliente bigint
    Declare @ID_Venta bigint

    Begin Transaction
    Select 
        @Importe = I.Importe, 
        @ID_Venta = I.ID_Venta, 
        @ID_Cliente = V.ID_Cliente,
        @ImporteVenta = V.Total
    From inserted I
    Inner Join Ventas V ON V.ID_Venta = I.ID_Venta

    Select @SumaPagos = SUM(Importe) From Pagos Where ID_Venta = @ID_Venta

    If @SumaPagos > @ImporteVenta Begin
        Rollback Transaction
        Raiserror('Estas pagando de más', 16, 0)
        Return
    End

    Update Clientes Set Saldo += @Importe Where ID_Cliente = @ID_Cliente

    Commit Transaction

End

-- Borro el trigger
Drop Trigger TR_Nuevo_Pago