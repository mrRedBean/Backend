●リスト6-10 経路列挙モデルによる木構造の表現
CREATE TABLE OrgChartPath
 (emp  VARCHAR(32) PRIMARY KEY
    CHECK (REPLACE(emp, '/', '') = emp),
  path VARCHAR(256) NOT NULL,
    UNIQUE (path)); 

●リスト6-11 パスを主キーで表す場合
INSERT INTO OrgChartPath VALUES ('高橋',  '/高橋/');
INSERT INTO OrgChartPath VALUES ('鈴木',  '/高橋/鈴木/');
INSERT INTO OrgChartPath VALUES ('藤井',  '/高橋/藤井/');
INSERT INTO OrgChartPath VALUES ('吉村',  '/高橋/藤井/吉村/');
INSERT INTO OrgChartPath VALUES ('木曽',  '/高橋/藤井/吉村/木曽/' );
INSERT INTO OrgChartPath VALUES ('香川',  '/高橋/藤井/香川/' );
INSERT INTO OrgChartPath VALUES ('高田',  '/高橋/藤井/高田/' );


●パスを番号で表す場合
INSERT INTO OrgChart VALUES ('高橋',  '.1.');
INSERT INTO OrgChart VALUES ('鈴木',  '.1.1.');
INSERT INTO OrgChart VALUES ('藤井',  '.1.2.');
INSERT INTO OrgChart VALUES ('吉村',  '.1.2.1.');
INSERT INTO OrgChart VALUES ('木曽',  '.1.2.1.1.' );
INSERT INTO OrgChart VALUES ('香川',  '.1.2.2.' );
INSERT INTO OrgChart VALUES ('高田',  '.1.2.3.' );

●リスト6-12 ノードの深さを計算する
SELECT emp, LENGTH(path) - LENGTH(REPLACE(path, '/', '')) -1 AS depth
  FROM OrgChartPath;

●リスト6-13 ノードの深さを計算する（SQL Server）
SELECT emp, LEN(path) - LEN(REPLACE(path, '/', '')) -1 AS depth
  FROM OrgChartPath;


●リスト6-14 上司を列挙する（列持ちバージョン：PostgreSQL）
SELECT O1.emp,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O2.path)) AS level_0,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O3.path)) AS level_1,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O4.path)) AS level_2
  FROM OrgChartPath O1
       LEFT OUTER JOIN OrgChartPath O2
         ON O1.path LIKE O2.path || '_%'
            LEFT OUTER JOIN OrgChartPath O3
              ON O2.path LIKE O3.path || '_%'
                 LEFT OUTER JOIN OrgChartPath O4
                   ON O3.path LIKE O4.path || '_%'
GROUP BY O1.emp;

●リスト6-15 上司を列挙する（列持ちバージョン：MySQLとSQL Server）
SELECT O1.emp,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O2.path)) AS level_0,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O3.path)) AS level_1,
       (SELECT emp
          FROM OrgChartPath
         WHERE path = MAX(O4.path)) AS level_2
  FROM OrgChartPath O1
       LEFT OUTER JOIN OrgChartPath O2
         ON O1.path LIKE CONCAT(O2.path, '_%')
            LEFT OUTER JOIN OrgChartPath O3
              ON O2.path LIKE CONCAT(O3.path, '_%')
                 LEFT OUTER JOIN OrgChartPath O4
                   ON O3.path LIKE CONCAT(O4.path, '_%')
GROUP BY O1.emp;


●リスト6-16 経路列挙モデルでリーフノードを求める
SELECT *
  FROM OrgChartPath Parents
 WHERE NOT EXISTS
       (SELECT *
          FROM OrgChartPath Children
         WHERE Children.path LIKE Parents.path || '_%');

●リスト6-17 経路列挙モデルでルートを求める
SELECT *
  FROM OrgChartPath
 WHERE emp = REPLACE(path, '/', '');

