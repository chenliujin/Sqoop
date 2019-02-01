#!/bin/bash

sqoop import \
  --connect jdbc:mysql://mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root \
  --password chenliujin \
  --table deal \
  -m 1 \
  --direct \
  --hive-import \
  --hive-overwrite \
  --hive-database ods_stock \
  --hive-table deal

# * select 字段需要按表定义的顺序，分区字段在最后

#hive > SET hive.exec.dynamic.partition=true;  
#hive > SET hive.exec.dynamic.partition.mode=nonstrict; 
#hive > SET hive.exec.max.dynamic.partitions.pernode=1000;
#hive > insert overwrite table dw_stock.deal partition(deal_date) select deal_id, customer_id, stock_code, deal_type, price, volume, total, stamp_tax, poundage, transfer_fee, sundry_fees, amount, status, date_added, last_modified, deal_date from raw_stock.deal;
