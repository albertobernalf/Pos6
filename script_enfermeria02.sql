SELECT * FROM CLINICO_HISTORIALNOTASENFERMERIA;

SELECT * FROM CLINICO_historia order by id

select * from farmacia_farmaciadespachos;
select * from farmacia_farmaciadespachosdispensa;
select * from sitios_serviciosadministrativos;

select desp.id despacho,serv1.nombre servEntrega , serv2.nombre servRecibe, pla1.nombre Entrega , pla2.nombre Recibe ,* 
FROM farmacia_farmaciadespachos desp
INNER JOIN farmacia_farmaciadespachosdispensa disp ON (disp.despacho_id = desp.id)
LEFT JOIN sitios_serviciosadministrativos serv1 ON (serv1.id = desp."serviciosAdministrativosEntrega_id") 
LEFT JOIN sitios_serviciosadministrativos serv2 ON (serv2.id = desp."serviciosAdministrativosRecibe_id")
LEFT JOIN planta_planta pla1 ON (pla1.id = desp."usuarioEntrega_id")
LEFT JOIN planta_planta pla2 ON (pla2.id = desp."usuarioRecibe_id")
WHERE desp."fechaRegistro" >= '2025-01-01'
