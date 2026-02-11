-- Practice 1
-- Get the corresponding skill and skill type for each job posting in Q1
-- Includes those without any skills, too
-- Why? Look at the skills and the type for each job in the first quarter that has a salary >$70,000

WITH q1_jobs AS (
    SELECT job_id, salary_year_avg FROM january_jobs
    UNION ALL
    SELECT job_id, salary_year_avg FROM february_jobs
    UNION ALL
    SELECT job_id, salary_year_avg FROM march_jobs
)
SELECT 
    q1.job_id,
    q1.salary_year_avg,
    sd.skills AS skill_name,
    sd.type AS skill_type
FROM 
    q1_jobs AS q1
LEFT JOIN skills_job_dim AS sjd 
    ON q1.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    q1.salary_year_avg > 70000
ORDER BY 
    q1.job_id;