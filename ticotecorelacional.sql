/* ticotecorelacional: */

CREATE TABLE Usuario (
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR,
    descricao VARCHAR
);

CREATE TABLE Postagem (
    compart CHAR,
    link INTEGER PRIMARY KEY,
    curtidas INTEGER,
    fk_Usuario_codigo INTEGER,
    fk_Audio_codigo INTEGER
);

CREATE TABLE Musica (
    codigo INTEGER PRIMARY KEY,
    duracao TIME,
    artista VARCHAR,
    nome VARCHAR
);

CREATE TABLE Idioma (
    nome CHAR PRIMARY KEY
);

CREATE TABLE Hashtag (
    nome CHAR PRIMARY KEY
);

CREATE TABLE Audio (
    codigo INTEGER PRIMARY KEY,
    nome CHAR,
    duracao TIME
);

CREATE TABLE Padrao_de_fotos (
    nome CHAR PRIMARY KEY,
    qntUsos INTEGER
);

CREATE TABLE Efeito (
    nome CHAR,
    criador CHAR,
    PRIMARY KEY (nome, criador)
);

CREATE TABLE Carrossel (
    qntFotos SMALLINT,
    fk_Postagem_link INTEGER PRIMARY KEY,
    fk_Padrao_de_fotos_nome CHAR
);

CREATE TABLE Video (
    duracao TIME,
    fk_Postagem_link INTEGER PRIMARY KEY,
    fk_Lugar_pais CHAR,
    fk_Lugar_estado CHAR,
    fk_Lugar_cidade CHAR,
    fk_Pergunta_codigo INTEGER
);

CREATE TABLE Pergunta (
    codigo INTEGER PRIMARY KEY,
    texto VARCHAR,
    fk_Usuario_codigo INTEGER
);

CREATE TABLE Lugar (
    pais CHAR,
    estado CHAR,
    cidade CHAR,
    PRIMARY KEY (pais, estado, cidade)
);

CREATE TABLE Seguir (
    fk_Usuario_codigo INTEGER,
    fk_Usuario_codigo_ INTEGER
);

CREATE TABLE Ver (
    fk_Usuario_codigo INTEGER,
    fk_Postagem_link INTEGER,
    data TIMESTAMP
);

CREATE TABLE Salvar (
    fk_Usuario_codigo INTEGER,
    fk_Hashtag_nome CHAR
);

CREATE TABLE Composicao (
    fk_Video_fk_Postagem_link INTEGER,
    fk_Efeito_nome CHAR,
    fk_Efeito_criador CHAR
);

CREATE TABLE Escutar (
    fk_Musica_codigo INTEGER,
    fk_Usuario_codigo INTEGER
);

CREATE TABLE Favorito (
    fk_Lugar_pais CHAR,
    fk_Lugar_estado CHAR,
    fk_Lugar_cidade CHAR,
    fk_Usuario_codigo INTEGER
);

CREATE TABLE Inclusao (
    fk_Postagem_link INTEGER,
    fk_Hashtag_nome CHAR
);

CREATE TABLE Compreensao (
    fk_Idioma_nome CHAR,
    fk_Usuario_codigo INTEGER
);
 
ALTER TABLE Postagem ADD CONSTRAINT FK_Postagem_2
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Postagem ADD CONSTRAINT FK_Postagem_3
    FOREIGN KEY (fk_Audio_codigo)
    REFERENCES Audio (codigo)
    ON DELETE RESTRICT;
 
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
    FOREIGN KEY (fk_Usuario_codigo)
    REFERENCES Usuario (codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Ver ADD CONSTRAINT FK_Ver_2
    FOREIGN KEY (fk_Postagem_link)
    REFERENCES Postagem (link)
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
    FOREIGN KEY (fk_Efeito_nome, fk_Efeito_criador)
    REFERENCES Efeito (nome, criador)
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