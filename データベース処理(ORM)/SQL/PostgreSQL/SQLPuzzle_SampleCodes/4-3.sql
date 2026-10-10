
●リスト4-14 要素テーブル
CREATE TABLE Elements
(e INTEGER NOT NULL PRIMARY KEY);

INSERT INTO Elements VALUES (1);
INSERT INTO Elements VALUES (2);
INSERT INTO Elements VALUES (3);
INSERT INTO Elements VALUES (4);
INSERT INTO Elements VALUES (5);


●リスト4-15 一つの組み合わせ（該当なし）
SELECT E1.e
  FROM Elements E1
 WHERE E1.e = 7;


●リスト4-16 二つの組み合わせ
SELECT E1.e AS e1, E2.e AS e2
  FROM Elements E1, Elements E2
 WHERE E1.e < E2.e
   AND E1.e + E2.e = 7;


●リスト4-17 三つの組み合わせ
SELECT E1.e AS e1, E2.e AS e2, E3.e AS e3
  FROM Elements E1, Elements E2, Elements E3
 WHERE E1.e < E2.e
   AND E2.e < E3.e
   AND E1.e + E2.e + E3.e = 7;


●リスト4-18 四つの組み合わせ（該当なし）
SELECT E1.e AS e1, E2.e AS e2, E3.e AS e3, E4.e AS e4
  FROM Elements E1, Elements E2, Elements E3, Elements E4
 WHERE E1.e < E2.e
   AND E2.e < E3.e
   AND E3.e < E4.e
   AND E1.e + E2.e + E3.e + E4.e = 7;

●リスト4-19 五つの組み合わせ（該当なし）
SELECT E1.e AS e1, E2.e AS e2, E3.e AS e3, E4.e AS e4, E5.e AS e5
  FROM Elements E1, Elements E2, Elements E3, Elements E4, Elements E5
 WHERE E1.e < E2.e
   AND E2.e < E3.e
   AND E3.e < E4.e
   AND E4.e < E5.e
   AND E1.e + E2.e + E3.e + E4.e + E5.e = 7;


●リスト4-20 ビットフラグ・テーブル（0、1の2行のみ）
CREATE TABLE Bool(bit_flg INTEGER PRIMARY KEY);

INSERT INTO Bool VALUES (1);
INSERT INTO Bool VALUES (0);

●リスト4-21 5つの要素で作りうる組み合わせ
SELECT a.bit_flg AS a_bit, b.bit_flg AS b_bit, 
       c.bit_flg AS c_bit, d.bit_flg AS d_bit, e.bit_flg AS e_bit
  FROM Bool AS A, Bool AS B, Bool AS C, Bool AS D, Bool AS E;

●リスト4-22 フラグが1の列だけを足して7になる行をさがｪす
SELECT  E1.e AS e1, E2.e AS e2, E3.e AS e3, E4.e AS e4, E5.e AS e5
  FROM (SELECT a.bit_flg AS a_bit, b.bit_flg AS b_bit, 
               c.bit_flg AS c_bit, d.bit_flg AS d_bit, e.bit_flg AS e_bit
          FROM Bool AS A, Bool AS B, Bool AS C, Bool AS D, Bool AS E) AS FLG
        LEFT OUTER JOIN 
         (SELECT e FROM Elements  WHERE e = 1) AS E1
          ON a_bit = 1
        LEFT OUTER JOIN 
         (SELECT e FROM Elements  WHERE e = 2) AS E2
          ON b_bit = 1
        LEFT OUTER JOIN
         (SELECT e FROM Elements  WHERE e = 3) AS E3
          ON c_bit = 1
        LEFT OUTER JOIN
         (SELECT e FROM Elements  WHERE e = 4) AS E4
          ON d_bit = 1
        LEFT OUTER JOIN
         (SELECT e FROM Elements  WHERE e = 5) AS E5
          ON e_bit = 1
  WHERE COALESCE(e1.e, 0) + COALESCE(e2.e, 0) + COALESCE(e3.e, 0) + COALESCE(e4.e, 0) + COALESCE(e5.e, 0) = 7;


●リスト4-23 ビットフラグの利用：スカラサブクエリ版
SELECT a_bit * e1 AS e1, b_bit * e2 AS e2, c_bit * e3 AS e3, d_bit * e4 AS e4, e_bit * e5 AS e5
  FROM (SELECT  a_bit, b_bit, c_bit, d_bit, e_bit,
               (SELECT e FROM Elements WHERE e = 1) AS e1,
               (SELECT e FROM Elements WHERE e = 2) AS e2,
               (SELECT e FROM Elements WHERE e = 3) AS e3,
               (SELECT e FROM Elements WHERE e = 4) AS e4,
               (SELECT e FROM Elements WHERE e = 5) AS e5
           FROM (SELECT a.bit_flg AS a_bit, b.bit_flg AS b_bit, c.bit_flg AS c_bit, 
                        d.bit_flg AS d_bit, e.bit_flg AS e_bit
                   FROM Bool AS A, Bool AS B, Bool AS C, Bool AS D, Bool AS E) AS FLG) AS TMP
 WHERE a_bit * e1 + b_bit * e2 + c_bit * e3 + d_bit * e4 + e_bit * e5 = 7;


●リスト4-24 要素テーブル（列持ち）
CREATE TABLE ElementCols
(e1 INTEGER NOT NULL,
 e2 INTEGER NOT NULL,
 e3 INTEGER NOT NULL,
 e4 INTEGER NOT NULL,
 e5 INTEGER NOT NULL);

INSERT INTO ElementCols VALUES(1, 2, 3, 4, 5);

●リスト4-25 CUBEですべての組み合わせを網羅する
SELECT e1, e2, e3, e4, e5
  FROM ElementCols
 GROUP BY CUBE(e1, e2, e3, e4, e5)
HAVING COALESCE(e1, 0) + COALESCE(e2, 0) + COALESCE(e3, 0) + COALESCE(e4, 0) + COALESCE(e5, 0) = 7;
