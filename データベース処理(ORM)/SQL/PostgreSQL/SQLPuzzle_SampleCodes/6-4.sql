
●リスト6-18 閉包テーブルモデルによる木構造の表現
CREATE TABLE OrgChart
 (emp  VARCHAR(32) PRIMARY KEY,
  role VARCHAR(32) NOT NULL,
  tree_id INTEGER  UNIQUE NOT NULL); 

CREATE TABLE Closure
(parent INTEGER NOT NULL,
 child  INTEGER NOT NULL,
   CONSTRAINT pk_Closure PRIMARY KEY (parent, child),
   CONSTRAINT fk_parent FOREIGN KEY  (parent) REFERENCES OrgChart (tree_id),
   CONSTRAINT fk_child  FOREIGN KEY  (child)  REFERENCES OrgChart (tree_id));


INSERT INTO OrgChart VALUES ('高橋',  '社長', 1);
INSERT INTO OrgChart VALUES ('鈴木',  '部長', 2);
INSERT INTO OrgChart VALUES ('藤井',  '部長', 3);
INSERT INTO OrgChart VALUES ('吉村',  '課長', 4);
INSERT INTO OrgChart VALUES ('香川',  '課長', 5);
INSERT INTO OrgChart VALUES ('高田',  '課長', 6);
INSERT INTO OrgChart VALUES ('木曽',  'ヒラ', 7);

INSERT INTO Closure VALUES (1, 1);
INSERT INTO Closure VALUES (1, 2);
INSERT INTO Closure VALUES (1, 3);
INSERT INTO Closure VALUES (1, 4);
INSERT INTO Closure VALUES (1, 5);
INSERT INTO Closure VALUES (1, 6);
INSERT INTO Closure VALUES (1, 7);
INSERT INTO Closure VALUES (2, 2);
INSERT INTO Closure VALUES (3, 3);
INSERT INTO Closure VALUES (3, 4);
INSERT INTO Closure VALUES (3, 5);
INSERT INTO Closure VALUES (3, 6);
INSERT INTO Closure VALUES (3, 7);
INSERT INTO Closure VALUES (4, 4);
INSERT INTO Closure VALUES (4, 7);
INSERT INTO Closure VALUES (5, 5);
INSERT INTO Closure VALUES (6, 6);
INSERT INTO Closure VALUES (7, 7);

●リスト6-19 ノードの深さを計算する
SELECT O.emp, COUNT(*) AS depth
  FROM OrgChart O INNER JOIN Closure C
    ON O.tree_id = C.child
 GROUP BY O.emp
 ORDER BY depth;

●リスト6-2 上司を列挙する
SELECT emp 
  FROM OrgChart O INNER JOIN
       (SELECT C.parent
          FROM OrgChart O INNER JOIN Closure C
            ON O.tree_id = C.child
         WHERE O.emp = '香川') TMP
    ON O.tree_id = TMP.parent;

●リスト6-21 閉包テーブルモデルでリーフノードを求める
SELECT emp
  FROM OrgChart O INNER JOIN 
        (SELECT parent, COUNT(*)
           FROM Closure
          GROUP BY parent
         HAVING COUNT(*) = 1) C
    ON O.tree_id = C.parent;


●リスト6-22 閉包テーブルモデルでルートを求める
SELECT DISTINCT O.emp
  FROM (SELECT parent, 
               COUNT(*) AS cnt
          FROM Closure
         GROUP BY parent) C
       INNER JOIN 
       (SELECT parent,
               MAX(cnt) OVER () AS max_cnt
          FROM (SELECT parent, 
                       COUNT(*) AS cnt
                  FROM Closure
                 GROUP BY parent)) MC
           ON C.cnt = MC.max_cnt
         INNER JOIN OrgChart O
            ON O.tree_id = C.parent;


●最大のレコード数を持つparentを探す
SELECT parent, 
       COUNT(*) AS cnt
  FROM Closure
 GROUP BY parent;
