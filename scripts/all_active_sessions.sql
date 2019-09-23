select username,osuser,sid,serial#, program,sql_hash_value,module from v$session where username is not null
and status ='ACTIVE' and module is not null;