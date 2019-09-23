set linesize 9999
column QUERY format a999
set pages 250
set head off
set verify off
select id,lpad(' ',2*(depth-1)) || depth ||'.' || nvl(position,0) || ' '|| operation || ' '|| options || ' '|| object_name ||' '
||'cost= '|| to_char(cost)||' '|| optimizer "QUERY"
from v$sql_plan
where hash_value = &sql_hash_value
order by child_number,id
/