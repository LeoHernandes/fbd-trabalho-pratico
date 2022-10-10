import psycopg2


class TicoTeco:
    def __init__(self):
        self._connection = None

    def open_connection(self):
        if self._connection is None:
            try:
                self._connection = psycopg2.connect(
                    host="localhost",
                    database="ticoteco",
                    user="postgres",
                    password="admin"
                )
            except (Exception, psycopg2.DatabaseError) as error:
                print("Error while connecting to PostgreSQL", error)

    def close_connection(self):
        self._connection.close()

    def print_query(self, cursor):
        rows = cursor.fetchall()
        columns = [col[0].strip() for col in cursor.description]
        print("|", end=" ")
        for c in columns:
            print(c, end=" | ")
        print()
        for r in rows:
            print("|", end=" ")
            for item in r:
                print(str(item).strip(), end=' | ')
            print()

    def insert_ver(self, link, user_code, date, liked, shared):
        with self._connection.cursor() as cursor:
            cursor.execute("""INSERT INTO Ver(linkPostagem, codigoUsuario, dataHora, curtiu, compartilhou) 
                              VALUES (%s, %s, %s, %s, %s)""", (link, user_code, date, liked, shared))

    def print_likes_shares(self, link):
        with self._connection.cursor() as cursor:
            cursor.execute("""select curtidas, compartilhamentos
                              from Postagem
                              where linkPostagem = %s""", (link, ))
            self.print_query(cursor)

    def query1(self):
        # Nomes dos usuários que publicaram todas as postagens reproduzindo áudios de outros usuários
        with self._connection.cursor() as cursor:
            cursor.execute("""select distinct nome
                              from Postagem PEXT join Usuario using(codigoUsuario)
                              where not exists (select codigoAudio
                                                from Postagem
                                                where codigoAudio in (select distinct codigoAudio
                                                                      from Audio
                                                                      where codigoUsuario = PEXT.codigoUsuario))""")
            self.print_query(cursor)

    def query2(self):
        # Postagens que o usuário usou o próprio áudio
        with self._connection.cursor() as cursor:
            cursor.execute("""select Usuario.nome, linkPostagem, Audio.nome
                              from Usuario join Postagem using (codigoUsuario)
                                           join Audio using (codigoAudio)
                              where Usuario.codigoUsuario = Audio.codigoUsuario""")
            self.print_query(cursor)

    def query3(self):
        # Nome da música mais escutada por usuários que compreendem determinado idioma
        with self._connection.cursor() as cursor:
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
            self.print_query(cursor)

    def query4(self):
        # Efeitos utilizados por usuário por ordem de curtidas totais
        with self._connection.cursor() as cursor:
            cursor.execute("""select TotalCurtidasPorUsuario.codigoUsuario, TotalCurtidas, Efeito.nome
                              from TotalCurtidasPorUsuario join Postagem using (codigoUsuario) 
                                                           join Composicao using (linkPostagem)
                                                           join Efeito using (codigoEfeito)
                              group by TotalCurtidas, TotalCurtidasPorUsuario.codigoUsuario, Efeito.nome
                              order by TotalCurtidas desc""")
            self.print_query(cursor)

    def query5(self):
        # Usuários que salvaram alguma hashtag inclusa no video mais curtido
        with self._connection.cursor() as cursor:
            cursor.execute("""select distinct nome
                              from Usuario natural join Salvar 
                              natural join Inclusao 
                                      join Postagem using (linkPostagem) 
                              where curtidas in (select max(curtidas)
                                                 from Postagem 
                                                 where tipo = TRUE)""")
            self.print_query(cursor)

    def query6(self, country):
        # Hashtags usadas em videos no país dado por ordem de uso
        with self._connection.cursor() as cursor:
            cursor.execute("""select nomeHashtag, count(linkPostagem)
                              from Hashtag join Inclusao using (nomeHashtag)
                                           join Video using (linkPostagem)
                                           join Lugar using (codigoLugar)
                              where pais = %s
                              group by nomeHashtag
                              order by count(linkPostagem)""", (country,))
            self.print_query(cursor)

    def query7(self, total_likes):
        # Perguntas respondidas em postagens por usuarios que possuem acima de um dado número de curtidas totais
        with self._connection.cursor() as cursor:
            cursor.execute("""select texto, TotalCurtidasPorUsuario.codigoUsuario
                              from Pergunta join Video using (codigoPergunta)
                                            join Postagem using (linkPostagem)
                                            join TotalCurtidasPorUsuario on 
                                            (TotalCurtidasPorUsuario.codigoUsuario = Postagem.codigoUsuario)
                              group by texto, TotalCurtidasPorUsuario.codigoUsuario, totalCurtidas
                              having totalCurtidas > %s""", (total_likes,))
            self.print_query(cursor)

    def query8(self, user_name):
        # Vídeos curtidos por algum usuário e sua localização
        with self._connection.cursor() as cursor:
            cursor.execute("""select linkPostagem, pais, estado, cidade
                              from Usuario join Ver using (codigoUsuario)
                                           join Video using (linkPostagem)
                                           join Lugar using (codigoLugar)
                              where curtiu = true and nome = %s""", (user_name,))
            self.print_query(cursor)

    def query9(self):
        # Padrões de fotos utilizados em carrosséis que possuem mais de 10 compartilhamentos e mais de 5 fotos
        # e nome dos criadores da publicação
        with self._connection.cursor() as cursor:
            cursor.execute("""select nome, linkPostagem, nomePadrao
                              from Usuario natural join Postagem
                                          natural join Carrossel
                                          natural join PadraoDeFoto
                              where compartilhamentos > 10 and quantidadeFotos > 5
                              order by nome""")
            self.print_query(cursor)

    def query10(self):
        # Para cada país em que um vídeo foi gravado, o link do seu vídeo com o maior número de curtidas
        with self._connection.cursor() as cursor:
            cursor.execute("""select pais, curtidas, linkPostagem
                              from Postagem join Video using (linkPostagem)
                                            join Lugar using (codigoLugar)
                              where curtidas in (select max(curtidas)
                                                 from Postagem join Video using (linkPostagem)
                                                               join Lugar using (codigoLugar)
                                                 group by pais)
                              group by pais, curtidas, linkPostagem
                              order by curtidas desc""")
            self.print_query(cursor)


class DBController:
    def __init__(self):
        self.db = TicoTeco()

    def menu(self):
        self.db.open_connection()

        choice = int(input("[0] - Consultar\n[1] = Testar gatilho\nEscolha: "))
        if choice == 0:
            self.print_options()
            query_number = -1
            while query_number != 0:
                query_number = int(input("Número da consulta: "))
                self.query_selector(query_number)
        elif choice == 1:
            self.trigger_test()

        # self.db.close_connection()

    def print_options(self):
        print(
            """
==================================================CONSULTAS==================================================
[0] - Sair
[1] - Nomes dos usuários que publicaram todas as postagens reproduzindo áudios de outros usuários
[2] - Postagens que o usuário usou o próprio áudio
[3] - Nome da música mais escutada por usuários que compreendem determinado idioma
[4] - Efeitos utilizados por usuário por ordem de curtidas totais
[5] - Usuários que salvaram alguma hashtag inclusa no video mais curtido
[6] - Hashtags usadas em videos em um país escolhido por ordem de uso
[7] - Perguntas respondidas em postagens por usuarios que possuem acima de um número de curtidas totais escolhido 
[8] - Vídeos curtidos por um usuário escolhido e sua localização
[9] - Padrões de fotos utilizados em carrosséis que possuem mais de 10 compartilhamentos e mais de 5 fotos
e nome dos criadores da publicação
[10] - Para cada país em que um vídeo foi gravado, o link do seu vídeo com o maior número de curtidas
            """)

    def query_selector(self, query_number):
        match query_number:
            case 0:
                print("Encerrando...")
            case 1:
                self.db.query1()
            case 2:
                self.db.query2()
            case 3:
                self.db.query3()
            case 4:
                self.db.query4()
            case 5:
                self.db.query5()
            case 6:
                country = input("Nome do país: ")
                self.db.query6(country)
            case 7:
                total_likes = int(input("Quantidade de likes totais: "))
                self.db.query7(total_likes)
            case 8:
                user_name = input("Nome do usuário: ")
                self.db.query8(user_name)
            case 9:
                self.db.query9()
            case 10:
                self.db.query10()

    def trigger_test(self):
        link = input("Link da postagem: ")
        user_code = int(input("Código do usuário: "))
        date = input("Data e hora em que a postagem foi assistida: ")
        liked = input("Curtiu?[Y/N] ").upper()
        liked = True if liked == "Y" else False
        shared = input("Compartilhou?[Y/N] ").upper()
        shared = True if shared == "Y" else False
        self.db.print_likes_shares(link)
        self.db.insert_ver(link, user_code, date, liked, shared)
        self.db.print_likes_shares(link)


controller = DBController()
controller.menu()
