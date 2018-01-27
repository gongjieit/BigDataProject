create database practice6;
use practice6;

-- hive practice6
hdfs dfs -ls /hive

hdfs dfs -put ~/data/stocks /hive
-------------------------------------
--create external table
CREATE EXTERNAL TABLE IF NOT EXISTS stocks_external (
  ymd         DATE ,
  price_open  FLOAT ,
  price_high  FLOAT ,
  price_low   FLOAT ,
  price_close FLOAT ,
  volume      FLOAT ,
  price_adj_close FLOAT
)
PARTITIONED BY (exchanger STRING, symbol STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/hive/stocks';


select * from stocks_external;
--0 rows
---------------------------
--load data
alter table stocks_external add partition(exchanger="NASDAQ",symbol="AAPL")
location '/hive/stocks/NASDAQ/AAPL/';

show partitions stocks_external;

select * from stocks_external limit 10;


alter table stocks_external add partition(exchanger="NASDAQ",symbol="INTC")
location '/hive/stocks/NASDAQ/INTC/';

alter table stocks_external add partition(exchanger="NYSE",symbol="IBM")
location '/hive/stocks/NYSE/IBM/';

alter table stocks_external add partition(exchanger="NYSE",symbol="GE")
location '/hive/stocks/NYSE/GE/';

show partitions stocks_external;
-----------------------
--query data

select * from  stocks_external where exchanger='NASDAQ'
and symbol = 'AAPL' limit 10;

select ymd,price_close from  stocks_external where exchanger='NASDAQ'
and symbol = 'AAPL' limit 10;

select exchanger, symbol,count(*) from stocks_external group by exchanger,symbol;

select exchanger, symbol,max(price_high) from stocks_external group by exchanger,symbol;

------------------------------
-- drop table
drop table stocks;

--list see HDFA file dirs
hdfs dfs -ls /hive

--drop external TABLE
drop table stocks_external;

hdfs dfs -ls /hive/stocks
--the HDFS firs still there






