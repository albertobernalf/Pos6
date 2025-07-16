TIPS THE WORK

-- PARTE I ADMISIONES - ADMINISTRATIVA  - FACTURACION

-- OJO EL DIA LUNES 8/07
En facturacion:
0.1 Tarifas (id, nombre,  convenioId, conceptoId, tipo, codigoCups, codigoSuministro, valor, grupoQx, paquete, Honorarios)
0.1.1 TiposTarifa(id, nombre ) EPS, ENTE TERRITORIAL Particular, Iss, soat, otros
0.2 TiposTarifa(id,nombre)  EPS,SOAT, ISS, ENTE TERRITORIAL, IPS, ARL, PARTICULAR)
0.3  Eapb (id,nombre,codigoEapb, codigoRips, tipoDoc, documento)-- Entidades de aseguramiento del plan de beneficios
0.4 Empresas (id,  tipoDoc, documento,nombre, codigoEapb , direccion, telefono, representante,  regimen, fosyga, particular, departamento, municipio, codigoPostal, responsableFiscal, identificadorDian )


0.5  -- sunpongo la tabla ConveniosPaciente (id,tipoDoc,documento,convenio)
0.6 -- ConveniosPacienteIngresos (id,tipoDoc,documento,consec, convenio)

0.7 Conceptos (id, nombre,tipoCups, codAd, codAt, ripsAc, ripsAp, ripsAt, ripsAm, ripsAh, ripsAu)
0.8 TipoCups (id, nombre)  Son : Cups, Articulos
0.9 Cups (id, nombre,codigoCups, concepto,autorizar, codigoRips,cupsGrupo, cupsSubgrupo;cupsCategoria, resolucion1132,
	 Tipo,nivelAtencion,Plan,centroCosto ,finalidad, duracion, manejaInterfaz,DistribucionTerceros,consentimientoInformado,cita1Vez, cContable)
   
-- En facturacion a ver que oasa
0.0.1 TiposSuministro (id, nombre)  -- Material,Articulo, Medicamento, osteosisntesis ,etc
0.10 Suministros (id, nombre, tipoSuministro, nombreGenerico, concepto, concentracion,grupo,unidadaMedida, fraccion, unidadFraccion, viaAdministracion, vence,control,antibiotico,pos, facturable,stockMinimo,stockMaximo,maxOrdenar,estabilidad, invFarmacia,invAlmacen, enfermeria, terapia, nutricion, cantidad, cums, formaFarmaceutica,regSanitario, altoCosto, vrCompra, vrUltimaCompra, codigoAtc, infusion, tipoAdministracion, regulado, calorRegulado,observaciones, sispro, oncologico, ortesis, mipres, epiHigiene, controlStock
		        AnatoPos, magistral control , genericoPos)


0.11 FormasLiquidacion : (id, nombe,  Codigo,tipoCruento ,caracteristica, valorHonorario,tiposHonorarios,cuentaContable,centroCosto)

En contratacion:
0.9 -- supongo tabla - Convenios (id,nombre, empresa, tipoTarifa etc, vigencia_desde, vigencia_hasta, porcTarifario, porcSuministros, valorOxigeno,porcEsterilizacion, porcMaterial, hospitalario, urgencias, ambulatorio, consultaExterna
								    copago, moderadora, tipofactura , agrupada, facturacionSuministros, facturacionCups , cuentaContable, requisitos)

para el lunes 15/julio

1. Poder grabar una Admision (una vez guarde el nuevo usuario se pueda seguir la modal desaparezca y pueda crear correctamente una admision al igual con actualizar probar)
2. Probar todos los filtros de consultas en admisiones (por servicios, sedes, subservicios, habitaciones, nombres etc)
   se debe seguir con Furips, Triage, Ingreso a Triage (Probar trabajar con clases)
3. No eta UPDATE /INSERT de ls campos manilla, acompanatete, responsable remitido ips 

	                 empresa_id=empresaId,
                         ipsRemite_id = ipsRemite,
                         numManilla =numManilla,
                         contactoAcompanante_id = contactoAcompanante,
                         contactoResponsable_id = contactoResponsable,
4. Ojo recuerda los permisos punuales DSACTIVAR / INACTIVAR Botones
5. Ojo como genera el consecutivo de ingreso, tiene que NOO observar la sede o sea va a tener un consecutivo permanente, no pueden haber mas d eun consecutivo, o repetido
   son independientes de la sede , son ascendentes
6. Crear modulos de farmacia, inventarios y creo pare de contar no va mas ...
        
-- No graba num_manilla, remitido
-- ojo como carachas editas los existentes ???(ideas un link en html en la tabla y que llame una modal admisiones). Pero hay que ver que cambio es posible cambioar auqui ? Regimen?, num_manilla, remitido, ips_remite, empresa ???, responsable, acompañante, tipo de cotizante, muerte , defuncion, hclinica,fechaMuerte, causasMuerte,vias_deIngreso, viasdeegreso
        actadedefuncion, estadoSalida, especialidades, dx,  etc
    -- Pues datos como usuaruio no se hacen aqui, contactos, tampoco se hacen aquip,
-- ojo cuando fitra o cuando cre admision No cocerva el modulo, profesioal,sede
-- Ojo cuando se hace le ingreso no parece no graba bien el Id del medico
-- ojo el combo de especialidad en ingresos trae medicos de las americas error
-- ojo hay que unificar mayuscula y minuscula un estandrad o sino paila por ejemplo Profesional / profesional
--Ojo que pasa con os estadorREg de todos los modelos ojop definir de una vez despues es inmanejable
-- OJO NO ESTA PASANDO EL MODELO A LA VISTA ACOMPAN, RESPO, IPS, MANULLA, ETC
-- cuando voya craer in creadmision por segunda vez pierde los cmbos de empresas, acompanamtes, repospoonsables, ips por  cua ?
-- OJO SE DEBEBN CREAR CONTEXTOS DE ACUERDO A LOS MODULOS EJEMPLO INGRESOS uno HISPTRIA CLINICA OTRO DIRIA YO SOLO LAS TABLAS CLINICAS
-- la funcion retornarAdmision que hace ?
-- ojo cuando retorna en algunas pantallas se pieerde la sede, profesioonal,colaborador

--Hay que organizar todo eso papaberol antes d eseguir adelante si no PAILANDER, la tiene dura el dia LUNES PAPABEROL
-- TIENE QUE ESTANDARIZAR EL SOFTWARE O SI NOP PAILAS ANTES DE SEGUIR ORDEN SI NO PASA ESTA PRUEBA ADIOS SERVER

-- OJOP:
1. hilo de performance llenar tabla ingresos con 500000 registors o los mismo que tienen actualmente imhotep (para realizar consultas-filtros)
2. crear los boceto de todos las paginas-programa con el boton retorn volviendo al menu anterioro, admiisone-autorizaciones etc
3. reorganizar los context para cada caso ahorrar memoria -cpu vien organizadito el codigo
4. cvarialene¿s am pasar a los html ,os mismo para todas las paginas

FIN 15/julio


5. Crear Proceso Traslados de Habitaciones/Servicio/etc
6. Crear un proceso masivo de actualizacion a una nueva instalacion python, con export de bdatos y creacion global d eun nuevo sitio
   es como ir creando algo asi como un instalador del programa y un backup/restore de la informacion postgres como le parece . AUTOMATIZAR
7. ojo tengo quemado un centroc_id en 1 creo para que guarde la modal usuario (NO SE PORQUE)/ tambien en main, ausuario1 fecIngreso esta quemado 2024-01-01
8.  Creo crear programa autorizaciones con panelAutorizaciones y demas depronot un menuAutorizaciones para comenzar a diferenciar y yap todo
   con el estandard de programacion


   PROCESO TENTATIVO INICIAL
   0. Justo antes de realizar cualquier cambio en los modelos del aplicativo1. Crear un ambiente python exacto al que hay (Mediante archivo .bat de Windows)
	Algo asi :
        cmd
        cd\
        cd EntornosPythn  alberto@
        virtualenv nuevoProyecto
        cd nuevoProyecto
        cd scripts
        activate
        cd ..
        requeriments.bat
        django-admin startproject vulner
        cd vulner
        django-admin start app Administracion
        .
        .
        django-admin startapp usuarios
        xcopy c:\entornosPython\proyectoAnterior\vulner\Administracion\*.py  c:\entornosPython\proyectoANuevo\vulner\Administracion\*.py 
        .
        .
        .
	xcopy c:\entornosPython\proyectoAnterior\vulner\usuarios\*.py  c:\entornosPython\proyectoANuevo\vulner\usuarios\*.py 
	xcopy c:\entornosPython\proyectoAnterior\vulner\vulner\urls.py  c:\entornosPython\proyectoANuevo\vulner\vulner\urls.py
	xcopy c:\entornosPython\proyectoAnterior\vulner\static  c:\entornosPython\proyectoANuevo\vulner\static
	xcopy c:\entornosPython\proyectoAnterior\vulner\media  c:\entornosPython\proyectoANuevo\vulner\media
	xcopy c:\entornosPython\proyectoAnterior\vulner\templates  c:\entornosPython\proyectoANuevo\vulner\templates

        # crear el nuevo settings.py en el proyecto nuevo
        python manage.py makemigrations
	python manage.py migrate
        python manage.py createsuperuser
          -- respuestas
        python manage.py runserver 8082
         	
   2. Backup Base de Datos Postgres solo data (puede ser solo instrucciones SQL)

	Se saco backup tipo Tar, pero exceptuando todas las tablas auth* y django*. Pero ojo no me subio las tablas con campos timestamp
        Lo logre sin activar insert column ni activar oids ni activar insert commands
        planito planito y yap probar mañana TODO


   3. Restore Bases de Datos a nuevo ambiente (solo data el mismo archivo). correr script SQL
   4. Actualizar Aplicativo (Crear nuevos Modelos, vistas, templates, etc)-  Aplicar makemigrations - migrate
   5. Correr script que pueblan tablas recien creadas o actualizan campos si los hay
   6. Listop


7. Seguir con clinico.*, nuevas tablas, campos , logica etc de imh(Ojop)
7.1 vERIFICAR LOS CHOICES EN EL PROGRAMA


9. PENDIENTES (facturacion mae_topsesoat(Facturacion), (mae_tarifasqx(Contratacion),mae_tarifasSoat(Contratacion), 
	
Tablas = tblhcl_ingresos ( es la parte clinica del accidente)
Tablas= tbl_furips ( Es como la parte legal de datos)
Podria ser FuripsClinico, FuripsLegal
Mas la tabla normal de las evoluciones Clinicas
Ideas: ir backup de tablas sep



-- PARTE II CLINICA

-- Ojo ver tabla de incapacidades 

clinico_historia:


-- modulo  clinico

class Historia(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
                tiposFolio = models.ForeignKey('clinico.TiposFolio', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                causasExterna = models.ForeignKey('clinico.causasExterna', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                dependenciasRealizado = models.ForeignKey('sitios.Dependencias', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                especialidades = models.ForeignKey('clinico.Especialidades', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                planta   = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                motivo     = models.CharField(max_length=250,blank=True)
                subjetivo  = models.CharField(max_length=250, blank=True)
                objetivo   = models.CharField(max_length=250,blank=True)
                analisis   = models.CharField(max_length=250, blank=True)
                plann       = models.CharField(max_length=250, blank=True)
                enfermedadActual =  models.CharField(max_length=5000, blank=True)
 		ingestaAlcohol =  models.CharField(max_length=5000, blank=True)
	        monitoreo =  models.CharField(max_length=1,blank=True)
                examenFisico = models.CharField(max_length=5000,blank=True)
 		justificacion = models.CharField(max_length=5000,blank=True)
                tipoEvolucion = models.ForeignKey('clinico.TiposEvolucion', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                apache2 = models.IntegerField(default=0)
                indiceMortalidad = models.IntegerField(default=0)
		epicrisis = models.CharField(max_length=20000,blank=True)
                manejoQx =   models.CharField(max_length=20000,blank=True)
                noQx = models.CharField(max_length=30,blank=True)
		antibioticos = models.CharField(max_length=1,blank=True)
                tratamiento = models.CharField(max_length=5000,blank=True)
                llenadoCapilar = models.CharField(max_length=1,blank=True)
		pulsos = models.CharField(max_length=1,blank=True)
		vomito = models.CharField(max_length=1,blank=True)
		nauseas = models.CharField(max_length=1,blank=True)
		irritacion = models.CharField(max_length=1,blank=True)
		neurologia = models.CharField(max_length=1,blank=True)
		retiroPuntos = models.CharField(max_length=1,blank=True)
		movilidadLimitada = models.CharField(max_length=1,blank=True)
		interconsulta =  models.CharField(max_length=1,blank=True)
		observaciones = models.CharField(max_length=5000,blank=True)
		riesgos = models.CharField(max_length=5000,blank=True)
		notaAclaratoria =  models.CharField(max_length=1,blank=True)
		fecNotaAclaratoria = models.DateTimeField()
		textoNotaAclaratoria = models.CharField(max_length=5000,blank=True)
		usuarioNotaAclaratoria = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True,  on_delete=models.PROTECT)
		inmovilizacion = models.CharField(max_length=1,blank=True)
                inmovilizacionObservaciones = models.CharField(max_length=5000,blank=True)
		riesgoHemodinamico = models.CharField(max_length=15,blank=True)
		riesgoVentilatorio =  models.CharField(max_length=15,blank=True)
		leucopenia = models.CharField(max_length=50,blank=True)
		trombocitopenia = models.CharField(max_length=50,blank=True)
		hipotension = models.CharField(max_length=50,blank=True)
	        fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

             
                def __str__(self):
                    return str(self.id)

                class Meta:
                    ordering = ["tipoDoc","documento","folio","fecha","especialidades","motivo","subjetivo","objetivo","analisis","plann"]


class SignosVitales(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
		frecCardiaca = models.DecimalField( max_digits=3, decimal_places=2)
		frecRespiratoria =  models.DecimalField( max_digits=3, decimal_places=2)
		tensionADiastolica =  models.DecimalField( max_digits=3, decimal_places=2)
		tensionASistolica=  models.DecimalField( max_digits=3, decimal_places=2)
		tensionAMedia =  models.DecimalField( max_digits=3, decimal_places=2)
		temperatura =  models.DecimalField( max_digits=3, decimal_places=2)
		saturacion =  models.DecimalField( max_digits=3, decimal_places=2)
		glucometria =  models.DecimalField( max_digits=3, decimal_places=2)	
		glasgow =  models.DecimalField( max_digits=3, decimal_places=2)
		apache =  models.DecimalField( max_digits=3, decimal_places=2)
		pvc =  models.DecimalField( max_digits=3, decimal_places=2)
		cuna =  models.DecimalField( max_digits=3, decimal_places=2)
		ic  =  models.DecimalField( max_digits=3, decimal_places=2)
		glasgowOcular =  models.DecimalField( max_digits=3, decimal_places=2)
		glagowVerbal = models.DecimalField( max_digits=3, decimal_places=2)
		glasgowMotora = models.DecimalField( max_digits=3, decimal_places=2)
		observacion =  models.CharField(max_length=5000,blank=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

              
                def __str__(self):
                    return str(self.id)



class RevisionPacientesSistemas(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
		revisionSistemas= models.ForeignKey('clinico.RevisionSistemas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		observacion =   models.CharField(max_length=5000,blank=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)



class Trasfusiones(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
		selloCalidad = models.CharField(max_length=5000,blank=True)
		grupoBolsa = models.CharField(max_length=50,blank=True)
		fechaCaducidad = models.DateTimeField()
		realizoTrasfusion =models.CharField(max_length=50,blank=True)
		trasfusionInicio = models.CharField(max_length=50,blank=True)
		trasfusionFinal = models.CharField(max_length=50,blank=True)
		complicaciones = models.CharField(max_length=5000,blank=True)
		tipoComponente = models.CharField(max_length=50,blank=True)
		epicrisis = models.CharField(max_length=5000,blank=True)
		compReactRtha = models.CharField(max_length=15,blank=True)
		compEnfInjerto = models.CharField(max_length=15,blank=True)
		compSobreCargaCirc = models.CharField(max_length=15,blank=True)
		compLesPulmonar = models.CharField(max_length=15,blank=True)
		compReacAlergica = models.CharField(max_length=15,blank=True)
		compSepsis =	 models.CharField(max_length=15,blank=True)
		compPurpPostTrans = models.CharField(max_length=15,blank=True)
		compReacFHemolitica = models.CharField(max_length=15,blank=True)
		compReacFNoHemolitica = models.CharField(max_length=15,blank=True)
		compEmboAereo = models.CharField(max_length=15,blank=True)
		compHipocalemia = models.CharField(max_length=15,blank=True)
		compHipotermia = models.CharField(max_length=15,blank=True)
		compTransMasiva = models.CharField(max_length=15,blank=True)
		compEscalofrios = models.CharField(max_length=15,blank=True)
		compOtro =  models.CharField(max_length=15,blank=True)
		compOtroDesc = models.CharField(max_length=2000,blank=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class ImHaloTerapia(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
		salbutamol = models.CharField(max_length=50,blank=True)
		ipratropio = models.CharField(max_length=50,blank=True)
		beclometazona =  models.CharField(max_length=50,blank=True)
		berudual = models.CharField(max_length=50,blank=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class Oxigeno(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fechaInicio = models.DateTimeField()
                fechaFinal = models.DateTimeField()
		tipoOxigenacion = models.CharField(max_length=15,blank=True)
		aire = models.CharField(max_length=1,blank=True)
		saturacionOxigeno =  models.DecimalField( max_digits=3, decimal_places=2)
		flujoLtsOxigeno = models.DecimalField( max_digits=3, decimal_places=2)
		flujoLtsAire = models.DecimalField( max_digits=3, decimal_places=2)
		horasOxigeno = models.DecimalField( max_digits=3, decimal_places=2)
		horasAire = models.DecimalField( max_digits=3, decimal_places=2)
		totalLtsoxigeno = models.DecimalField( max_digits=3, decimal_places=2)
		totalLtsAire = models.DecimalField( max_digits=3, decimal_places=2)
		totalMetrocubicoOxigeno = models.DecimalField( max_digits=3, decimal_places=2)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)


-- modulo  clinico cre facturacion

class Suministros(models.Model):
                id = models.AutoField(primary_key=True)
		codigoSuministro = models.CharField(max_length=30, blank=True,null= True, editable=True)
		nombre =  models.CharField(max_length=100, blank=True,null= True, editable=True)	 
		generico =  models.CharField(max_length=250, blank=True,null= True, editable=True)	
		concepto = models.ForeignKey('facturacion.Conceptos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		cuentaContable = models.CharField(max_length=30, blank=True,null= True, editable=True)	
		codigoCums = models.CharField(max_length=20, blank=True,null= True, editable=True)
		rips = 
		concentracion = models.CharField(max_length=250, blank=True,null= True, editable=True)
		grupo =  models.ForeignKey('clinico.Grupos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		subgrupo = models.ForeignKey('clinico.SubGrupos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		unidadMedida = models.ForeignKey('clinico.dosisUMedidas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fraccion = models.DecimalField( max_digits=20, decimal_places=0)
		unidadFraccion = models.ForeignKey('clinico.dosisUFraccion', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		viaAdministracion =
		deControl =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		pos = models.CharField(max_length=1, blank=True,null= True, editable=True)
		antibiotico = models.CharField(max_length=1, blank=True,null= True, editable=True)
		facturable = models.CharField(max_length=1, blank=True,null= True, editable=True)
		stockMinimo = models.DecimalField( max_digits=20, decimal_places=0)
		stockMaximo =  models.DecimalField( max_digits=20, decimal_places=0)
		enfermeria = models.CharField(max_length=1, blank=True,null= True, editable=True)
		formaFarmacetutica= models.CharField(max_length=250, blank=True,null= True, editable=True)
		registrosanitario = models.CharField(max_length=30, blank=True,null= True, editable=True)
		altoCosto = models.CharField(max_length=1, blank=True,null= True, editable=True)
		vlrCompra = models.DecimalField( max_digits=20, decimal_places=0)
		ultVlrCompra =	 models.DecimalField( max_digits=20, decimal_places=0)	
		codigoAtc = models.CharField(max_length=10, blank=True,null= True, editable=True)
		codigoRips5521 = models.CharField(max_length=10, blank=True,null= True, editable=True)
		codigoRips5926 = models.CharField(max_length=10, blank=True,null= True, editable=True)
		codigoRips2019= models.CharField(max_length=10, blank=True,null= True, editable=True)
		infusion= models.CharField(max_length=1, blank=True,null= True, editable=True)
		tipoAdministracion= models.CharField(max_length=20, blank=True,null= True, editable=True)
		regulado = models.CharField(max_length=1, blank=True,null= True, editable=True)
		valorRegulado =models.DecimalField( max_digits=20, decimal_places=0)	
		reportaSispro = models.CharField(max_length=1, blank=True,null= True, editable=True)
		oncologico = models.CharField(max_length=1, blank=True,null= True, editable=True)
		ortesis = models.CharField(max_length=1, blank=True,null= True, editable=True)
		mipres = models.CharField(max_length=15, blank=True,null= True, editable=True)
		precauciones = models.CharField(max_length=5000, blank=True,null= True, editable=True)
		contraindicaciones = models.CharField(max_length=5000, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )

                def __str__(self):
                    return str(self.id)


class Grupos(models.Model):
                id = models.AutoField(primary_key=True)
		grupo = models.CharField(max_length=80, blank=True,null= True , editable=False)
		nombre = models.CharField(max_length=80, blank=True,null= True , editable=False)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class SubGrupos(models.Model):
                id = models.AutoField(primary_key=True)
		grupo = models.ForeignKey('facturacion.Grupos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		nombre = models.CharField(max_length=80, blank=True,null= True , editable=False)

		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class TiposAdministracion(models.Model):
                id = models.AutoField(primary_key=True)
		nombre = models.CharField(max_length=80, blank=True,null= True , editable=False)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

-- modulo  clinico 

class Medicamentos(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fecha = models.DateTimeField()
		orden =  models.IntegerField(default=0)
		suministro = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		concentracion = models.CharField(max_length=150, blank=True,null= True , editable=False)
		concentracionUMedida = models.ForeignKey('clinico.ConcentracionUMedidas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dosisCantidad = models.DecimalField( max_digits=20, decimal_places=3)
		dosisUnidad = models.ForeignKey('clinico.dosisUMedidas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		frecuenciaCantidad = models.DecimalField( max_digits=2, decimal_places=0)
		frecuenciaUnidad = models.ForeignKey('clinico.frecuenciaUnidad', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		via = models.ForeignKey('clinico.frecuenciaVia', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		nota = models.CharField(max_length=5000,blank=True)
		cantidadSolicitada = models.DecimalField( max_digits=20, decimal_places=0)
		cantidadEntregada= models.DecimalField( max_digits=20, decimal_places=0)
		cantidadDispensada = models.DecimalField( max_digits=20, decimal_places=0)
		cantidadAplicada = models.DecimalField( max_digits=20, decimal_places=0)
		cantidadDevuelta =models.DecimalField( max_digits=20, decimal_places=0)
		cantidadSaldoIni = models.DecimalField( max_digits=20, decimal_places=0)
		cantidadsaldoFinal = models.DecimalField( max_digits=20, decimal_places=0)
		cantidadfacturada = models.DecimalField( max_digits=20, decimal_places=0)
		nopos = models.CharField(max_length=1,  blank=True,null= True, editable=True, editable=False)
		estadoMedicamento =  models.CharField(max_length=1,  blank=True,null= True, editable=True, editable=False)
		horarioDosis = models.CharField(max_length=200,  blank=True,null= True, editable=True, editable=False)
		dosisUnica = models.DecimalField( max_digits=10, decimal_places=0)
		dosisRescate = models.CharField(max_length=200,  blank=True,null= True, editable=True, editable=False)
		dosisProfilaxis = models.CharField(max_length=200,  blank=True,null= True, editable=True, editable=False)
		dosisAdelanto = models.CharField(max_length=200,  blank=True,null= True, editable=True, editable=False)
		urgente = models.CharField(max_length=1,  blank=True,null= True, editable=True, editable=False)
		dosificacion = models.CharField(max_length=2000,  blank=True,null= True, editable=True, editable=False)
		antibiotico = models.CharField(max_length=1,  blank=True,null= True, editable=True, editable=False)
		fechaSuspension = models.DateTimeField()
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)


-- modulo  enfermeria

class AplicacionMedicamentos(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
		orden =  models.IntegerField(default=0)
		suministro = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                fecha_ini = models.DateTimeField()
		fecha_fin = models.DateTimeField()
		cantidadAdministrada = models.DecimalField( max_digits=15, decimal_places=2)
		dosisAdministrada = models.DecimalField( max_digits=15, decimal_places=2)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)



                def __str__(self):
                    return str(self.id)

-- modulo  clinico

class Antibiotico(models.Model):
                id = models.AutoField(primary_key=True)
                tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)
                fechaSolicitud = models.DateTimeField()	
		fechaInicio  = models.DateTimeField()	
		suministro = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		profilaxis =  models.CharField(max_length=10, blank=True,null= True, editable=True)
		ttoEmpirico = models.CharField(max_length=10, blank=True,null= True, editable=True)
		ttoetiologico = models.CharField(max_length=10, blank=True,null= True, editable=True)
		ampliacionTto = models.CharField(max_length=10, blank=True,null= True, editable=True)
		cambioEsquema = models.CharField(max_length=10, blank=True,null= True, editable=True)
		saludPublica = models.CharField(max_length=10, blank=True,null= True, editable=True)
		dxInfeccion = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		germenAislado = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		fechaVigencia = models.DateTimeField()	
		fallaRenal = models.CharField(max_length=10, blank=True,null= True, editable=True)
		fallaHepatica = models.CharField(max_length=10, blank=True,null= True, editable=True)
		infeccionSevera = models.CharField(max_length=10, blank=True,null= True, editable=True)
		inmunoSupresion = models.CharField(max_length=10, blank=True,null= True, editable=True)
		aprobado = models.CharField(max_length=15, blank=True,null= True, editable=True)
		prescripcion = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		protocolo = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		noProtocolo = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		ajustadoCultivo = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		ajustadoDosiRenal = models.CharField(max_length=1000, blank=True,null= True, editable=True)
		autInfectologia = models.CharField(max_length=2, blank=True,null= True, editable=True)
		observacionEpidemilogia = models.CharField(max_length=10000, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)

                def __str__(self):
                    return str(self.id)

-- modulo  clinico

-- Nuevo
-----------------------------------------------------------------------------------------------------------------------
class ViasAdministracion(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		nombre =  models.CharField(max_length=30, blank=True,null= True, editable=True)
                habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class UnidadesDeMedida(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		nomenclatura=  models.CharField(max_length=50, blank=True,null= True, editable=True) 
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		nombre =  models.CharField(max_length=30, blank=True,null= True, editable=True)
                habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class Presentacion(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		nombre =  models.CharField(max_length=30, blank=True,null= True, editable=True)
                habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class FormasFarmaceuticas(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		nombre =  models.CharField(max_length=30, blank=True,null= True, editable=True)
                habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class UnidadesDeMedidaDosis(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		unidadaDeMedidaPrincipioA =  models.CharField(max_length=50, blank=True,null= True, editable=True) 
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class FrecuenciasAplicacion(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class IndicacionesEspeciales(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)



class TiposMedicamento(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class MedicamentosDci(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcionDciConcentracion =  models.CharField(max_length=100, blank=True,null= True, editable=True) 
		tipoMedicamento =  models.ForeignKey('clinico.TiposMedicamento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class ExpedienteDCI(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		formaFarmaceutica = models.ForeignKey('clinico.FormasFarmaceuticas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class TiposDispositivoMedico(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True)
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)


class TiposProductosNutricion(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		descripcion =  models.CharField(max_length=100, blank=True,null= True, editable=True)
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

class ProductosNutricion(models.Model):
                id = models.AutoField(primary_key=True) 
		codigoMipres =  models.DecimalField( max_digits=5, decimal_places=0)
		nombreComercial =  models.CharField(max_length=100, blank=True,null= True, editable=True)
		grupo =
		formaFarmaceutica = models.ForeignKey('clinico.FormasFarmaceuticas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		presentacion = models.ForeignKey('clinico.Presentacion', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		unidades =  models.ForeignKey('clinico.UnidadesMedida', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		habilitadoMipres =  models.CharField(max_length=1, blank=True,null= True, editable=True) 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1,default='A', editable=False)

                def __str__(self):
                    return str(self.id)

-- Fin Nuevo
-----------------------------------------------------------------------------------------------------------------------


-- modulo cirugia


class Cirugias(models.Model):
                id = models.AutoField(primary_key=True) 
		tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
                folio =  models.IntegerField(default=0)		-- debe crear un folio la cirugia
		sedesClinica_id = models.ForeignKey('sitios.Sedesclinica', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		serviciosSedes_id = models.ForeignKey('sitios.Serviciossedes', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		subServiciosSedes_id = models.ForeignKey('sitios.Subserviciossedes', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		numero =  models.CharField(max_length=50, blank=True,null= True, editable=True)
		especialidad = models.ForeignKey('clinico.Especialidades', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		urgente = models.CharField(max_length=1, blank=True,null= True, editable=True)
	        tipoQx = models.CharField(max_length=20, blank=True,null= True, editable=True)
		anestesia = models.ForeignKey('clinico.TiposAnestesia', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		autorizacion =  models.CharField(max_length=30, blank=True,null= True, editable=True)
		usuarioSolicita =  models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fechaSolicia =   models.DateTimeField()
		solicitaHospitalizacion =  models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaAyudante = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaTiempoQx = models.DecimalField( max_digits=5, decimal_places=0)
		solicitatipoQx=  models.CharField(max_length=20, blank=True,null= True, editable=True)
		solicitaAnestesia =  models.CharField(max_length=20, blank=True,null= True, editable=True)
		solicitaSangree = models.CharField(max_length=1, blank=True,null= True, editable=True)
		describeSangre = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		cantidadSangre = models.DecimalField( max_digits=5, decimal_places=0)
		solicitaCamaUci = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaMicroscopio = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaRx = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaAutoSutura = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaOsteosintesis = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		soliictaSoporte = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaBiopsia =models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaMalla = models.CharField(max_length=1, blank=True,null= True, editable=True)
		solicitaOtros =models.CharField(max_length=1, blank=True,null= True, editable=True)
		describeOtros = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		fechaProg =  models.DateField()
		HoraProg= models.CharField(max_length=5, blank=True,null= True, editable=True)
		tiempoQxProg=  models.DecimalField( max_digits=5, decimal_places=0)
		fechaQx = models.DateField()
		horaQx= models.CharField(max_length=5, blank=True,null= True, editable=True)
		tiempoQx=    models.DecimalField( max_digits=5, decimal_places=0)
		fechaIniAnestesia = models.DateField()
		HoraIniAnestesia = models.CharField(max_length=5, blank=True,null= True, editable=True)
		fechaFinAnestesia =models.DateField()
		horaFinAnestesia = models.CharField(max_length=5, blank=True,null= True, editable=True)
		intervencion = models.CharField(max_length=100, blank=True,null= True, editable=True)
		cups1 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad1 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups2 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad2 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups3 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad3 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups4 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad4 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups5 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad5 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups6 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad6 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups7 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad7 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups8 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad8 = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups9 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad9 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups10 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad10 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups11 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad11 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups12 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad12 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups13 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad13 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups14 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad14 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		cups15 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		finalidad15 =models.CharField(max_length=1, blank=True,null= True, editable=True)
		riesgos = models.CharField(max_length=3000, blank=True,null= True, editable=True)
		observaciones = models.CharField(max_length=5000, blank=True,null= True, editable=True)
		dxPreQx = models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxPostQx = models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxPrinc = models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxRel1 = models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxRel2 =models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxRel3 =models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		descripcionQx=  models.CharField(max_length=10000, blank=True,null= True, editable=True)
		dxComplicacion=  models.CharField(max_length=4, blank=True,null= True, editable=True)
		complicaciones =  models.CharField(max_length=3000, blank=True,null= True, editable=True)
		patologia =  models.CharField(max_length=500, blank=True,null= True, editable=True)
		formaRealiza =  models.CharField(max_length=15, blank=True,null= True, editable=True)
		cirujano1 = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		cirujano2 = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		cirujano3 = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		anestesiologo = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		ayudante1 = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		ayudante2 = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		circulante = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		instrumentador = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoCirugia = models.ForeignKey('cirugia.EstadoCirugia', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoSalida = models.CharField(max_length=1, default='A', editable=False)
		vboAdmon= models.CharField(max_length=1, blank=True,null= True, editable=True)
		hallazgos = models.CharField(max_length=5000, blank=True,null= True, editable=True)
		osteosintesis =  models.CharField(max_length=300, blank=True,null= True, editable=True)
		auxiliar = models.CharField(max_length=200, blank=True,null= True, editable=True)
		materialEspecial = models.CharField(max_length=300, blank=True,null= True, editable=True)
		reprogramada= models.CharField(max_length=1, blank=True,null= True, editable=True)
		motivoReprogramada = models.CharField(max_length=500, blank=True,null= True, editable=True)
		tipoCancela= models.CharField(max_length=15, blank=True,null= True, editable=True) --Admon, medico, etc
		motivoCancela= models.CharField(max_length=500, blank=True,null= True, editable=True)
		timepoMaxQx = models.CharField(max_length=10, blank=True,null= True, editable=True)
		observacionesProgramacion= models.CharField(max_length=500, blank=True,null= True, editable=True)
		usuarioPrograma= models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fechaPrograma= models.DateTimeField()
		usuarioCancela=	 models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)	
		fechaCancela= models.DateTimeField()
		usuarioReprograma= models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)	
		fechaReprograma= models.DateTimeField()
		intensificador= models.CharField(max_length=1, blank=True,null= True, editable=True)
		tipofractura=	models.CharField(max_length=30, blank=True,null= True, editable=True)	 
		recomendacionenfermeria= models.CharField(max_length=2000, blank=True,null= True, editable=True)	 
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)


                def __str__(self):
                    return str(self.id)



class CirugiasMaterialQx(models.Model):
                id = models.AutoField(primary_key=True) 
		cirugia =  models.ForeignKey('cirugia.Cirugias', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		suministro = models.ForeignKey('facturacionSuministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		cantidad =  models.DecimalField( max_digits=10, decimal_places=3)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)


                def __str__(self):
                    return str(self.id)



class RecordAnestesico(models.Model):
                id = models.AutoField(primary_key=True) 




		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)


                def __str__(self):
                    return str(self.id)


class ProgramacionCirugias(models.Model):
                id = models.AutoField(primary_key=True) 
		sedesClinica_id = models.ForeignKey('sitios.Sedesclinica', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		serviciosSedes_id = models.ForeignKey('sitios.Serviciossedes', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		subServiciosSedes_id = models.ForeignKey('sitios.Subserviciossedes', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		numero =  models.CharField(max_length=50, blank=True,null= True, editable=True)

		falta estop
		.. despues de cargar algunas cosas complementar estop




		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)


                def __str__(self):
                    return str(self.id)


class EstadosCirugias(models.Model):
                id = models.AutoField(primary_key=True) 
		nombre = models.CharField(max_length=30, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False)


                def __str__(self):
                    return str(self.id)


class TiposAnestesia(models.Model):
                id = models.AutoField(primary_key=True) 
		nombre = models.CharField(max_length=30, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )


                def __str__(self):
                    return str(self.id)

-- en facturacion cre

class TiposSuministro (models.Model):
                id = models.AutoField(primary_key=True) 
		nombre = models.CharField(max_length=30, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )


                def __str__(self):
                    return str(self.id)

class Suministros (models.Model):
                id = models.AutoField(primary_key=True) 
		nombre = models.CharField(max_length=30, blank=True,null= True, editable=True)
		tipoSuministro =   models.ForeignKey('facturacion.TiposSuministro', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		nombreGenerico  =  models.CharField(max_length=250, default='A', editable=False ) 
		concepto = models.ForeignKey('facturacion.Conceptos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		concentracion = models.ForeignKey('clinico.ConcentracionUMedidas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		grupo =  models.ForeignKey('clinico.Grupos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		subGrupo models.ForeignKey('clinico.Grupos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		unidadMedida =  models.ForeignKey('clinico.DosisUMedidas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fraccion =  models.DecimalField( max_digits=20, decimal_places=2)
		unidadFraccion =   = models.CharField(max_length=20, blank=True,null= True, editable=True)
		viaAdministracion = models.ForeignKey('clinico.TiposAdministracion', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		vence =  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		control =  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		antibiotico =  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		pos	 =  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		facturable =  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		stockMinimo = models.DecimalField( max_digits=20, decimal_places=2)
		stockMaximo = models.DecimalField( max_digits=20, decimal_places=2)
		maxOrdenar = models.DecimalField( max_digits=20, decimal_places=2)
		estabilidad	 = models.DecimalField( max_digits=20, decimal_places=0)
		invFarmacia = models.CharField(max_length=1, blank=True,null= True, editable=True)
		invAlmacen = models.CharField(max_length=1, blank=True,null= True, editable=True)
		enfermeria = models.CharField(max_length=1, blank=True,null= True, editable=True)
		terapia = models.CharField(max_length=1, blank=True,null= True, editable=True)
		nutricion = models.CharField(max_length=1, blank=True,null= True, editable=True)
		cantidad	 = models.DecimalField( max_digits=20, decimal_places=2)
		cums = models.CharField(max_length=30, blank=True,null= True, editable=True)
		formaFarmaceutica = models.CharField(max_length=250, blank=True,null= True, editable=True)
		regSanitario = models.CharField(max_length=30, blank=True,null= True, editable=True)
		altoCosto = models.CharField(max_length=1, blank=True,null= True, editable=True)
		vrCompra = models.DecimalField( max_digits=20, decimal_places=2)
		vrUltimaCompra = models.DecimalField( max_digits=20, decimal_places=2)
		codigoAtc	= models.CharField(max_length=10, blank=True,null= True, editable=True)
		infusion  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		tipoAdministracion = models.CharField(max_length=20, blank=True,null= True, editable=True)
		regulado = models.CharField(max_length=1, blank=True,null= True, editable=True)
		vaorRegulado = models.DecimalField( max_digits=20, decimal_places=2)
		observaciones = models.CharField(max_length=250, blank=True,null= True, editable=True)
		sispro = models.CharField(max_length=1, blank=True,null= True, editable=True)
		oncologico = models.CharField(max_length=1, blank=True,null= True, editable=True)
		ortesis = models.CharField(max_length=1, blank=True,null= True, editable=True)
		mipres = models.CharField(max_length=15, blank=True,null= True, editable=True)
		epiHigiene = models.CharField(max_length=1, blank=True,null= True, editable=True)
		controlStock = models.CharField(max_length=1, blank=True,null= True, editable=True)
	        AnatoPos = models.CharField(max_length=1, blank=True,null= True, editable=True)
		magistralControl  = models.CharField(max_length=1, blank=True,null= True, editable=True)
		genericoPos = models.CharField(max_length=1, blank=True,null= True, editable=True)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )


                def __str__(self):
                    return str(self.id)


-- modulo contratacion

class ConveniosPaciente (models.Model):
                id = models.AutoField(primary_key=True) 
		tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
		convenio = models.ForeignKey('contratacion.Convenios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )

                def __str__(self):
                    return str(self.id)


class ConveniosPacienteIngresos (models.Model):
                id = models.AutoField(primary_key=True) 
		tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
		convenio = models.ForeignKey('contratacion.Convenios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )

                def __str__(self):
                    return str(self.id)


-- modulo referencia
class Referencia(models.Model):
                id = models.AutoField(primary_key=True) 
		tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
                documento = models.ForeignKey('usuarios.Usuarios', blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='DocumentoHistoria')
                consecAdmision = models.IntegerField(default=0)
		servicio = models.ForeignKey('clinico.Servicios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		tipoAtencion =  models.CharField(max_length=20, default='A', editable=False ) -- electiva/ electiva prioritario / hospitalizacion
		convenio1 = models.ForeignKey('contratacion.convenios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		convenio2 =models.ForeignKey('contratacion.convenios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		contacto = models.ForeignKey('usuarios.UsuariosContacto', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		anamnesis == models.CharField(max_length=2000, blank=True,null= True, editable=True)
		exaFisico = = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		exaDiagnostico= = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		tratamiento = models.CharField(max_length=2000, default='A', editable=False )
		motivoReferencia = = models.CharField(max_length=2000, blank=True,null= True, editable=True)
		otroMotivo == models.CharField(max_length=2000, blank=True,null= True, editable=True)
		cups1 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		cups2 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		cups3 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		cups4 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		cups5 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		cups6 = models.ForeignKey('facturacion.Cups', blank=True,null= True, editable=True, on_delete=models.PROTECT)		
		medico = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		regimerReferencia = models.ForeignKey('clinico.Regimenes', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxIngreso = models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		dxEgreso =models.ForeignKey('clinico.Diagnosticos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
		usuarioRegistro = models.ForeignKey('planta.Planta', blank=True,null= True, editable=True, on_delete=models.PROTECT)
		estadoReg = models.CharField(max_length=1, default='A', editable=False )


                def __str__(self):
                    return str(self.id)

