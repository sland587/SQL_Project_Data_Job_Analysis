/*
Problem Statement
Retrieve the job id, job title short, job location, job via, skill and skill type for each job posting from the first quarter 
(January to March). Using a subquery to combine job postings from the first quarter (these tables were created in the Advanced 
Section - Practice Problem 6 [include timestamp of Youtube video]) Only include postings with an average yearly salary greater 
than $70,000.

Hint
Use UNION ALL to combine job postings from January, February, and March into a single dataset.
Apply a LEFT JOIN to include skills information, allowing for job postings without associated skills to be included.
Filter the results to only include job postings with an average yearly salary above $70,000.
*/
SELECT 
    quarter_1_jobs.job_id,
    quarter_1_jobs.job_title_short,
    quarter_1_jobs.job_location,
    quarter_1_jobs.job_via,
    skills as skill,
    type AS skill_type
FROM
    (
        SELECT 
            *
        FROM 
            january_jobs

        UNION ALL

        SELECT
            *
        FROM 
            february_jobs

        UNION ALL

        SELECT
            *
        FROM 
            march_jobs
    ) AS quarter_1_jobs
LEFT JOIN 
    skills_job_dim ON skills_job_dim.job_id = quarter_1_jobs.job_id
LEFT JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE   
    quarter_1_jobs.salary_year_avg > 70000
ORDER BY
    quarter_1_jobs.job_id