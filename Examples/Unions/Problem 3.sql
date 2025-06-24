/*
Problem Statement
Analyze the monthly demand for skills by counting the number of job postings for each skill in the first quarter 
(January to March), utilizing data from separate tables for each month. 
Ensure to include skills from all job postings across these months. 
The tables for the first quarter job postings were created in Practice Problem 6.

Hint
Use UNION ALL to combine job postings from January, February, and March into a consolidated dataset.
Apply the EXTRACT function to obtain the year and month from job posting dates, even though the month will be implicitly 
known from the source table.
Group the combined results by skill to summarize the total postings for each skill across the first quarter.
Join with the skills dimension table to match skill IDs with skill names.
*/
SELECT
    skills_dim.skills AS skill,
    EXTRACT(MONTH FROM job_posted_date) as job_posting_month,
    EXTRACT(YEAR FROM job_posted_date) as job_posting_year,
    COUNT(quarter_1_jobs.job_id)
FROM
    (
        SELECT 
            job_id, job_posted_date
        FROM 
            january_jobs

        UNION ALL

        SELECT
            job_id, job_posted_date
        FROM 
            february_jobs

        UNION ALL

        SELECT
            job_id, job_posted_date
        FROM 
            march_jobs
    ) AS quarter_1_jobs
INNER JOIN 
    skills_job_dim ON skills_job_dim.job_id = quarter_1_jobs.job_id
INNER JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skill, job_posting_month, job_posting_year
ORDER BY skill