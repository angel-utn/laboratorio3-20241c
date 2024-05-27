Use ExcursionesDB
Go
Alter Table Clientes
Add Eliminado bit not null default (0)
Go
-- Trigger que no permita eliminar un cliente de la tabla de Clientes
Create or Alter Trigger TR_BajaLogica_Cliente ON Clientes
Instead Of Delete
As
Begin
    Declare @Eliminado bit
    Declare @ID_Cliente bigint 
    
    Select @ID_Cliente = ID_Cliente, @Eliminado = Eliminado from deleted

    If @Eliminado = 0 begin
        Update Clientes Set Eliminado = 1 Where ID_Cliente = @ID_Cliente
    End
    Else Begin
        Delete From Clientes Where ID_Cliente = @ID_Cliente
    End

End