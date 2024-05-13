Use ExcursionesDB
Go
INSERT INTO Vehiculos (Patente, AñoPatentamiento, Cupo_Maximo, Eliminado) 
VALUES  ('ABC123', 2019, 10, 0),
        ('DEF456', 2020, 12, 0),
        ('GHI789', 2018, 8, 0),
        ('JKL012', 2021, 15, 0),
        ('MNO345', 2017, 10, 0),
        ('PQR678', 2019, 12, 0),
        ('STU901', 2022, 8, 0),
        ('VWX234', 2018, 14, 0),
        ('YZA567', 2020, 10, 0),
        ('BCD890', 2016, 12, 0),
        ('EFG123', 2023, 8, 0),
        ('HIJ456', 2019, 15, 0),
        ('KLM789', 2017, 10, 0),
        ('NOP012', 2021, 12, 0),
        ('PQR345', 2018, 8, 0),
        ('STU678', 2020, 14, 0),
        ('VWX901', 2016, 10, 0),
        ('YZA234', 2019, 8, 0),
        ('BCD567', 2017, 15, 0),
        ('EFG890', 2022, 10, 0);

INSERT INTO Destinos (Nombre, DificultadDelCamino, Pais, Costo) 
VALUES 
    ('Patagonia', 4, 'Argentina', 350.00),
    ('Ushuaia', 3, 'Argentina', 280.00),
    ('Bariloche', 2, 'Argentina', 200.00),
    ('Puerto Madryn', 2, 'Argentina', 190.00),
    ('Villa La Angostura', 2, 'Argentina', 180.00),
    ('El Calafate', 3, 'Argentina', 250.00),
    ('Cataratas del Iguazú', 2, 'Argentina', 160.00),
    ('Cafayate', 3, 'Argentina', 200.00),
    ('Tandil', 2, 'Argentina', 150.00),
    ('Villa General Belgrano', 1, 'Argentina', 170.00),
    ('Machu Picchu', 3, 'Perú', 250.00),
    ('Torres del Paine', 4, 'Chile', 300.00),
    ('Galápagos', 2, 'Ecuador', 400.00),
    ('Salar de Uyuni', 3, 'Bolivia', 200.00),
    ('Amazonía', 4, 'Perú', 300.00),
    ('Cartagena', 1, 'Colombia', 200.00),
    ('Machuca', 2, 'Chile', 120.00),
    ('Pantanal', 3, 'Brasil', 220.00),
    ('Tayrona', 2, 'Colombia', 180.00),
    ('Huacachina', 1, 'Perú', 150.00),
    ('San Pedro de Atacama', 3, 'Chile', 250.00),
    ('Cotopaxi', 3, 'Ecuador', 200.00),
    ('Tulum', 2, 'México', 180.00),
    ('Arequipa', 2, 'Perú', 160.00),
    ('Cusco', 3, 'Perú', 200.00),
    ('Bocas del Toro', 2, 'Panamá', 220.00);

INSERT INTO Excursiones (ID_Destino, ID_Vehiculo, FechaHora, Costo, Cancelada) 
VALUES 
    (1, 1, '2024-03-20 09:00:00', 200.00, 0),
    (2, 3, '2024-06-10 10:30:00', 280.00, 0),
    (3, 5, '2024-07-05 08:15:00', 400.00, 0),
    (4, 3, '2024-08-15 11:00:00', 150.00, 1),
    (5, 3, '2024-09-02 10:00:00', 300.00, 0),
    (6, 5, '2024-10-20 09:30:00', 220.00, 0),
    (7, 2, '2024-11-12 07:45:00', 180.00, 0),
    (8, 6, '2024-12-03 08:30:00', 250.00, 0),
    (9, 7, '2025-01-14 09:45:00', 190.00, 0),
    (10, 9, '2025-02-25 10:15:00', 210.00, 0),
    (11, 11, '2025-03-18 11:30:00', 280.00, 0),
    (12, 13, '2025-04-09 12:00:00', 320.00, 0),
    (13, 15, '2025-05-01 07:00:00', 180.00, 0),
    (14, 17, '2025-06-02 09:30:00', 260.00, 0),
    (15, 19, '2025-07-15 10:45:00', 300.00, 0);

INSERT INTO Clientes (Apellido, Nombre, FechaNacimiento, Celular, Telefono, Mail, Saldo) 
VALUES 
    ('García', 'Ana', '1990-03-15', '+5491122334455', NULL, 'ana.garcia@example.com', 0.00),
    ('Rodríguez', 'Juan', '1985-07-20', '+5491122334466', NULL, 'juan.rodriguez@example.com', 0.00),
    ('López', 'María', '1993-05-10', '+5491122334477', NULL, 'maria.lopez@example.com', 0.00),
    ('Martínez', 'Pedro', '1988-11-03', '+5491122334488', NULL, 'pedro.martinez@example.com', 0.00),
    ('González', 'Lucía', '1995-09-28', NULL, NULL, 'lucia.gonzalez@example.com', 0.00),
    ('Fernández', 'Carlos', '1982-02-18', NULL, NULL, 'carlos.fernandez@example.com', 0.00),
    ('Díaz', 'Laura', '1987-04-25', NULL, '938284434', 'laura.diaz@example.com', 0.00),
    ('Pérez', 'Diego', '1991-06-30', '+5491122334522', NULL, 'diego.perez@example.com', 0.00),
    ('Gómez', 'Martina', '1984-08-12', '+5491122334533', NULL, 'martina.gomez@example.com', 0.00),
    ('Sánchez', 'Javier', '1998-01-05', '+5491122334544', NULL, 'javier.sanchez@example.com', 0.00),
    ('Álvarez', 'Paula', '1994-10-17', '+5491122334555', '1184374434', 'paula.alvarez@example.com', 0.00),
    ('Romero', 'Alejandro', '1986-12-08', '+5491122334566', NULL, 'alejandro.romero@example.com', 0.00),
    ('Torres', 'Camila', '1997-08-22', '+5491122334577', '329884434', 'camila.torres@example.com', 0.00),
    ('Flores', 'Lucas', '1989-03-11', '+5491122334588', NULL, 'lucas.flores@example.com', 0.00),
    ('Benítez', 'Valentina', '1996-07-02', '+5491122334599', NULL, 'valentina.benitez@example.com', 0.00),
    ('Acosta', 'Nicolás', '1983-11-29', '+5491122334600', NULL, 'nicolas.acosta@example.com', 0.00),
    ('Rojas', 'Sofía', '1990-09-14', '+5491122334611', NULL, 'sofia.rojas@example.com', 0.00),
    ('Morales', 'Matías', '1985-05-07', '+5491122334622', NULL, 'matias.morales@example.com', 0.00),
    ('Sosa', 'Catalina', '1992-04-03', '+5491122334633', NULL, 'catalina.sosa@example.com', 0.00),
    ('Giménez', 'Francisco', '1981-07-26', '+5491122334644', NULL, 'francisco.gimenez@example.com', 0.00);

INSERT INTO Ventas (ID_Cliente, ID_Excursion, Fecha, CantidadPasajes, Total, Cancelada)
VALUES 
    (1, 1, '2024-05-11 11:30:00', 2, 400.00, 0),
    (2, 1, '2024-05-11 11:45:00', 1, 200.00, 0),
    (3, 1, '2024-05-11 12:00:00', 3, 600.00, 0),
    (4, 1, '2024-05-12 12:15:00', 2, 400.00, 0),
    (5, 1, '2024-05-12 12:30:00', 1, 200.00, 0),
    (1, 2, '2024-05-13 12:15:00', 1, 280.00, 0),
    (2, 2, '2024-05-13 12:30:00', 1, 280.00, 0);

INSERT INTO FormasPagos (Nombre, Electronica) 
VALUES 
    ('Efectivo', 0),
    ('Tarjeta de crédito', 1),
    ('Tarjeta de débito', 1),
    ('Transferencia bancaria', 1),
    ('Cheque', 0);

INSERT INTO Pagos (ID_Venta, ID_FormaPago, FechaHora, Importe, Cancelado)
VALUES 
    (1, 1, '2024-05-18 11:45:00', 200.00, 0),
    (1, 1, '2024-05-19 12:45:00', 200.00, 0),
    (2, 2, '2024-05-18 12:00:00', 200.00, 0),
    (3, 3, '2024-05-18 12:15:00', 600.00, 0),
    (4, 1, '2024-05-18 12:30:00', 400.00, 0),
    (5, 2, '2024-05-18 12:45:00', 200.00, 0);
