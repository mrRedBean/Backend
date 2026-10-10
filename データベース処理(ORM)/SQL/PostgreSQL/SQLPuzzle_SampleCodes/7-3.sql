●リスト7-16 人口テーブル
CREATE TABLE PopTbl
(pref_name VARCHAR(32) PRIMARY KEY,
 population INTEGER NOT NULL);

INSERT INTO PopTbl VALUES('徳島', 100);
INSERT INTO PopTbl VALUES('香川', 200);
INSERT INTO PopTbl VALUES('愛媛', 150);
INSERT INTO PopTbl VALUES('高知', 200);
INSERT INTO PopTbl VALUES('福岡', 300);
INSERT INTO PopTbl VALUES('佐賀', 100);
INSERT INTO PopTbl VALUES('長崎', 200);
INSERT INTO PopTbl VALUES('東京', 400);
INSERT INTO PopTbl VALUES('群馬', 50);


●リスト7-17 PostgreSQL、MySQL、Oracle
SELECT CASE pref_name
          WHEN '徳島' THEN '四国'
          WHEN '香川' THEN '四国'
          WHEN '愛媛' THEN '四国'
          WHEN '高知' THEN '四国'
          WHEN '福岡' THEN '九州'
          WHEN '佐賀' THEN '九州'
          WHEN '長崎' THEN '九州'
          ELSE 'その他' END AS district,
       SUM(population)
  FROM PopTbl
 GROUP BY district;


●リスト7-18 その他のDBMS
SELECT CASE pref_name
          WHEN '徳島' THEN '四国'
          WHEN '香川' THEN '四国'
          WHEN '愛媛' THEN '四国'
          WHEN '高知' THEN '四国'
          WHEN '福岡' THEN '九州'
          WHEN '佐賀' THEN '九州'
          WHEN '長崎' THEN '九州'
          ELSE 'その他' END AS district,
       SUM(population)
  FROM PopTbl
 GROUP BY CASE pref_name
             WHEN '徳島' THEN '四国'
             WHEN '香川' THEN '四国'
             WHEN '愛媛' THEN '四国'
             WHEN '高知' THEN '四国'
             WHEN '福岡' THEN '九州'
             WHEN '佐賀' THEN '九州'
             WHEN '長崎' THEN '九州'
             ELSE 'その他' END;


●リスト7-19 身長テーブル
CREATE TABLE Heights
(name    VARCHAR(16) PRIMARY KEY,
 height  INTEGER NOT NULL);

INSERT INTO Heights VALUES ('田中',   167);
INSERT INTO Heights VALUES ('藤原',   153);
INSERT INTO Heights VALUES ('葛西',   182);
INSERT INTO Heights VALUES ('米原',   159);
INSERT INTO Heights VALUES ('紀藤',   190);
INSERT INTO Heights VALUES ('佐々木', 172);
INSERT INTO Heights VALUES ('轟',     178);
INSERT INTO Heights VALUES ('向井',   185);


●リスト7-20 身長階級ごとの人数を求める
SELECT CASE WHEN height BETWEEN 150 AND 159 THEN '150cm台'
            WHEN height BETWEEN 160 AND 169 THEN '160cm台'
            WHEN height BETWEEN 170 AND 179 THEN '170cm台'
            ELSE 'それ以上' END height_class,
       COUNT(*)
  FROM Heights
 GROUP BY height_class;


●リスト7-21 ウィンドウ関数で年齢階級ごとの人数を求める
SELECT name, height,
       COUNT(*) OVER (PARTITION BY CASE WHEN height BETWEEN 150 AND 159 THEN '150cm台'
                                        WHEN height BETWEEN 160 AND 169 THEN '160cm台'
                                        WHEN height BETWEEN 170 AND 179 THEN '170cm台'
                                        ELSE 'それ以上' END) AS height_class        
  FROM Heights;
