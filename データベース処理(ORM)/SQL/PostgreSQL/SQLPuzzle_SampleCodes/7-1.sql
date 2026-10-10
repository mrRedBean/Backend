●リスト7-1 配列テーブル
CREATE TABLE ArrayTbl
(c1  INTEGER NOT NULL,
 c2  INTEGER NOT NULL,
 c3  INTEGER NOT NULL,
 c4  INTEGER NOT NULL,
 c5  INTEGER NOT NULL,
 c6  INTEGER NOT NULL,
 c7  INTEGER NOT NULL,
 c8  INTEGER NOT NULL,
 c9  INTEGER NOT NULL,
 c10 INTEGER NOT NULL);

INSERT INTO ArrayTbl VALUES (2, 3, 0, 5, 0, 0, 0, 2, 0, 8);
INSERT INTO ArrayTbl VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO ArrayTbl VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ArrayTbl VALUES (4, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ArrayTbl VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 5);
INSERT INTO ArrayTbl VALUES (0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO ArrayTbl VALUES (1, 1, 1, 1, 1, 0, 0, 0, 0, 0);


●リスト7-2 どのDBMSでも動く簡単な解
SELECT *
  FROM ArrayTbl
 WHERE c1 = 1
   AND c2 = 1
   AND c3 = 1
   AND c4 = 1
   AND c5 = 1
   AND c6 = 1
   AND c7 = 1
   AND c8 = 1
   AND c9 = 1
   AND c10 = 1; 


●リスト7-3 すべての列が1（Oracle）
SELECT *
  FROM ArrayTbl
 WHERE 1 = ALL (c1, c2, c3, c4, c5, c6, c7, c8, c9, c10); 

●リスト7-4 多くの実装で動作する簡潔な書き方
SELECT *
  FROM ArrayTbl
 WHERE (c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
     = (1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

●リスト7-5 少なくとも一つの列に1が含まれる
SELECT *
  FROM ArrayTbl
 WHERE 1 IN (c1, c2, c3, c4, c5, c6, c7, c8, c9, c10); 


●リスト7-6 ちょうど五つの列に1が含まれる
SELECT *
  FROM ArrayTbl
 WHERE CASE WHEN c1 = 1  THEN 1 ELSE 0 END + 
       CASE WHEN c2 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c3 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c4 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c5 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c6 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c7 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c8 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c9 = 1  THEN 1 ELSE 0 END +
       CASE WHEN c10 = 1 THEN 1 ELSE 0 END = 5;


●リスト7-7 配列テーブル（行持ち）
CREATE TABLE ArrayTblRow
(col_id  INTEGER NOT NULL,
 seq  INTEGER NOT NULL,
 val  INTEGER NOT NULL,
   CONSTRAINT pk_ArrayTblRow PRIMARY KEY (col_id, seq));

INSERT INTO ArrayTblRow VALUES (1, 1, 0);
INSERT INTO ArrayTblRow VALUES (1, 2, 1);
INSERT INTO ArrayTblRow VALUES (1, 3, 5);
INSERT INTO ArrayTblRow VALUES (1, 4, 0);
INSERT INTO ArrayTblRow VALUES (1, 5, 2);
INSERT INTO ArrayTblRow VALUES (2, 1, 1);
INSERT INTO ArrayTblRow VALUES (2, 2, 1);
INSERT INTO ArrayTblRow VALUES (2, 3, 1);
INSERT INTO ArrayTblRow VALUES (2, 4, 1);
INSERT INTO ArrayTblRow VALUES (2, 5, 1);
INSERT INTO ArrayTblRow VALUES (3, 1, 1);
INSERT INTO ArrayTblRow VALUES (3, 2, 2);
INSERT INTO ArrayTblRow VALUES (3, 3, 1);
INSERT INTO ArrayTblRow VALUES (3, 4, 5);
INSERT INTO ArrayTblRow VALUES (3, 5, 9);


●リスト7-8 HAVING句で特性関数を使う
SELECT col_id
  FROM ArrayTblRow
 GROUP BY col_id
HAVING 2 = SUM(CASE WHEN val = 1 THEN 1
                    ELSE 0 END);


