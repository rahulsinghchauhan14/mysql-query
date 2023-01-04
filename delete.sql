# delete duplicate data
```
DELETE FROM table_name WHERE col_name IN (SELECT col_name
  FROM (
    SELECT col_name, ROW_NUMBER() OVER (PARTITION BY col_name ORDER BY col_name) AS row_num
    FROM table_name
  ) t
  WHERE t.row_num > 1);
```
