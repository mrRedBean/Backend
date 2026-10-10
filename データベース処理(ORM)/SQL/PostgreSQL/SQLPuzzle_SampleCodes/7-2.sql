
●リスト7-9 ピザ屋の売り上げテーブル
CREATE TABLE PizzaSales
(sale_date DATE,
 sale_amt  INTEGER,
   CONSTRAINT pk_PizzaSales PRIMARY KEY (sale_date) );

INSERT INTO PizzaSales VALUES ('2025-04-01', 10937);
INSERT INTO PizzaSales VALUES ('2025-04-02', 11298);
INSERT INTO PizzaSales VALUES ('2025-04-03',  9087);
INSERT INTO PizzaSales VALUES ('2025-04-04', 32000);
INSERT INTO PizzaSales VALUES ('2025-04-05', 28789);
INSERT INTO PizzaSales VALUES ('2025-04-06', 14890);

●リスト7-10 LIMIT句（PostgreSQL、MySQL）
SELECT *
  FROM PizzaSales
 ORDER BY sale_amt DESC
 LIMIT 3;


●リスト7-11 TOP関数（SQL Server）
SELECT TOP(3) sale_date, sale_amt
  FROM PizzaSales
 ORDER BY sale_amt DESC;


●リスト7-12 rownum（Oracle）
SELECT *
  FROM (SELECT *
          FROM PizzaSales
         ORDER BY sale_amt DESC)
 WHERE rownum <= 3;

DELETE FROM PizzaSales;
INSERT INTO PizzaSales VALUES ('2025-04-01', 10937);
INSERT INTO PizzaSales VALUES ('2025-04-02', 11298);
INSERT INTO PizzaSales VALUES ('2025-04-03',  9087);
INSERT INTO PizzaSales VALUES ('2025-04-04', 32000);
INSERT INTO PizzaSales VALUES ('2025-04-05', 28789);
INSERT INTO PizzaSales VALUES ('2025-04-06', 14890);
INSERT INTO PizzaSales VALUES ('2025-04-07', 32000);
INSERT INTO PizzaSales VALUES ('2025-04-08', 28789);


●リスト7-13 RANK関数で順位を求める
SELECT *
  FROM (SELECT sale_date, sale_amt,
               RANK() OVER (ORDER BY sale_amt DESC) rank_sale
          FROM PizzaSales) TMP
 WHERE TMP.rank_sale <= 3;

●リスト7-14 DENSE_RANK関数で順位を求める
SELECT *
  FROM (SELECT sale_date, sale_amt,
               DENSE_RANK() OVER (ORDER BY sale_amt DESC) rank_sale
          FROM PizzaSales) TMP
 WHERE TMP.rank_sale <= 3;

●リスト7-15 DENSE_RANK関数で順位を求める（QUALIFY 句）
 SELECT sale_date, sale_amt,
        DENSE_RANK() OVER (ORDER BY sale_amt DESC) AS rank_sale
   FROM PizzaSales
QUALIFY rank_sale <= 3;
