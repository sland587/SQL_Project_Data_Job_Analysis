/*
Problem Statement
Calculate the number of unique skills required by each company. Aim to quantify the unique skills 
required per company and identify which of these companies offer the highest average salary for positions necessitating at 
least one skill. 
For entities without skill-related job postings, list it as a zero skill requirement and a null salary. 
Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.

Hint
Use two CTEs:
The first should focus on counting the unique skills required by each company.
The second CTE should aim to find the highest average salary offered by these companies.
Ensure the final output includes companies without skill-related job postings. This involves use of 
LEFT JOINs to maintain companies in the result set even if they don't match criteria in the subsequent CTEs.
After creating the CTEs, the main query joins the company dimension table with the results of both CTEs.
*/

WITH 
    required_skills_per_company AS (
        SELECT 
            companies.company_id,
            COUNT(DISTINCT skill_id)AS skill_count
        FROM 
            company_dim AS companies
        LEFT JOIN 
            job_postings_fact AS job_postings on job_postings.company_id = companies.company_id
        LEFT JOIN
            skills_job_dim AS skills_to_job ON skills_to_job.job_id = job_postings.job_id
        GROUP BY 
            companies.company_id
    ),
    max_company_avg_salary AS (
        SELECT 
            company_id,
            MAX(salary_year_avg) AS max_average_salary
        FROM 
            job_postings_fact AS job_postings
        WHERE 
            job_postings.job_id IN (
                Select job_id FORM FROM skills_job_dim)
        GROUP BY 
            company_id
    )


SELECT
    name AS company_name,
    required_skills_per_company.skill_count AS company_skill_count,
    max_company_avg_salary.max_average_salary
FROM  
    company_dim AS company_info
LEFT JOIN 
    required_skills_per_company ON required_skills_per_company.company_id = company_info.company_id
LEFT JOIN 
    max_company_avg_salary ON max_company_avg_salary.company_id = company_info.company_id
ORDER BY
    company_info.name