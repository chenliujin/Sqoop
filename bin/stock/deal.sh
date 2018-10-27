#!/bin/bash

sqoop import \
  --connect jdbc:mysql://ambari-mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root \
  --password chenliujin \
  --table deal \
  -m 1 \
  --hive-import \
  --create-hive-table \
  --hive-table olap_stock.deal \
  --delete-target-dir

