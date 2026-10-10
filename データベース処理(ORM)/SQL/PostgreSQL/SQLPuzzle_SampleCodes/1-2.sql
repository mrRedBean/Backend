
●リスト1-19 社員テーブルと部門テーブル
CREATE TABLE Departments
 (department  CHAR(32),
    CONSTRAINT pk_Departments PRIMARY KEY (department)); 

CREATE TABLE Personnel
 (emp  CHAR(32),
  age  INTEGER,
  department CHAR(32),
    CONSTRAINT pk_Personnel PRIMARY KEY (emp),
    CONSTRAINT fk_Personnel FOREIGN KEY (department) REFERENCES departments (department)); 
    
INSERT INTO Departments VALUES('営業');
INSERT INTO Departments VALUES('研究開発');
INSERT INTO Departments VALUES('総務');
INSERT INTO Departments VALUES('人事');

INSERT INTO Personnel (emp, age, department) VALUES('山田信二',	28,	'営業');
INSERT INTO Personnel (emp, age, department) VALUES('高見恵三',	43,	'研究開発');
INSERT INTO Personnel (emp, age, department) VALUES('吉田洋子',	33,	'総務');
INSERT INTO Personnel (emp, age, department) VALUES('古沢香織',	42,	'営業');
INSERT INTO Personnel (emp, age, department) VALUES('武田宏',	30,	'人事');

●リスト1-20 参照整合性制約を付与
CREATE TABLE Personnel
(emp CHAR(32),
 age INTEGER,
 department CHAR(32),
    CONSTRAINT pk_Personnel PRIMARY KEY (emp),
    CONSTRAINT fk_Personnel FOREIGN KEY (department) REFERENCES departments (department));

●リスト1-21 存在しない部署の社員を登録する
INSERT INTO Personnel (emp, age, department) VALUES ('後藤啓二', 40, '広報');

●リスト1-22 所属する社員が存在する部署のレコードは削除できない
DELETE FROM Departments 
 WHERE TRIM(department) = '営業';


●リスト1-24 自己参照整合性制約
CREATE TABLE OrgChartAdjacency
 (emp  VARCHAR(32),
  boss VARCHAR(32),
    CONSTRAINT pk_OrgChartAdjacency PRIMARY KEY (emp), 
    CONSTRAINT fk_OrgChartAdjacency FOREIGN KEY (boss) REFERENCES OrgChartAdjacency (emp));

INSERT INTO OrgChartAdjacency VALUES ('アダム', NULL);
INSERT INTO OrgChartAdjacency VALUES ('イブ', 'アダム');
INSERT INTO OrgChartAdjacency VALUES ('セト', 'アダム');
INSERT INTO OrgChartAdjacency VALUES ('カイン','セト');
INSERT INTO OrgChartAdjacency VALUES ('アベル','セト');
INSERT INTO OrgChartAdjacency VALUES ('ノア', 'セト');
INSERT INTO OrgChartAdjacency VALUES ('ヨブ', 'カイン');

