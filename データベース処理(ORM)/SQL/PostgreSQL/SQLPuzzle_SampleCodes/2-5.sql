●リスト2-22 本来望ましいがうまくいかないDDL
CREATE TABLE Badges
(badge_nbr INTEGER NOT NULL,
 emp_id INTEGER NOT NULL,
 issued_date DATE NOT NULL,
 badge_status CHAR(1) NOT NULL
   CHECK (badge_status IN ('A', 'I')),
   CHECK (1 <= ALL (SELECT COUNT(badge_status)
                      FROM Badges
                     WHERE badge_status = 'A'
                     GROUP BY emp_id)),
   CONSTRAINT pk_Badges PRIMARY KEY (badge_nbr));


●リスト2-23 BadgesテーブルからCHECK制約を除去したテーブル定義
CREATE TABLE Badges
(badge_nbr INTEGER NOT NULL,
 emp_id INTEGER NOT NULL,
 issued_date DATE NOT NULL,
 badge_status CHAR(1) NOT NULL
   CHECK (badge_status IN ('A', 'I')),
   CONSTRAINT pk_Badges PRIMARY KEY (badge_nbr));

●リスト2-24 サンプルデータ
-- 二つの入館証がActive
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (1, 1, '2024-11-14', 'A');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (2, 1, '2024-10-14', 'I');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (3, 1, '2024-09-14', 'A');

-- 最新ではない入館証がActive
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (4, 2, '2024-12-07', 'A');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (5, 2, '2024-12-08', 'I');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (6, 2, '2024-05-20', 'I');

-- すべての入館証がInactive
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (7, 3, '2024-04-07', 'I');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (8, 3, '2024-05-19', 'I');
INSERT INTO Badges(badge_nbr, emp_id, issued_date, badge_status) VALUES (9, 3, '2024-06-01', 'I');


●リスト2-25 二つ以上のバッジが有効な社員（HAVING句）
SELECT emp_id
  FROM Badges
 WHERE badge_status = 'A'
 GROUP BY emp_id
HAVING COUNT(*) >= 2;


●リスト2-26 二つ以上のバッジが有効な社員（ウィンドウ関数）
SELECT emp_id, issued_date, badge_status
  FROM (SELECT emp_id, issued_date, badge_status,
               COUNT(*) OVER (PARTITION BY emp_id) AS cnt
          FROM Badges
         WHERE badge_status = 'A') TMP
 WHERE cnt >= 2;


●リスト2-27 不正なデータのクレンジング（全レコード初期化）
UPDATE Badges
   SET badge_status = CASE WHEN  issued_date = 
                                   (SELECT MAX(issued_date)
                                      FROM Badges B1
                                     WHERE Badges.emp_id = B1.emp_id)
                           THEN 'A'
                           ELSE 'I' END;

●リスト2-28 不正なデータのクレンジング（不正レコードだけ初期化）
UPDATE Badges
   SET badge_status = CASE WHEN  issued_date = 
                                   (SELECT MAX(issued_date)
                                      FROM Badges B1
                                     WHERE Badges.emp_id = B1.emp_id)
                           THEN 'A'
                           ELSE 'I' END
 WHERE 2 <=  (SELECT COUNT(badge_status)
                FROM Badges B2
               WHERE badge_status = 'A'
                 AND Badges.emp_id = B2.emp_id
               GROUP BY emp_id);
