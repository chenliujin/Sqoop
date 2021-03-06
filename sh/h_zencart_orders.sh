sqoop import \
    --connect jdbc:mysql://vm1/zencart --username db_user --password 123456 \
    --table orders \
    --hbase-table h_zencart_orders \
    --column-family data \
	--hbase-row-key date_purchased,orders_id \
    --hbase-create-table \
    --where "date_purchased>='2014-01-01 00:00:00' AND date_purchased<'2015-01-01 00:00:00'" \
    -m 1




sqoop import \
    --connect jdbc:mysql://vm1/zencart --username dataread --password 123456 \
    --query "SELECT *, date_format(date_purchased, '%Y-%m-%d') AS purchased_at FROM orders WHERE date_purchased>='2015-05-07 00:00:00' AND date_purchased<='2015-05-07 23:59:59' AND \$CONDITIONS" \
    --hbase-table h_zencart_orders \
    --column-family data \
    --hbase-row-key "purchased_at,orders_id" \
    --hbase-create-table \
    -m 1
	
	
	
created_date=$1
target_dir='/data/rawlog/log/zencart/orders/www.tinydeal.com/'$created_date
	
/opt/sqoop/bin/sqoop import \
    --connect jdbc:mysql://vm1/zencart --username dataread --password 123456 \
    --table orders \
    --where "date_purchased>='"$created_date" 00:00:00' AND date_purchased<='"$created_date" 23:59:59'" \
    --target-dir "$target_dir" \
    --fields-terminated-by '\0001' \
    --hive-drop-import-delims \
    --hive-overwrite \
    --compress \
    -m 1
	

