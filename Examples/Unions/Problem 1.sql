/*
Problem Statement
Create a unified query that categorizes job postings into two groups: those with salary information 
(salary_year_avg or salary_hour_avg is not null) and those without it. 
Each job posting should be listed with its job_id, job_title, and an indicator of whether salary information is provided.

Hint
Use UNION ALL to merge results from two separate queries.
For the first query, filter job postings where either salary field is not null to identify postings with salary information.
For the second query, filter for postings where both salary fields are null to identify postings without salary information.
Include a custom field to indicate the presence or absence of salary information in the output.
When categorizing data, you can create a custom label directly in your query using string literals, such as 
'With Salary Info' or 'Without Salary Info'. These literals are manually inserted values that indicate specific characteristics 
of each record. An example of this is as a new column in the query that doesn’t have salary information, put: 'Without Salary 
Info' AS salary_info. As the last column in the SELECT statement.
*/

SELECT 
    job_id,
    job_title,
    TRUE AS salary_available
FROM 
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL OR salary_year_avg is NOT NULL
UNION ALL
SELECT 
    job_id,
    job_title,
    FALSE AS salary_available
FROM 
    job_postings_fact
WHERE
    salary_hour_avg IS NULL AND salary_year_avg is NULL