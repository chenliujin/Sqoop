#!/bin/bash

CREATE TABLE `deal`(
  `deal_id` bigint,
  `customer_id` bigint,
  `stock_code` string,
  `deal_type` string,
  `price` double,
  `volume` int,
  `total` double,
  `stamp_tax` double,
  `poundage` double,
  `transfer_fee` double,
  `sundry_fees` double,
  `amount` double,
  `status` tinyint,
  `date_added` string,
  `last_modified` string
)
PARTITIONED BY(deal_date string);


sqoop create-hive-table \
  --connect jdbc:mysql://ambari-mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root --password chenliujin \
  --table deal \
  --hive-database olap_stock \
  --hive-table deal \
  --map-column-hive status=TINYINT 

```
CREATE TABLE `deal`(
  `deal_id` bigint,
  `customer_id` bigint,
  `deal_date` string,
  `stock_code` string,
  `deal_type` string,
  `price` double,
  `volume` int,
  `total` double,
  `stamp_tax` double,
  `poundage` double,
  `transfer_fee` double,
  `sundry_fees` double,
  `amount` double,
  `status` tinyint,
  `date_added` string,
  `last_modified` string)
COMMENT 'Imported by sqoop on 2018/10/30 14:26:58'
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\u0001'
  LINES TERMINATED BY '\n'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'hdfs://h1.chenliujin.com:8020/apps/hive/warehouse/olap_stock.db/deal'
TBLPROPERTIES (
  'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',
  'numFiles'='0',
  'numRows'='0',
  'rawDataSize'='0',
  'totalSize'='0',
  'transient_lastDdlTime'='1540909656')
```
