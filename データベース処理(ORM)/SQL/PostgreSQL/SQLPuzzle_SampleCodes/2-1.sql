●リスト2-1 プロジェクトテーブル
CREATE TABLE Projects
(project_id CHAR(5) NOT NULL,
 work_nbr INTEGER NOT NULL
     CHECK (work_nbr BETWEEN 0 AND 1000),
 work_status CHAR(1) NOT NULL
     CHECK (work_status IN ('C', 'W')), -- Cは完了、Wは待機
  CONSTRAINT pk_Projects PRIMARY KEY (project_id, work_nbr));


INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P001', 0, 'C');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P001', 1, 'W');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P001', 2, 'W');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P002', 0, 'W');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P002', 1, 'W');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P002', 2, 'W');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P003', 0, 'C');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P003', 1, 'C');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P003', 2, 'C');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P004', 0, 'C');
INSERT INTO Projects (project_id, work_nbr, work_status) VALUES('P004', 1, 'W');


●リスト2-2 HAVING句を使った特性関数
SELECT project_id
  FROM Projects
 GROUP BY project_id
HAVING SUM(CASE WHEN work_nbr <> 0 AND work_status = 'W' THEN 1
                WHEN work_nbr = 0  AND work_status = 'C' THEN 1
                ELSE 0 END) = COUNT(*);


●リスト2-3 ウィンドウ関数を使った特性関数
SELECT DISTINCT project_id
  FROM (SELECT project_id,
               SUM(CASE WHEN work_nbr <> 0 AND work_status = 'W' THEN 1
                        WHEN work_nbr = 0  AND work_status = 'C' THEN 1
                        ELSE 0 END) OVER (PARTITION BY project_id) AS status_flag,
               COUNT(*) OVER (PARTITION BY project_id) AS cnt
          FROM Projects) TMP
 WHERE status_flag = cnt;


●リスト2-4 ALL演算子による解
SELECT project_id
  FROM Projects P1
 WHERE work_nbr = 0
   AND work_status = 'C'
   AND 'W' = ALL (SELECT work_status
                    FROM Projects P2
                   WHERE work_nbr <> 0
                     AND P1.project_id = P2.project_id);
