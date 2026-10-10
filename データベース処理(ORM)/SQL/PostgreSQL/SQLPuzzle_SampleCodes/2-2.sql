
●リスト2-5 再帰共通表式による自然数列の生成(OracleとSQL ServerではRECURSIVEを削除すること)
WITH RECURSIVE NumberGenerate (num) AS
(SELECT 1 AS num /* 開始点となるクエリ */
 UNION ALL
 SELECT num + 1 AS num /* 再帰的に繰り返されるクエリ */
   FROM NumberGenerate
  WHERE num < 99)
SELECT num
  FROM NumberGenerate;


●リスト2-6 数字テーブル
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


●リスト2-7 クロス結合で自然数を作る
SELECT D1.digit + (D2.digit * 10) AS seq
  FROM Digits D1 CROSS JOIN Digits D2
 ORDER BY seq;


●リスト2-8 アルファベットのテーブル
CREATE TABLE Alphabet
 (letter CHAR(1) PRIMARY KEY); 

INSERT INTO Alphabet VALUES ('a');
INSERT INTO Alphabet VALUES ('b');
INSERT INTO Alphabet VALUES ('c');
INSERT INTO Alphabet VALUES ('d');
INSERT INTO Alphabet VALUES ('e');
INSERT INTO Alphabet VALUES ('f');
INSERT INTO Alphabet VALUES ('g');
INSERT INTO Alphabet VALUES ('h');


●リスト2-9 ウィンドウ関数による自然数列の生成
SELECT ROW_NUMBER() OVER (ORDER BY letter) AS row_num
  FROM Alphabet;
