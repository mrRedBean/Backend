●リスト7-22 線分テーブル
CREATE TABLE Lines
(line_id   CHAR(1) NOT NULL,
 dimension CHAR(1) NOT NULL,
 low  INTEGER NOT NULL,
 high INTEGER NOT NULL,
   CONSTRAINT pk_lines PRIMARY KEY (line_id, dimension),
   CHECK (low < high));

INSERT INTO Lines VALUES ('A', 'x', 0, 2);
INSERT INTO Lines VALUES ('B', 'x', 1, 3);
INSERT INTO Lines VALUES ('C', 'x', 10, 12);
INSERT INTO Lines VALUES ('D', 'x', 5, 9);
INSERT INTO Lines VALUES ('E', 'x', 6, 7);


●リスト7-23 1次元の場合
SELECT L1.line_id, L2.line_id
  FROM Lines L1, Lines L2
 WHERE L1.line_id < L2.line_id
   AND (   (L1.high BETWEEN L2.low and L2.high)
        OR (L2.high BETWEEN L1.low and L1.high));


●リスト7-24 長方形テーブル
CREATE TABLE Boxes
(box_id    CHAR(1) NOT NULL,
 dimension CHAR(1) NOT NULL,
 low INTEGER NOT NULL,
 high INTEGER NOT NULL
   CHECK (low < high),
   CONSTRAINT pk_Boxes PRIMARY KEY (box_id, dimension));

INSERT INTO Boxes VALUES ('A', 'x', 0, 2);
INSERT INTO Boxes VALUES ('A', 'y', 0, 2);
INSERT INTO Boxes VALUES ('B', 'x', 1, 3);
INSERT INTO Boxes VALUES ('B', 'y', 1, 4);
INSERT INTO Boxes VALUES ('C', 'x', 10, 12);
INSERT INTO Boxes VALUES ('C', 'y', 0, 4);
INSERT INTO Boxes VALUES ('D', 'x', 5, 9);
INSERT INTO Boxes VALUES ('D', 'y', 3, 5);
INSERT INTO Boxes VALUES ('E', 'x', 6, 7);
INSERT INTO Boxes VALUES ('E', 'y', 3, 4);
INSERT INTO Boxes VALUES ('F', 'x', 5, 8);
INSERT INTO Boxes VALUES ('F', 'y', 6, 7);


●リスト7-25 2次元の場合
SELECT B1.box_id, B2.box_id
  FROM Boxes B1, Boxes B2
 WHERE B1.box_id < B2.box_id
   AND B1.dimension = B2.dimension
   AND (   (B1.high BETWEEN B2.low and B2.high)
        OR (B2.high BETWEEN B1.low and B1.high))
 GROUP BY B1.box_id, B2.box_id
HAVING COUNT(B1.dimension) = 2;
