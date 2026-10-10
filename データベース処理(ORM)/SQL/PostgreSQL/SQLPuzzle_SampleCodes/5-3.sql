●リスト5-8 NTILE関数を用いた四分位
SELECT time_id,
       response_time,
       NTILE(4) OVER (ORDER BY response_time) AS tile
  FROM ResponseTimes
 ORDER BY tile;


●リスト5-9 4で割った余りで分類
SELECT time_id,
       response_time,
       MOD(time_id, 4) modulo
  FROM ResponseTimes
 ORDER BY time_id;


●リスト5-10 4を法とする剰余類（SQL Server）
SELECT time_id,
       response_time,
       time_id % 4 AS modulo
  FROM ResponseTimes
 ORDER BY time_id;
