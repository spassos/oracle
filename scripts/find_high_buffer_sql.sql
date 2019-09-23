select * from (SELECT address, hash_value,
buffer_gets, executions, buffer_gets/executions "Gets/Exec",
sql_text
FROM v$sqlarea
WHERE buffer_gets > 500000 and executions>0
ORDER BY 3 desc) where rownum <20
;