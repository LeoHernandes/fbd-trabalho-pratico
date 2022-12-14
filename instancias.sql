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

CREATE TABLE PadraoDeFoto (
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
    REFERENCES PadraoDeFoto
    ON DELETE CASCADE
);

CREATE TABLE Video (
	linkPostagem INTEGER PRIMARY KEY,
    duracao TIME NOT NULL,
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
-------------------------- INST??NCIAS --------------------------
----------------------------------------------------------------

INSERT INTO Usuario(codigoUsuario, nome, descricao)
VALUES 
(327023, 'V??tor Caruso', 'Ga??cho e programador. Me sigam nas redes sociais! @progaucho'),
(323961, 'L??o Vasconcelos', 'Ol??, sou o L??o!'),
(258134, 'Hunter Prosper', 'We are more alike than we are different'),
(1, 'The Creator', NULL),
(1145, 'Karin Becker', 'Sou nova por aqui!'),
(84579, 'Camilla Santaola', 'Libre para disfrutar de la vida'),
(155470, 'DJ Hernandes', 'Ven a escuchar mis canciones');

INSERT INTO Seguir(usuarioSeguidor, UsuarioSeguido)
VALUES
(327023, 323961),
(323961, 327023),
(327023, 258134),
(84579, 155470),
(155470, 258134),
(327023, 1145),
(323961, 1145),
(327023, 1),
(323961, 1),
(258134, 1),
(155470, 1),
(1145, 1),
(84579, 1);

INSERT INTO Audio(codigoAudio, nome, duracao, codigoUsuario)
VALUES 
(1, 'som original - V??tor Caruso', '00:00:15', 327023),
(2, 'som original - V??tor Caruso', '00:00:30', 327023),
(3, 'som original - L??o Vasconcelos', '00:00:27', 323961),
(4, 'som Original - L??o Vasoncelos', '00:01:14', 323961),
(5, 'som original - Hunter Prosper', '00:00:30', 258134),
(6, 'som Original - Hunter Prosper', '00:01:00', 258134),
(7, 'som original - Hunter Prosper', '00:00:23', 258134),
(8, 'som Original - Hunter Prosper', '00:01:25', 258134),
(9, 'som original - Hunter Prosper', '00:02:03', 258134),
(10, 'som Original - Hunter Prosper', '00:01:00', 258134),
(11, 'som original - Hunter Prosper', '00:00:46', 258134),
(12, 'som Original - Hunter Prosper', '00:01:51', 258134),
(13, 'kaboom', '00:00:09', 258134),
(14, 'envolver-remix', '00:01:00', 155470),
(15, 'dont worry-remix', '00:00:30', 155470),
(16, 'despacito-remix', '00:01:00', 155470),
(17, 'where is my mind', '00:00:37', 1),
(18, 'Facetime ring', '00:10:00', 1),
(19, 'Beep', '00:00:04', 1);

INSERT INTO Idioma(nomeIdioma)
VALUES 
('Portugu??s'),
('Espanhol'),
('Ingl??s'),
('Alem??o');

INSERT INTO Compreensao(nomeIdioma, codigoUsuario)
VALUES
('Portugu??s', 327023),
('Ingl??s', 327023),
('Portugu??s', 323961),
('Portugu??s', 1145),
('Espanhol', 1145),
('Ingl??s', 1145),
('Alem??o', 1145),
('Ingl??s', 258134),
('Ingl??s', 1),
('Espanhol', 84579),
('Espanhol', 155470);

INSERT INTO Postagem(linkPostagem, compartilhamentos, curtidas, codigoUsuario, codigoAudio, nomeIdioma, tipo)
VALUES 
(1, 107, 26045, 327023, 19, 'Portugu??s', TRUE),
(2, 5, 1989, 327023, 1, 'Portugu??s', FALSE),
(3, 0, 5, 327023, NULL, 'Portugu??s', TRUE),
(4, 554, 140846, 327023, 2, 'Portugu??s', TRUE),

(5, 1, 14, 323961, 3, 'Portugu??s', TRUE),
(6, 15, 4744, 323961, 18, 'Portugu??s', FALSE),
(7, 3, 132, 323961, 4, 'Portugu??s', FALSE),
(8, 247, 90846, 323961, 2, 'Portugu??s', TRUE),
(9, 0, 32, 323961, 13, 'Portugu??s', TRUE),

(10, 2045, 1256849, 258134, 5, 'Ingl??s', TRUE),
(11, 53, 256441, 258134, 6, 'Ingl??s', TRUE),
(12, 659, 3560127, 258134, 7, 'Ingl??s', TRUE),
(13, 151, 450120, 258134, 8, 'Ingl??s', TRUE),
(14, 6531, 48163244, 258134, 9, 'Ingl??s', TRUE),
(15, 15, 161125, 258134, 10, 'Ingl??s', TRUE),
(16, 1658, 2864652, 258134, 11, 'Ingl??s', TRUE),
(17, 844, 664023, 258134, 12, 'Ingl??s', TRUE),
(18, 564, 274648, 258134, 13, 'Ingl??s', TRUE),

(19, 4, 53, 84579, 14, 'Espanhol', FALSE),
(20, 1, 17, 84579, 15, 'Espanhol', FALSE),
(21, 0, 11, 84579, 16, 'Espanhol', FALSE),
(22, 0, 34, 84579, 17, 'Espanhol', FALSE),
(23, 0, 13, 84579, NULL, 'Espanhol', FALSE),

(24, 513, 1084685, 155470, 14, 'Espanhol', TRUE),
(25, 421, 742890, 155470, 15, 'Espanhol', TRUE),
(26, 3042, 4452689, 155470, 16, 'Espanhol', TRUE);


INSERT INTO Ver(linkPostagem, codigoUsuario, dataHora, curtiu, compartilhou)
VALUES
(10, 327023, '2022-08-02 22:04:21', TRUE, TRUE),
(11, 327023, '2022-08-02 22:07:25', FALSE, FALSE),
(12, 327023, '2022-08-03 12:53:48', FALSE, FALSE),
(13, 327023, '2022-08-03 12:57:11', FALSE, TRUE),
(14, 327023, '2022-08-03 13:02:01', FALSE, FALSE),
(15, 327023, '2022-08-03 13:05:15', TRUE, TRUE),
(16, 327023, '2022-08-05 15:42:58', FALSE, FALSE),
(17, 327023, '2022-08-06 02:20:36', TRUE, FALSE),
(18, 327023, '2022-08-06 02:29:31', FALSE, FALSE),
(8, 327023, '2022-09-12 23:05:10', TRUE, FALSE),
(6, 327023, '2022-09-25 22:30:42', TRUE, FALSE),

(1, 323961, '2022-09-11 03:15:46', TRUE, FALSE),
(2, 323961, '2022-09-12 22:39:41', TRUE, FALSE),
(3, 323961, '2022-09-17 21:55:23', FALSE, FALSE),
(4, 323961, '2022-09-22 22:06:02', TRUE, TRUE),

(4, 1145, '2022-09-11 12:31:16', TRUE, FALSE),
(8, 1145, '2022-09-12 12:40:39', TRUE, FALSE),

(24, 84579, '2022-05-03 17:25:20', TRUE, TRUE),
(25, 84579, '2022-07-29 04:22:50', TRUE, TRUE),
(26, 84579, '2022-08-20 18:49:13', TRUE, TRUE);

INSERT INTO PadraoDeFoto(nomePadrao)
VALUES 
('Rainbow'),
('Glitters'),
('No Vapor'),
('TV Show'),
('Glitch'),
('Raining Love');

INSERT INTO Efeito(nome, codigoUsuario)
VALUES 
('Sardas Reais', 1),
('Desenhando o Rosto', 1),
('Olhos Azuis', 1),
('Lightning', 258134),
('Distorsi??n delirante', 155470),
('Sintiendo el ritmo', 155470);

INSERT INTO Carrossel(linkPostagem, quantidadefotos, nomePadrao)
VALUES 
(2, 5, 'Glitch'),
(6, 10, 'TV Show'),
(7, 10, 'No Vapor'),
(19, 3, 'Raining Love'),
(20, 6, 'Glitters'),
(21, 7, 'Rainbow'),
(22, 7, 'Rainbow'),
(23, 10, 'Glitters');

INSERT INTO Pergunta(codigoPergunta, texto, codigoUsuario)
VALUES 
(1, 'Qual sua comida favorita?', 327023),
(2, 'Qual profiss??o voc?? queria ser quando crian??a?', 323961),
(3, 'What was the name of your first love and why did you fall in love with them?', 258134),
(4, '??Cu??l es tu remix favorito?', 84579);

INSERT INTO Lugar(cidade, estado, pais)
VALUES 
('Porto Alegre do Norte', 'Mato Grosso', 'Brasil'),
('Porto Alegre', 'Rio Grande do Sul', 'Brasil'),
('Orlando', 'Fl??rida', 'Estados Unidos'),
('Terrassa', 'Barcelona', 'Espanha');

INSERT INTO Favorito(codigoLugar, codigoUsuario)
VALUES
(1, 327023),
(2, 327023),
(2, 323961),
(2, 1145),
(3, 258134);

INSERT INTO Video(linkPostagem, duracao, codigoPergunta, codigoLugar)
VALUES 

(1, '00:00:15', NULL, NULL),
(3, '00:01:00', NULL, 2),
(4, '00:00:37', 3, 2),
(5, '00:00:37', NULL, NULL),
(8, '00:00:37', NULL, 2),
(9, '00:00:45', 1, NULL),
(10, '00:00:30', NULL, 3),
(11, '00:01:00', NULL, 3),
(12, '00:00:23', NULL, 3),
(13, '00:01:25', 3, 3),
(14, '00:02:03', NULL, 3),
(15, '00:01:00', NULL, 3),
(16, '00:00:46', NULL, 3),
(17, '00:01:51', NULL, 3),
(18, '00:00:10', NULL, 3),
(24, '00:00:30', 4, 4),
(25, '00:00:30', NULL, NULL),
(26, '00:00:30', NULL, NULL);

INSERT INTO Composicao(linkPostagem, codigoEfeito)
VALUES
(4, 3),
(8, 3),
(10, 1),
(12, 2),
(13, 3),
(24, 5),
(24, 6),
(25, 4),
(25, 5),
(26, 6);

INSERT INTO Hashtag(nomeHashtag)
VALUES 
('fyp'),
('foryou'),
('amor'),
('love'),
('refreshing'),
('cute'),
('remix'),
('joke');

INSERT INTO Salvar(codigoUsuario, nomeHashtag)
VALUES
(327023, 'cute'),
(327023, 'amor'),
(327023, 'love'),
(327023, 'joke'),
(323961, 'fyp'),
(323961, 'foryou'),
(323961, 'amor'),
(323961, 'love'),
(323961, 'remix'),
(1145, 'amor'),
(1145, 'love'),
(1145, 'cute'),
(84579, 'fyp'),
(84579, 'remix'),
(155470, 'remix');

INSERT INTO Inclusao(nomeHashtag, linkPostagem)
VALUES
('fyp', 4),
('fyp', 8),
('fyp', 10),
('fyp', 11),
('fyp', 12),
('fyp', 13),
('fyp', 14),
('fyp', 15),
('fyp', 16),
('fyp', 17),
('fyp', 18),
('fyp', 19),
('fyp', 20),
('fyp', 21),
('fyp', 22),
('fyp', 23),
('fyp', 24),
('fyp', 25),
('fyp', 26),
('foryou', 4),
('foryou', 8),
('foryou', 10),
('foryou', 11),
('foryou', 12),
('foryou', 13),
('foryou', 14),
('foryou', 15),
('foryou', 16),
('foryou', 17),
('foryou', 18),
('foryou', 24),
('foryou', 25),
('foryou', 26),
('amor', 4),
('amor', 8),
('cute', 10),
('cute', 19),
('cute', 20),
('joke', 11),
('joke', 12),
('joke', 23),
('love', 13),
('remix', 24),
('remix', 25),
('remix', 26);

INSERT INTO Musica(codigoMusica, duracao, artista, nome)
VALUES 
(1, '00:03:01', 'Rex Orange County', 'THE SHADE'),
(2, '00:03:21', 'Victor e Leo', 'Borboletas'),
(3, '00:03:36', 'Billie Eilish', 'The 30th'),
(4, '00:03:14', 'Ana Castela', 'Pipoco'),
(5, '00:03:53', 'Joji', 'Glimpse of Us'),
(6, '00:02:47', 'Mc Livinho, Alok', 'Symphonia - Remix'),
(7, '00:03:13', 'Anitta', 'Envolver');

INSERT INTO Escutar(codigoMusica, codigoUsuario, dataHora)
VALUES
(1, 258134, '2022-09-12 13:05:39'),
(3, 258134, '2022-09-15 15:07:10'),
(3, 258134, '2022-09-15 15:11:15'),
(3, 258134, '2022-09-16 12:55:14'),
(5, 258134, '2022-09-08 15:45:34'),
(2, 323961, '2022-08-23 18:24:30'),
(2, 323961, '2022-08-23 18:28:12'),
(2, 323961, '2022-08-23 18:37:15'),
(2, 323961, '2022-08-23 18:41:54'),
(2, 323961, '2022-08-23 18:48:34'),
(2, 323961, '2022-08-24 18:24:30'),
(2, 323961, '2022-08-24 18:28:12'),
(2, 323961, '2022-08-24 18:37:15'),
(2, 323961, '2022-08-24 18:41:54'),
(4, 323961, '2022-05-02 18:28:12'),
(4, 323961, '2022-05-02 18:37:15'),
(4, 323961, '2022-05-02 18:41:54'),
(4, 323961, '2022-05-05 18:48:34'),
(6, 323961, '2022-07-28 18:28:12'),
(6, 323961, '2022-07-28 18:37:15'),
(6, 323961, '2022-07-29 18:41:54'),
(2, 327023, '2022-08-15 18:24:30'),
(2, 327023, '2022-08-15 18:28:12'),
(2, 327023, '2022-08-16 18:37:15'),
(2, 327023, '2022-08-16 18:41:54'),
(2, 327023, '2022-08-18 18:48:34'),
(2, 327023, '2022-08-18 18:37:15'),
(2, 327023, '2022-08-25 18:41:54'),
(3, 327023, '2022-07-02 18:28:12'),
(3, 327023, '2022-07-02 18:37:15'),
(3, 327023, '2022-07-02 18:41:54'),
(3, 327023, '2022-07-05 18:48:34'),
(6, 327023, '2022-05-11 18:28:12'),
(6, 327023, '2022-05-11 18:37:15'),
(6, 327023, '2022-05-12 18:41:54'),
(7, 84579, '2022-08-25 18:41:54'),
(7, 84579, '2022-07-02 18:28:12'),
(7, 84579, '2022-07-02 18:37:15'),
(7, 84579, '2022-07-02 18:41:54'),
(7, 84579, '2022-07-05 18:48:34'),
(7, 84579, '2022-05-11 18:28:12'),
(7, 84579, '2022-05-11 18:37:15'),
(7, 84579, '2022-05-12 18:41:54'),
(2, 1145, '2022-08-25 18:41:54'),
(2, 1145, '2022-07-02 18:28:12'),
(2, 1145, '2022-07-02 18:37:15'),
(2, 1145, '2022-07-02 18:41:54');