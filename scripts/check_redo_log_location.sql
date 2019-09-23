col Grp format 9999
col member format a50 heading "Online REDO Logs"
col File# format 9999
col name format a50 heading "Online REDO Logs"
break on Grp
select group#,member
from sys.v_$logfile
/