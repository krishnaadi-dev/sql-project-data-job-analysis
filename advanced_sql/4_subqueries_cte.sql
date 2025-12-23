-- Subquery to filter job postings made in January
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE (EXTRACT(MONTH FROM job_posted_date) = 1)
) AS january_jobs;

-- Common Table Expression (CTE) to filter job postings made in January
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;

-- example of Subquery
-- Find companies that have job postings mentioning no degree required  
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
);

-- example of CTE
WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) as total_job
FROM job_postings_fact
GROUP BY
    company_id
)
SELECT
    cd.name AS company_name,
    cjc.total_job
FROM
    company_dim AS cd
LEFT JOIN company_job_count AS cjc
    ON cd.company_id = cjc.company_id  
ORDER BY
    cjc.total_job DESC;
