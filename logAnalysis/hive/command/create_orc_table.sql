create database practice7;
use practice7;

create table if not exists record_orc (
 rid STRING,
 uid STRING,
 bid STRING,
 price INT,
 source_province STRING,
 target_province STRING,
 site STRING,
 express_number STRING,
 express_company STRING,
 trancation_date DATE
)
STORED AS ORC;

--load data
select * from record_orc limit 10;

insert into table record_orc select * from mydb.record;

select * from record_orc limit 10;

----------------------
create table if not exists record_orc (
 rid STRING,
 uid STRING,
 bid STRING,
 trancation_date TIMESTAMP,
 price INT,
 source_province STRING,
 target_province STRING,
 site STRING,
 express_number STRING,
 express_company STRING
)
 PARTITIONED BY (
 partition_date STRING,
 hour_minute STRING
 )
STORED AS ORC;
