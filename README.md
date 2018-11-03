# JDBC

* characterEncoding=utf-8
* tinyInt1isBit=false: tinyint(1): jdbc会把 tinyint(1) 认为是java.sql.Types.BIT,然后sqoop就会转为Boolean

# 参数
* -m: 

设置导入数据的 map 任务数量，即指定了 -m 即表示导入方式为并发导入，这时我们必须同时指定 - -split-by 参数指定根据哪一列来实现哈希分片，从而将不同分片的数据分发到不同 map 任务上去跑，避免数据倾斜。

    一般RDBMS的导出速度控制在60~80MB/s，每个 map 任务的处理速度5~10MB/s 估算，即 -m 参数一般设置4~8，表示启动 4~8 个map 任务并发抽取。

# MySQL 

* --query: query 和 table 参数是互斥的
* --where
* --columns
* --fields-terminated-by
* --lines-terminated-by 
* --split-by

# Hive
* --hive-drop-import-delims

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
--hive-partition-key
--hive-partition-value
--delete-target-dir

## 2. 全量导入

* --hive-import
* --hive-overwrite: hive 覆盖用此参数，而不是 `--delete-target-dir`

```
sqoop import \
  --connect jdbc:mysql://ambari-mysql.chenliujin.com/stock?tinyInt1isBit=false \
  --username root \
  --password chenliujin \
  --table deal \
  -m 1 \
  --hive-import \
  --hive-overwrite \
  --hive-database raw_stock \
  --hive-table deal
```

## 3. 增量导入
* --incremental: [ append | lastmodified ], 用来指定增量导入的模式
* --check-column: 用来指定一些列，这些列在增量导入时用来检查这些数据是否作为增量数据进行导入，和关系行数据库中的自增字段及时间戳类似, 这些被指定的列的类型不能使用任意字符类型，如char、varchar等类型都是不可以的，同时 --check-column 可以去指定多个列, 不能是 CHAR/VARCHAR/...
* --last-value: 指定上一次导入中检查列指定字段的最大值

### 3.1 append

### 3.2 lastmodified
* 数据重复如何解决？

## 4. 按天导入

---

# HBase

--hbase-table
--hbase-create-table
--hbase-row-key
--column-family

# 增量更新
