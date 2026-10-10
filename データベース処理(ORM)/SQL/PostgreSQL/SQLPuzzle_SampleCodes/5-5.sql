
●リスト5-17 イスクリーム売り上げテーブル
CREATE TABLE SalesIcecream
(shop_id   CHAR(4) NOT NULL,
 sale_date DATE NOT NULL,
 sales_amt INTEGER NOT NULL,
   CONSTRAINT pk_SalesIcecream PRIMARY KEY(shop_id, sale_date) );

INSERT INTO SalesIcecream VALUES('A', '2024-06-01', 67800);
INSERT INTO SalesIcecream VALUES('A', '2024-06-02', 87000);
INSERT INTO SalesIcecream VALUES('A', '2024-06-05', 11300);
INSERT INTO SalesIcecream VALUES('A', '2024-06-10', 9800);
INSERT INTO SalesIcecream VALUES('A', '2024-06-15', 9800);
INSERT INTO SalesIcecream VALUES('B', '2024-06-02', 178000);
INSERT INTO SalesIcecream VALUES('B', '2024-06-15', 18800);
INSERT INTO SalesIcecream VALUES('B', '2024-06-17', 19850);
INSERT INTO SalesIcecream VALUES('B', '2024-06-20', 23800);
INSERT INTO SalesIcecream VALUES('B', '2024-06-21', 18800);
INSERT INTO SalesIcecream VALUES('C', '2024-06-01', 12500);

●リスト5-18 ウィンドウ関数による累計
SELECT shop_id,
       sale_date,
       sales_amt,
       SUM(sales_amt) OVER (PARTITION BY shop_id 
                                ORDER BY sale_date) AS cumlative_amt
  FROM SalesIcecream;

●リスト5-19 全件数とデータを同時に取得する
SELECT shop_id,
       sale_date,
       sales_amt,
       SUM(sales_amt) OVER (PARTITION BY shop_id 
                                ORDER BY sale_date) AS cumlative_amt,
       COUNT(*) OVER() AS cnt
  FROM SalesIcecream;
