●リスト2-33 変数テーブル
CREATE TABLE Variables
(key_col CHAR(1),
 x   INTEGER,
 y   INTEGER,
 z   INTEGER,
   CONSTRAINT pk_Variables PRIMARY KEY (key_col));


INSERT INTO Variables VALUES ('A', 1, 2, 3);
INSERT INTO Variables VALUES ('B', 30, 20, 10);
INSERT INTO Variables VALUES ('C', NULL, 15, 30);
INSERT INTO Variables VALUES ('D', 10, NULL, 45);
INSERT INTO Variables VALUES ('E', NULL, NULL, 50);
INSERT INTO Variables VALUES ('F', NULL, NULL, NULL);
INSERT INTO Variables VALUES ('G', NULL, 100, NULL);


●リスト2-34 GREATEST関数で最大値を求める
SELECT  key_col,
        GREATEST(x, y) AS result
  FROM Variables;

●リスト2-35 他のDBMSでPostgreSQLのGREATEST関数を模倣する
SELECT  key_col,
        GREATEST(COALESCE(x, y), COALESCE(y, x)) AS result
  FROM Variables;


●リスト2-36 PostgreSQL流のGREATEST関数（引数:3個）
SELECT  key_col,
        GREATEST(COALESCE(x, y, z), 
                 COALESCE(x, z, y), 
                 COALESCE(y, x, z), 
                 COALESCE(y, z, x), 
                 COALESCE(z, x, y), 
                 COALESCE(z, y, z)) AS result
  FROM Variables;

