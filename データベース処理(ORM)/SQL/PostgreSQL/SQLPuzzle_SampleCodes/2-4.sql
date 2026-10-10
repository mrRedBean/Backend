
●リスト2-17 クラスAとクラスBのテーブル定義
CREATE TABLE Class_A
(name     VARCHAR(32),
 birthday DATE,
   CONSTRAINT pk_Class_A PRIMARY KEY (name) );

CREATE TABLE Class_B
(name     VARCHAR(32),
 birthday DATE ,
   CONSTRAINT pk_Class_B PRIMARY KEY (name) );

INSERT INTO Class_A (name, birthday) VALUES ('在原努',   '2011/11/13');
INSERT INTO Class_A (name, birthday) VALUES ('芦田京子', '2012/10/24');
INSERT INTO Class_A (name, birthday) VALUES ('辺見洋三', '2010/04/11');
INSERT INTO Class_A (name, birthday) VALUES ('古賀誠',   '2012/06/22');
INSERT INTO Class_A (name, birthday) VALUES ('三浦晴美', '2011/09/30');

INSERT INTO Class_B (name, birthday) VALUES ('ケリー・ウィーバー',   '2011/11/13');
INSERT INTO Class_B (name, birthday) VALUES ('マーク・グリーン',     '2010/07/05');
INSERT INTO Class_B (name, birthday) VALUES ('ジョン・カーター',     '2012/06/18');
INSERT INTO Class_B (name, birthday) VALUES ('ロバート・ロマノ',     NULL);
INSERT INTO Class_B (name, birthday) VALUES ('エリザベス・コーデイ', '2011/09/30');


●リスト2-18 IN述語で一致する誕生日を調べる
SELECT name
  FROM Class_A
 WHERE birthday IN (SELECT birthday FROM Class_B);


●リスト2-19 NOT IN述語で一致しない誕生日を調べる（？）
SELECT name
  FROM Class_A
 WHERE birthday NOT IN (SELECT birthday FROM Class_B);


●リスト2-21 NOT EXISTS述語で一致しない誕生日を調べる
SELECT name
  FROM Class_A A
 WHERE NOT EXISTS 
       (SELECT * FROM Class_B B
         WHERE A.birthday = B.birthday);
