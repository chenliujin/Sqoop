#!/bin/bash

sqoop import \
  --connect jdbc:mysql://ambari-mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root \
  --password chenliujin \
  --table deal \
  -m 1 \
  --hive-import \
  --hive-database raw_stock \
  --hive-table deal \
  --delete-target-dir

#hive > SET hive.exec.dynamic.partition=true;  
#hive > SET hive.exec.dynamic.partition.mode=nonstrict; 
#hive > SET hive.exec.max.dynamic.partitions.pernode=1000;
#hive > insert overwrite table olap_stock.deal partition(deal_date) select * from raw_stock.deal;
