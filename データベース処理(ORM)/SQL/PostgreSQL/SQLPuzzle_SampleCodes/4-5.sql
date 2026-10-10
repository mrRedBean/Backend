
●リスト4-32 歯抜けのあるテーブル
CREATE TABLE Gaps
(num INTEGER NOT NULL,
   CONSTRAINT pk_Gaps PRIMARY KEY (num));

-- 歯抜けあり (NG)
INSERT INTO Gaps VALUES (1);
INSERT INTO Gaps VALUES (2);
INSERT INTO Gaps VALUES (3);
INSERT INTO Gaps VALUES (5);
INSERT INTO Gaps VALUES (6);

-- 歯抜けなし (OK)
INSERT INTO Gaps VALUES (1);
INSERT INTO Gaps VALUES (2);
INSERT INTO Gaps VALUES (3);
INSERT INTO Gaps VALUES (4);
INSERT INTO Gaps VALUES (5);

-- 開始値が1ではない (NG)
INSERT INTO Gaps VALUES (2);
INSERT INTO Gaps VALUES (3);
INSERT INTO Gaps VALUES (4);
INSERT INTO Gaps VALUES (5);


●リスト4-33 歯抜けチェックのクエリ
SELECT '歯抜けあり' AS result
  FROM Gaps
HAVING COUNT(*) <> MAX(num); 


●リスト4-34 歯抜けチェックのクエリ
SELECT num,
       CASE WHEN num + 1 <> LEAD(num, 1) OVER(ORDER BY num)
            THEN '歯抜けあり' 
            ELSE '歯抜けなし' END result
  FROM Gaps; 

-- 複数の箇所で歯抜けあり (NG)
INSERT INTO Gaps VALUES (1);
INSERT INTO Gaps VALUES (2);
INSERT INTO Gaps VALUES (3);
INSERT INTO Gaps VALUES (5);
INSERT INTO Gaps VALUES (6);
INSERT INTO Gaps VALUES (9);

●リスト4-35 クロス結合で自然数テーブルを作る
CREATE TABLE Numbers (num) AS 
SELECT D1.digit + (D2.digit * 10) AS num
  FROM Digits D1 CROSS JOIN Digits D2;

●リスト4-36 自然数テーブルとの差集合を取る
SELECT num
  FROM Numbers
 WHERE num BETWEEN 1 AND (SELECT MAX(num) FROM Gaps)
EXCEPT
SELECT num
  FROM Gaps; 

●クロス結合で自然数テーブルを作る(MySQL)
CREATE TABLE Numbers (num INTEGER) AS 
SELECT D1.digit + (D2.digit * 10) AS num
  FROM Digits D1 CROSS JOIN Digits D2;

●クロス結合で自然数テーブルを作る(SQL Server)
SELECT D1.digit + (D2.digit * 10) AS num
  INTO Numbers 
  FROM Digits D1 CROSS JOIN Digits D2;
