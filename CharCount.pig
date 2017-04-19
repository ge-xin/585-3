tokens = FOREACH (LOAD '/root/585_3/{para{1,2,3,4,5,6}.txt}' AS (line:chararray)) GENERATE FLATTEN(TOKENIZE(LOWER((REPLACE(line,'([^a-zA-Z\\s]+)',''))))) as word;
letters = FOREACH tokens GENERATE FLATTEN(TOKENIZE(REPLACE(word,'','|'), '|')) AS letter;
res = FOREACH (group letters by letter) GENERATE group, COUNT(letters);
STORE res INTO 'output1' USING PigStorage (':');
