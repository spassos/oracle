SET HEADING ON
SET LINESIZE 300
SET PAGESIZE 60COLUMN owner FORMAT A20
SELECT owner,
job_name,
running_instance,
elapsed_time
FROM dba_scheduler_running_jobs
ORDER BY owner, job_name
/