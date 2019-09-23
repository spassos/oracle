select nvl(username,'ORACLE SHADOW PROCESS'),
machine from
v$session where username is null
and rownum < 2
/