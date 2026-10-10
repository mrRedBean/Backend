●リスト6-5 入れ子集合モデルによる木構造の表現
CREATE TABLE OrgChartNestedSets
 (emp VARCHAR(32) PRIMARY KEY,
  lft INTEGER NOT NULL,
  rgt INTEGER NOT NULL,
    CHECK (lft < rgt)); 

INSERT INTO OrgChartNestedSets VALUES ('高橋',  1, 14);
INSERT INTO OrgChartNestedSets VALUES ('鈴木',  2,  3);
INSERT INTO OrgChartNestedSets VALUES ('藤井',  4, 13);
INSERT INTO OrgChartNestedSets VALUES ('吉村',  5,  8);
INSERT INTO OrgChartNestedSets VALUES ('木曽',  6,  7);
INSERT INTO OrgChartNestedSets VALUES ('香川',  9,  10);
INSERT INTO OrgChartNestedSets VALUES ('高田', 11,  12);

●リスト6-6 入れ子集合モデルによる木の深さの探索
SELECT Children.emp , COUNT(Parents.emp) AS depth
  FROM OrgChartNestedSets Parents, OrgChartNestedSets Children
 WHERE Children.lft BETWEEN Parents.lft AND Parents.rgt
GROUP BY Children.emp;

●リスト6-7 香川氏の上司を全員求める
SELECT Parents.emp AS boss, COUNT(*) AS depth
  FROM OrgChartNestedSets Parents, OrgChartNestedSets Children
 WHERE Children.emp = '香川'
   AND Children.lft BETWEEN Parents.lft AND Parents.rgt
 GROUP BY Parents.emp;

●リスト6-8 入れ子集合モデルでリーフノードを求める
SELECT *
  FROM OrgChartNestedSets Boss
 WHERE NOT EXISTS
       (SELECT *
          FROM OrgChartNestedSets Workers
         WHERE Workers.lft > Boss.lft 
           AND Workers.lft < Boss.rgt);

●リスト6-9 ルートを求める(左端座標が 1 でなくても  OK)
SELECT *
  FROM OrgChartNestedSets Workers
 WHERE NOT EXISTS
       (SELECT *
          FROM OrgChartNestedSets Boss
         WHERE Workers.lft > Boss.lft 
           AND Workers.lft < Boss.rgt);
