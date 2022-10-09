import psycopg2

con = psycopg2.connect(
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


cur = con.cursor()
cur.execute("select nome from usuario")

rows = cur.fetchall()

for r in rows:
    print(r)

cur.close()
con.close()