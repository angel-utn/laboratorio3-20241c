--Hacer un procedimiento almacenado llamado SP_Descalificar que reciba un ID de
--fotografía y realice la descalificación de la misma. También debe eliminar todas las
--votaciones registradas a la fotografía en cuestión. Sólo se puede descalificar una
--fotografía si pertenece a un concurso no finalizado.

CREATE PROCEDURE SP_Descalificar(@ID BIGINT) 
AS BEGIN
BEGIN TRY
    BEGIN TRANSACTION
    DECLARE @FechaUltimo DATE
    SET @FechaUltimo = (SELECT TOP 1 C.Fin FROM Concursos AS C
    INNER JOIN Fotografias AS F ON F.IDConcurso = C.ID
    INNER JOIN Votaciones AS V ON V.IDFotografia = F.ID
    WHERE @ID = F.ID
    ORDER BY C.Fin DESC
    )

    IF(@FechaUltimo >= GETDATE())
        BEGIN
            UPDATE Fotografias SET Descalificada = 1 WHERE ID = @ID
            DELETE FROM Votaciones WHERE IDFotografia = @ID
            PRINT 'Fotografía eliminada con éxito'
        END
    ELSE
            PRINT 'La fotografía no pudo eliminarse debido a que el concurso ha finalizado'
    COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        RAISERROR('Ocurrió un error',16,1)
        ROLLBACK TRANSACTION
    END CATCH
END

--Al insertar una fotografía verificar que el usuario creador de la fotografía tenga el
--ranking suficiente para participar en el concurso. También se debe verificar que el
--concurso haya iniciado y no finalizado. Si ocurriese un error, mostrarlo con un
--mensaje aclaratorio. De lo contrario, insertar el registro teniendo en cuenta que la
--fecha de publicación es la fecha y hora del sistema.
--El ranking de un usuario consiste en el promedio de puntajes de todas las fotografías de
--su autoría. Si no tiene promedio, el ranking del usuario debe ser 0.

GO

CREATE TRIGGER VerificarUsuario
ON Fotografias
INSTEAD OF INSERT
AS
BEGIN

    DECLARE @IDParticipante BIGINT
    DECLARE @RankingConcurso DECIMAL (5,2)
    DECLARE @FechaInicioConcurso DATE 
    DECLARE @FechaFinConcurso DATE 

    SET @IDParticipante = (SELECT IDParticipante FROM inserted)
    DECLARE @IDConcurso BIGINT

    SET @IDConcurso = (SELECT IDConcurso FROM inserted)
    DECLARE @Titulo VARCHAR(150)

    SET @Titulo = (SELECT Titulo FROM inserted)
    DECLARE @RankingUsuario DECIMAL(5,2)

	SET @RankingUsuario = (SELECT AVG(V.Puntaje) FROM Votaciones AS V 
    INNER JOIN Fotografias AS F ON F.ID = V.IDFotografia
    WHERE F.IDParticipante = @IDParticipante
    )

    SET @RankingConcurso = (SELECT RankingMinimo FROM Concursos AS C
    WHERE @IDConcurso = C.ID
    )

    SET @FechaInicioConcurso = (SELECT C.Inicio FROM Concursos AS C
    INNER JOIN inserted ON inserted.IDConcurso = C.ID
    )

    SET @FechaFinConcurso = (SELECT C.Fin FROM Concursos AS C
    INNER JOIN inserted ON inserted.IDConcurso = C.ID
    )

    IF(@RankingUsuario >= @RankingConcurso AND (GETDATE() BETWEEN @FechaInicioConcurso AND @FechaInicioConcurso))
    
    INSERT INTO Fotografias(IDParticipante,IDConcurso,Titulo,Descalificada,Publicacion)
    VALUES (@IDParticipante, @IDConcurso, @Titulo, 0, GETDATE())
    ELSE
        RAISERROR('Ocurrió un error. No es posible insertar la fotografía',16,1)
    END

END

--Al insertar una votación, verificar que el usuario que vota no lo haga más de una vez
--para el mismo concurso ni se pueda votar a sí mismo. Tampoco puede votar una
--fotografía descalificada. Si ninguna validación lo impide insertar el registro, de lo
--contrario, informar un mensaje de error.

GO

CREATE TRIGGER VerificarUsuario
ON Votaciones
AFTER INSERT
AS
BEGIN TRANSACTION 
BEGIN
    DECLARE @IDVotante BIGINT
    SET @IDVotante = (SELECT IDVotante FROM inserted) 
    DECLARE @IDFotografia BIGINT
    SET @IDFotografia = (SELECT IDFotografia FROM inserted) 
    DECLARE @IDConcurso BIGINT 
    SET @IDConcurso = (SELECT IDConcurso FROM Fotografias WHERE ID = @IDFotografia)
    DECLARE @Contador INT 
    SET @Contador = (SELECT COUNT(*) FROM Votaciones AS V
    INNER JOIN Fotografias AS F ON V.IDFotografia = F.ID
    WHERE @IDVotante = V.IDVotante AND F.IDConcurso = @IDConcurso
    )
    DECLARE @Calificacion BIT
    SET @Calificacion = (SELECT F.Descalificada FROM Fotografias AS F
    WHERE F.ID = @IDFotografia
    )
    DECLARE @IDParticipante BIGINT 
    SET @IDParticipante = (SELECT IDParticipante FROM Fotografias
    WHERE ID = @IDFotografia
    )

    IF(@Contador > 1)
            BEGIN 
                RAISERROR('No es posible votar más de una vez',16,1)
                ROLLBACK TRANSACTION
            END   
    ELSE IF (@IDVotante = @IDParticipante)
            BEGIN 
                RAISERROR ('No está permitiendo votarse a uno mismo, tramposo',16,1)
                ROLLBACK TRANSACTION
            END    
    ELSE IF (@Calificacion = 1)
            BEGIN 
                RAISERROR('No es posible votar a una fotografía descalificada',16,1)
                ROLLBACK TRANSACTION
            END
    ELSE
        BEGIN
            PRINT ('Votación insertada correctamente')
            COMMIT TRANSACTION
        END
END

--Hacer un listado en el que se obtenga: ID de participante, apellidos y nombres de los
--participantes que hayan registrado al menos dos fotografías descalificadas

SELECT P.ID AS 'IDParticipante', P.Apellidos, P.Nombres FROM Participantes AS P
INNER JOIN Fotografias AS F ON F.IDParticipante = P.ID
WHERE F.Descalificada = 1
GROUP BY P.ID, P.Apellidos, P.Nombres
HAVING COUNT(*) >= 2
ORDER BY P.Apellidos;

--Agregar las tablas y restricciones que sean necesarias para poder registrar las
--denuncias que un usuario hace a una fotografía. Debe poder registrar cuando realiza
--la denuncia incluyendo fecha y hora. Se debe asegurar que se conozcan los datos del
--usuario que denuncia la fotografía, como el usuario que publicó la fotografía y la
--fotografía denunciada. También debe registrarse obligatoriamente un comentario a
--la denuncia y una categoría de denuncia. Las categorías de denuncia habitualmente
--son: Suplantación de identidad, Contenido inapropiado, Infringimiento de derechos
--de autor, etc. Un usuario solamente puede denunciar una fotografía una vez.

CREATE TABLE Denunciantes(
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(25) NOT NULL,
    Apellido VARCHAR(25) NOT NULL
)

CREATE TABLE Denuncias(
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    IDUsuarioDenunciante BIGINT FOREIGN KEY REFERENCES Denunciantes(ID),
    IDFotografia BIGINT FOREIGN KEY REFERENCES Fotografias(ID),
    IDParticipante BIGINT FOREIGN KEY REFERENCES Participantes(ID),
    Comentario VARCHAR(150) NOT NULL,
    FechaHora DATETIME NOT NULL,
    IDDescripcionCategoria INT FOREIGN KEY REFERENCES DescripcionCategorias(ID)
    CONSTRAINT UQ_SeñaladorConstante UNIQUE(IDUsuarioDenunciante,IDFotografia)
)

CREATE TABLE DescripcionCategorias(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(250) NOT NULL
)