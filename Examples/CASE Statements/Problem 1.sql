/*
Problem Statement
From the job_postings_fact table, categorize the salaries from job postings that are data analyst jobs, and that have yearly salary information. Put salary into 3 different categories:

If the salary_year_avg is greater than or equal to $100,000, then return ‘high salary’.
If the salary_year_avg is greater than or equal to $60,000 but less than $100,000, then return ‘Standard salary.’
If the salary_year_avg is below $60,000 return ‘Low salary’.
Also, order from the highest to the lowest salaries.

Hint
In SELECT retrieve these columns: job_id, job_title, salary_year_avg, and a new column for the salary category.

CASE Statement: Use to categorize salary_year_avg into 'High salary', 'Standard salary', or 'Low salary'.
If the salary is over $100,000, it's a High salary.
For salaries greater than or equal to $60,000,  assign Standard salary.
Any salary below $60,000 should be marked as Low salary.
FROM the job_postings_fact table.
WHERE statement:
Exclude records without a specified salary_year_avg.
Focus on job_title_short that exactly matches 'Data Analyst'.
Use ORDER BY to sort by salary_year_avg in descending order to start with the highest salaries first.
*/

Select 
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg >= 60000 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END as salary_category 
FROM 
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC