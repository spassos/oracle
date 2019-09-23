SELECT segment_name, segment_type
FROM dba_extents
WHERE file_id = < file> AND
<block> BETWEEN block_id and block_id + blocks - 1;