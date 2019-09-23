col Tspace format a25
col status format a3 heading Sta
col Id format 9999
col Mbyte format 999999999
col name format a50 heading "Database Data Files"
col Reads format 99,999,999
col Writes format 99,999,999

break on report
compute sum label 'Total(MB)' of Mbyte on report

select F.file_id Id,
F.file_name name,
F.bytes/(1024*1024) Mbyte,
decode(F.status,'AVAILABLE','OK',F.status) status,
F.tablespace_name Tspace
from sys.dba_data_files F
order by tablespace_name;