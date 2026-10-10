●リスト3-38 二つのよく似たテーブル(SQL Serverではidという名前の列が使えないので別の列名を使用すること)
CREATE TABLE Class_A
(id   CHAR(1), 
 name VARCHAR(16), 
   CONSTRAINT pk_Class_A PRIMARY KEY(id));

CREATE TABLE Class_B
(id   CHAR(1), 
 name VARCHAR(16), 
   CONSTRAINT pk_Class_B PRIMARY KEY(id));

INSERT INTO Class_A (id, name) VALUES('1', '田中');
INSERT INTO Class_A (id, name) VALUES('2', '鈴木');
INSERT INTO Class_A (id, name) VALUES('3', '伊集院');

INSERT INTO Class_B (id, name) VALUES('1', '田中');
INSERT INTO Class_B (id, name) VALUES('2', '鈴木');
INSERT INTO Class_B (id, name) VALUES('4', '西園寺');

●リスト3-39 完全外部結合
SELECT COALESCE(A.id, B.id) AS id,
       COALESCE(A.name, B.name) AS name
  FROM Class_A A FULL OUTER JOIN Class_B B
    ON A.id = B.id;


●リスト3-40 完全外部結合（COALESCEなし）
SELECT A.id AS A_id, B.id AS B_id,
       A.name AS A_name, B.name AS B_name
  FROM Class_A A FULL OUTER JOIN Class_B B
    ON A.id = B.id;


●リスト3-41 完全外部結合をUNIONで模倣する
SELECT A.id AS id, COALESCE(A.name, B.name) AS name
  FROM Class_A A LEFT OUTER JOIN Class_B B
    ON A.id = B.id
UNION
SELECT B.id AS id, COALESCE(A.name, B.name) AS name
  FROM Class_A A RIGHT OUTER JOIN Class_B B
    ON A.id = B.id;


●リスト3-42 完全外部結合で排他的和集合を求める
SELECT COALESCE(A.id, B.id) AS id,
       COALESCE(A.name , B.name ) AS name
  FROM Class_A A FULL OUTER JOIN Class_B B
    ON A.id = B.id
 WHERE A.name IS NULL
    OR B.name IS NULL;


●リスト3-43 集合演算で排他的和集合を作る
(SELECT id, name
  FROM Class_A
EXCEPT SELECT id, name
  FROM Class_B)
UNION
(SELECT id, name
  FROM Class_B
EXCEPT SELECT id, name
  FROM Class_A);
