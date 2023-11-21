

WITH RECURSIVE Series AS ( 
  SELECT 1 AS series_number 
    UNION ALL 
      SELECT series_number + 1 FROM Series WHERE series_number < (SELECT MAX(totalpost) FROM job_positions) 
) 
SELECT p.*, s.series_number FROM job_positions p JOIN Series s ON s.series_number <= p.totalpost;


output:

| id | title              | groups | levels | payscale | totalpost | series_number |
|----|--------------------|--------|--------|----------|-----------|---------------|
| 1  | General manager    | A      | l-15   | 10000    | 1         | 1             |
| 2  | Manager            | B      | l-14   | 9000     | 5         | 1             |
| 2  | Manager            | B      | l-14   | 9000     | 5         | 2             |
| 2  | Manager            | B      | l-14   | 9000     | 5         | 3             |
| 2  | Manager            | B      | l-14   | 9000     | 5         | 4             |
| 2  | Manager            | B      | l-14   | 9000     | 5         | 5             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 1             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 2             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 3             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 4             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 5             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 6             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 7             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 8             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 9             |
| 3  | Asst. Manager      | C      | l-13   | 8000     | 10        | 10            |


//-- In latest mysql version you can use generate_series funciton 


select p.*, generate_series
FROM job_positions p 
cross join generate_series(1,p.totalpost);
