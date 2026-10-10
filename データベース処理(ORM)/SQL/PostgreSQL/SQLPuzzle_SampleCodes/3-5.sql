●リスト3-27 アイスクリームショップの種類
CREATE TABLE Icecreams
(sale_date DATE NOT NULL,
 flavor    CHAR(32) NOT NULL,
 sale_amt  INTEGER NOT NULL,
   CONSTRAINT pk_Icecreams PRIMARY KEY(sale_date, flavor));

INSERT INTO Icecreams VALUES ('2026-01-01', 'コットンキャンディ', 12000);
INSERT INTO Icecreams VALUES ('2026-01-01', 'ティーオーレ', 8000);
INSERT INTO Icecreams VALUES ('2026-01-01', '抹茶', 32000);
INSERT INTO Icecreams VALUES ('2026-01-01', 'ラムレーズン', 45000);
INSERT INTO Icecreams VALUES ('2026-01-01', 'チョコミント', 17000);
INSERT INTO Icecreams VALUES ('2026-01-02', 'ティーオーレ', 20000);
INSERT INTO Icecreams VALUES ('2026-01-02', 'マスクメロン', 3000);
INSERT INTO Icecreams VALUES ('2026-01-02', '抹茶', 8000);
INSERT INTO Icecreams VALUES ('2026-01-02', 'チョコミント', 29000);
INSERT INTO Icecreams VALUES ('2026-01-02', 'オレンジソルベ', 45000);
INSERT INTO Icecreams VALUES ('2026-01-03', '抹茶', 21000);
INSERT INTO Icecreams VALUES ('2026-01-03', 'コットンキャンディ', 9000);
INSERT INTO Icecreams VALUES ('2026-01-03', 'ラムレーズン', 8900);
INSERT INTO Icecreams VALUES ('2026-01-04', 'チョコミント', 7600);
INSERT INTO Icecreams VALUES ('2026-01-04', 'オレンジソルベ', 7600);
INSERT INTO Icecreams VALUES ('2026-01-04', 'ラムレーズン', 50000);


●リスト3-28 EXCEPTを使った解
SELECT I1.sale_date, I2.flavor
  FROM Icecreams I1 CROSS JOIN Icecreams I2
EXCEPT
SELECT sale_date, flavor
  FROM Icecreams;


●リスト3-29 NOT EXISTSを使った解
SELECT DISTINCT I1.sale_date, I2.flavor
  FROM Icecreams I1 CROSS JOIN Icecreams I2
 WHERE NOT EXISTS
       (SELECT sale_date, flavor
          FROM Icecreams I3
         WHERE I3.sale_date = I1.sale_date
           AND I3.flavor = I2.flavor);


●リスト3-30 フレーバーマスタ
CREATE TABLE Flavors
(flavor    CHAR(32) NOT NULL,
   CONSTRAINT pk_Flavors PRIMARY KEY (flavor));

INSERT INTO Flavors VALUES ('コットンキャンディ');
INSERT INTO Flavors VALUES ('ティーオーレ');
INSERT INTO Flavors VALUES ('抹茶');
INSERT INTO Flavors VALUES ('ラムレーズン');
INSERT INTO Flavors VALUES ('チョコミント');
INSERT INTO Flavors VALUES ('マスクメロン');
INSERT INTO Flavors VALUES ('オレンジソルベ');

●リスト3-31 フレーバーマスタを使った解
SELECT I.sale_date, F.flavor
  FROM Icecreams I CROSS JOIN Flavors F
EXCEPT
SELECT sale_date, flavor
  FROM Icecreams;
