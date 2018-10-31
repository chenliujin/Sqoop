# JDBC

* characterEncoding=utf-8
* tinyInt1isBit=false: tinyint(1): jdbc会把 tinyint(1) 认为是java.sql.Types.BIT,然后sqoop就会转为Boolean

# eval

--query



--split-by

# Hive

## 1. 建表

```
sqoop create-hive-table \
  --connect jdbc:mysql://localhost/test?tinyInt1isBit=false \
  --username root --password 123456 \
  --table deal \
  --hive-database olap_stock \
  --hive-table deal \
  --hive-partition-key deal_date \
  --map-column-hive status=TINYINT 
```

--create-hive-table: 创建目标表，如果有会报错, 不建议大家使用--create-hive-table,建议事先创建好hive表
--hive-import
--hive-overwrite
--hive-partition-key
--hive-partition-value
--delete-target-dir

```
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
```

## HBase

--hbase-table
--hbase-create-table
--hbase-row-key
--column-family

# 增量更新
