Create Database ExamenIntegrador20241C
Go
Use ExamenIntegrador20241C
Go
CREATE TABLE Concursos (
	ID bigint IDENTITY(1,1) NOT NULL,
	Titulo varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Inicio date NOT NULL,
	Fin date NOT NULL,
	RankingMinimo decimal(5,2) NOT NULL,
	CONSTRAINT PK__Concurso__3214EC27C10C899D PRIMARY KEY (ID)
)
Go
CREATE TABLE Participantes (
	ID bigint IDENTITY(1,1) NOT NULL,
	Apellidos varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Nombres varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Particip__3214EC2749CC62C4 PRIMARY KEY (ID)
)
Go
CREATE TABLE Fotografias (
	ID bigint IDENTITY(1,1) NOT NULL,
	IDParticipante bigint NOT NULL,
	IDConcurso bigint NOT NULL,
	Titulo varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Descalificada bit DEFAULT 0 NOT NULL,
	Publicacion date NOT NULL,
	CONSTRAINT PK__Fotograf__3214EC27A48B8043 PRIMARY KEY (ID),
	CONSTRAINT FK__Fotografi__IDCon__29572725 FOREIGN KEY (IDConcurso) REFERENCES Concursos(ID),
	CONSTRAINT FK__Fotografi__IDPar__286302EC FOREIGN KEY (IDParticipante) REFERENCES Participantes(ID)
)
Go
CREATE TABLE Votaciones (
	ID bigint IDENTITY(1,1) NOT NULL,
	IDVotante bigint NOT NULL,
	IDFotografia bigint NOT NULL,
	Fecha date NOT NULL,
	Puntaje decimal(5,2) NOT NULL,
	CONSTRAINT PK__Votacion__3214EC2794203779 PRIMARY KEY (ID),
	CONSTRAINT FK__Votacione__IDFot__2E1BDC42 FOREIGN KEY (IDFotografia) REFERENCES Fotografias(ID),
	CONSTRAINT FK__Votacione__IDVot__2D27B809 FOREIGN KEY (IDVotante) REFERENCES Participantes(ID)
);
ALTER TABLE Votaciones ADD CONSTRAINT CK__Votacione__Punta__2F10007B CHECK (([Puntaje]>=(0) AND [Puntaje]<=(10)));

SET DATEFORMAT 'YMD'

INSERT INTO Concursos (Titulo,Inicio,Fin,RankingMinimo) VALUES
	 (N'Yada Yada Yada','2024-06-01','2024-06-10',0.00),
	 (N'Spare a Square','2024-06-15','2024-06-28',0.00),
	 (N'Serenity Now','2024-05-10','2024-06-15',3.00),
	 (N'No soup for you','2024-06-03','2024-06-20',8.00);

INSERT INTO Participantes (Apellidos,Nombres) VALUES
	 (N'Seinfeld',N'Jerry'),
	 (N'Benes',N'Elaine'),
	 (N'Costanza',N'George'),
	 (N'Kramer',N'Cosmo'),
	 (N'Ross',N'Susan'),
	 (N'Costanza',N'Frank'),
	 (N'Costanza',N'Estelle'),
	 (N'Seinfeld',N'Helen'),
	 (N'Seinfeld',N'Morty')

INSERT INTO Fotografias (IDParticipante,IDConcurso,Titulo,Descalificada,Publicacion) VALUES
	 (1,1,N'The Stake Out',0,'2024-06-02'),
	 (1,3,N'The Stock Tip',1,'2024-06-06'),
	 (2,1,N'The Pony Remark',0,'2024-06-03'),
	 (2,3,N'The Jacket',0,'2024-06-05'),
	 (2,4,N'The Phone Message',0,'2024-06-06'),
	 (3,1,N'The Apartment',0,'2024-06-02'),
	 (3,3,N'The Statue',0,'2024-05-20'),
	 (4,1,N'The Revenge',0,'2024-06-03'),
	 (5,1,N'The Chinese Restaurant',0,'2024-06-04'),
	 (6,1,N'The Library',0,'2024-06-01'),
	 (6,3,N'The Parking Garage',0,'2024-05-31'),
	 (7,1,N'The Red Dot',0,'2024-06-05')



INSERT INTO Votaciones (IDVotante,IDFotografia,Fecha,Puntaje) VALUES
	 (2,1,'2024-06-03',9.00),
	 (3,1,'2024-06-03',7.00),
	 (4,1,'2024-06-03',8.00),
	 (5,1,'2024-06-03',6.00),
	 (6,1,'2024-06-03',5.00),
	 (4,3,'2024-06-03',4.00),
	 (5,3,'2024-06-04',8.00),
	 (6,4,'2024-06-05',10.00),
	 (7,4,'2024-06-05',5.00),
	 (8,5,'2024-06-06',7.00),
	 (9,5,'2024-06-06',9.00),
	 (1,6,'2024-06-02',7.00),
	 (2,6,'2024-06-03',9.00),
	 (8,7,'2024-05-21',9.00),
	 (9,8,'2024-06-03',7.00),
	 (8,10,'2024-06-02',8.00)
