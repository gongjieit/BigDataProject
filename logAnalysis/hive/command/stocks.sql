
create database practice4;
use practice4;

CREATE TABLE if NOT EXISTS stocks(
  ymd DATE,
  price_open FLOAT,
  price_high FLOAT,
  price_low FLOAT,
  price_close FLOAT,
  volume INT,
  price_adj_close FLOAT
)
partitioned BY (exchanger String,symbol string)
row format delimited fields terminated by ',';

--load data
load data local inpath
'/home/gj/apps/apache-hive-2.1.1-bin/hivedata/stocks/NASDAQ/AAPL/stocks.csv'
overwrite into table stocks
partition(exchanger="NASDAQ",symbol="AAPL");

show partitions stocks;

load data local inpath
'/home/gj/apps/apache-hive-2.1.1-bin/hivedata/stocks/NASDAQ/INTC/stocks.csv'
overwrite into table stocks
partition(exchanger="NASDAQ",symbol="INTC");

load data local inpath
'/home/gj/apps/apache-hive-2.1.1-bin/hivedata/stocks/NYSE/GE/stocks.csv'
overwrite into table stocks
partition(exchanger="NYSE",symbol="GE");

load data local inpath
'/home/gj/apps/apache-hive-2.1.1-bin/hivedata/stocks/NYSE/IBM/stocks.csv'
overwrite into table stocks
partition(exchanger="NYSE",symbol="IBM");


show partitions stocks;

--query---------
SELECT * from stocks
where exchanger = 'NASDAQ'
AND symbol = 'AAPL'
limit 10;

SELECT ymd,price_close from stocks
where exchanger = 'NASDAQ'
AND symbol = 'AAPL'
limit 10;

SELECT exchanger,symbol,count(*) from stocks
group by exchanger,symbol;

SELECT exchanger,symbol,max(price_high) from stocks
group by exchanger,symbol;


--list and see HDFS file directories

hdfs dfs -ls /warehouse/
hdfs dfs -ls /warehouse/practice4.db/
hdfs dfs -ls /warehouse/practice4.db/stocks
hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NASDAQ
hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NASDAQ/symbol=AAPL
hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NASDAQ/symbol=INTC

hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NYSE
hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NYSE/symbol=IBM
hdfs dfs -ls /warehouse/practice4.db/stocks/exchanger=NYSE/symbol=GE