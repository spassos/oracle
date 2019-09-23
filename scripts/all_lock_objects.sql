set term on;
set lines 130;
column sid_ser format a12 heading 'session,|serial#';
column username format a12 heading 'os user/|db user';
column process format a9 heading 'os|process';
column spid format a7 heading 'trace|number';
column owner_object format a35 heading 'owner.object';
column locked_mode format a13 heading 'locked|mode';
column status format a8 heading 'status';
select
substr(to_char(l.session_id)||','||to_char(s.serial#),1,12) sid_ser,
substr(l.os_user_name||'/'||l.oracle_username,1,12) username,
l.process,
p.spid,
substr(o.owner||'.'||o.object_name,1,35) owner_object,
decode(l.locked_mode,
1,'No Lock',
2,'Row Share',
3,'Row Exclusive',
4,'Share',
5,'Share Row Excl',
6,'Exclusive',null) locked_mode,
substr(s.status,1,8) status
from
v$locked_object l,
all_objects o,
v$session s,
v$process p
where
l.object_id = o.object_id
and l.session_id = s.sid
and s.paddr = p.addr
and s.status != 'KILLED'
/