#!/usr/bin/python3

import time
import datetime
import pymysql
import os


print('=== Sqoop import ===')

#starttime = time.strftime('%Y-%m-%d', time.localtime(time.time())) + ' 00:00:00'

yesterday = datetime.datetime.now() + datetime.timedelta(days=-1)
starttime = yesterday.strftime('%Y-%m-%d 00:00:00')

sql = 'SELECT distinct deal_date FROM stock.deal where last_modified >= "' + starttime + '"'

db = pymysql.connect(host='mysql.chenliujin.com', port=3306, user='root', password='chenliujin', db='stock')

cursor = db.cursor()

cursor.execute(sql)

results = cursor.fetchall()

dates = []

for row in results:
  date = row[0].strftime('%Y-%m-%d')
  dates.append(date)
  print('=== Sqoop import: ' + date + ' ===')
  os.system('/opt/sqoop/bin/stock_deal.sh ' + date)

#print('=== Kylin ===')

#os.system('/opt/sqoop/bin/build_cube.py --inputs ' + ' '.join(dates))
