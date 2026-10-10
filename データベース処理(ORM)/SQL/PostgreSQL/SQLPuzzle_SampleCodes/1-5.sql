●リスト1-41 都道府県テーブル
CREATE TABLE Prefectures
(pref_name VARCHAR(48) NOT NULL,
   CONSTRAINT pk_Pref PRIMARY KEY (pref_name));

INSERT INTO Prefectures VALUES ('01:北海道');
INSERT INTO Prefectures VALUES ('02:青森県');
INSERT INTO Prefectures VALUES ('03:秋田県');
INSERT INTO Prefectures VALUES ('30:和歌山県');
INSERT INTO Prefectures VALUES ('46:鹿児島県');


●リスト1-42 都道府県名の切り出し（PostgreSQL）
SELECT RIGHT(pref_name, LENGTH(pref_name) - POSITION(':' IN pref_name)) AS name_only
  FROM Prefectures;

●リスト1-43 都道府県名の切り出し（MySQL）
SELECT RIGHT(pref_name, CHAR_LENGTH(pref_name) - POSITION(':' IN pref_name)) AS name_only
  FROM Prefectures;

●リスト1-44 都道府県名の切り出し（Oracle）
SELECT SUBSTR(pref_name, -(LENGTH(pref_name) - INSTR(pref_name, ':'))) AS name_only
  FROM Prefectures;

●リスト1-45 都道府県名の切り出し（SQL Server）
SELECT RIGHT(pref_name, LEN(pref_name) - CHARINDEX(':', pref_name)) AS name_only
  FROM Prefectures;
