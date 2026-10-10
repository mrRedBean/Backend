●リスト5-11 体重テーブル
CREATE TABLE Weights
(student_id	CHAR(4) PRIMARY KEY,
 weight     INTEGER);

●レコード数が奇数
INSERT INTO Weights VALUES('A100',	50);
INSERT INTO Weights VALUES('A101',	55);
INSERT INTO Weights VALUES('A124',	55);
INSERT INTO Weights VALUES('B343',	60);
INSERT INTO Weights VALUES('B346',	72);
INSERT INTO Weights VALUES('C563',	72);
INSERT INTO Weights VALUES('C345',	72);

●レコード数が偶数
INSERT INTO Weights VALUES('A100',	50);
INSERT INTO Weights VALUES('A101',	55);
INSERT INTO Weights VALUES('A124',	55);
INSERT INTO Weights VALUES('B343',	60);
INSERT INTO Weights VALUES('B346',	72);
INSERT INTO Weights VALUES('C563',	72);


●リスト5-12 中央値を求める（汎用的な解）
SELECT AVG(weight) AS median
  FROM (SELECT weight,
               ROW_NUMBER() OVER (ORDER BY weight ASC, student_id ASC) AS hi,
               ROW_NUMBER() OVER (ORDER BY weight DESC, student_id DESC) AS lo
          FROM Weights) TMP
 WHERE hi IN (lo, lo + 1 , lo - 1);

●リスト5-13 中央値を求める（PostgreSQLとBigQuery）
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median
  FROM Weights;


●リスト5-14 中央値を求める（OracleとSnowflakeとRedshift）
SELECT MEDIAN(weight) AS median
  FROM Weights;

●リスト5-15 中央値を求める（SQL Server）
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) OVER() AS median
  FROM Weights;

●リスト5-16 中央値を求める（改良版）
SELECT AVG(weight)
  FROM (SELECT weight,
               2 * ROW_NUMBER() OVER (ORDER BY weight)
                  - COUNT(*) OVER() AS diff
          FROM Weights) TMP
 WHERE diff BETWEEN 0 AND 2;
 