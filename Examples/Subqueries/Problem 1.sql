/*
Problem Statement
Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.

Hint
Focus on creating a subquery that identifies and ranks (ORDER BY in descending order) the top 5 skill IDs by their frequency (COUNT) of mention in job postings.
Then join this subquery with the skills table (skills_dim) to match IDs to skill names.
*/


SELECT
    skills.skills AS skill_name
FROM 
    skills_dim skills
INNER JOIN 
(
    SELECT  -- Subquery to find the skill IDs with the highest counts
        skills_to_job.skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    GROUP BY 
        skills_to_job.skill_id
    ORDER BY 
        COUNT(*) DESC
    LIMIT 5
) AS skills_count ON skills_count.skill_id = skills.skill_id
ORDER BY 
    skills_count.skill_count DESC
