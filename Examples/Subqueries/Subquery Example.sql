Select *
FROM ( -- SubQuery starts here
    SELECT * 
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_postings_fact.job_posted_date) = 1

) AS january_jobs;
-- SubQuery ends here