/*
Scenario:
    Find the companies that have the most job openings.
    - Get the total number of job postings per company id (job_posting_fact)
    - Return the total number of jobs with the company name (company_dim)
*/


With company_job_count AS (
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)


SELECT 
    name as company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN 
    company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY 
    company_job_count.total_jobs DESC