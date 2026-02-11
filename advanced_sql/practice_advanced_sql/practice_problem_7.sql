/*
Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_skill_counts AS (
    SELECT
        sjd.skill_id,
        COUNT(*) AS remote_job_count
    FROM
        skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS jpf
        ON sjd.job_id = jpf.job_id
    WHERE
        jpf.job_work_from_home = true
    GROUP BY
        sjd.skill_id)
SELECT
    sd.skill_id,
    sd.skills AS skill_name,
    rsc.remote_job_count
FROM
    remote_skill_counts AS rsc
INNER JOIN skills_dim AS sd
    ON rsc.skill_id = sd.skill_id
ORDER BY
    rsc.remote_job_count DESC
LIMIT 5;