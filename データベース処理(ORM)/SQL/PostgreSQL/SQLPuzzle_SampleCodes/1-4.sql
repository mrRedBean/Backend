●リスト1-36 喫煙者テーブル
CREATE TABLE Smokers
(name CHAR(16) NOT NULL,
 age  INTEGER  NOT NULL,
 smoker CHAR(1) NOT NULL);

INSERT INTO Smokers VALUES ('ヒルベルト',	20,	'Y');
INSERT INTO Smokers VALUES ('デデキント',	35,	'Y');
INSERT INTO Smokers VALUES ('カントール',	16,	'Y');
INSERT INTO Smokers VALUES ('ペアノ',	    19,	'N');
INSERT INTO Smokers VALUES ('ツェルメロ',	20,	'N');
INSERT INTO Smokers VALUES ('コーシー',	    30,	'N');

●リスト1-37 CASE式による条件法
CREATE TABLE Smokers
(name CHAR(16) NOT NULL,
 age  INTEGER  NOT NULL,
 smoker CHAR(1) NOT NULL
   CONSTRAINT check_smoker CHECK
      (CASE WHEN age < 20 
            THEN CASE WHEN smoker = 'N'
                      THEN 1 ELSE 0 END
            ELSE 1 END = 1) );

●リスト1-38 MySQLとSQL Serverの場合は後からCHECK制約を追加する
ALTER TABLE Smokers 
  ADD CONSTRAINT check_smoker CHECK
      (CASE WHEN age < 20 
            THEN CASE WHEN smoker = 'N'
                      THEN 1 ELSE 0 END
            ELSE 1 END = 1);

●リスト1-39 間違い（これは条件法では「ない」）
CREATE TABLE Smokers
(name CHAR(16) NOT NULL,
 age  INTEGER  NOT NULL,
 smoker CHAR(1) NOT NULL
   CONSTRAINT check_smoker CHECK
      (CASE WHEN age < 20 AND smoker = 'N' 
            THEN 1 ELSE 0 END = 1) );


●リスト1-40 別解 条件法を論理和で書き換える
CREATE TABLE Smokers
(name CHAR(16) NOT NULL,
 age INTEGER NOT NULL,
 smoker CHAR(1) NOT NULL
    CONSTRAINT check_smoker CHECK
      (NOT (age < 20) OR smoker = 'N') );
