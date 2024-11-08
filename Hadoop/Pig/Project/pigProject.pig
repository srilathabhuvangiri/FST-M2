-- Load input file from HDFS
inputFiles = LOAD 'hdfs:///user/srilatha/inputs' USING PigStorage('\t') AS (name:chararray,line:chararray);

-- Combine the name from the above script
grpd_lines = GROUP inputFiles BY name;

-- Count the number of line of each character
cntd_lines = FOREACH grpd_lines GENERATE $0 AS character, COUNT($1) as lineCount;

--Order the results in descending order
ordered_line = ORDER cntd_lines BY lineCount DESC;

-- Delete the output folder
rmf hdfs:///user/srilatha/pigProjectResult

-- Save result in HDFS folder
STORE ordered_line  INTO 'hdfs:///user/srilatha/pigProjectResult' USING PigStorage(',');