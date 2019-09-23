SET HEADING ON
SET LINESIZE 300
SET PAGESIZE 60
COLUMN owner FORMAT A20
COLUMN next_run_date FORMAT A35
SELECT owner,
job_name,
enabled,
job_class,
next_run_date
FROM dba_scheduler_jobs
ORDER BY owner, job_name
/