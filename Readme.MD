# read Json data
```
SELECT COUNT(*) AS count, SUBSTRING_INDEX(JSON_UNQUOTE(JSON_EXTRACT(column_name, '$[0].name')), '.', -1) AS extension
FROM table_name
WHERE JSON_UNQUOTE(JSON_EXTRACT(column_name, '$[0].name')) LIKE '%.zip'
GROUP BY extension;
```
