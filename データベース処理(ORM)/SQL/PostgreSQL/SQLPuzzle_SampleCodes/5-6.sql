●リスト5-20 給与テーブル
CREATE TABLE Graduates
(name   VARCHAR(16) PRIMARY KEY,
 income INTEGER NOT NULL);

INSERT INTO Graduates VALUES('サンプソン', 400000);
INSERT INTO Graduates VALUES('マイク',     30000);
INSERT INTO Graduates VALUES('ホワイト',   20000);
INSERT INTO Graduates VALUES('アーノルド', 20000);
INSERT INTO Graduates VALUES('スミス',     20000);
INSERT INTO Graduates VALUES('ロレンス',   15000);
INSERT INTO Graduates VALUES('ハドソン',   15000);
INSERT INTO Graduates VALUES('ケント',     10000);
INSERT INTO Graduates VALUES('ベッカー',   10000);
INSERT INTO Graduates VALUES('スコット',   10000);


●リスト5-21 最頻値を求めるSQL　その1：ALL述語の利用 
SELECT income, COUNT(*) AS cnt 
  FROM Graduates 
 GROUP BY income 
HAVING COUNT(*) >= ALL ( SELECT COUNT(*) 
                           FROM Graduates
                          GROUP BY income);


●リスト5-22 最頻値を求める SQL　その 2：極値関数の利用 
SELECT income, COUNT(*) AS cnt 
  FROM Graduates 
 GROUP BY income 
HAVING COUNT(*) >= ( SELECT MAX(cnt) 
                       FROM ( SELECT COUNT(*) AS cnt 
                                FROM Graduates 
                               GROUP BY income) TMP ) ;


●リスト5-23 最頻値（Oracle実装依存）
SELECT STATS_MODE(income) AS mode_income
  FROM Graduates;


●リスト5-24 最頻値（PostgreSQL実装依存）
SELECT MODE() WITHIN GROUP (ORDER BY income) AS mode_income
  FROM Graduates;


●リスト5-25 最頻値を求める（ウィンドウ関数）
SELECT income, cnt
  FROM (SELECT income, COUNT(*) AS cnt,
               MAX(count(*)) OVER() AS max_cnt
          FROM Graduates
         GROUP BY income) TMP
 WHERE cnt = max_cnt;


●サブクエリの内部を見てみる
SELECT income, COUNT(*) AS cnt,
       MAX(count(*)) OVER() AS max_cnt
  FROM Graduates
 GROUP BY income;

