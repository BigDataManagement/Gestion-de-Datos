import pandas as pd
import mysql.connector
from mysql.connector import errorcode

try:
    cnx = mysql.connector.connect(user='root', password='psgMVN94',
                                  host='localhost',
                                  database='sakila')

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
else:
    cursor = cnx.cursor()
    query = ("SELECT * FROM country")
    cursor.execute(query)
    sql = pd.DataFrame(cursor.fetchall(), columns = ['country_id', 'country', 'last_update'])
    
url = "https://restcountries.eu/rest/v2/all"

json = pd.read_json(url, orient='columns')

#Por default es un left join
df = json.join(sql.set_index('country'), on='name', how = 'outer')

df.to_csv("newFile.csv", index=False, sep='\t')
table = ""
for i in range(len(df.columns)):
    if df.columns[i] == "area" or df.columns[i] == "population" or df.columns[i] == "gini" or df.columns[i] == "country_id":
        table+=(df.columns[i] + " int,\n")
    else:
        if i == len(df.columns)-1:
            table+=(df.columns[i] + " VARCHAR(255)\n")
        else:
            table+=(df.columns[i] + " VARCHAR(255),\n")
query = ("CREATE TABLE country2 ("+table+");")
cursor.execute(query)

cursor.close()
cnx.close()



'''Comandos para configuración
brew services start mysql --> solo MAC
mysql -u myuser -p --local-infile sakila
SHOW VARIABLES LIKE 'local_infile'; y si es falso SET GLOBAL local_infile = 1;
'''
'''Las siguientes lineas deben ejecutarse desde la terminal de mysql
         "LOAD DATA LOCAL INFILE 'newFile.csv' " + 
         "INTO TABLE country2 " +
         "COLUMNS TERMINATED BY '\t' "+
         "LINES TERMINATED BY '\n'")'''