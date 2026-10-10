●リスト3-44 経路テーブル
CREATE TABLE Routes
(source_city	  VARCHAR(32),
 destination_city VARCHAR(32) ,	
 distance         INTEGER NOT NULL,
   CONSTRAINT pk_Cities PRIMARY KEY (source_city, destination_city));

INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Chicago', 'Boston', 985);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Boston', 'Chicago', 985);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Boston', 'New York', 215);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('New York', 'Boston',	215);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('New York', 'Philadelphia',	95);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Philadelphia', 'New York',	95);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Philadelphia', 'Washington',	140);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Washington',	'Philadelphia',	140);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Washington',	'Atlanta',	640);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Atlanta',	'Washington',	640);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Atlanta',	'Miami',	660);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Miami',	'Atlanta',	660);

●リスト3-45 再帰共通表式による解（PostgreSQL）
WITH RECURSIVE ShortestPaths AS (
    -- ベースケース: New Yorkから直接行ける都市
    SELECT  'New York' AS source_city, destination_city, distance,
            ARRAY['New York', destination_city] AS path
    FROM Routes
   WHERE source_city = 'New York'    
   UNION ALL
    -- 再帰部分: 既に探索した経路から新しい経路を見つける
    SELECT SP.source_city, R.destination_city, SP.distance + R.distance,
           SP.path || R.destination_city
      FROM ShortestPaths SP INNER JOIN Routes R
        ON SP.destination_city = R.source_city
    WHERE R.destination_city <> ALL(SP.path) -- 循環経路を防ぐ
),
-- 各目的地への最短経路を選択
BestPaths AS (
    SELECT source_city, destination_city, MIN(distance) AS min_distance
      FROM ShortestPaths
     GROUP BY source_city, destination_city)
-- 結果を取得（New York以外の全ての都市への最短距離）
SELECT destination_city, min_distance
  FROM BestPaths
 WHERE destination_city <> 'New York' 
ORDER BY min_distance;


●リスト3-46 閉路を作るデータ
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('New York',	'Chicago',	800);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Chicago',	'New York',	800);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Philadelphia',	'Miami',	550);
INSERT INTO Routes (source_city, destination_city, distance) VALUES ('Miami',	'Philadelphia',	550);

