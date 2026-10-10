
●リスト2-29 購入明細テーブル
CREATE TABLE Receipts
(customer_id   CHAR(4) NOT NULL, 
 seq           INTEGER NOT NULL, 
 price         INTEGER NOT NULL, 
   CONSTRAINT pk_Receipts PRIMARY KEY (customer_id, seq));

INSERT INTO Receipts VALUES ('A',   1   ,500    );
INSERT INTO Receipts VALUES ('A',   2   ,1000   );
INSERT INTO Receipts VALUES ('A',   3   ,700    );
INSERT INTO Receipts VALUES ('B',   5   ,100    );
INSERT INTO Receipts VALUES ('B',   6   ,5000   );
INSERT INTO Receipts VALUES ('B',   7   ,300    );
INSERT INTO Receipts VALUES ('B',   9   ,200    );
INSERT INTO Receipts VALUES ('B',   12  ,1000   );
INSERT INTO Receipts VALUES ('C',   10  ,600    );
INSERT INTO Receipts VALUES ('C',   20  ,100    );
INSERT INTO Receipts VALUES ('C',   45  ,200    );
INSERT INTO Receipts VALUES ('C',   70  ,50     );
INSERT INTO Receipts VALUES ('D',   3   ,2000   );


●リスト2-30 FIRST_VALUE関数で最初の行を取得する
SELECT *
  FROM (SELECT customer_id, seq, price,
               FIRST_VALUE(seq) OVER (PARTITION BY customer_id 
                                            ORDER BY seq) AS min_seq
          FROM Receipts) TMP
 WHERE seq = min_seq;


●リスト2-31 結合で最初の行を取得する(これは悪手！)
SELECT R1.customer_id, R1.seq, R1.price
  FROM Receipts R1
         INNER JOIN
           (SELECT customer_id, MIN(seq) AS min_seq
              FROM Receipts
             GROUP BY customer_id) R2
    ON R1.customer_id = R2.customer_id
   AND R1.seq = R2.min_seq;


●リスト2-32 NTH_VALUE関数でn行目を取得する
SELECT *
  FROM (SELECT customer_id, seq, price,
               NTH_VALUE(seq, 3) OVER (PARTITION BY customer_id 
                                           ORDER BY seq) AS third_seq
          FROM Receipts) TMP
 WHERE seq = third_seq;


