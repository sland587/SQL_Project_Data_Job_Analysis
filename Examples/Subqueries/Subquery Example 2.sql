
/*
Query used for subquery in query below
SELECT
    job_postings_fact.company_id
FROM 
    job_postings_fact
WHERE
    job_postings_fact.job_no_degree_mention = TRUE
*/

SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE 
    company_dim.company_id IN (
        SELECT
            job_postings_fact.company_id
        FROM 
            job_postings_fact
        WHERE
            job_postings_fact.job_no_degree_mention = TRUE
        ORDER BY company_id
    )

