-- Date and Time Functions in SQL
-- With ::DATE, we can cast a timestamp to a date, removing the time component.
-- This is useful when we want to focus only on the date part of a timestamp.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date 
FROM 
    job_postings_fact;
LIMIT 10;

-- AT TIME ZONE 'zone' allows us to convert a timestamp to a different time zone.
-- If the data doesnt have timezone information, we can first assign it a timezone and then convert it.
-- as example, assigning to it's real time zone first, as in this example as UTC (AT TIME ZONE 'UTC') the convert to EST (AT TIME ZONE 'EST').
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time 
FROM 
    job_postings_fact
LIMIT 10;

-- EXTRACT(part FROM date) allows us to pull out specific parts of a date or timestamp, such as year, month, day, etc.
-- Here, we extract the month and year from the job_posted_date.
-- these can be useful for grouping or filtering data based on specific time components.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 10;

-- Example query using EXTRACT to count the number of job postings per month for 'Data Analyst' positions.
SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_count DESC;


