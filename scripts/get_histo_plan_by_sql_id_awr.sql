SET PAGESIZE 60
SET LINESIZE 300
SELECT * FROM TABLE(dbms_xplan.display_awr('&SQL_ID'))
/