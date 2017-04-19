tokens = FOREACH (LOAD '/root/585_3/{para{1,2,3,4,5,6}.txt}' AS (line:chararray)) GENERATE FLATTEN(TOKENIZE(LOWER((chararray)$0))) as words;
letters = foreach tokens generate flatten(TOKENIZE(REPLACE(words,'','|'), '|')) as letter;
res = FOREACH (group letters by letter) GENERATE COUNT(letters), group;
DUMP res;
