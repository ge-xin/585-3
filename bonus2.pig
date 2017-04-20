kids = LOAD '/root/585_3/kids.txt' USING PigStorage(' ') AS (kid:chararray, age:int);
selected_kids = FOREACH (FILTER kids BY (age==10 OR age==11 OR age==12)) GENERATE kid, age;
purchases = LOAD '/root/585_3/purchases.txt' USING PigStorage(' ') AS (name:chararray, product:chararray);
selected_kids_purchases = JOIN selected_kids BY kid, purchases BY name;
summary = FOREACH (GROUP selected_kids_purchases BY product) GENERATE group, COUNT(selected_kids_purchases) AS amt;
res = LIMIT (ORDER summary BY amt DESC) 1;
top = FOREACH (JOIN res BY amt, summary BY amt) GENERATE summary::group, summary::amt;
STORE top INTO 'output3' USING PigStorage(':');
