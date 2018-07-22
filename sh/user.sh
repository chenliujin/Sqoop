#!/bin/bash

/opt/sqoop/bin/sqoop import \
  --connect "jdbc:mysql://127.0.0.1/test?tinyInt1isBit=false&zeroDateTimeBehavior=CONVERT_TO_NULL" --username root --password 123456 \
  --table user \
  --hive-import \
  --delete-target-dir \
  --bindir /root/ \
  -m 1
