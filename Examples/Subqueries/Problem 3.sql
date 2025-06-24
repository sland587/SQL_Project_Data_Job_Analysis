/*
Problem Statement
Find companies that offer an average salary above the overall average yearly salary of all job postings. Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).

Hint
Start by separating the task into two main steps:
Calculating the overall average salary
Identifying companies with higher averages.
Use a subquery (subquery 1) to find the average yearly salary across all job postings. Then join this subquery onto the company_dim table.
Use another subquery (subquery 2) to establish the overall average salary, which will help in filtering in the WHERE clause companies with higher average salaries.
Determine each company's average salary (what you got from subquery 1) and compare it to the overall average you calculated (subquery 2). Focus on companies that greater than this average.
*/

SELECT 
    company_info.name as company_name
FROM 
    company_dim as company_info
JOIN 
    (
        SELECT 
            company_id,
            AVG(salary_year_avg) AS average_annual_salary
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
        GROUP BY
            company_id
    ) AS company_avg_salary ON company_avg_salary.company_id = company_info.company_id
WHERE
    company_avg_salary.average_annual_salary > 
    (
        SELECT -- Subquery 2: Calculating the overall average salary
            AVG(salary_year_avg) AS average_salary
        FROM 
            job_postings_fact
    )



