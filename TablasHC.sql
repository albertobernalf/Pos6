--Para el Modulo de HC
-- Ojo la revision por sistemas la tengo en otra tabla aparte , para que pueda ser parametrizable.
 
select * from tblhcl_evolheridas where num_admision = 916764; --Sip
select * from tblhcl_evoluciones limit 1000 where num_admision = 916764 and fecha_evol >= '2024-07-17'; -- Sip
select * from tblhcl_ingresos where num_admision = 916764  -- Nop, ver si de pronto sirve algun u otro datop
select * from tblhcl_signos where num_admision = 916764  -- Sip,, -- ops parece cada evolucion tiene unos signos aparte
select * from tblhcl_revsistemas  where num_admision = '916764' -- sip
select * from tblhcl_evolsellos where num_admision = 916764  -- Sip trasfusiones
select * from tblhcl_imhaloterapia where num_admision = 916764  -- bueno
select * from tblhcl_oxigeno  where num_admision = '916764' -- Sip Para oxigeno
select * from tblhcl_dosis where num_admision = '916764' -- dosis medicamentos
select * from tblhcl_antibiotico  where num_admision = '916764' -- Sip ojop 
select * from tblhcl_medicamentos where num_admision = '916764' -- Sip obvio
select * from tblhcl_contrareferencia where num_admision = '916764'-- Sip para pacientes referencia - contrareferencia
select * from tblhcl_cirugias where num_admision = '916764'-- Sip
select * from tblhcl_enfcuidados where num_admision = '916764'
select * from tblhcl_enfdolor where num_admision = '916764'
select * from tblhcl_enfheridas where num_admision = '916764'
select * from tblhcl_enfnotas where num_admision = '916764'
select * from tblhcl_enfnotasliq where num_admision = '916764'
select * from tblhcl_enfposicion where num_admision = '916764'
select * from tblhcl_enfsignos where num_admision = '916764'
select * from tblhcl_enfdispositivos where num_admision = '916764'

-- Aquip vamos
 
select * from tblhcl_hallazgos_ic where num_admision = 916764   -- Sip
select * from tblhcl_hallazgos where num_admision = 916764   -- Sip
select * from tblhcl_fichas where num_admision = 916764  --  Sip
select * from tblhcl_ingrtrauma limit 1000 where num_admision = 916764 
select * from tblhcl_interconsultas where num_admision = 916764  -- Sip
select * from tblhcl_resumeaten  where num_admision = '916764' -- sip pero no se como
select * from tblhcl_serfarma  where num_admision = '916764' -- sip npo se exactamente para que es
select * from tblhcl_dietas where num_admision = '916764' -- Sip pa dietas
select * from tblhcl_egreso limit 1000 where num_admision = '916764' -- Sip 
select * from tblhcl_mezclas where num_admision = '916764' -- Sip analizar la info
select * from tblhcl_nopos where num_admision = '916764' -- Sip


-- Para modulo basicas
select * from tblhcl_sivigila; -- Sip cruce con sivigila -- de parametrizacion 
select * from tblhcl_materialqx where num_admision = '916764' -- Es como un lstado de material qx, umm sirve

-- Para el modulo de Enfermeria :
select * from tblhcl_enfsabanas where num_admision = '916764' order by fecha

-- ojo ciomo manejar los turnos en las tablas



