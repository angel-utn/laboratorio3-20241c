Use Univ
Go
INSERT INTO Categorias (Nombre) VALUES
	 (N'Argentina'),
	 (N'Arte'),
	 (N'Belico'),
	 (N'Bordado'),
	 (N'Cocina'),
	 (N'Deportes individuales'),
	 (N'Diseño'),
	 (N'Edad media'),
	 (N'Historia'),
	 (N'Informatica'),
	 (N'Internet'),
	 (N'Italia'),
	 (N'Juegos de tablero'),
	 (N'Manualidades'),
	 (N'Musica'),
	 (N'Negocios'),
	 (N'Pesca'),
	 (N'Programacion'),
	 (N'Mascotas');

INSERT INTO Niveles (Nombre) VALUES
	 (N'Introductivo'),
	 (N'Aficionado'),
	 (N'Avanzado'),
	 (N'Medio'),
	 (N'Principiante'),
	 (N'Junior'),
	 (N'Experto');

INSERT INTO TiposContenido (Nombre) VALUES
	 (N'Audio de alta calidad'),
	 (N'Examen'),
	 (N'Texto'),
	 (N'Video');

INSERT INTO FormatosIdioma (Nombre) VALUES
	 (N'Subtitulo'),
	 (N'Audio'),
	 (N'Texto del video');



INSERT INTO Cursos (IDNivel,Nombre,CostoCurso,CostoCertificacion,FechaEstreno) VALUES
	 (5,N'Lenguaje C',14000.0000,7000.0000,'2015-10-10'),
	 (NULL,N'Cocina italiana',20000.0000,8500.0000,'2019-09-09'),
	 (3,N'Bordado: Tecnicas avanzadas',5000.0000,1000.0000,'2018-07-03'),
	 (5,N'Python 101',13000.0000,4000.0000,'2017-07-07'),
	 (5,N'Javascript 101',10000.0000,5000.0000,'2017-07-07'),
	 (2,N'Introduccion a la pesca con mosca',17000.0000,7000.0000,'2020-09-21'),
	 (4,N'Preparacion de mermeladas',10000.0000,1000.0000,'2020-08-10'),
	 (5,N'Pixel art',0.0000,15000.0000,'2019-10-11'),
	 (5,N'Guitarra',0.0000,1500.0000,'2015-05-06'),
	 (NULL,N'Edad Media: Armas y tecnicas belicas',50000.0000,35000.0000,'2020-08-20'),
	 (NULL,N'Historia del Rock Argentino',20000.0000,2000.0000,'2020-08-20'),
	 (5,N'Ajedrez',7000.0000,700.0000,'2008-04-11'),
	 (5,N'Go',7000.0000,700.0000,'2008-04-11'),
	 (5,N'Damas',7000.0000,700.0000,'2008-04-11'),
	 (NULL,N'Internet para dummies',5000.0000,50.0000,'2010-08-19'),
	 (5,N'Comportamiento felino',60000.0000,6000.0000,'2024-01-10');

INSERT INTO Categorias_x_Curso (IDCurso,IDCategoria) VALUES
	 (1,10),
	 (1,18),
	 (2,5),
	 (2,12),
	 (3,2),
	 (3,4),
	 (3,14),
	 (4,10),
	 (4,18),
	 (5,10),
	 (5,18),
	 (6,6),
	 (6,17),
	 (7,5),
	 (7,16),
	 (8,2),
	 (8,7),
	 (8,10),
	 (9,2),
	 (9,9),
	 (9,15),
	 (10,3),
	 (10,8),
	 (10,9),
	 (11,1),
	 (11,9),
	 (11,15),
	 (12,6),
	 (12,9),
	 (12,13),
	 (13,6),
	 (13,9),
	 (13,13),
	 (14,9),
	 (14,13),
	 (15,10),
	 (15,11),
	 (16,9),
	 (16,19);

INSERT INTO Clases (IDCurso,Nombre,Numero,Duracion) VALUES
	 (1,N'Tipos de datos y variables',1,45),
	 (1,N'Estructura de decision',2,45),
	 (1,N'Estructura de repeticion',3,50),
	 (1,N'Arrays',4,60),
	 (1,N'Funciones',5,70),
	 (2,N'Pastas',1,50),
	 (2,N'Pizzas',2,50),
	 (2,N'Pescados',3,50),
	 (2,N'Dulces',4,50),
	 (3,N'Elementos basicos para comenzar',1,45),
	 (3,N'Tipos de telas',2,50),
	 (3,N'Tipos de puntos',3,60),
	 (4,N'Tipos de datos y variables',1,30),
	 (4,N'Estructura de decision',2,40),
	 (4,N'Estructura de repeticion',3,20),
	 (4,N'Arrays',4,40),
	 (4,N'Funciones',5,50),
	 (4,N'Clases',6,100),
	 (5,N'Tipos de datos y variables',1,50),
	 (5,N'Estructura de decision',2,60),
	 (5,N'Estructura de repeticion',3,50),
	 (5,N'Arrays',4,70),
	 (5,N'Funciones',5,60),
	 (5,N'Clases',6,70),
	 (6,N'Elementos basicos para comenzar',1,90),
	 (6,N'Los peces',2,120),
	 (6,N'Las moscas',3,90),
	 (7,N'Frutas de estacion',1,50),
	 (7,N'Coccion y almacenamiento',2,50),
	 (7,N'Herramientas para venta online',3,90),
	 (7,N'Poniendose al dia con la AFIP',4,110),
	 (8,N'Empezando: Ejemplos',1,60),
	 (8,N'Practica',2,70),
	 (8,N'Abandonando porque no me sale',3,5),
	 (9,N'Historia de la guitarra',1,60),
	 (9,N'Historia de las cuerdas de la guitarra',2,40),
	 (9,N'Historia de las clavijas de la guitarra',3,70),
	 (9,N'Brian May',4,80),
	 (10,N'La caballeria',1,150),
	 (10,N'La infanteria',2,200),
	 (10,N'Tropas lanzaproyectiles',3,240),
	 (10,N'Armas de asedio',4,330),
	 (11,N'Virus',1,120),
	 (11,N'Soda Stereo',2,120),
	 (11,N'Las demas bandas',3,30),
	 (12,N'Reglas de juego',1,80),
	 (13,N'Reglas de juego',1,80),
	 (14,N'Reglas de juego',1,40),
	 (15,N'La historia de Internet',1,90),
	 (15,N'Memes',2,70),
	 (15,N'¿Como mandar spam?',3,50),
	 (16,N'Los gatos en el antiguo Egipto',1,50),
	 (16,N'Adoptando un gatito',2,60),
	 (16,N'La salud de mi gato',3,70),
	 (16,N'Mi gato ¿quire matarme?',4,90);

INSERT INTO Contenidos (IDClase,IDTipoContenido,Tamaño) VALUES
	 (1,3,3),
	 (1,4,42129),
	 (2,3,9),
	 (2,4,42479),
	 (3,3,8),
	 (3,4,31123),
	 (4,3,8),
	 (4,4,52558),
	 (5,3,2),
	 (5,4,27233),
	 (6,4,7565),
	 (7,4,11748),
	 (8,4,12277),
	 (9,4,41865),
	 (10,3,10),
	 (10,4,55689),
	 (11,3,10),
	 (11,4,13564),
	 (12,3,8),
	 (12,4,45610),
	 (1,3,4),
	 (1,4,23281),
	 (2,3,8),
	 (2,4,27679),
	 (3,3,2),
	 (3,4,6054),
	 (4,3,1),
	 (4,4,33472),
	 (5,3,4),
	 (5,4,27925),
	 (5,2,1),
	 (18,3,7),
	 (18,4,21568),
	 (18,2,2),
	 (1,4,1093),
	 (2,4,57116),
	 (3,4,22670),
	 (4,4,40725),
	 (5,4,1772),
	 (18,4,50823),
	 (10,4,8836),
	 (26,4,23943),
	 (27,4,50476),
	 (28,3,1),
	 (28,4,54331),
	 (28,2,2),
	 (29,3,6),
	 (29,4,17761),
	 (29,2,2),
	 (30,3,5),
	 (30,4,56704),
	 (30,2,2),
	 (31,3,1),
	 (31,4,13237),
	 (31,2,1),
	 (32,4,15684),
	 (33,4,24366),
	 (34,4,7753),
	 (35,1,34),
	 (36,1,807),
	 (37,1,459),
	 (38,1,745),
	 (35,4,6799),
	 (36,4,2868),
	 (37,4,18715),
	 (38,4,31962),
	 (39,3,9),
	 (40,3,9),
	 (41,3,7),
	 (42,3,8),
	 (39,4,27851),
	 (40,4,48400),
	 (41,4,46921),
	 (42,4,29492),
	 (43,1,741),
	 (44,1,143),
	 (45,1,123),
	 (43,4,59839),
	 (44,4,16470),
	 (45,4,44445),
	 (46,3,1),
	 (46,3,3),
	 (46,3,2),
	 (49,4,21649),
	 (50,4,18306),
	 (51,4,21680),
	 (52,4,95000),
	 (53,3,500),
	 (54,4,158000),
	 (55,3,650);

INSERT INTO Idiomas (Nombre) VALUES
	 (N'Castellano'),
	 (N'Ingles'),
	 (N'Italiano'),
	 (N'Frances'),
	 (N'Portugues'),
	 (N'Chino');

INSERT INTO Idiomas_x_Curso (IDCurso,IDIdioma,IDFormatoIdioma) VALUES
	 (1,1,1),
	 (1,1,2),
	 (1,2,1),
	 (1,2,2),
	 (1,3,1),
	 (1,4,1),
	 (1,5,1),
	 (2,1,1),
	 (2,2,1),
	 (2,2,2),
	 (2,3,1),
	 (2,3,2),
	 (2,4,1),
	 (2,5,1),
	 (3,1,2),
	 (4,1,1),
	 (4,2,1),
	 (4,2,2),
	 (4,3,1),
	 (4,4,1),
	 (4,5,1),
	 (5,1,1),
	 (5,2,1),
	 (5,2,2),
	 (5,3,1),
	 (5,4,1),
	 (5,5,1),
	 (6,1,1),
	 (6,2,1),
	 (6,2,2),
	 (6,3,1),
	 (6,4,1),
	 (6,5,1),
	 (7,1,1),
	 (7,1,2),
	 (7,2,1),
	 (8,1,1),
	 (8,1,2),
	 (8,2,1),
	 (9,1,2),
	 (10,1,1),
	 (10,2,1),
	 (10,2,2),
	 (11,1,1),
	 (11,1,2),
	 (12,1,1),
	 (12,1,2),
	 (13,1,1),
	 (13,1,2),
	 (14,1,1),
	 (14,1,2),
	 (15,1,1),
	 (15,1,2),
	 (15,2,1);