/* ticotecorelacional: */

CREATE TABLE Usuario (
    codigoUsuario INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(160)
);

CREATE TABLE Idioma (
    nomeIdioma CHAR(16) PRIMARY KEY
);

CREATE TABLE Hashtag (
    nomeHashtag CHAR(16) PRIMARY KEY
);

CREATE TABLE Audio (
    codigoAudio INTEGER PRIMARY KEY,
    nome CHAR(32) NOT NULL,
    duracao TIME NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE PadraoDeFotos (
    nomePadrao CHAR(32) PRIMARY KEY
);

CREATE TABLE Efeito (
	codigoEfeito SERIAL PRIMARY KEY,
    nome CHAR(32) NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	UNIQUE(nome, codigoUsuario),

	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE Pergunta (
    codigoPergunta INTEGER PRIMARY KEY,
    texto VARCHAR(150) NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE Lugar (
    codigoLugar SERIAL PRIMARY KEY,
    pais CHAR(32) NOT NULL,
    estado CHAR(32) NOT NULL,
    cidade CHAR(32) NOT NULL,
    UNIQUE (pais, estado, cidade)
);

CREATE TABLE Postagem (
	linkPostagem INTEGER PRIMARY KEY,
    compartilhamentos INTEGER NOT NULL,
    curtidas INTEGER NOT NULL,
    codigoUsuario INTEGER NOT NULL,
    codigoAudio INTEGER,
    nomeIdioma CHAR(16) NOT NULL,
	tipo BOOLEAN NOT NULL,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE,
	
	FOREIGN KEY (codigoAudio)
    REFERENCES Audio
    ON DELETE SET NULL,
	
	FOREIGN KEY (nomeIdioma)
    REFERENCES Idioma
    ON DELETE CASCADE
);

CREATE TABLE Carrossel (
    quantidadeFotos SMALLINT NOT NULL,
    linkPostagem INTEGER PRIMARY KEY,
    nomePadrao CHAR(32) NOT NULL,
	
    FOREIGN KEY (linkPostagem)
    REFERENCES Postagem
    ON DELETE CASCADE,
	
    FOREIGN KEY (nomePadrao)
    REFERENCES PadraoDeFotos
    ON DELETE CASCADE
);

CREATE TABLE Video (
	linkPostagem INTEGER PRIMARY KEY,
    duracao TIME NOT NULL,
	codigoEfeito INTEGER NOT NULL,
    codigoLugar INTEGER,
    codigoPergunta INTEGER,
	
	FOREIGN KEY (linkPostagem)
    REFERENCES Postagem
	ON DELETE CASCADE,
	
	FOREIGN KEY (codigoLugar)
    REFERENCES Lugar
    ON DELETE SET NULL,
	
	FOREIGN KEY (codigoPergunta)
    REFERENCES Pergunta
    ON DELETE SET NULL
);

CREATE TABLE Musica (
    codigoMusica INTEGER PRIMARY KEY,
    duracao TIME NOT NULL,
    artista VARCHAR(100) NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Seguir (
    usuarioSeguidor INTEGER NOT NULL,
    usuarioSeguido INTEGER NOT NULL,
	
	FOREIGN KEY (usuarioSeguidor)
    REFERENCES Usuario (codigoUsuario)
    ON DELETE CASCADE,
	
	FOREIGN KEY (usuarioSeguido)
    REFERENCES Usuario (codigoUsuario)
    ON DELETE CASCADE
);

CREATE TABLE Ver (
    linkPostagem INTEGER NOT NULL,
    codigoUsuario INTEGER NOT NULL,
    dataHora TIMESTAMP NOT NULL,
    curtiu BOOLEAN NOT NULL,
    compartilhou BOOLEAN NOT NULL,
	
	FOREIGN KEY (linkPostagem)
    REFERENCES Postagem
    ON DELETE CASCADE,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE Salvar (
    codigoUsuario INTEGER NOT NULL,
    nomeHashtag CHAR(16) NOT NULL,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE,
	
	FOREIGN KEY (nomeHashtag)
    REFERENCES Hashtag
    ON DELETE CASCADE
);

CREATE TABLE Composicao (
    linkPostagem INTEGER NOT NULL,
    codigoEfeito INTEGER NOT NULL,
	
	FOREIGN KEY (linkPostagem)
    REFERENCES Video
    ON DELETE CASCADE,
	
    FOREIGN KEY (codigoEfeito)
    REFERENCES Efeito
    ON DELETE CASCADE
);

CREATE TABLE Escutar (
    codigoMusica INTEGER NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	dataHora TIMESTAMP NOT NULL,
	
	FOREIGN KEY (codigoMusica)
    REFERENCES Musica
    ON DELETE CASCADE,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE Favorito (
    codigoLugar INTEGER NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	
	FOREIGN KEY (codigoLugar)
    REFERENCES Lugar
    ON DELETE CASCADE,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

CREATE TABLE Inclusao (
    linkPostagem INTEGER NOT NULL,
    nomeHashtag CHAR(16) NOT NULL,
	
	FOREIGN KEY (linkPostagem)
    REFERENCES Postagem
    ON DELETE CASCADE,
	
	FOREIGN KEY (nomeHashtag)
    REFERENCES Hashtag
    ON DELETE CASCADE
);

CREATE TABLE Compreensao (
    nomeIdioma CHAR(16) NOT NULL,
    codigoUsuario INTEGER NOT NULL,
	
	FOREIGN KEY (nomeIdioma)
    REFERENCES Idioma
    ON DELETE CASCADE,
	
	FOREIGN KEY (codigoUsuario)
    REFERENCES Usuario
    ON DELETE CASCADE
);

----------------------------------------------------------------
-------------------------- INSTÂNCIAS --------------------------
----------------------------------------------------------------

INSERT INTO Usuario(codigoUsuario, nome, descricao)
VALUES 
(327023, 'Vítor Caruso', 'Gaúcho e programador. Me sigam nas redes sociais! @progaucho'),
(323691, 'Léo Vasconcelos', 'Olá, sou o Léo!'),
(258134, 'Hunter Prosper', 'We are more alike than we are different'),
(1, 'The Creator', NULL),
(1145, 'Karin Becker', 'Sou nova por aqui!'),
(84579, 'Camilla Santaola', 'Libre para disfrutar de la vida');

INSERT INTO Seguir(usuarioSeguidor, UsuarioSeguido)
VALUES
(327023, 323691),
(323691, 327023),
(327023, 258134),
(84579, 258134),
(327023, 1145),
(323691, 1145),
(327023, 1),
(323691, 1),
(258134, 1),
(1145, 1),
(84579, 1);

INSERT INTO Audio(codigoAudio, nome, duracao, codigoUsuario)
VALUES 
(1, 'som original - Vítor Caruso', '00:00:15', 327023),
(2, 'som original - Vítor Caruso', '00:00:30', 327023),
(3, 'som original - Léo Vasconcelos', '00:00:27', 323691),
(4, 'som Original - Léo Vasoncelos', '00:01:14', 323691),
(5, 'som original - Hunter Prosper', '00:00:30', 258134),
(6, 'som Original - Hunter Prosper', '00:01:00', 258134),
(7, 'som original - Hunter Prosper', '00:00:23', 258134),
(8, 'som Original - Hunter Prosper', '00:01:25', 258134),
(9, 'som original - Hunter Prosper', '00:02:03', 258134),
(10, 'som Original - Hunter Prosper', '00:01:00', 258134),
(11, 'som original - Hunter Prosper', '00:00:46', 258134),
(12, 'som Original - Hunter Prosper', '00:01:51', 258134),
(13, 'kaboom', '00:00:09', 258134),
(14, 'envolver-remix', '00:01:00', 84579),
(15, 'dont worry-remix', '00:00:30', 84579),
(16, 'despacito-remix', '00:01:00', 84579),
(17, 'where is my mind', '00:00:37', 1),
(18, 'Facetime ring', '00:10:00', 1),
(19, 'Beep', '00:00:04', 1);

INSERT INTO Idioma(nomeIdioma)
VALUES 
('Português'),
('Espanhol'),
('Inglês'),
('Alemão');

INSERT INTO Postagem(linkPostagem, compartilhamentos, curtidas, codigoUsuario, codigoAudio, nomeIdioma, tipo)
VALUES 
(1, 107, 26045, 327023, 19, 'Português', TRUE),
(2, 5, 1989, 327023, 1, 'Português', FALSE),
(3, 0, 5, 327023, NULL, 'Português', TRUE),
(4, 554, 140846, 327023, 2, 'Português', TRUE),

(5, 1, 14, 323691, 3, 'Português', TRUE),
(6, 15, 4744, 323691, 18, 'Português', FALSE),
(7, 3, 132, 323691, 4, 'Português', FALSE),
(8, 247, 90846, 323691, 2, 'Português', TRUE),
(9, 0, 32, 323691, 13, 'Português', TRUE),

(10, 2045, 1256849, 258134, 5, 'Inglês', TRUE),
(11, 53, 256441, 258134, 6, 'Inglês', TRUE),
(12, 659, 3560127, 258134, 7, 'Inglês', TRUE),
(13, 151, 450120, 258134, 8, 'Inglês', TRUE),
(14, 6531, 48163244, 258134, 9, 'Inglês', TRUE),
(15, 15, 161125, 258134, 10, 'Inglês', TRUE),
(16, 1658, 2864652, 258134, 11, 'Inglês', TRUE),
(17, 844, 664023, 258134, 12, 'Inglês', TRUE),
(18, 564, 274648, 258134, 13, 'Inglês', TRUE),

(19, 4, 53, 84579, 14, 'Espanhol', FALSE),
(20, 1, 12, 84579, 15, 'Espanhol', FALSE),
(21, 0, 11, 84579, 16, 'Espanhol', FALSE),
(22, 0, 34, 84579, 17, 'Espanhol', FALSE);

---------------------------------------------------------------
-------------------------- CONSULTAS --------------------------
---------------------------------------------------------------

CREATE VIEW TotalCurtidasPorUsuario
AS select nome, sum (curtidas) totalCurtidas
   from Usuario natural join Postagem
   group by codigoUsuario
   order by nome
   
CREATE VIEW TotalSeguidoresPorUsuario
AS select nome, count TotalSeguidores
   from Usuario join Seguir (using Usuario.codigoUsuario = Seguir.usuarioSeguido)
   group by codigoUsuario
   order by nome