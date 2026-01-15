-- Date Function Practice

-- Practice 1
-- Write a query to find the average salary both yearly ( salary_year_avg )and hourly
-- ( salary_hour_avg ) for job postings that were posted after June 1, 2023. 
-- Group the results by job schedule type.
SELECT 
    job_schedule_type AS schedule_type,
    AVG(salary_year_avg) AS avg_year_salary,
    AVG(salary_hour_avg) AS avg_hour_salary
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE > '2023-06-01'
GROUP BY
    schedule_type;

-- Practice 2
-- Write a query to count the number of job postings for each month in 2023, adjusting the
-- job_posted_date to be in 'America/New_York' time zone before extracting (hint) the month.
-- Assume the job_posted_date is stored in UTC. Group by and order by the month.
SELECT
    COUNT(job_id) AS job_count_2023,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS post_month
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    post_month
ORDER BY
    post_month;

-- Practice 3
-- Write a query to find companies (include company name) that have posted jobs offering health
-- insurance, where these postings were made in the second quarter of 2023. Use date extraction
-- to filter by quarter.
SELECT
    cd.name as company_name,
    COUNT(jpf.job_id) AS health_insurance_jobs
FROM
    job_postings_fact as jpf
JOIN
    company_dim as cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_health_insurance = TRUE
    AND EXTRACT(YEAR FROM jpf.job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM jpf.job_posted_date) = 2
GROUP BY
    company_name
ORDER BY
health_insurance_jobs DESC
LIMIT 10;