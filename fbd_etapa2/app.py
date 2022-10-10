import psycopg2

try:
    connection = psycopg2.connect(
        host="localhost",
        database="ticoteco",
        user="postgres",
        password="admin"
    )


    class TicoTeco:
        def __init__(self):
            self.host = "localhost",
            self.database = "ticoteco",
            self.user = "postgres",
            self.password = "admin"


    cursor = connection.cursor()

    # Nomes dos usuários que publicaram todas as postagens reproduzindo áudios de outros usuários
    cursor.execute("""select distinct nome
                   from Postagem PEXT join Usuario using(codigoUsuario)
                   where not exists (select codigoAudio
                                     from Postagem
                                     where codigoAudio in (select distinct codigoAudio
                                            from Audio
                                            where codigoUsuario = PEXT.codigoUsuario))""")

    # Postagens que o usuário usou o próprio áudio
    cursor.execute("""select Usuario.nome, linkPostagem, Audio.nome
                   from Usuario join Postagem using (codigoUsuario)
                                join Audio using (codigoAudio)
                   where Usuario.codigoUsuario = Audio.codigoUsuario""")

    # Nome da música mais escutada por usuários que compreendem determinado idioma
    cursor.execute("""select nomeIdioma, nome
                   from (select nomeIdioma, Musica.nome, count(*) as totalReproducoesPorIdioma
                         from Compreensao natural join Usuario 
                                          natural join Escutar
                                          join Musica using (codigoMusica)
                         group by nomeIdioma, Musica.nome, codigoMusica) as musicasReproduzidasPorIdioma
                   where totalReproducoesPorIdioma >= all (select count(*)
                                                           from Compreensao natural join Usuario 
                                                           natural join Escutar
                                                           where nomeIdioma = musicasReproduzidasPorIdioma.nomeIdioma
                                                           group by codigoMusica)""")

    # Efeitos utilizados por usuário por ordem de curtidas totais
    cursor.execute("""select TotalCurtidasPorUsuario.codigoUsuario, TotalCurtidas, Efeito.nome
                   from TotalCurtidasPorUsuario join Postagem using (codigoUsuario) 
                                                join Composicao using (linkPostagem)
                                                join Efeito using (codigoEfeito)
                   group by TotalCurtidas, TotalCurtidasPorUsuario.codigoUsuario, Efeito.nome
                   order by TotalCurtidas desc""")

    # Usuários que salvaram alguma hashtag inclusa no video mais curtido
    cursor.execute("""select distinct nome
                   from Usuario natural join Salvar 
                                natural join Inclusao 
                                join Postagem using (linkPostagem) 
                   where curtidas in (select max(curtidas)
                                      from Postagem 
                                      where tipo = TRUE)""")

    # Hashtags usadas em videos no país dado por ordem de uso
    cursor.execute("""select nomeHashtag, count(linkPostagem)
                   from Hashtag join Inclusao using (nomeHashtag)
                                join Video using (linkPostagem)
                                join Lugar using (codigoLugar)
                   where pais = %s
                   group by nomeHashtag
                   order by count(linkPostagem)""", ('Brasil',))  # <--- PARAMETRO

    # Perguntas respondidas em postagens por usuarios que possuem acima de um dado número de curtidas totais
    cursor.execute("""select texto, TotalCurtidasPorUsuario.codigoUsuario
                   from Pergunta join Video using (codigoPergunta)
                                 join Postagem using (linkPostagem)
                                 join TotalCurtidasPorUsuario on 
                                      (TotalCurtidasPorUsuario.codigoUsuario = Postagem.codigoUsuario)
                   group by texto, TotalCurtidasPorUsuario.codigoUsuario, totalCurtidas
                   having totalCurtidas > %s""", (1000000,))

    # Vídeos curtidos por algum usuário e sua localização
    cursor.execute("""select linkPostagem, pais, estado, cidade
                   from Usuario join Ver using (codigoUsuario)
                                join Video using (linkPostagem)
                                join Lugar using (codigoLugar)
                   where curtiu = true and nome = %s""", ('Vítor Caruso',))  # <--- PARAMETRO

    # Padrões de fotos utilizados em carrosséis que possuem mais de 10 compartilhamentos e mais de 5 fotos
    # e nome dos criadores da publicação
    cursor.execute("""select nome, linkPostagem, nomePadrao
                   from Usuario natural join Postagem
                                natural join Carrossel
                                natural join PadraoDeFoto
                   where compartilhamentos > 10 and quantidadeFotos > 5
                   order by nome""")

    # Para cada país em que um vídeo foi gravado, o link do seu vídeo com o maior número de curtidas
    cursor.execute("""select pais, curtidas, linkPostagem
                   from Postagem join Video using (linkPostagem)
                                 join Lugar using (codigoLugar)
                   where curtidas in (select max(curtidas)
                                      from Postagem join Video using (linkPostagem)
                                                    join Lugar using (codigoLugar)
                                      group by pais)
                   group by pais, curtidas, linkPostagem
                   order by curtidas desc""")

    rows = cursor.fetchall()

    for r in rows:
        print(r)

except (Exception, psycopg2.DatabaseError) as error:
    print("Error while connecting to PostgreSQL", error)

finally:
    # closing database connection.
    if connection:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")

