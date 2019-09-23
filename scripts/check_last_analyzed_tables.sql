set lin 1000
set verify off
col owner format a15
col object_name format a25
col object_type format a12
col "LAST ANALYZED" format a13

 

select do.OWNER,do.OBJECT_NAME,OBJECT_TYPE,
decode (OBJECT_TYPE,'TABLE'  , (Select LAST_ANALYZED from dba_tables where owner=do.owner and TABLE_NAME=do.object_name)  ,'INDEX'  , (Select LAST_ANALYZED from dba_indexes where owner=do.owner and INDEX_NAME=do.object_name) ,'UNKNOWN') "LAST ANALYZED",STATUS
from   DBA_OBJECTS do
where  OBJECT_TYPE in ('TABLE','INDEX')
and    (OWNER,OBJECT_NAME) in (select OBJECT_OWNER,OBJECT_NAME from V$SQL_PLAN where HASH_VALUE=&1)
/