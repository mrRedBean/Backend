●リスト3-8 タイムシートテーブル
CREATE TABLE Timesheets
(job_id CHAR(4),
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
          CHECK(start_date <= end_date),
   CONSTRAINT pk_Timesheets PRIMARY KEY (job_id));

INSERT INTO Timesheets VALUES ('J1', '2025-01-01', '2025-01-03');
INSERT INTO Timesheets VALUES ('J2', '2025-01-02', '2025-01-04');
INSERT INTO Timesheets VALUES ('J3', '2025-01-04', '2025-01-05');
INSERT INTO Timesheets VALUES ('J4', '2025-01-06', '2025-01-09');
INSERT INTO Timesheets VALUES ('J5', '2025-01-09', '2025-01-09');
INSERT INTO Timesheets VALUES ('J6', '2025-01-09', '2025-01-09');
INSERT INTO Timesheets VALUES ('J7', '2025-01-12', '2025-01-15');
INSERT INTO Timesheets VALUES ('J8', '2025-01-13', '2025-01-14');
INSERT INTO Timesheets VALUES ('J9', '2025-01-14', '2025-01-14');
INSERT INTO Timesheets VALUES ('J10', '2025-01-17', '2025-01-17');


●リスト3-9 自己非等値結合による解
SELECT start_date,
       MIN(end_date) AS end_date
  FROM ( SELECT T1.start_date AS start_date,
                T2.end_date AS end_date
           FROM Timesheets T1, Timesheets T2, Timesheets T3
          WHERE T1.start_date <= T2.start_date    
          GROUP BY T1.start_date, T2.end_date
         HAVING COUNT(CASE WHEN (T1.start_date > T3.start_date 
                                 AND  T1.start_date <= T3.end_date)     -- 条件1-a
                             OR (T2.end_date  >= T3.start_date 
                                 AND T2.end_date < T3.end_date)         -- 条件1-b
                      THEN 1 END) = 0 ) TMP
 GROUP BY start_date;


●リスト3-10 開始日 <= 終了日の組み合わせ
SELECT T1.start_date AS start_date,
       T2.end_date AS end_date
  FROM Timesheets T1, Timesheets T2
 WHERE T1.start_date <= T2.start_date;


●リスト3-11 中途半端な開始日と終了日の期間を除外する
SELECT T1.start_date AS start_date,
       T2.end_date AS end_date
  FROM Timesheets T1, Timesheets T2, Timesheets T3   -- T3を追加
 WHERE T1.start_date <= T2.start_date
 GROUP BY T1.start_date, T2.end_date
HAVING COUNT(CASE WHEN (T1.start_date > T3.start_date
                          AND T1.start_date <= T3.end_date) -- 条件1-a
                       OR
                       (T2.end_date >= T3.start_date
                          AND T2.end_date < T3.end_date)    -- 条件1-b
                   THEN 1 END) = 0;


