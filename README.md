# 建表

## 数据类型
* tinyint(1): jdbc会把 tinyint(1) 认为是java.sql.Types.BIT,然后sqoop就会转为Boolean

```
jdbc:mysql://localhost/test?tinyInt1isBit=false
```

--map-column-hive status="TINYINT"

--query
--split-by

## Hive
--create-hive-table
--hive-table
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
