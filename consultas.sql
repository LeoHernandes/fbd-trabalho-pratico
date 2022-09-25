--------------------------------------------------------------
--------------------------- VISÕES ---------------------------
--------------------------------------------------------------

CREATE VIEW TotalCurtidasPorUsuario
AS select nome, sum (curtidas) totalCurtidas
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



-----------------------------------------------------------------
/* Efeitos utilizados por usuário por ordem de curtidas totais */



-----------------------------------------------------------------
/* Usuários que salvaram a hashtag inclusa no carrossel mais visto */



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
/* Padrões de fotos utilizados em carrosséis que possuem mais de 50000 compartilhamentos */



-----------------------------------------------------------------
/* Para cada país em que um vídeo foi gravado, o link do seu vídeo com o maior número de curtidas */

