lines = LOAD '/root/585_3/{para{1,2,3,4,5,6}.txt}' AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
wordcount = FOREACH (GROUP words BY word)  GENERATE group, COUNT(words);
DUMP wordcount;
