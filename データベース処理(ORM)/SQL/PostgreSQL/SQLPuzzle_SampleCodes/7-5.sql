
●リスト7-26 顧客明細テーブル
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

●リスト7-27 FIRST_VALUE 関数による解法
SELECT customer_id, seq, max_price - min_price AS diff
  FROM (SELECT customer_id, seq,
               FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                            ORDER BY seq) AS min_price,
               FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                            ORDER BY seq DESC) AS max_price
          FROM Receipts);

●リスト7-28 FIRST_VALUE 関数は最小値も最大値も持ってくることができる
SELECT customer_id, seq,
       FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                    ORDER BY seq) AS min_price,
       FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                    ORDER BY seq DESC) AS max_price
  FROM Receipts;


●リスト7-29 LAST_VALUE関数による別解
SELECT customer_id, seq, max_price - min_price AS diff
  FROM (SELECT customer_id, seq,
               FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                            ORDER BY seq) AS min_price,
               LAST_VALUE(price) OVER (PARTITION BY customer_id
                                           ORDER BY seq
                                       ROWS BETWEEN UNBOUNDED PRECEDING
                                                AND UNBOUNDED FOLLOWING) AS max_price
          FROM Receipts);

●リスト7-30 単純にLAST_VALUE関数に変えただけダメ（間違い）
SELECT customer_id, seq, max_price - min_price AS diff
  FROM (SELECT customer_id, seq,
               FIRST_VALUE(price) OVER (PARTITION BY customer_id
                                            ORDER BY seq) AS min_price,
               LAST_VALUE(price) OVER (PARTITION BY customer_id
                                           ORDER BY seq) AS max_price
          FROM Receipts);

●リスト7-31 ROW_NUMBER関数による解法
SELECT customer_id, seq,
       ROW_NUMBER() OVER (PARTITION BY customer_id
                              ORDER BY seq) AS min_seq,
       ROW_NUMBER() OVER (PARTITION BY customer_id
                              ORDER BY seq DESC) AS max_seq
  FROM Receipts;

●リスト7-32 最小レコードの枝番を求める：相関サブクエリによる解法
SELECT R1.customer_id, R1.seq, R1.price
  FROM Receipts R1
 WHERE seq = (SELECT MIN(seq)
                FROM Receipts R2
               WHERE R1.customer_id = R2.customer_id
               GROUP BY customer_id);