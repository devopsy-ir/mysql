#!/bin/bash

date=$(date '+%Y%m%d')
#Name that adds to the original table name to become new table name
temp_name="${date}"

#Name that adds to the original table name to become a middle temp name
temp_name_mid="${date}_temp"

table_name=$(echo "$1" | awk -F '","' '{print $1}')
column_name=$(echo "$1" | awk -F '","' '{print $2}')
column_type=$(echo "$1" | awk -F '","' '{print $3}')

#echo table=$table_name

echo "create table if not exists  ${table_name}_${temp_name} like ${table_name};"
echo "insert into ${table_name}_${temp_name} select * from ${table_name} group by ${column_name};"
echo "drop table if exists ${table_name}_${temp_name_mid};"
echo "alter table ${table_name} rename to ${table_name}_${temp_name_mid};"
echo "alter table ${table_name}_${temp_name} rename to ${table_name};"
echo -e "alter table ${table_name} DROP INDEX IF EXISTS \`PRIMARY\`, add primary key (${column_name});"
echo "alter table ${table_name} modify column ${column_name} ${column_type} auto_increment;"
