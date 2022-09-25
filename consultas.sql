---------------------------------------------------------------
------------------- PROCEDIMENTO ARMAZENADO -------------------
---------------------------------------------------------------

create or replace function AtualizaPostagem() returns trigger as
$$
	begin
		if new.curtiu and not new.compartilhou then
			update Postagem
				set curtidas = curtidas + 1
			where Postagem.linkPostagem = new.linkPostagem;
		elsif not new.curtiu and new.compartilhou then
			update Postagem
				set compartilhamentos = compartilhamentos + 1
			where Postagem.linkPostagem = new.linkPostagem;
		elsif new.curtiu and new.compartilhou then
			update Postagem
				set curtidas = curtidas + 1,
				 compartilhamentos = compartilhamentos + 1
			where Postagem.linkPostagem = new.linkPostagem;
		end if;
		return null;
	end;
	 $$
	 language plpgsql;

---------------------------------------------------------------
--------------------------- GATILHO ---------------------------
---------------------------------------------------------------

CREATE TRIGGER gatilhoAtualizaPostagem
AFTER INSERT OR UPDATE ON Ver
FOR EACH ROW EXECUTE PROCEDURE AtualizaPostagem();

--------------------------------------------------------------
--------------------------- VISÕES ---------------------------
--------------------------------------------------------------

CREATE VIEW TotalCurtidasPorUsuario
AS select codigoUsuario, sum (curtidas) totalCurtidas
   from Usuario natural join Postagem
   group by codigoUsuario
   order by nome
   
CREATE VIEW TotalSeguidoresPorUsuario
AS select nome, count (usuarioSeguidor) TotalSeguidores
   from Usuario join Seguir on (Usuario.codigoUsuario = Seguir.usuarioSeguido)
   group by codigoUsuario
   order by nome
   
-----------------------------------------------------------------
--------------------------- CONSULTAS ---------------------------
-----------------------------------------------------------------

/* Nomes dos usuários que publicaram todas as postagens reproduzindo áudios de outros usuários */

select distinct nome
from Postagem PEXT join Usuario using(codigoUsuario)
where not exists (select codigoAudio
                  from Postagem
                  where codigoAudio in (select distinct codigoAudio
                                        from Audio
                                        where codigoUsuario = PEXT.codigoUsuario))

-----------------------------------------------------------------
/* Postagens que o usuário usou o próprio áudio */

select Usuario.nome, linkPostagem, Audio.nome
from Usuario join Postagem using (codigoUsuario)
             join Audio using (codigoAudio)
where Usuario.codigoUsuario = Audio.codigoUsuario

-----------------------------------------------------------------
/* Nome da música mais escutada por usuários que compreendem determinado idioma */

select nomeIdioma, nome
from (select nomeIdioma, Musica.nome, count(*) as totalReproducoesPorIdioma
	  from Compreensao natural join Usuario 
					   natural join Escutar
	 				   join Musica using (codigoMusica)
	  group by nomeIdioma, Musica.nome, codigoMusica) as musicasReproduzidasPorIdioma
where totalReproducoesPorIdioma >= all (select count(*)
					 					from Compreensao natural join Usuario 
								        				 natural join Escutar
					 					where nomeIdioma = musicasReproduzidasPorIdioma.nomeIdioma
										group by codigoMusica)

-----------------------------------------------------------------
/* Efeitos utilizados por usuário por ordem de curtidas totais */

select TotalCurtidasPorUsuario.codigoUsuario, TotalCurtidas, Efeito.nome
from TotalCurtidasPorUsuario join Postagem using (codigoUsuario) 
                             join Composicao using (linkPostagem)
                             join Efeito using (codigoEfeito)
group by TotalCurtidas, TotalCurtidasPorUsuario.codigoUsuario, Efeito.nome
order by TotalCurtidas desc

-----------------------------------------------------------------
/* Usuários que salvaram alguma hashtag inclusa no video mais curtido */

select distinct nome
from Usuario natural join Salvar 
			 natural join Inclusao 
			 join Postagem using (linkPostagem) 
where curtidas in (select max(curtidas)
						  from Postagem 
						  where tipo = TRUE)

-----------------------------------------------------------------
/* Hashtags usadas em videos no Brasil por ordem de uso */

select nomeHashtag, count(linkPostagem)
from Hashtag join Inclusao using (nomeHashtag)
             join Video using (linkPostagem)
             join Lugar using (codigoLugar)
where pais = 'Brasil'
group by nomeHashtag
order by count(linkPostagem)

-----------------------------------------------------------------
/* Perguntas respondidas em postagens por usuarios que possuem acima de 100000 de curtidas totais */

select texto, TotalCurtidasPorUsuario.codigoUsuario
from Pergunta join Video using (codigoPergunta)
              join Postagem using (linkPostagem)
              join TotalCurtidasPorUsuario on (TotalCurtidasPorUsuario.codigoUsuario = Postagem.codigoUsuario)
group by texto, TotalCurtidasPorUsuario.codigoUsuario, totalCurtidas
having totalCurtidas > 1000000

-----------------------------------------------------------------
/* Vídeos curtidos por Vitor e sua localização */

select linkPostagem, pais, estado, cidade
from Usuario join Ver using (codigoUsuario)
             join Video using (linkPostagem)
             join Lugar using (codigoLugar)
where curtiu = true and nome = 'Vítor Caruso'	

-----------------------------------------------------------------
/* Padrões de fotos utilizados em carrosséis que possuem mais de 10 compartilhamentos e mais de 5 fotos 
   e nome dos criadores da publicação */

select nome, linkPostagem, nomePadrao
from Usuario natural join Postagem
		 	 natural join Carrossel
			 natural join PadraoDeFoto
where compartilhamentos > 10 and quantidadeFotos > 5
order by nome
			  
-----------------------------------------------------------------
/* Para cada país em que um vídeo foi gravado, o link do seu vídeo com o maior número de curtidas */
select pais, curtidas, linkPostagem
from Postagem join Video using (linkPostagem)
              join Lugar using (codigoLugar)
where curtidas in (select max(curtidas)
                   from Postagem join Video using (linkPostagem)
                                 join Lugar using (codigoLugar)
                   group by pais)
group by pais, curtidas, linkPostagem
order by curtidas desc