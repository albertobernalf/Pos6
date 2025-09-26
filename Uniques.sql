select * from enfermeria_turnosenfermeria;

select nombre,count(*)
from clinico_examenes
group by nombre
order by count(*) desc

select nombre,count(*)
from facturacion_suministros
group by nombre
order by count(*) desc

	select nombre,count(*)
from facturacion_suministros
group by nombre
	having count(*) >1
order by count(*) desc
	

	select nombre,count(*)
from facturacion_suministros_20250926
group by nombre
order by count(*) desc
	

select * from facturacion_suministros where nombre = 'PASEDOL TABLETAS'
select * from facturacion_tipossuministro;

CREATE TABLE facturacion_suministros_20250926 AS SELECT * FROM facturacion_suministros
	
BEGIN TRANSACTION;
--delete from tarifarios_tarifariossuministros;
DELETE FROM facturacion_suministros;
-- ROLLBACk;
-- COMMIT;


select count(*) from facturacion_suministros -- 17021
select count(*) from facturacion_suministros_20250926; -- 17021

CREATE TABLE tarifarios_tarifariossuministros_20250926 AS SELECT * FROM tarifarios_tarifariossuministros
select count(*) from tarifarios_tarifariossuministros_20250926; -- 17021	

SELECT * FROM tarifarios_tarifariossuministros WHERE  "codigoCum_id" = 1366;
select count(*) from tarifarios_tarifariossuministros; --16399/1228

delete from tarifas_tarifassuministros
	delete from tarifas_liquidacionhonorarios
		delete from tarifas_liquidaciontarifashonorarios

delete from contratacion_conveniosliquidaciontarifashonorarios
select * from contratacion_conveniosliquidaciontarifashonorarios
CREATE TABLE contratacion_conveniosliquidaciontarifashonorarios_20250926 AS SELECT * FROM contratacion_conveniosliquidaciontarifashonorarios

	
BEGIN TRANSACTION;
delete FROM tarifarios_tarifariossuministros
WHERE  "codigoCum_id" in
		(select y.id from facturacion_suministros y
			where y.nombre = (select x.nombre from facturacion_suministros x where x.nombre=y.nombre  group by x.nombre  having count(*) > 1)
	
	) - 15171
 
-- ROLLBACk;
-- COMMIT;
select count(*) from tarifarios_tarifariossuministros;  -- 16399
insert into facturacion_suministros
select * from facturacion_suministros_20250926

select * from facturacion_suministros order by id; -- comienza en la 114 y termina en / 17630
													-- COMIENZA EN EL 17631 y termina en 34651
delete from facturacion_suministros;

INSERT INTO facturacion_suministros (nombre, "nombreGenerico", fraccion, "unidadFraccion", vence, control, antibiotico, pos, facturable, "stockMinimo", "stockMaximo", "maxOrdenar", estabilidad, "invFarmacia", "invAlmacen", enfermeria, terapia, nutricion, cantidad, cums, "regSanitario", "altoCosto", "vrCompra", "vrUltimaCompra", "codigoAtc", infusion, "tipoAdministracion", regulado, "vaorRegulado", observaciones, sispro, oncologico, ortesis, "epiHigiene", "controlStock", "AnatoPos", "magistralControl", "genericoPos", "fechaRegistro", "estadoReg", concentracion_id, concepto_id, grupo_id, "subGrupo_id", "tipoSuministro_id", "unidadMedida_id", "viaAdministracion_id", "principioActivo_id", "descripcionComercial", "fechaExpedicion", "fechaVencimiento", "registroSanitario", "ripsCums_id", "ripsDci_id", "ripsFormaFarmaceutica_id", "ripsTipoMedicamento_id", "ripsUnidadDispensa_id", "ripsUnidadMedida_id", "tipoHonorario_id", "cantidadUvr", "ripsUnidadUpr_id", "requiereAutorizacion"
)
SELECT nombre, "nombreGenerico", fraccion, "unidadFraccion", vence, control, antibiotico, pos, facturable, "stockMinimo", "stockMaximo", "maxOrdenar", estabilidad, "invFarmacia", "invAlmacen", enfermeria, terapia, nutricion, cantidad, cums, "regSanitario", "altoCosto", "vrCompra", "vrUltimaCompra", "codigoAtc", infusion, "tipoAdministracion", regulado, "vaorRegulado", observaciones, sispro, oncologico, ortesis, "epiHigiene", "controlStock", "AnatoPos", "magistralControl", "genericoPos", "fechaRegistro", "estadoReg", concentracion_id, concepto_id, grupo_id, "subGrupo_id", "tipoSuministro_id", "unidadMedida_id", "viaAdministracion_id", "principioActivo_id", "descripcionComercial", "fechaExpedicion", "fechaVencimiento", "registroSanitario", "ripsCums_id", "ripsDci_id", "ripsFormaFarmaceutica_id", "ripsTipoMedicamento_id", "ripsUnidadDispensa_id", "ripsUnidadMedida_id", "tipoHonorario_id", "cantidadUvr", "ripsUnidadUpr_id", "requiereAutorizacion"
FROM facturacion_suministros_20250926

select "codigoCum_id",* from tarifarios_tarifariossuministros_20250926;-- 
select * from facturacion_suministros where id= 613
select * from facturacion_suministros_20250926 where id= 613 --"MATERIAL DE SUTURA Y CURACIÓN,",
								-- "MATERIAL DE SUTURA Y CURACIÓN, AGENTES Y GASES ANESTÉSICOS, EN SALA DE PROCEDIMIENTOS ESPECIAL"
alter table tarifarios_tarifariossuministros_20250926 add column idNuevo integer

begin transaction;	
update tarifarios_tarifariossuministros_20250926
set idNuevo = (select b.id
				from facturacion_suministros_20250926 a, facturacion_suministros b
			    where a.nombre= b.nombre and a."descripcionComercial" = b."descripcionComercial" and
	                  a.cums = b.cums and a."nombreGenerico" = b."nombreGenerico"
					and cast(tarifarios_tarifariossuministros_20250926."codigoCum_id" as integer) = a.id
	
				)
select idNuevo,* from tarifarios_tarifariossuministros_20250926   where id = 16410
--commit
--rollback
select * from facturacion_suministros_20250926 where id=613
select * from facturacion_suministros where id=18258

begin transaction;
	insert into tarifarios_tarifariossuministros ( "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3", "colValor4", "colValor5", "colValor6", "colValor7", "colValor8", "colValor9", "colValor10", "fechaRegistro", "estadoReg", "codigoCum_id", concepto_id, "tiposTarifa_id", "usuarioRegistro_id", "serviciosAdministrativos_id"
	)
select
 "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3", "colValor4", "colValor5", "colValor6", "colValor7", "colValor8", "colValor9", "colValor10", "fechaRegistro", "estadoReg", IdNuevo, concepto_id, "tiposTarifa_id", "usuarioRegistro_id", "serviciosAdministrativos_id"
from tarifarios_tarifariossuministros_20250926
		 where idNuevo is not null; 
--commit
--rollback

select idNuevo,* from tarifarios_tarifariossuministros_20250926 where idNuevo is null; -- 16399
select count(*) from tarifarios_tarifariossuministros_20250926
select idNuevo,* from tarifarios_tarifariossuministros_20250926   where "codigoCum_id" = 613
select * from facturacion_suministros_20250926  where id=613
select "codigoCum_id",* from tarifarios_tarifariossuministros_20250926  where id=16410 -- where "codigoCum_id" = 613
select * from facturacion_suministros  where id=15310
	select * from facturacion_suministros_20250926  where id=15310
	select  * FROM facturacion_suministros where cums='19928325-1'

-- La llave (codigoCum_id)=(613) no está presente en la tabla «facturacion_suministros».

select * from contratacion_conveniosliquidaciontarifashonorarios;	
select * from contratacion_conveniosliquidaciontarifashonorarios_20250926;	

INSERT INTO contratacion_conveniosliquidaciontarifashonorarios ("codigoHomologado", descripcion, valor, "fechaRegistro", "estadoReg", suministro_id, "tipoHonorario_id", "tipoTarifa_id", "usuarioRegistro_id", concepto_id, convenio_id, cups_id, "serviciosAdministrativos_id"
)
SELECT  "codigoHomologado", descripcion, valor, "fechaRegistro", "estadoReg", 32309, "tipoHonorario_id", "tipoTarifa_id", "usuarioRegistro_id", concepto_id, convenio_id, cups_id, "serviciosAdministrativos_id"
FROM contratacion_conveniosliquidaciontarifashonorarios_20250926

select * from facturacion_suministros;
