
●リスト4-8 数字テーブル
CREATE TABLE Digits
 (digit INTEGER PRIMARY KEY); 

INSERT INTO Digits VALUES (0);
INSERT INTO Digits VALUES (1);
INSERT INTO Digits VALUES (2);
INSERT INTO Digits VALUES (3);
INSERT INTO Digits VALUES (4);
INSERT INTO Digits VALUES (5);
INSERT INTO Digits VALUES (6);
INSERT INTO Digits VALUES (7);
INSERT INTO Digits VALUES (8);
INSERT INTO Digits VALUES (9);


●リスト4-9 クロス結合で自然数テーブルを作る
CREATE TABLE Numbers (num) AS
SELECT D1.digit + (D2.digit * 10) AS num
  FROM Digits D1 CROSS JOIN Digits D2
 WHERE D1.digit + (D2.digit * 10) BETWEEN 1 AND 99;

●リスト4-10 MySQLにおけるCTAS構文
CREATE TABLE Numbers (num INTEGER) AS
SELECT D1.digit + (D2.digit * 10) AS num
  FROM Digits D1 CROSS JOIN Digits D2
 WHERE D1.digit + (D2.digit * 10) BETWEEN 1 AND 99;

●リスト4-11 SQL Serverの場合
SELECT D1.digit + (D2.digit * 10) AS num
INTO Numbers 
  FROM Digits D1 CROSS JOIN Digits D2
 WHERE D1.digit + (D2.digit * 10) BETWEEN 1 AND 99;

●リスト4-12 完全数を求める
SELECT Dividend.num AS perfect
  FROM Numbers Dividend INNER JOIN Numbers Divisor
    ON Divisor.num <= Dividend.num / 2
   AND MOD(Dividend.num, Divisor.num) = 0
 GROUP BY Dividend.num
HAVING Dividend.num  = SUM(Divisor.num)
ORDER BY perfect;

●リスト4-13 完全数を求める(SQL Serverの場合)
SELECT Dividend.num AS perfect
  FROM Numbers Dividend INNER JOIN Numbers Divisor
    ON Divisor.num <= Dividend.num / 2
   AND Dividend.num % Divisor.num = 0
 GROUP BY Dividend.num
HAVING Dividend.num  = SUM(Divisor.num)
ORDER BY perfect;



