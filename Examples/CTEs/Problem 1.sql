/*
Problem Statement
Identify companies with the most diverse (unique) job titles. Use a CTE to count the number of unique job titles per company, 
then select companies with the highest diversity in job titles.

Hint
Use a CTE to count the distinct number of job titles for each company.
After identifying the number of unique job titles per company, join this result with the company_dim table to get the 
company names.
Order your final results by the number of unique job titles in descending order to highlight the companies with the highest 
diversity.
Limit your results to the top 10 companies. This limit helps focus on the companies with the most significant diversity in 
job roles. 
Think about how SQL determines which companies make it into the top 10 when there are ties in the number of unique job titles.
*/

WITH distinct_job_count AS(
    SELECT
        company_id,
        COUNT(DISTINCT job_title) job_count
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
) 

SELECT 
    name as company_name,
    job_count
FROM 
    company_dim AS company_info
INNER JOIN 
    distinct_job_count ON distinct_job_count.company_id = company_info.company_id
ORDER BY
    job_count DESC
LIMIT 10