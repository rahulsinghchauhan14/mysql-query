

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


-- Another query
with recursive cte as
		(
      select p.id, p.title, p.groups, p.levels, p.payscale, '' as employee_name, p.totalpost 
		    from job_positions p 
		    union all
		      select id, title, groups, levels, payscale, '' as employee_name, (totalpost - 1) as totalpost
		        from cte 
		            where totalpost > 1
    )
	  select title, groups, levels, payscale, coalesce(e.name,'Vacant') as employee_name
	  from cte
	  left join (
                select *, row_number() over(partition by position_id order by id) as rn 
			          from job_employees
              ) e on e.rn=cte.totalpost and e.position_id = cte.id
	  order by groups,totalpost;
