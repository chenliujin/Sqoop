#!/bin/bash

# 使用 hive 用户 执行

# --direct 需要 mysqldump，在所有节点安装 mysql-community-client 
# yum install -y mysql-community-client

su hive;

sqoop import \
  --connect jdbc:mysql://mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root \
  --password chenliujin \
  --table deal \
  -m 1 \
  --direct \
  --hive-import \
  --hive-overwrite \
  --delete-target-dir \
  --hive-database ods_stock \
  --hive-table deal

# * select 字段需要按表定义的顺序，分区字段在最后

#hive > SET hive.exec.dynamic.partition=true;  
#hive > SET hive.exec.dynamic.partition.mode=nonstrict; 
#hive > SET hive.exec.max.dynamic.partitions.pernode=1000;
#hive > insert overwrite table dw_stock.deal partition(deal_date) select deal_id, customer_id, stock_code, deal_type, price, volume, total, stamp_tax, poundage, transfer_fee, sundry_fees, amount, status, date_added, last_modified, deal_date from ods_stock.deal;
