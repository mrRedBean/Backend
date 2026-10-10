
●リスト4-1 要素テーブル
CREATE TABLE Items
(i INTEGER NOT NULL PRIMARY KEY);

INSERT INTO Items VALUES (1);
INSERT INTO Items VALUES (2);
INSERT INTO Items VALUES (3);
INSERT INTO Items VALUES (4);
INSERT INTO Items VALUES (5);


●リスト4-2 二つ選ぶ場合の順列
SELECT I1.i AS i1, I2.i AS i2
  FROM Items I1 INNER JOIN Items I2
    ON I1.i <> I2.i;

●リスト4-3 三つ選ぶ場合の順列
SELECT I1.i AS i1, I2.i AS i2, I3.i AS i3
  FROM Items I1 INNER JOIN Items I2
    ON I1.i <> I2.i
       INNER JOIN Items I3
          ON I2.i <> I3.i
         AND I1.i <> I3.i;

●リスト4-4 三つ選ぶ場合の順列  別解：一度使った要素はその後の選択で使わない
SELECT I1.i AS i1, I2.i AS i2, I3.i AS i3
  FROM Items I1, Items I2, Items I3
 WHERE I2.i NOT IN (I1.i)
   AND I3.i NOT IN (I1.i, I2.i);

●リスト4-5 四つ選ぶ場合の順列：一度使った要素はその後の選択で使わない
SELECT I1.i AS i1, I2.i AS i2, I3.i AS i3, I4.i AS i4
  FROM Items I1, Items I2, Items I3, Items I4
 WHERE I2.i NOT IN (I1.i)
   AND I3.i NOT IN (I1.i, I2.i)
   AND I4.i NOT IN (I1.i, I2.i, I3.i);

●リスト4-6 二つ選ぶ場合の組み合わせ
SELECT I1.i AS i1, I2.i AS i2
  FROM Items I1 INNER JOIN Items I2
    ON I1.i < I2.i;


●リスト4-7 三つ選ぶ場合の組み合わせ
SELECT I1.i AS i1, I2.i AS i2, I3.i AS i3
  FROM Items I1 INNER JOIN Items I2 
    ON I1.i < I2.i
         INNER JOIN Items I3
           ON I2.i < I3.i;


