●リスト2-11 日付ごとの来客数テーブル
CREATE TABLE CustomerCount
(record_date DATE,
 dow CHAR(3),
 customers INTEGER,
   CONSTRAINT pk_CustomerCount PRIMARY KEY (record_date));

INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-12', 'Mon', 212);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-13', 'Tue', 540);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-14', 'Wed', 145);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-15', 'Thr', 321);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-16', 'Fri', 670);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-17', 'Sat', 518);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-18', 'Sun', 420);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-19', 'Mon', 376);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-20', 'Tue', 222);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-21', 'Wed', 518);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-22', 'Thr', 842);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-23', 'Fri', 632);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-24', 'Sat', 190);
INSERT INTO CustomerCount (record_date, dow, customers) VALUES ('2024-11-25', 'Sun', 341);


●リスト2-12 CASE式によるピボット
SELECT SUM(CASE WHEN dow = 'Mon' THEN customers ELSE 0 END) AS Mon,
       SUM(CASE WHEN dow = 'Tue' THEN customers ELSE 0 END) AS Tue,
       SUM(CASE WHEN dow = 'Wed' THEN customers ELSE 0 END) AS Wed,
       SUM(CASE WHEN dow = 'Thr' THEN customers ELSE 0 END) AS Thr,
       SUM(CASE WHEN dow = 'Fri' THEN customers ELSE 0 END) AS Fri,
       SUM(CASE WHEN dow = 'Sat' THEN customers ELSE 0 END) AS Sat,
       SUM(CASE WHEN dow = 'Sun' THEN customers ELSE 0 END) AS Sun
  FROM CustomerCount;

●リスト2-13 スカラサブクエリによる解
SELECT DISTINCT
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Mon') AS Mon,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Tue') AS Tue,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Wed') AS Wed,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Thr') AS Thr,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Fri') AS Fri,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Sat') AS Sat,
       (SELECT SUM(customers) FROM CustomerCount WHERE dow = 'Sun') AS Sun
  FROM CustomerCount;


●リスト2-14 サービススケジュールテーブル
CREATE TABLE ServicesSchedule
(order_nbr CHAR(10) NOT NULL,
 sch_seq INTEGER NOT NULL CHECK (sch_seq IN (1,2,3)),
 sch_date DATE,
   CONSTRAINT pk_ServicesSchedule PRIMARY KEY (order_nbr, sch_seq));

INSERT INTO ServicesSchedule VALUES('4155526710',   1,  '2025-07-16' );
INSERT INTO ServicesSchedule VALUES('4155526710',   2,  '2025-07-30' ); 
INSERT INTO ServicesSchedule VALUES('4155526710',   3,  '2025-10-01' );
INSERT INTO ServicesSchedule VALUES('4155526711',   1,  '2025-07-16' ); 
INSERT INTO ServicesSchedule VALUES('4155526711',   2,  '2025-07-30' ); 
INSERT INTO ServicesSchedule VALUES('4155526711',   3,   NULL ); 


●リスト2-15 CASE式によるピボット
SELECT order_nbr,
       MAX(CASE WHEN sch_seq = 1 THEN sch_date ELSE NULL END) AS processed,
       MAX(CASE WHEN sch_seq = 2 THEN sch_date ELSE NULL END) AS completed,
       MAX(CASE WHEN sch_seq = 3 THEN sch_date ELSE NULL END) AS confirmed
  FROM ServicesSchedule
 GROUP BY order_nbr;


●リスト2-16 スカラサブクエリによるピボット
SELECT order_nbr,
       (SELECT sch_date FROM ServicesSchedule SS1
         WHERE sch_seq = 1 AND SS0.order_nbr = SS1.order_nbr) AS processed,
       (SELECT sch_date FROM ServicesSchedule SS2
         WHERE sch_seq = 2 AND SS0.order_nbr = SS2.order_nbr) AS completed,
       (SELECT sch_date FROM ServicesSchedule SS3
         WHERE sch_seq = 3 AND SS0.order_nbr = SS3.order_nbr) AS confirmed
  FROM ServicesSchedule SS0
 GROUP BY order_nbr;
 