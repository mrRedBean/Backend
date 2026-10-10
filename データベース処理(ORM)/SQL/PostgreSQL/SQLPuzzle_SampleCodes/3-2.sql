
●リスト3-5 日付の範囲テーブル
CREATE TABLE DateRanges
(start_date DATE NOT NULL,
 end_date DATE NOT NULL,
          CHECK(start_date <= end_date),
   CONSTRAINT pk_DateRanges PRIMARY KEY (start_date));

INSERT INTO DateRanges VALUES ('2025-01-01', '2025-01-03');
INSERT INTO DateRanges VALUES ('2025-01-02', '2025-01-04');
INSERT INTO DateRanges VALUES ('2025-01-04', '2025-01-05');
INSERT INTO DateRanges VALUES ('2025-01-06', '2025-01-09');


●リスト3-6 開始日 <= 終了日の組み合わせ
SELECT D1.start_date AS start_date,
       D2.start_date AS start_date2
  FROM DateRanges D1, DateRanges D2
 WHERE D1.start_date <= D2.start_date;

●リスト3-7 非等値結合による自然数列の生成
SELECT COUNT(D1.end_date) AS num
  FROM DateRanges D1, DateRanges D2
 WHERE D1.start_date <= D2.start_date
 GROUP BY D1.start_date
 ORDER BY num;

