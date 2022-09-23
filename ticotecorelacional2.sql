/* ticotecorelacional: */

CREATE TABLE Usuario (
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(160) NOT NULL
);

CREATE TABLE Postagem (
    compart INTEGER NOT NULL,
    link INTEGER PRIMARY KEY,
    curtidas INTEGER NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL,
    fk_Audio_codigo INTEGER NOT NULL,
    fk_Idioma_nome CHAR NOT NULL,
	tipo BOOL NOT NULL
);

CREATE TABLE Musica (
    codigo INTEGER PRIMARY KEY,
    duracao TIME NOT NULL,
    artista VARCHAR(100) NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Idioma (
    nome CHAR(16) PRIMARY KEY
);

CREATE TABLE Hashtag (
    nome CHAR(16) PRIMARY KEY
);

CREATE TABLE Audio (
    codigo INTEGER PRIMARY KEY,
    nome CHAR,
    duracao TIME,
    fk_Usuario_codigo INTEGER
);

CREATE TABLE Padrao_de_fotos (
    nome CHAR(32) PRIMARY KEY,
);

CREATE TABLE Efeito (
    nome CHAR(32) PRIMARY KEY,
    fk_Usuario_codigo INTEGER
);

CREATE TABLE Carrossel (
    qntFotos SMALLINT NOT NULL,
    fk_Postagem_link INTEGER PRIMARY KEY,
    fk_Padrao_de_fotos_nome CHAR(32) NOT NULL
);

CREATE TABLE Video (
    duracao TIME NOT NULL,
    fk_Postagem_link INTEGER PRIMARY KEY,
    fk_Lugar_codigo INTEGER,
    fk_Pergunta_codigo INTEGER
);

CREATE TABLE Pergunta (
    codigo INTEGER PRIMARY KEY,
    texto VARCHAR(150) NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL
);

CREATE TABLE Lugar (
    codigo SERIAL PRIMARY KEY,
    pais CHAR(32) NOT NULL,
    estado CHAR(32) NOT NULL,
    cidade CHAR(32) NOT NULL,
    UNIQUE (pais, estado, cidade)
);

CREATE TABLE Seguir (
    fk_Usuario_codigo INTEGER NOT NULL,
    fk_Usuario_codigo_ INTEGER NOT NULL
);

CREATE TABLE Ver (
    fk_Postagem_link INTEGER NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL,
    data TIMESTAMP NOT NULL,
    curtiu BOOLEAN NOT NULL,
    compartilhou BOOLEAN NOT NULL
);

CREATE TABLE Salvar (
    fk_Usuario_codigo INTEGER NOT NULL,
    fk_Hashtag_nome CHAR(16) NOT NULL
);

CREATE TABLE Composicao (
    fk_Video_fk_Postagem_link INTEGER NOT NULL,
    fk_Efeito_nome CHAR(32) NOT NULL
);

CREATE TABLE Escutar (
    fk_Musica_codigo INTEGER NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL
);

CREATE TABLE Favorito (
    fk_Lugar_codigo INTEGER NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL
);

CREATE TABLE Inclusao (
    fk_Postagem_link INTEGER NOT NULL,
    fk_Hashtag_nome CHAR(16) NOT NULL
);

CREATE TABLE Compreensao (
    fk_Idioma_nome CHAR(16) NOT NULL,
    fk_Usuario_codigo INTEGER NOT NULL
);
 
ALTER TABLE Postagem ADD CONSTRAINT FK_Postagem_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Postagem ADD CONSTRAINT FK_Postagem_3
    FOREIGN KEY (fk_Audio_codigo)
    REFERENCES Audio (codigo)
    ON DELETE RESTRICT;
 
ALTER TABLE Postagem ADD CONSTRAINT FK_Postagem_4
    FOREIGN KEY (fk_Idioma_nome)
    REFERENCES Idioma (nome)
    ON DELETE CASCADE;
 
ALTER TABLE Audio ADD CONSTRAINT FK_Audio_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Efeito ADD CONSTRAINT FK_Efeito_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Carrossel ADD CONSTRAINT FK_Carrossel_2
    FOREIGN KEY (fk_Postagem_link)
    REFERENCES Postagem (link)
    ON DELETE CASCADE;
 
ALTER TABLE Carrossel ADD CONSTRAINT FK_Carrossel_3
    FOREIGN KEY (fk_Padrao_de_fotos_nome)
    REFERENCES Padrao_de_fotos (nome)
    ON DELETE CASCADE;
 
ALTER TABLE Video ADD CONSTRAINT FK_Video_2
    FOREIGN KEY (fk_Postagem_link)
    REFERENCES Postagem (link)
    ON DELETE CASCADE;
 
ALTER TABLE Video ADD CONSTRAINT FK_Video_3
    FOREIGN KEY (fk_Lugar_pais, fk_Lugar_estado, fk_Lugar_cidade)
    REFERENCES Lugar (pais, estado, cidade)
    ON DELETE SET NULL;
 
ALTER TABLE Video ADD CONSTRAINT FK_Video_4
    FOREIGN KEY (fk_Pergunta_codigo)
    REFERENCES Pergunta (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Pergunta ADD CONSTRAINT FK_Pergunta_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Seguir ADD CONSTRAINT FK_Seguir_1
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Seguir ADD CONSTRAINT FK_Seguir_2
    FOREIGN KEY (fk_Usuario_codigo_)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Ver ADD CONSTRAINT FK_Ver_1
    FOREIGN KEY (fk_Postagem_link)
    REFERENCES Postagem (link)
    ON DELETE SET NULL;
 
ALTER TABLE Ver ADD CONSTRAINT FK_Ver_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Salvar ADD CONSTRAINT FK_Salvar_1
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Salvar ADD CONSTRAINT FK_Salvar_2
    FOREIGN KEY (fk_Hashtag_nome)
    REFERENCES Hashtag (nome)
    ON DELETE SET NULL;
 
ALTER TABLE Composicao ADD CONSTRAINT FK_Composicao_1
    FOREIGN KEY (fk_Video_fk_Postagem_link)
    REFERENCES Video (fk_Postagem_link)
    ON DELETE SET NULL;
 
ALTER TABLE Composicao ADD CONSTRAINT FK_Composicao_2
    FOREIGN KEY (fk_Efeito_nome)
    REFERENCES Efeito (nome)
    ON DELETE SET NULL;
 
ALTER TABLE Escutar ADD CONSTRAINT FK_Escutar_1
    FOREIGN KEY (fk_Musica_codigo)
    REFERENCES Musica (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Escutar ADD CONSTRAINT FK_Escutar_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Favorito ADD CONSTRAINT FK_Favorito_1
    FOREIGN KEY (fk_Lugar_pais, fk_Lugar_estado, fk_Lugar_cidade)
    REFERENCES Lugar (pais, estado, cidade)
    ON DELETE SET NULL;
 
ALTER TABLE Favorito ADD CONSTRAINT FK_Favorito_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Inclusao ADD CONSTRAINT FK_Inclusao_1
    FOREIGN KEY (fk_Postagem_link)
    REFERENCES Postagem (link)
    ON DELETE RESTRICT;
 
ALTER TABLE Inclusao ADD CONSTRAINT FK_Inclusao_2
    FOREIGN KEY (fk_Hashtag_nome)
    REFERENCES Hashtag (nome)
    ON DELETE SET NULL;
 
ALTER TABLE Compreensao ADD CONSTRAINT FK_Compreensao_1
    FOREIGN KEY (fk_Idioma_nome)
    REFERENCES Idioma (nome)
    ON DELETE RESTRICT;
 
ALTER TABLE Compreensao ADD CONSTRAINT FK_Compreensao_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;