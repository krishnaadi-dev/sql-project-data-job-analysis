-- Practice Problem 1
-- I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
-- · Put salary into different buckets
-- . Define what's a high, standard, or low salary with our own conditions
-- . Why? It is easy to determine which job postings are worth looking at based on salary.
--      Bucketing is a common practice in data analysis when viewing categories.
-- . I only want to look at data analyst roles
-- . Order from highest to lowest

SELECT
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;