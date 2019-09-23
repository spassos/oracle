set linesize 128 pages 1000
col owner format a15
col db_link format a15
col username format a20
col host format a15
col name format a30
Prompt Database Links:
select owner, db_link, username, host from dba_db_links order by owner,db_link,username
/
Prompt Synonym Links:
select distinct owner, db_link from dba_synonyms where db_link is not null
/
Prompt Snapshot Links:
select owner, name, replace(master_link,'@','') db_link from dba_snapshots
where master_link is not null
/