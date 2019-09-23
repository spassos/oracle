set linesize 1000
column sid format 999
column username format a15 wrapped
column spid format a8
column event format a30 wrapped
column osuser format a12 wrapped
column machine format a25 wrapped
column program format a30 wrapped
select sw.sid sid
, p.spid spid
, s.username username
, s.osuser osuser
, sw.event event
, s.machine machine
, s.program program
from v$session_wait sw
, v$session s
, v$process p
where s.paddr = p.addr
and event not in ('pipe get','client message')
and sw.sid = s.sid
/