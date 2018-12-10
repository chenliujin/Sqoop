#!/usr/bin/python36

import time
import pymysql
import os

starttime = time.strftime('%Y-%m-%d', time.localtime(time.time())) + ' 00:00:00'

sql = 'SELECT distinct deal_date FROM stock.deal where last_modified >= "' + starttime + '"'

db = pymysql.connect(host='172.20.10.6', port=3307, user='root', password='chenliujin', db='stock')

cursor = db.cursor()

cursor.execute(sql)

results = cursor.fetchall()

for row in results:
  date = row[0].strftime('%Y-%m-%d')
  print(date)
  os.system('/opt/sqoop/bin/day_deal.sh ' + date)
