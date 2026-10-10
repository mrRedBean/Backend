●リスト3-1 住所履歴テーブル
CREATE TABLE PostalHistory
(name CHAR(1),
 pcode CHAR(7),
 new_pcode CHAR(7),
   CONSTRAINT pk_name_pcode PRIMARY KEY(name, pcode));

CREATE INDEX idx_new_pcode ON PostalHistory(new_pcode);

INSERT INTO PostalHistory VALUES ('A', '4130001', '4130002');
INSERT INTO PostalHistory VALUES ('A', '4130002', '4130103');
INSERT INTO PostalHistory VALUES ('A', '4130103', NULL );
INSERT INTO PostalHistory VALUES ('B', '4130041', NULL );
INSERT INTO PostalHistory VALUES ('C', '4103213', '4380824');
INSERT INTO PostalHistory VALUES ('C', '4380824', NULL );


●リスト3-2 再帰共通表式による解
WITH RECURSIVE Explosion (name, pcode, new_pcode, depth)
AS
(SELECT name, pcode, new_pcode, 1
　 FROM PostalHistory
  WHERE name = 'A'
AND new_pcode IS NULL -- 探索の開始点
UNION ALL
SELECT Child.name, Child.pcode, Child.new_pcode, depth + 1
  FROM Explosion Parent INNER JOIN PostalHistory Child
    ON Parent.pcode = Child.new_pcode
AND Parent.name = Child.name)
-- メインのSELECT文
SELECT name, pcode, new_pcode
  FROM Explosion
WHERE depth = (SELECT MAX(depth)
                 FROM Explosion);


●リスト3-3 開始点を求めるクエリ
SELECT name, pcode, new_pcode, 1 AS depth
  FROM PostalHistory
 WHERE name = 'A'
AND new_pcode IS NULL;

●リスト3-4 CONNECT BY句による解（Oracle限定）
SELECT name, pcode, new_pcode, LEVEL
  FROM PostalHistory
 WHERE name = 'A'
 START WITH new_pcode IS NULL
CONNECT BY PRIOR new_pcode = pcode;
