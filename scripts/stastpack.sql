/* Habilitando o Statspack no Oracle
 *  1 - Criar a tablespace statspack, onde o <path_of_oradata> � o caminho dos 
 *	datafiles da inst�ncia alvo.
 */
create tablespace statspack datafile '<path_of_oradata>/statspack01.dbf' size 100m autoextend on next 100m maxsize 5000m;
/* 2 - Executar o scripts spcreate.sql localizado em $ORACLE_HOME/rdbms/admin logado com o sysdba
 *	 	a) 	Durante a execu��o do script ser� pedido a senha para o usu�rio perfstat, � obrigat�rio a defini��o 
 *	   	  	da senha.
 *		b) 	Ap�s a defini��o da senha, ser� solicitada a default tablespace, selecionar o tablespace 'stastpack', 
 *			criada no passo anterior.
 *		c)	Por fim informar a tablespace tempor�ria a ser utilizada. ser� utilizada a tablespace padr�o TEMP.
 */
SQL> @?/rdbms/admin/spcreate.sql
/* 3 - Para gerar um relat�rio do ambiente, assim como no AWR, precisamos gerar snapshots da base. O Snapshot pode
 *		pode ser gerado manualmente ou automaticamente.
 *		a) 	Para a coleta autom�tica, rodar o script spauto.sql localizado em $ORACLE_HOME/rdbms/admin e 
 *			logado com o usu�rio sysdba
 */
SQL> @?/rdbms/admin/spauto.sql
/*		b) 	Para a coleta manual, utilizamos o comando abaixo:*/
SQL> EXEC STATSPACK.snap
/* 4 - Ao utilizar o processo automatizado de gera��o de snapshots, se atentar e realizar uma limpeza periodica dos
 *		mesmos. Para realizar a limpeza, utilizamos o script sppurge.sql
 */
SQL> select SNAP_ID, SNAP_TIME from STATS$SNAPSHOT order by 2;
SQL> @$ORACLE_HOME/rdbms/admin/sppurge.sql
/* Afim de reduzir a necessidade de interven��o manual no processo de gerenciamento dos snapshots, estarei 
 * criando uma procedure chamada statspackpurge para limpeza dos snapshots, com uma reten��o de 7 dias, 
 * por�m esse valor pode ser alterado de acordo com a necessidade do ambiente.
 */
SQL> create or replace procedure statspackpurge is
var_lo_snap number;
var_hi_snap number;
var_db_id number;
var_instance_no number;
noofsnapshot number;
n_count number ;
begin
 
n_count := 0;
 
select count(*) into n_count from stats$snapshot where snap_time < sysdate-7; 
if n_count > 0 then
 
select min(s.snap_id) , max(s.snap_id),max(di.dbid),max(di.instance_number) into var_lo_snap, var_hi_snap,var_db_id,var_instance_no
 from stats$snapshot s
 , stats$database_instance di
 where s.dbid = di.dbid
 and s.instance_number = di.instance_number
 and di.startup_time = s.startup_time
 and s.snap_time < sysdate-7; 
 noofsnapshot := statspack.purge( i_begin_snap => var_lo_snap
 , i_end_snap => var_hi_snap
 , i_snap_range => true
 , i_extended_purge => false
 , i_dbid => var_db_id
 , i_instance_number => var_instance_no);
 
 dbms_output.Put_line('snapshot deleted'||to_char(noofsnapshot));
 
end if;
end;
/
/* Ap�s criada a procedure, estarei criando um job que executara o processo de limpeza diariamente.*/
SQL> declare
  my_job number;
begin
  dbms_job.submit(job => my_job,
    what => 'statspackpurge;',
    next_date => trunc(sysdate)+1,
    interval => 'trunc(sysdate)+1');
end;
/* Consultar os snapshots existentes */
select SNAP_ID, SNAP_TIME from STATS$SNAPSHOT;
/* Gerar relat�rio de an�lise do ambiente */
SQL> @?/rdbms/admin/spreport.sql
/* Remover o stastpack da inst�ncia */
SQL> @?/rdbms/admin/spdrop.sql