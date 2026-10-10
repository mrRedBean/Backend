●リスト7-38 累計テーブル
CREATE TABLE MonthlySales (
  month_id INTEGER PRIMARY KEY,
  month_name VARCHAR(10),
  cumulative_sales INTEGER );

INSERT INTO MonthlySales VALUES (1, 'Jan', 5000);
INSERT INTO MonthlySales VALUES (2, 'Feb', 9500);
INSERT INTO MonthlySales VALUES (3, 'Mar', 15200);
INSERT INTO MonthlySales VALUES (4, 'Apr', 21900);
INSERT INTO MonthlySales VALUES (5, 'May', 29800);
INSERT INTO MonthlySales VALUES (6, 'Jun', 38700);

●リスト7-39 累計の逆算
SELECT month_id, month_name,
       cumulative_sales - COALESCE(LAG(cumulative_sales, 1) OVER (ORDER BY month_id), 0) AS monthly_sales
  FROM MonthlySales;
