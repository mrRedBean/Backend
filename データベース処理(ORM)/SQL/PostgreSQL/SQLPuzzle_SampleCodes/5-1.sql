●リスト5-1 株価テーブル
CREATE TABLE StockPrice
(deal_date   DATE,
 ticker_symbol CHAR(4),
 stock_price INTEGER,
   CONSTRAINT pk_StockPrice PRIMARY KEY (deal_date, ticker_symbol));

INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-01', 'AAAA', 120);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-02', 'AAAA', 125);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-03', 'AAAA', 150);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-04', 'AAAA', 90);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-05', 'AAAA', 104);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-06', 'AAAA', 190);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-01', 'BBBB', 300);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-05', 'BBBB', 200);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-07', 'BBBB', 150);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-09', 'BBBB', 212);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-12', 'BBBB', 350);
INSERT INTO StockPrice (deal_date, ticker_symbol, stock_price) VALUES ('2025-04-13', 'BBBB', 800);

●リスト5-2 ウィンドウ関数による移動平均
SELECT deal_date,
       ticker_symbol,
       AVG(stock_price) OVER (PARTITION BY ticker_symbol 
                                  ORDER BY deal_date
                                     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS mvg_avg 
  FROM StockPrice;


●リスト5-3 ウィンドウ関数によるトレンド分析
SELECT deal_date,
       ticker_symbol,
       stock_price,
       CASE WHEN stock_price > LAG(stock_price, 1) OVER W_TREND   
              THEN 'up'
            WHEN stock_price < LAG(stock_price, 1) OVER W_TREND
              THEN 'down'
            ELSE '-' END AS trend
  FROM StockPrice
  WINDOW W_TREND AS (PARTITION BY ticker_symbol ORDER BY deal_date);

