col sid format 999999
col spid format a6
col tablespace format a10
col username format a25
col noexts format 9999 head EXTS
col proginfo format a25 trunc
col mbused format 999,999.90
col status format a1 trunc
set verify off
select * from (
select s.sid,
s.status,
b.spid,
s.sql_hash_value sesshash,
u.SQLHASH sorthash,
s.username,
u.tablespace,
sum(u.blocks*p.value/1024/1024) mbused ,
sum(u.extents) noexts,
u.segtype,
s.module || ' - ' || s.program proginfo
from v$sort_usage u, v$session s, v$parameter p, v$process b
where u.session_addr = s.saddr
and p.name = 'db_block_size'
and b.addr = s.paddr
group by s.sid,s.status,b.spid,s.sql_hash_value,u.sqlhash,s.username,u.tablespace,
u.segtype,
s.module || ' - ' || s.program
order by 8 desc,4)
where rownum < 11;