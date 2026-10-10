●リスト4-37 歯抜けの連番テーブル
CREATE TABLE Line
(num INTEGER NOT NULL);

INSERT INTO Line VALUES (1);
INSERT INTO Line VALUES (2);
INSERT INTO Line VALUES (5);
INSERT INTO Line VALUES (6);
INSERT INTO Line VALUES (7);
INSERT INTO Line VALUES (8);
INSERT INTO Line VALUES (11);
INSERT INTO Line VALUES (12);
INSERT INTO Line VALUES (13);
INSERT INTO Line VALUES (15);
INSERT INTO Line VALUES (16);
INSERT INTO Line VALUES (17);


●リスト4-38 シーケンスを求める
SELECT MIN(TMP.data_val) AS start_num,
       MIN(TMP.data_val) + COUNT(*) - 1 AS end_num,
       COUNT(*) AS length
  FROM (SELECT num AS data_val,
               ROW_NUMBER() OVER(ORDER BY num) AS data_seq,
               num - ROW_NUMBER() OVER(ORDER BY num) AS absent_data_grp
          FROM Line) TMP
  GROUP BY TMP.absent_data_grp;


●リスト4-39 自己結合による解
SELECT L1.num AS start_num, MIN(L2.num) AS end_num, 
       MIN(L2.num) - L1.num + 1 AS length
  FROM Line L1, Line L2
 WHERE L1.num <= L2.num
   AND NOT EXISTS
         (SELECT *
            FROM Line L3
           WHERE L3.num NOT BETWEEN L1.num AND L2.num
             AND (L3.num = L1.num - 1
              OR  L3.num = L2.num + 1))
 GROUP BY L1.num;


●リスト4-40 長さ3のシーケンスを全て求める
SELECT num, '～', num + (3 -1)
  FROM (SELECT num,
               MAX(num) OVER (ORDER BY num
                               ROWS BETWEEN (3-1) FOLLOWING
                                        AND (3-1) FOLLOWING) AS end_num
          FROM Line) TMP
  WHERE end_num - num = (3 - 1);
