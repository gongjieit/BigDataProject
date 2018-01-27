create table if not exists record (
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
 hour INT
 )
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY ',';

-------------------------------
--explain way to query data

-- query then amount of each transaction
explain select price from record;

-- the number of transactions taking place onf April 1, 2017
explain select count(*) from record where trancation_date = '2017-04-01';

-- the consumption of different ages
explain select cast(DATEDIFF(CURRENT_DATE,birth)/365 as int) as age,
sum(price) as totalPrice
from record
join user_dimension on record.uid= user_dimension.uid
group by cast(DATEDIFF(CURRENT_DATE,birth)/365 as int)
order by totalPrice desc;

-- different brands are consumed
explain select brand,sum(price)as totalPrice
from record join brand_dimension on record.bid=brand_dimension.bid
group by brand_dimension.brand
order by totalPrice desc;

-- consumption in different province
explain select province,sum(price) as totalPrice
from record join user_dimension on record.uid=user_dimension.uid
group by province
order by totalPrice desc;

-- query about the categories of the goods consumed at different ages
-- (Total prices of different categories of goods at different ages)
explain select cast(DATEDIFF(CURRENT_DATE,birth)/365 as int) as age,
category,sum(price) as totalPrice
from record join user_dimension on record.uid= user_dimension.uid
join brand_dimension on record.bid=brand_dimension.bid
group by cast(DATEDIFF(CURRENT_DATE,birth)/365 as int),category
order by age,category,totalPrice;
