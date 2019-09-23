set linesize 1000
column waiting_session heading ‘WAITING|SESSION’
column holding_session heading ‘HOLDING|SESSION’
column lock_type format a15
column mode_held format a15
column mode_requested format a15select
waiting_session,
holding_session,
lock_type,
mode_held,
mode_requested,
lock_id1,
lock_id2
from
dba_waiters
/