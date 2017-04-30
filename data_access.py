!/usr/bin/env python3

import mysql.connector

dbname = "lg001"
dbhost = "hope"
dbuser = "lg001"
dbpass = "i-tf7on%8"
port = 3306

db = mysql.connector.connect(host=dbhost, port=port,
                             user=dbuser, db=dbname, passwd=dbpass)

def get_all_coding_seqs():

        sql = "select coding_seq from coding_sequence"
        cursor = db.cursor()
        nrows = cursor.execute(sql)
        all_coding_seqs = ''
        data = cursor.fetchone()
        while data is not None:
                coding_seq = data[0]
                all_coding_seqs += coding_seq
                data = cursor.fetchone()
        return all_coding_seqs
