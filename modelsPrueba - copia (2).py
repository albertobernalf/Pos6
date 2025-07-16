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


7. Seguir con clinico.*, nuevas tablas, campos , logica etc de imh(Ojop)
7.1 vERIFICAR LOS CHOICES EN EL PROGRAMA


9. PENDIENTES (facturacion mae_topsesoat(Facturacion), (mae_tarifasqx(Contratacion),mae_tarifasSoat(Contratacion), 
	
Tablas = tblhcl_ingresos ( es la parte clinica del accidente)
Tablas= tbl_furips ( Es como la parte legal de datos)
Podria ser FuripsClinico, FuripsLegal
Mas la tabla normal de las evoluciones Clinicas
Ideas: ir backup de tablas sep


-- PARTE II CLINICA
-- OJO BORRAR

class HistoriaExamenesCabezote(models.Model):
class HistorialDiagnosticosCabezote(models.Model):

IDEAS:
Tengo que tener una columna de seleccion, para por ejemplo (cambio de cama/Copagos/reponsables/etc) de la admision seleccionada
Para editar la Admision como tal (Se crea un icono de edicion, que debe abrir una ventana Modal), datos basicos
Para evolucionar Pacientes Por parte Medica Y/O Por enfermeria:(Nop aqui llama todo una nueva seccion Clinica, Y/O programa clinico o de enfermeria)(Se crea un icono de seleccion si hay tareas articles)
Para Autorizaciones algo parecido a Admisiones con ventana Modal._


Para cada check box de la tabla:

<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
  <label class="form-check-label" for="flexCheckDefault">
    Casilla de verificación por defecto
  </label>
</div>


<label
  ><input type="checkbox" id="cbox1" value="first_checkbox" /> Este es mi primer
  checkbox</label
><br />

base.html,, podria ser en caso de admisiones
MenuAdmisiones.html

<div id="ventana_modal" class="modal fade" role="dialog"></div>

    <script>
        function abrir_modal(url)
        {
            $('#ventana_modal').load(url, function()
            {
            $(this).modal({
                backdrop: 'static',
                keyboard: false
            })
            $(this).modal('show');
            });
            return false;
        }
        function cerrar_modal()
        {
        $('#ventana_modal').modal('hide');
        return false;
        }
    </script>

Para llamar la modal :
{% extends 'base/base.html' %} 
{% block page_header %} 
Listado de Sub Categorías 
{% endblock page_header %} 


{% block contenido %}

<div class="panel panel-default">

    <div class="panel-heading">
        <a class="btn btn-warning" onclick="return abrir_modal('{% url 'catalogos:subcategoria_new' %}')" href="#"><span class="fa fa-plus-circle"></span> Nueva SubCategoría en PopPup</a>
    </div>

   <div class="panel-body">
	 <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">

   </div>

</div>


Para editar una admision una :  <a class="btn btn-warning" onclick="return abrir_modal('{% url 'catalogos:subcategoria_new' %}')" href="#"><span class="fa fa-plus-circle"></span> Nueva SubCategoría en PopPup</a>
   Para borrar y editar en una celda : 
		 <td>
			  <a onclick="return abrir_modal ('{% url 'catalogos:subcategoria_edit' item.id %}')" class="btn btn-primary btn-circle" href="#"> <span class="fa fa-edit"></span> </a>
                          <a href="{% url 'catalogos:categoria_del' item.id %}" class="btn btn-danger btn-circle">  <span class="fa fa-trash"></span>    </a>
                 </td>




<div class="panel panel-default">
  <div class="panel-heading">
    <h4>Panel Heading</h4>
    <div id="my-modal" class="modal fade">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">Title</h4>
          </div>
          <div class="modal-body">
            <p>Body</p>
            <form>
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon">Label</span>
                  <input type="text" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon">Label</span>
                  <input type="text" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon">Label</span>
                  <input type="text" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon">Label</span>
                  <input type="text" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon">Label</span>
                  <input type="text" class="form-control" />
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="panel-body">
    <button class="btn btn-default" data-toggle="modal" data-target="#my-modal">Button</button>
  </div>
</div>

PASOS A SEGUIR PARA CREAR VENTANA MODAL D EEDICION FILA DE INGRESOS SELCCIONADA

1. colocar el boton en el table thtml en la fila td
2. crear evencto clicki, filtre tipoDoc, Documentom consec, sede, llame function en main.js
3. crear funcion en main.js que lea los paramteros haga u ajax a una funcion python definida en un def pasando parametros
4. crear function python lea completa ,los datos de la admsion y los devuelva creo via jresponse creo , investigar
5. en la funcition enmais.js en el ajax, por succes llenar la ventana modadl con los datos traidos de la vista .............
6. Mostrar la ventana modal .......... / .......... / ..........

7. Eso es todo no va mas
8. aRREGLAR BONITA LA VENTANA MODAL, EFICIENTE, UTIL , RAPIDA, COMPLETA , SIN ENREDOS


-- Datos a capturar de la tabla Admisiones Triage para dejar listo para crerar el ingreso en admisiones ...


"fechaSolicita" timestamp with time zone,
  "fechaAtendio" timestamp with time zone,
  consec integer NOT NULL,
  "hClinica" character varying(50),
  motivo character varying(1000),
  "examenFisico" character varying(5000),
  "frecCardiaca" integer NOT NULL,
  "frecRespiratoria" integer NOT NULL,
  "taSist" integer NOT NULL,
  "taDiast" integer NOT NULL,
  "taMedia" integer NOT NULL,
  glasgow integer NOT NULL,
  peso integer NOT NULL,
  temperatura integer NOT NULL,
  estatura integer NOT NULL,
  glucometria integer NOT NULL,
  saturacion integer NOT NULL,
  "escalaDolor" integer NOT NULL,
  "tipoIngreso" character varying(20),
  observaciones character varying(200) NOT NULL,
  "fechaRegistro" timestamp with time zone,
  "estadoReg" character varying(1) NOT NULL,
  "causaExterna_id" integer,
  "clasificacionTriage_id" integer,
  documento_id integer,
  "enfermedaActual_id" integer,
  "sedesClinica_id" integer,
  "tipoDoc_id" integer,
  "usuarioAtiende_id" integer,
  "usuarioAutoriza_id" integer,
  "usuarioCrea_id" integer,



