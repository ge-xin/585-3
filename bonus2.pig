kids = LOAD '/root/585_3/kids.txt' USING PigStorage(' ') AS (kid:chararray, age:int);
purchases = LOAD '/root/585_3/purchases.txt' USING PigStorage(' ') AS (name:chararray, product:chararray);
kids_purchases = JOIN kids BY kid, purchases BY name;
filtered = FILTER kids_purchases BY (age==10 OR age ==11 OR age == 12);
summary = FOREACH (GROUP filtered BY product) GENERATE group, COUNT(filtered) AS amt;
res = LIMIT (ORDER summary BY amt DESC) 1;
DUMP res; 
