/*
Problem Statement
Explore job postings by listing job id, job titles, company names, and their average salary rates, 
while categorizing these salaries relative to the average in their respective countries. 
Include the month of the job posted date. Use CTEs, conditional logic, and date functions, to compare individual salaries 
with national averages.

Hint
Define a CTE to calculate the average salary for each country. This will serve as a foundational dataset for comparison.
Within the main query, use a CASE WHEN statement to categorize each salary as 'Above Average' or 'Below Average' 
based on its comparison (>) to the country's average salary calculated in the CTE.
To include the month of the job posting, use the EXTRACT function on the job posting date within your SELECT statement.
Join the job postings data (job_postings_fact) with the CTE to compare individual salaries to the average. 
Additionally, join with the company dimension (company_dim) table to get company names linked to each job posting.
*/

WITH country_avg_salary AS (
SELECT
    job_postings.job_country AS country,
    AVG(job_postings.salary_year_avg) as annual_avg_salary
FROM job_postings_fact AS job_postings
GROUP BY
    job_postings.job_country
)

SELECT 
    job_id,
    job_title,
    company_info.name AS company_name,
    salary_year_avg AS job_salary_average,
    CASE
        WHEN salary_year_avg >  country_avg_salary.annual_avg_salary THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category,
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS month
FROM 
    job_postings_fact AS job_postings
INNER JOIN 
    company_dim AS company_info on company_info.company_id = job_postings.company_id
INNER JOIN 
    country_avg_salary ON country_avg_salary.country = job_postings.job_country

ORDER BY 
    month DESC