●リスト3-47 SNSテーブル
CREATE TABLE Relation
(followee	  INTEGER,    -- フォローされている人
 follower   INTEGER ,  	-- フォローしている人
   CONSTRAINT pk_Relation PRIMARY KEY (followee, follower));

INSERT INTO Relation (followee, follower) VALUES (1,	2);
INSERT INTO Relation (followee, follower) VALUES (1,	3);
INSERT INTO Relation (followee, follower) VALUES (1,	4);
INSERT INTO Relation (followee, follower) VALUES (2,	1);
INSERT INTO Relation (followee, follower) VALUES (2,	3);
INSERT INTO Relation (followee, follower) VALUES (2,	5);
INSERT INTO Relation (followee, follower) VALUES (3,	1);
INSERT INTO Relation (followee, follower) VALUES (4,	2);
INSERT INTO Relation (followee, follower) VALUES (4,	5);
INSERT INTO Relation (followee, follower) VALUES (5,	2);
INSERT INTO Relation (followee, follower) VALUES (5,	3);

●リスト3-48 INTERSECTによる解
SELECT followee, follower
  FROM Relation
INTERSECT
SELECT follower, followee
  FROM Relation;
