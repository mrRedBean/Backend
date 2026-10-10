●リスト5-26 要素テーブル
CREATE TABLE Elements
(lvl INTEGER NOT NULL,
 color VARCHAR(10),
 length INTEGER,
 width INTEGER,
 hgt INTEGER,
   CONSTRAINT pk_Elements PRIMARY KEY(lvl) );

INSERT INTO Elements (lvl, color, length, width, hgt) VALUES(1, 'RED',	8,	10,	12);
INSERT INTO Elements (lvl, color, length, width, hgt) VALUES(2, NULL,  NULL, NULL,	20);
INSERT INTO Elements (lvl, color, length, width, hgt) VALUES(3, NULL,	9,	82,	 25);
INSERT INTO Elements (lvl, color, length, width, hgt) VALUES(4, 'BLUE',		NULL, 67, NULL);
INSERT INTO Elements (lvl, color, length, width, hgt) VALUES(5, 'GRAY',		NULL, NULL, NULL);

●リスト5-27 ウィンドウ関数による解（間違い）
SELECT MAX(color_max), MAX(length_max), MAX(width_max), MAX(hgt_max)
  FROM (SELECT FIRST_VALUE(color)  OVER W_ELEMENTS color_max,
               FIRST_VALUE(length) OVER W_ELEMENTS length_max,
               FIRST_VALUE(width)  OVER W_ELEMENTS width_max,
               FIRST_VALUE(hgt)    OVER W_ELEMENTS hgt_max
          FROM Elements
        WINDOW W_ELEMENTS AS (ORDER BY lvl DESC)) TMP;


●リスト5-28 ウィンドウ関数による解（正解）
SELECT MAX(color_max), MAX(length_max), MAX(width_max), MAX(hgt_max)
  FROM (SELECT FIRST_VALUE(color)  IGNORE NULLS OVER (ORDER BY lvl DESC) color_max,
               FIRST_VALUE(length) IGNORE NULLS OVER (ORDER BY lvl DESC) length_max,
               FIRST_VALUE(width)  IGNORE NULLS OVER (ORDER BY lvl DESC) width_max,
               FIRST_VALUE(hgt)    IGNORE NULLS OVER (ORDER BY lvl DESC) hgt_max
          FROM Elements
        WINDOW W_ELEMENTS AS (ORDER BY lvl DESC)) TMP;

●リスト5-29 CASE式による解
SELECT (SELECT color  FROM Elements WHERE lvl = M.lc) AS color,
       (SELECT length FROM Elements WHERE lvl = M.ll) AS length,
       (SELECT width  FROM Elements WHERE lvl = M.lw) AS width,
       (SELECT hgt    FROM Elements WHERE lvl = M.lh) AS hgt
  FROM (SELECT MAX(CASE WHEN color IS NOT NULL
                        THEN lvl END) AS lc,
               MAX(CASE WHEN length IS NOT NULL
                        THEN lvl END) AS ll,
               MAX(CASE WHEN width IS NOT NULL
                        THEN lvl END) AS lw,
               MAX(CASE WHEN hgt IS NOT NULL
                        THEN lvl END) AS lh
          FROM Elements)  M;


●リスト5-30 NULLの大きさを調べるためのテーブル
CREATE TABLE OrderNull
(col INTEGER);

INSERT INTO OrderNull VALUES (1);
INSERT INTO OrderNull VALUES (2);
INSERT INTO OrderNull VALUES (3);
INSERT INTO OrderNull VALUES (NULL);

●リスト5-31 NULLの大きさを調べるためのテーブル
SELECT col
  FROM OrderNull
 ORDER BY col;


●リスト5-32 NULLを最小値として扱う（PostgreSQLおよびOracle）
SELECT col
  FROM OrderNull
 ORDER BY col NULLS FIRST;
