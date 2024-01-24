CREATE TABLE test (a TINYINT, b TINYINT);

INSERT INTO test (a, b) VALUES (1, 2);
INSERT INTO test (a, b) VALUES (3, 4);

SELECT b FROM test WHERE a = 1;
SELECT b FROM test;
SELECT b FROM test WHERE a = 1 OR a = 3;