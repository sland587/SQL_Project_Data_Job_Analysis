SELECT 
  job_title_short as title,
  job_location as location,
  job_posted_date,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as coverted_date,
  EXTRACT(MONTH FROM job_posted_date) AS date_month,
  EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 5