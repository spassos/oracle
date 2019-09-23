select substr(file_name,1,50), AUTOEXTENSIBLE from dba_data_files
(OR)
SQL> select tablespace_name,AUTOEXTENSIBLE from dba_data_files;