
●リスト4-26 数字テーブル
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


●リスト4-27 クロス結合で自然数テーブルを作る
CREATE TABLE Numbers (num) AS
SELECT D1.digit + (D2.digit * 10) AS seq
  FROM Digits D1 CROSS JOIN Digits D2
 WHERE D1.digit + (D2.digit * 10) BETWEEN 1 AND 99;


●リスト4-28 NOT EXISTSで全称量化を表現
SELECT num AS prime
  FROM Numbers Dividend
 WHERE num > 1
   AND NOT EXISTS
        (SELECT *
           FROM Numbers Divisor
          WHERE Divisor.num <= SQRT(Dividend.num)
            AND Divisor.num <> 1 -- 1 は約数に含まない
            AND MOD(Dividend.num, Divisor.num) = 0) -- 割り切れる
 ORDER BY prime;


●リスト4-29 HAVING 句で素数を求める
SELECT Dividend.num AS prime
  FROM Numbers Dividend
         INNER JOIN Numbers Divisor
            ON Divisor.num <= SQRT(Dividend.num)
 WHERE Dividend.num > 1
GROUP BY Dividend.num
HAVING 1 = SUM(CASE WHEN MOD(Dividend.num, Divisor.num) = 0 THEN 1
                    ELSE 0 END)  -- 1以外で割り切れない
 ORDER BY prime;


●リスト4-30 ウィンドウ関数で素数を求める
SELECT DISTINCT prime
  FROM (SELECT Dividend.num AS prime,
               SUM(CASE WHEN MOD(Dividend.num, Divisor.num) = 0 THEN 1
                        ELSE 0 END) OVER (PARTITION BY Dividend.num) AS flg
          FROM Numbers Dividend
                 INNER JOIN Numbers Divisor
            ON Divisor.num <= SQRT(Dividend.num)
         WHERE Dividend.num > 1)
 WHERE flg = 1
 ORDER BY prime;

●リスト4-31 ウィンドウ関数で素数を求める（QUALIFY句の使用）
 SELECT DISTINCT Dividend.num AS prime
   FROM Numbers Dividend
         INNER JOIN Numbers Divisor
            ON Divisor.num <= SQRT(Dividend.num)
  WHERE Dividend.num > 1
QUALIFY SUM(CASE WHEN MOD(Dividend.num, Divisor.num) = 0 THEN 1
                 ELSE 0 END) OVER (PARTITION BY Dividend.num) = 1
  ORDER BY prime;
