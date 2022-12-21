/*
Enter your query below.
Please append a semicolon ";" at the end of the query
*/
-- month, monthly max, monthly min, monthly average for six months

with cte as(
    SELECT
        *,
        month(cast(record_date as date)) as "month"
    from temperature_records
),

avg_value as (
    SELECT
        month,
        avg(data_value) as "avg"
    from cte
    where data_type = 'avg'
    group by 1
),

min_max as (
    SELECT
        month,
        max(data_value) as "max",
        min(data_value) as "min"
    from cte
    group by 1
)

select
    m.month,
    m.max,
    m.min,
    round(a.avg, 0)
from min_max m
left join avg_value a on m.month = a.month

    