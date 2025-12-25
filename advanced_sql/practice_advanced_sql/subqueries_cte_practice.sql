-- Practice 1
-- Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to
-- find the skill IDs with the highest counts in the skills_job_dim table and then join this result
-- with the skills_dim table to get the skill names.
SELECT
    sd.skills AS skill_name
FROM
    skills_dim AS sd
JOIN (
    SELECT
        skill_id
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        COUNT(job_id) DESC
    LIMIT 5
) AS top_skills
    ON sd.skill_id = top_skills.skill_id;

-- Practice 2
-- Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying
-- the number of job postings they have. Use a subquery to calculate the total job postings per
-- company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the
-- number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings.
-- Implement a subquery to aggregate job counts per company before classifying them based on size.

SELECT
    cd.name AS company_name,
    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category
FROM
    company_dim AS cd
JOIN (
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM
        job_postings_fact     
    GROUP BY
        company_id
) AS job_counts
    ON cd.company_id = job_counts.company_id
ORDER BY
    company_size_category DESC;         
