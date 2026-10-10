

●リスト1-1 フルーツテーブル(主キーなし)
CREATE TABLE Fruits
 (name CHAR(16)); 

INSERT INTO Fruits VALUES ('Orange');
INSERT INTO Fruits VALUES ('Orange');
INSERT INTO Fruits VALUES ('Apple');
INSERT INTO Fruits VALUES ('Apple');
INSERT INTO Fruits VALUES ('Apple');
INSERT INTO Fruits VALUES ('Grape');


●リスト1-2 フルーツテーブル(主キーあり：連番)
CREATE TABLE Fruits
 (pk_num INTEGER, 
  name CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 


●リスト1-3 シーケンスオブジェクト（Oracle）
CREATE SEQUENCE test_seq
  START WITH 1
  INCREMENT BY 1
  NOCYCLE;

●リスト1-4 シーケンスオブジェクトによる自動採番
INSERT INTO Fruits VALUES (test_seq.nextval, 'Orange');
INSERT INTO Fruits VALUES (test_seq.nextval, 'Orange');
INSERT INTO Fruits VALUES (test_seq.nextval, 'Apple');
INSERT INTO Fruits VALUES (test_seq.nextval, 'Apple');
INSERT INTO Fruits VALUES (test_seq.nextval, 'Apple');
INSERT INTO Fruits VALUES (test_seq.nextval, 'Grape');


●リスト1-5 シーケンスオブジェクト（PostgreSQL）
CREATE SEQUENCE test_seq
START 1;

●リスト1-6 シーケンスオブジェクトによる自動採番
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Orange');
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Orange');
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Apple');
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Apple');
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Apple');
INSERT INTO Fruits VALUES (nextval('test_seq'), 'Grape');


●リスト1-7 シーケンスオブジェクト（SQL Server）
CREATE SEQUENCE test_seq
  START WITH 1  
  INCREMENT BY 1;

●リスト1-8 シーケンスオブジェクトによる自動採番
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Orange');
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Orange');
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Apple');
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Apple');
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Apple');
INSERT INTO Fruits VALUES (NEXT VALUE FOR test_seq, 'Grape');


●リスト1-9 ID列（MySQL）
CREATE TABLE Fruits
 (pk_num INTEGER AUTO_INCREMENT, 
  name CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 

●リスト1-10 ID列を使った採番
INSERT INTO Fruits (name) VALUES ('Orange');
INSERT INTO Fruits (name) VALUES ('Orange');
INSERT INTO Fruits (name) VALUES ('Apple');
INSERT INTO Fruits (name) VALUES ('Apple');
INSERT INTO Fruits (name) VALUES ('Apple');
INSERT INTO Fruits (name) VALUES ('Grape');


●リスト1-11 UUID列を主キーにしたテーブル（Oracle）
CREATE TABLE Fruits
 (pk_num RAW(16), 
  name CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 

●リスト1-12 UUID列を使ったレコードの挿入
INSERT INTO Fruits VALUES (SYS_GUID(), 'Orange');
INSERT INTO Fruits VALUES (SYS_GUID(), 'Orange');
INSERT INTO Fruits VALUES (SYS_GUID(), 'Apple');
INSERT INTO Fruits VALUES (SYS_GUID(), 'Apple');
INSERT INTO Fruits VALUES (SYS_GUID(), 'Apple');
INSERT INTO Fruits VALUES (SYS_GUID(), 'Grape');


●リスト1-13 UUID列を主キーにしたテーブル（SQL Server）
CREATE TABLE Fruits
 (pk_num uniqueidentifier, 
  name   CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 

●リスト1-14 UUID列を使ったレコードの挿入
INSERT INTO Fruits VALUES (NEWID(), 'Orange');
INSERT INTO Fruits VALUES (NEWID(), 'Orange');
INSERT INTO Fruits VALUES (NEWID(), 'Apple');
INSERT INTO Fruits VALUES (NEWID(), 'Apple');
INSERT INTO Fruits VALUES (NEWID(), 'Apple');
INSERT INTO Fruits VALUES (NEWID(), 'Grape');

●リスト1-15 UUID列を主キーにしたテーブル（PostgreSQL）
CREATE TABLE Fruits
 (pk_num UUID, 
  name   CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 

●リスト1-16 UUID列を使ったレコードの挿入
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Orange');
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Orange');
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Apple');
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Apple');
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Apple');
INSERT INTO Fruits VALUES (gen_random_uuid (), 'Grape');


●リスト1-17 UUID列を主キーにしたテーブル（MySQL）
CREATE TABLE Fruits
 (pk_num BINARY(36), 
  name   CHAR(16),
    CONSTRAINT pk_Fruits PRIMARY KEY(pk_num)); 

●リスト1-18 UUID列を使ったレコードの挿入
INSERT INTO Fruits VALUES (UUID(), 'Orange');
INSERT INTO Fruits VALUES (UUID(), 'Orange');
INSERT INTO Fruits VALUES (UUID(), 'Apple');
INSERT INTO Fruits VALUES (UUID(), 'Apple');
INSERT INTO Fruits VALUES (UUID(), 'Apple');
INSERT INTO Fruits VALUES (UUID(), 'Grape');
