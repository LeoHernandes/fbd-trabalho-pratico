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
    nome CHAR NOT NULL,
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
    nomeIdioma CHAR NOT NULL,
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