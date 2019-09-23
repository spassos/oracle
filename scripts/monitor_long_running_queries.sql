set linesize 1000
select
OPNAME,
sid,SOFAR/TOTALWORK*100,
to_char(start_time,'dd-mon-yy hh:mi') started,
elapsed_seconds/60,time_remaining/60
from
v$session_longops
where
sid =&sid