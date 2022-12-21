/*
Enter your query below.
Please append a semicolon ";" at the end of the query
*/
-- determine the number of hurs worked during weekends
-- hours work in a day, hours truncated to integer part
-- 1. get weekends from dates (dayofweek)
-- 2. find the start and end time of each employee at each day (weekend) (row_number)
-- 3. join to create a new column with start date and end date (inner join)
-- 4. subtract the 2 timestamp and retrieve the hour from timestamp (-, Hour)
-- 5. sum them together by aggregating by each employee (sum, group by)
-- 6. order by descending hours work (order by)

with cte as (
    select
        dayofweek(timestamp) as day_of_week,
        cast(timestamp as datetime) as "timestamp",
        date(timestamp) as "date",
        emp_id,
        row_number() over(partition by date(timestamp), emp_id order by timestamp asc) as timestamp_rank
    from attendance
    where dayofweek(timestamp) in (1, 7)
)

SELECT
    t1.emp_id,
    sum(timestampdiff(HOUR, t1.timestamp, t2.timestamp)) as total_hours
FROM
    (select * from cte where timestamp_rank = 1) t1
    left join (select * from cte where timestamp_rank = 2) t2 on t1.emp_id = t2.emp_id and t1.date = t2.date
group by 1
order by 2 desc

    
    
    

