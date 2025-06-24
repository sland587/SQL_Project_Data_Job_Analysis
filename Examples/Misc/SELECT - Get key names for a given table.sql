SELECT
    con.constraint_name,
    con.constraint_type,
    con.table_name,
    col.column_name
FROM
    information_schema.table_constraints con
JOIN
    information_schema.key_column_usage col
    ON con.constraint_name = col.constraint_name
    AND con.table_schema = col.table_schema
WHERE
    con.table_name = 'skills_job_dim'  -- 🔁 Replace with your actual table name
    AND con.table_schema = 'public';    -- 🔁 Adjust if using a different schema
