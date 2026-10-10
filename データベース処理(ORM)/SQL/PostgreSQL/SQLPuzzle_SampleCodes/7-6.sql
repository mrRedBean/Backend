●リスト7-33 商品テーブル
CREATE TABLE Products
(product_id INTEGER NOT NULL,
 name VARCHAR(16) NOT NULL,
 price INTEGER NOT NULL,
   CONSTRAINT pk_Products PRIMARY KEY(product_id));


●重複するレコード
INSERT INTO Products VALUES(1, 'りんご',	50);
INSERT INTO Products VALUES(2, 'みかん',	100);
INSERT INTO Products VALUES(3, 'みかん',	100);
INSERT INTO Products VALUES(4, 'みかん',	100);
INSERT INTO Products VALUES(5, 'バナナ',	80);

●リスト7-34 重複行を削除する：極値関数の利用 
DELETE FROM Products
 WHERE product_id < ( SELECT MAX(P2.product_id) 
                        FROM Products P2 
                       WHERE Products.name = P2.name 
                         AND Products.price = P2.price );


●リスト7-35 重複行を削除する：NOT INの利用
DELETE FROM Products 
 WHERE product_id 
         NOT IN ( SELECT MAX(product_id)
                    FROM Products 
                   GROUP BY name, price);


●サブクエリの中身を実行
SELECT MAX(product_id)
  FROM Products 
 GROUP BY name, price;


●リスト7-36 重複行を削除する：差集合演算
DELETE FROM Products
 WHERE product_id IN (SELECT product_id
                        FROM Products 
                      EXCEPT
                      SELECT MAX(product_id)
                        FROM Products 
                       GROUP BY name, price);

●リスト7-37 重複行を削除する：ウィンドウ関数
DELETE FROM Products
 WHERE product_id IN 
         (SELECT product_id 
            FROM (SELECT product_id, name, price,
                         ROW_NUMBER() OVER (PARTITION BY name, price 
                                                ORDER BY product_id) AS row_num
                    FROM Products) TMP
           WHERE row_num > 1);
