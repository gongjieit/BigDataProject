create database practice2;

show databases;

use practice2;

CREATE TABLE IF NOT EXISTS employees (
	name	STRING,
	salary	FLOAT,
	subordinates ARRAY<STRING>,
	decutions	MAP<STRING, FLOAT>,
	address	STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
COLLECTION ITEMS TERMINATED BY '\002'
MAP KEYS TERMINATED BY '\003'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

-- LOAD DATA LOCAL INPATH '/home/bigdata/hadooop/training/hive/data/employees.txt' OVERWRITE INTO TABLE employees;
load data local inpath '/home/gj/apps/apache-hive-2.1.1-bin/hivedata/employees.txt' overwrite into table employees;


-- lateral view explode
select name,subordinate from employees lateral view
explode(subordinates)
subordinats_table as subordinate;