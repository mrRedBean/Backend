
●リスト1-25 アルファベットを少なくとも1文字含む（OracleとPostgreSQL）
CREATE TABLE SomeTbl
(some_alpha CHAR(6) 
   CHECK (UPPER(some_alpha) <> LOWER(some_alpha)));

●リスト1-26 テストデータ
-- INSERTに成功する
INSERT INTO SomeTbl (some_alpha) VALUES ('12345a');
INSERT INTO SomeTbl (some_alpha) VALUES ('1234ab');
INSERT INTO SomeTbl (some_alpha) VALUES ('abcdef');

-- INSERTに失敗する
INSERT INTO SomeTbl (some_alpha) VALUES ('123456');
INSERT INTO SomeTbl (some_alpha) VALUES ('あいうえお');
INSERT INTO SomeTbl (some_alpha) VALUES ('!"#$%&');


●リスト1-27 アルファベットを1文字以上含む制約 (SQL Server)
CREATE TABLE SomeTbl
(some_alpha CHAR(6) COLLATE Latin1_General_CS_AS
   CHECK (UPPER(some_alpha) <> LOWER(some_alpha)));

●リスト1-28 アルファベットを1文字以上含む制約 (MySQL)
CREATE TABLE SomeTbl
(some_alpha CHAR(6) COLLATE utf8mb4_bin
   CHECK (UPPER(some_alpha) <> LOWER(some_alpha)));

●リスト1-29 制約チェック時のみ型変換する (MySQL)
CREATE TABLE SomeTbl
(some_alpha CHAR(6)
    CHECK (CAST(UPPER(some_alpha) AS BINARY)
        <> CAST(LOWER(some_alpha) AS BINARY)));


●リスト1-30　アルファベットを含まない制約(OracleとPostgreSQL)
CREATE TABLE NoTbl
(no_alpha CHAR(6) 
   CHECK (UPPER(no_alpha) = LOWER(no_alpha)));

●リスト1-31 テストデータ
-- INSERTに成功する
INSERT INTO NoTbl (no_alpha) VALUES ('123456');
INSERT INTO NoTbl (no_alpha) VALUES ('あいうえお');
INSERT INTO NoTbl (no_alpha) VALUES ('!"#$%&');

-- INSERTに失敗する
INSERT INTO NoTbl (no_alpha) VALUES ('12345a');
INSERT INTO NoTbl (no_alpha) VALUES ('1234ab');
INSERT INTO NoTbl (no_alpha) VALUES ('abcdef');
INSERT INTO NoTbl (no_alpha) VALUES ('ab');


●リスト1-32 すべてアルファベットの文字列（PostgreSQL）
CREATE TABLE AllTbl
(all_alpha CHAR(6)
    CHECK ( all_alpha ~ '^[a-zA-Z]+$'));

●リスト1-33 テストデータ
-- INSERTに成功する
INSERT INTO AllTbl (all_alpha) VALUES ('ABCDEF');
INSERT INTO AllTbl (all_alpha) VALUES ('abcdef');
INSERT INTO AllTbl (all_alpha) VALUES ('AbCdEf');

-- INSERTに失敗する
INSERT INTO AllTbl (all_alpha) VALUES ('12345a');
INSERT INTO AllTbl (all_alpha) VALUES ('1234ab');
INSERT INTO AllTbl (all_alpha) VALUES ('abcde0');
INSERT INTO AllTbl (all_alpha) VALUES ('abc2de');
INSERT INTO AllTbl (all_alpha) VALUES ('');


●リスト1-34 すべてアルファベットの文字列制約（OracleとMySQLとSQL Server）
CREATE TABLE AllTbl
(all_alpha CHAR(6) 
   CHECK ( REGEXP_LIKE(all_alpha, '^[a-zA-Z]+$')));

●リスト1-35 Oracleでは空白文字のためエラーになる
INSERT INTO AllTbl (all_alpha) VALUES ('a');
INSERT INTO AllTbl (all_alpha) VALUES ('aaaa');
INSERT INTO AllTbl (all_alpha) VALUES ('a a');
