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
    nome CHAR(32) NOT NULL,
    duracao TIME NOT NULL
);

CREATE TABLE Padrao_de_fotos (
    nome CHAR(32) PRIMARY KEY,
    qntUsos INTEGER NOT NULL
);

CREATE TABLE Efeito (
    codigo SERIAL PRIMARY KEY,
    nome CHAR(32) NOT NULL,
    criador CHAR(32) NOT NULL,
    UNIQUE (nome, criador)
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
    fk_Usuario_codigo INTEGER NOT NULL,
    fk_Postagem_link INTEGER NOT NULL,
    data TIMESTAMP NOT NULL
);

CREATE TABLE Salvar (
    fk_Usuario_codigo INTEGER NOT NULL,
    fk_Hashtag_nome CHAR(16) NOT NULL
);

CREATE TABLE Composicao (
    fk_Video_fk_Postagem_link INTEGER NOT NULL, 
    fk_Efeito_codigo INTEGER NOT NULL
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
    FOREIGN KEY (fk_Lugar_codigo)
    REFERENCES Lugar (codigo)
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
    FOREIGN KEY (fk_Efeito_codigo)
    REFERENCES Efeito (codigo)
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
    FOREIGN KEY (fk_Lugar_codigo)
    REFERENCES Lugar (codigo)
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
    
INSERT INTO public."usuario"("codigo", "nome", "descricao")
VALUES 
(327023, 'Vítor Caruso Rodrigues Ferrer', 'Gaúcho e programador. Me sigam nas redes sociais! @progaucho'),
(323691, 'Léo Vasconcelos', 'Olá, sou o Léo!'),
(258134, 'Hunter Prosper', 'We are more alike than we are different')

INSERT INTO public."seguir"("fk_usuario_codigo", "fk_usuario_codigo_")
VALUES
(327023, 323691),
(323691, 327023),
(327023, 258134)

INSERT INTO public."audio"("codigo", "nome", "duracao")
VALUES 
(932143, 'som original - vitorcaruso746', '00:00:15'),
(431183, 'where is my mind', '00:00:37'),
(552921, 'Beep', '00:00:04')

INSERT INTO public."postagem"("compart", "link", "curtidas", "fk_usuario_codigo", "fk_audio_codigo", "tipo")
VALUES 
(65, 712876, 26045982, 327023, 932143, TRUE),
(278606, 594074, 1989880, 327023, 552921, FALSE),
(73817, 468946, 1252390, 323691, 552921, FALSE),
(5700, 700785, 52412424, 323691, 431183, FALSE),
(222500, 705314, 11600000, 258134, 431183, TRUE),
(73913, 639237, 9202590, 258134, 431183, TRUE)

INSERT INTO public."ver"("fk_usuario_codigo", "fk_postagem_link", "data")
VALUES
(327023, 705314, '2022-08-02 22:04:21'),
(327023, 468946, '2022-08-02 22:07:21'),
(323691, 712876, '2022-07-28 00:53:48')

INSERT INTO public."padrao_de_fotos"("nome", "qntusos")
VALUES 
('Rainbow', 74609),
('Glitters', 44217),
('No Vapor', 50201)

INSERT INTO public."carrossel"("qntfotos", "fk_postagem_link", "fk_padrao_de_fotos_nome")
VALUES 
(6, 468946, 'Rainbow'),
(2, 700785, 'No Vapor'),
(8, 594074, 'Glitters')

INSERT INTO public."pergunta"("codigo", "texto", "fk_usuario_codigo")
VALUES 
(531555, 'Qual sua comida favorita?', 327023),
(002322, 'Qual profissão você queria ser quando criança?', 323691),
(100123, 'What was the name of your first love, and why did you fall in love with them?', 258134)

INSERT INTO public."lugar"("pais", "estado", "cidade")
VALUES 
('Porto Alegre do Norte', 'Mato Grosso', 'Brasil'),
('Porto Alegre', 'Rio Grande do Sul', 'Brasil'),
('Orlando', 'Flórida', 'Estados Unidos')

INSERT INTO public."favorito"("fk_lugar_codigo", "fk_usuario_codigo")
VALUES
(1, 327023),
(2, 323691),
(3, 258134)

INSERT INTO public."video"("duracao", "fk_postagem_link", "fk_pergunta_codigo")
VALUES 
('00:00:15', 712876, 002322),
('00:01:00', 705314, NULL),
('00:00:37', 639237, NULL)

INSERT INTO public."efeito"("nome", "criador")
VALUES 
('real freckles', 'sahaanddiana'),
('Desenhando o Rosto', 'TikTok'),
('Blue Eyes', 'mayttearaneda')

INSERT INTO public."composicao"("fk_video_fk_postagem_link", "fk_efeito_codigo")
VALUES
(712876, 1),
(705314, 3),
(639237, 3)

INSERT INTO public."hashtag"("nome")
VALUES 
('fyp'),
('refreshing'),
('cute')

INSERT INTO public."salvar"("fk_usuario_codigo", "fk_hashtag_nome")
VALUES
(327023, 'cute'),
(323691, 'fyp'),
(323691, 'cute')

INSERT INTO public."inclusao"("fk_postagem_link", "fk_hashtag_nome")
VALUES
(712876, 'fyp'),
(468946, 'fyp'),
(639237, 'refreshing')

INSERT INTO public."idioma"("nome")
VALUES 
('Português'),
('Espanhol'),
('Inglês')

INSERT INTO public."compreensao"("fk_idioma_nome", "fk_usuario_codigo")
VALUES
('Português', 327023),
('Português', 323691),
('Inglês', 323691)

INSERT INTO public."musica" ("codigo", "duracao", "artista", "nome")
VALUES 
(310532, '00:03:01', 'Rex Orange County', 'THE SHADE'),
(513556, '00:03:21','Victor e Leo', 'Borboletas'),
(222542, '00:03:36','Billie Eilish', 'The 30th')

INSERT INTO public."escutar"("fk_musica_codigo", "fk_usuario_codigo")
VALUES
(310532, 327023),
(222542, 327023),
(513556, 323691)