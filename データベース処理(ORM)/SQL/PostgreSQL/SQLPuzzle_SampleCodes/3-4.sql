●リスト3-12 予約管理テーブル
CREATE TABLE Reservations
(rsv_id CHAR(4),
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
          CHECK(start_date <= end_date),
   CONSTRAINT pk_Reservations PRIMARY KEY (rsv_id));


INSERT INTO Reservations VALUES ('R1', '2026-01-01', '2026-01-03');
INSERT INTO Reservations VALUES ('R3', '2026-01-04', '2026-01-05');
INSERT INTO Reservations VALUES ('R4', '2026-01-06', '2026-01-09');
INSERT INTO Reservations VALUES ('R7', '2026-01-12', '2026-01-12');


●リスト3-13 OVERLAPS述語による解（PostgreSQL）
SELECT *
  FROM Reservations
 WHERE (:start_date, :end_date) OVERLAPS (start_date, end_date)

●リスト3-14 OVERLAPS述語を試してみる(PostgreSQL)
SELECT *
  FROM Reservations
 WHERE ('2026-01-07', '2026-01-08') OVERLAPS (start_date, end_date);

●リスト3-15 OVERLAPS 述語による解（Oracle版）
SELECT *
  FROM Reservations
 WHERE (TO_DATE('2026-01-07'), TO_DATE('2026-01-08')) OVERLAPS (start_date, end_date);

●リスト3-17 開始日の一点だけ重複する（PostgreSQL）
SELECT *
  FROM Reservations
 WHERE ('2026-01-06', '2026-01-06') OVERLAPS (start_date, end_date);

●リスト3-18　開始日が同じ期間の比較（PostgreSQL）
SELECT *
  FROM Reservations
 WHERE ('2026-01-05', '2026-01-06') OVERLAPS (start_date, end_date);

●リスト3-19 終了日の一点だけ重複する（PostgreSQL）
SELECT *
  FROM Reservations
 WHERE ('2026-01-09', '2026-01-11') OVERLAPS (start_date, end_date);


●リスト3-20 汎用的な重複検出
SELECT *
  FROM Reservations
 WHERE :start_date BETWEEN start_date AND end_date
    OR :end_date   BETWEEN start_date AND end_date
    OR (:start_date <= start_date AND :end_date >= end_date);


●リスト3-21 上手く動作するかの検証
-- ①当該期間が他の期間に完全に包含される場合：検出
SELECT *
  FROM Reservations
 WHERE '2026-01-07' BETWEEN start_date AND end_date
    OR '2026-01-08' BETWEEN start_date AND end_date
    OR ('2026-01-07' <= start_date AND '2026-01-08' >= end_date);

●リスト3-22
-- ②開始点だけで重複する場合：検出
SELECT *
  FROM Reservations
 WHERE '2026-01-06' BETWEEN start_date AND end_date
    OR '2026-01-06' BETWEEN start_date AND end_date
    OR ('2026-01-06' <= start_date AND '2026-01-06' >= end_date);

●リスト3-23
-- ③開始点は重複するが終了点は重複しない場合：検出
SELECT *
  FROM Reservations
 WHERE '2026-01-07' BETWEEN start_date AND end_date
    OR '2026-01-10' BETWEEN start_date AND end_date
    OR ('2026-01-07' <= start_date AND '2026-01-10' >= end_date);

●リスト3-24
-- 終了点だけで重複する場合：検出
SELECT *
  FROM Reservations
 WHERE '2026-01-09' BETWEEN start_date AND end_date
    OR '2026-01-09' BETWEEN start_date AND end_date
    OR ('2026-01-09' <= start_date AND '2026-01-09' >= end_date);

●リスト3-25
-- 重複しない場合：検出しない
SELECT *
  FROM Reservations
 WHERE '2026-01-10' BETWEEN start_date AND end_date
    OR '2026-01-11' BETWEEN start_date AND end_date
    OR ('2026-01-10' <= start_date AND '2026-01-11' >= end_date);

