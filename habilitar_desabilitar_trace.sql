-- habilitar trace na instância
alter system set events '10046 trace name context forever,level 12';
-- desabilitar trace na instância
alter system set events '10046 trace name context off';