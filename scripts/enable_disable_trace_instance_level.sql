-- habilitar trace na instância
alter system set events '10046 trace name context forever,level 8';
-- desabilitar trace na instância
alter system set events '10046 trace name context off';