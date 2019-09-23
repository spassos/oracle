col RBS format a15 trunc
col SID format 9999
col USER format a15 trunc
col COMMAND format a60 trunc
col status format a8 trunc
select r.name "RBS", s.sid, s.serial#, s.username "USER", t.status,
t.cr_get, t.phy_io, t.used_ublk, t.noundo,
substr(s.program, 1, 78) "COMMAND"
from v$session s, v$transaction t, v$rollname r
where t.addr = s.taddr
and t.xidusn = r.usn
order by t.cr_get, t.phy_io
/