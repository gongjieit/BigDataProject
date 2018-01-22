create database practice5;
use practice5;

create table if not exists record_partition (
 rid STRING,
 uid STRING,
 bid STRING,
 price INT,
 source_province STRING,
 target_province STRING,
 site STRING,
 express_number STRING,
 express_company STRING
)
 PARTITIONED BY (
 trancation_date date
 );

show create table record_partition;

--load data from table

select * from record_partition limit 10;

set hive.exec.dynamic.partition.mode=nonstrict;

insert into table record_partition partition(trancation_date) select * from mydb.record;

select * from record_partition limit 10;
