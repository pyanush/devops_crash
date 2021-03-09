import sqlite3
conn = sqlite3.connect('movies.db')
cursor = conn.cursor()

# 1. Create DB and 1st table 'Movies' in it
cursor.execute('''CREATE TABLE IF NOT EXISTS Movies
    (Title TEXT, Director TEXT, Year INT)''')  
conn.commit()

# 2. Insert some values in 'Movies' table (CRUD => C)
cursor.execute("INSERT INTO Movies VALUES ('Anthony Zimmer', 'Jérôme Salle', 2005)")
## 'execute' command is used when only 1 record needs to be inserted


# 3. Read newly added row
cursor.execute("SELECT * FROM Movies") 
# Above line doesn't actually print the result on the screen,
# but below one does :)
print(cursor.fetchone())

# 4. Declaring a tuple with movies
famousFilms = [('Pulp Fiction', 'Quentin Tarantino', 1994),
('Back to the Future', 'Steven Spielberg', 1985),
('The Grand Budapest Hotel', 'Wes Anderson', 2042)]

## 'executemany' command is used when lots of records need to be inserted at once
cursor.executemany('Insert INTO Movies VALUES (?,?,?)', famousFilms)

# 5. Reading all the records from the table
records = cursor.execute("SELECT * FROM Movies") 

print(cursor.fetchall())
## vs
#for record in records:
#	print(record)

conn.commit()
conn.close()