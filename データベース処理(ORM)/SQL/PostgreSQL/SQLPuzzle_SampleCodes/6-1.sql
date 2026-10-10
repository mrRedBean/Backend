●リスト6-1 隣接リストモデルのテーブル
CREATE TABLE OrgChartAdj
 (emp  VARCHAR(32) PRIMARY KEY,
  boss VARCHAR(32),
  role VARCHAR(32) NOT NULL,
    CONSTRAINT fk_OrgChartAdj FOREIGN KEY (boss) REFERENCES OrgChartAdj(emp) ); 

INSERT INTO OrgChartAdj VALUES ('高橋', NULL,  '社長');
INSERT INTO OrgChartAdj VALUES ('鈴木', '高橋', '部長');
INSERT INTO OrgChartAdj VALUES ('藤井', '高橋', '部長');
INSERT INTO OrgChartAdj VALUES ('吉村', '藤井', '課長');
INSERT INTO OrgChartAdj VALUES ('香川', '藤井', '課長');
INSERT INTO OrgChartAdj VALUES ('高田', '藤井', '課長');
INSERT INTO OrgChartAdj VALUES ('木曽', '吉村', 'ヒラ');


●リスト6-2 再帰共通表式による木の深さの探索(OracleとSQL ServerではRECURSIVEを削除すること)
WITH RECURSIVE Traversal (emp, boss, depth) AS
(SELECT O1.emp, O1.boss, 1 AS depth /* 開始点となるクエリ */
   FROM OrgChartAdj O1
  WHERE boss IS NULL
 UNION ALL
 SELECT O2.emp, O2.boss, (T.depth + 1) AS depth /* 再帰的に繰り返されるクエリ */
   FROM OrgChartAdj O2, Traversal T
  WHERE T.emp = O2.boss)
SELECT emp, boss, depth
  FROM Traversal;


●最初に実行されるクエリ
SELECT O1.emp, O1.boss, 1 AS depth /* 開始点となるクエリ */
   FROM OrgChartAdj O1
  WHERE boss IS NULL;


●後段のクエリ
 SELECT O2.emp, O2.boss, (T.depth + 1) AS depth /* 再帰的に繰り返されるクエリ */
   FROM OrgChartAdj O2, Traversal T
  WHERE T.emp = O2.boss


●リスト6-3 香川氏の上司を全員求める(OracleとSQL ServerではRECURSIVEを削除すること)
WITH RECURSIVE Traversal (emp, boss, depth) AS
(SELECT O1.emp, O1.boss, 1 AS depth /* 開始点となるクエリ */
   FROM OrgChartAdj O1
  WHERE emp = '香川'
 UNION ALL
 SELECT O2.emp, O2.boss, (T.depth + 1) AS depth  /* 再帰的に繰り返されるクエリ */
   FROM OrgChartAdj O2, Traversal T
  WHERE T.boss = O2.emp)
SELECT emp, boss, depth
  FROM Traversal;

●リスト6-4 隣接リストモデルでリーフノードを求める
SELECT emp
  FROM OrgChartAdj O1
 WHERE NOT EXISTS 
       (SELECT * 
          FROM OrgChartAdj O2
         WHERE O1.emp = O2.boss);

