console.log('Hola Alberto Hi!')

let dataTable;
let dataTableB;
let dataTableC;
let dataTableD;
let dataTableE;


let dataTableLiquidacionInitialized = false;
let dataTableLiquidacionDetalleInitialized = false;
let dataTableFacturacionInitialized = false;
let dataTableFacAbonosInitialized = false;
let dataTableFacturacionDetalleInitialized = false;



function arrancaLiquidacion(valorTabla,valorData)
{
    data = {}
    data = valorData;

// la primera tabla

    if (valorTabla == 1)
    {
        let dataTableOptionsLiquidacion  ={
  dom: "<'row'<'col-md-2'B><'col-md-12'f>>" + 
             "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col-md-6'i><'col-md-6'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info',
    },
  ],
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '375px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },

		{     "render": function ( data, type, row ) {
                        var btn = '';
                          btn = btn + " <input type='radio'  name='miLiquidacion' class='form-check-input editPostLiquidacion' data-pk='"  + row.pk + "'>" + "</input>";
                       return btn;
                    },
                    "targets": 10
               }
            ],
	 pageLength: 3,
	  destroy: true,
	  language: {
		    processing: 'Procesando...',
		    lengthMenu: 'Mostrar _MENU_ registros',
		    zeroRecords: 'No se encontraron resultados',
		    emptyTable: 'Ningún dato disponible en esta tabla',
		    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
		    infoFiltered: '(filtrado de un total de _MAX_ registros)',
		    search: 'Buscar:',
		    infoThousands: ',',
		    loadingRecords: 'Cargando...',
		    paginate: {
			      first: 'Primero',
			      last: 'Último',
			      next: 'Siguiente',
			      previous: 'Anterior',
		    }
			},


           ajax: {
                 url:"/load_dataLiquidacion/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
                { data: "fields.id"},
                { data: "fields.tipoDoc"},
                { data: "fields.documento"},
                { data: "fields.nombre"},
                { data: "fields.consec"},
                { data: "fields.fechaIngreso"},
        		{ data: "fields.servicioNombreIng"},
                { data: "fields.camaNombreIng"},
                /*  { data: "fields.convenio"}, */

		         {
		         target : 8,
			"sWidth": "1%",
        	           "render": function (data, type, row) {
                console.log ('data = ', data);
                console.log ('type = ', type);
                console.log ('row = ', row);


				if ( row['fields']['convenio'] === null)
                {
                    return '<i class="far fa-dot-circle" style="color:red" >Sin Convenio</i>';
					/*  return 'SIN CONVENIO'; */
					}

			    if ( row['fields']['convenio'] !=  '')
				{
                     return  row['fields']['convenio'];
                    return data;
                    }


	                    }
			},

		/* desde aqui nuevo campo */
                /*  { data: "fields.salidaClinica"}, */

		         {
		         target : 9,
    			"sWidth": "1%",
        	           "render": function (data, type, row) {
                console.log ('data = ', data);
                console.log ('type = ', type);
                console.log ('row = ', row);


				if ( row['fields']['salidaClinica'] === 'S')
                {
                    return '<i class="far fa-dot-circle" style="color:red" >Salida Clinica</i>';
					/*  return 'SIN CONVENIO'; */
					}

			    if ( row['fields']['salidaClinica'] ==  'N')
				{
	                     return  row['fields']['salidaClinica'];
        	            return data;
                    }
	                    }
			},




		/* hasta aqui nuevo campo */





    ]
  }
     dataTable = $('#tablaLiquidacion').DataTable(dataTableOptionsLiquidacion);
	// Aplicamos el filtro para cada columna

    $('#tablaLiquidacion thead input').on('keyup change', function () {
        var columnIndex = $(this).parent().index(); // Índice de la columna
        table.column(columnIndex).search(this.value).draw();
    });
 }

// La segunda Tabla

    if (valorTabla == 2)
    {

        let dataTableOptionsLiquidacionDetalle  ={
   dom: 'Bfrtilp',
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info',
    },
  ],
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '150px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%', targets: 0 },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                       return btn;
                    },
                    "targets": 10
               }
            ],
	 pageLength: 3,
	  destroy: true,
	  language: {
		    processing: 'Procesando...',
		    lengthMenu: 'Mostrar _MENU_ registros',
		    zeroRecords: 'No se encontraron resultados',
		    emptyTable: 'Ningún dato disponible en esta tabla',
		    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
		    infoFiltered: '(filtrado de un total de _MAX_ registros)',
		    search: 'Buscar:',
		    infoThousands: ',',
		    loadingRecords: 'Cargando...',
		    paginate: {
			      first: 'Primero',
			      last: 'Último',
			      next: 'Siguiente',
			      previous: 'Anterior',
		    }
			},
           ajax: {
                 url:"/load_dataLiquidacionDetalle/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
        { data: "fields.consecutivo"},
                { data: "fields.fecha"},
                { data: "fields.nombreExamen"},
                { data: "fields.cantidad"},
                { data: "fields.valorUnitario"},
                { data: "fields.valorTotal"},
                { data: "fields.tipoHonorario"},
                { data: "fields.observaciones"},
                { data: "fields.tipoRegistro"},
		{ data: "fields.estadoReg"},
                     ]
            }

            if  (dataTableLiquidacionDetalleInitialized)  {

		            dataTableC = $("#tablaLiquidacionDetalle").dataTable().fnDestroy();

                    }

                dataTableC = $('#tablaLiquidacionDetalle').DataTable(dataTableOptionsLiquidacionDetalle);

	            dataTableLiquidacionDetalleInitialized  = true;
      }


// La tercera Tabla

    if (valorTabla == 3)
    {

        let dataTableOptionsFacturacion  ={
  dom: "<'row'<'col-md-2'B><'col-md-12'f>>" + 
             "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col-md-6'i><'col-md-6'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info',
    },
  ],
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '275px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                          btn = btn + " <input type='radio' name='miFacturacion' class='form-check-input editPostFacturacion' data-pk='"  + row.pk + "'>" + "</input>";                       return btn;
                        return btn;
			},
                    "targets": 14
               }
            ],
	 pageLength: 3,
	  destroy: true,
	  language: {
		    processing: 'Procesando...',
		    lengthMenu: 'Mostrar _MENU_ registros',
		    zeroRecords: 'No se encontraron resultados',
		    emptyTable: 'Ningún dato disponible en esta tabla',
		    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
		    infoFiltered: '(filtrado de un total de _MAX_ registros)',
		    search: 'Buscar:',
		    infoThousands: ',',
		    loadingRecords: 'Cargando...',
		    paginate: {
			      first: 'Primero',
			      last: 'Último',
			      next: 'Siguiente',
			      previous: 'Anterior',
		    }
			},
           ajax: {
                 url:"/load_dataFacturacion/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
                  { data: "fields.id"},
                { data: "fields.fechaFactura"},
                { data: "fields.tipoDoc"},
                { data: "fields.documento"},
                { data: "fields.nombre"},
                { data: "fields.consec"},
                { data: "fields.fechaIngreso"},
                { data: "fields.fechaSalida"},
  		{ data: "fields.servicioNombreSalida"},
                { data: "fields.camaNombreSalida"},
		 { data: "fields.dxSalida"},
		 { data: "fields.convenio"},
		 { data: "fields.salidaClinica"},
		 { data: "fields.estadoReg"},
                     ]
            }

            if  (dataTableFacturacionInitialized)  {

		            dataTableD = $("#tablaFacturacion").dataTable().fnDestroy();

                    }

                dataTableD = $('#tablaFacturacion').DataTable(dataTableOptionsFacturacion);

	            dataTableFacturacionInitialized  = true;
      }


// La cuarta Tabla

    if (valorTabla == 4)
    {

        let dataTableOptionsFacAbonos  ={
  dom: 'Bfrtilp',
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info',
    },
  ],
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '275px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
			  btn = btn + " <button class='btn btn-primary createAplicarAbono' data-pk='" + row.pk + "'>" + "</button>";
			  btn = btn + " <button class='btn btn-danger deletePostAbonosFacturacion' data-action='post/" + row.pk + "/delete' data-pk='" + row.pk + "'>" + '<i class="fa fa-trash"></i>' + "</button>";
			    return btn;
                    },
                    "targets": 8
               }
            ],
	 pageLength: 3,
	  destroy: true,
	  language: {
		    processing: 'Procesando...',
		    lengthMenu: 'Mostrar _MENU_ registros',
		    zeroRecords: 'No se encontraron resultados',
		    emptyTable: 'Ningún dato disponible en esta tabla',
		    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
		    infoFiltered: '(filtrado de un total de _MAX_ registros)',
		    search: 'Buscar:',
		    infoThousands: ',',
		    loadingRecords: 'Cargando...',
		    paginate: {
			      first: 'Primero',
			      last: 'Último',
			      next: 'Siguiente',
			      previous: 'Anterior',
		    }
			},
           ajax: {
                 url:"/load_dataAbonosFacturacion/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
       { data: "fields.tipoPagoNombre"},
		{ data: "fields.formaPagoNombre"},
                { data: "fields.valor"},
                { data: "fields.descripcion"},
               { data: "fields.totalAplicado"},
               { data: "fields.saldo"},
               { data: "fields.valorEnCurso"},
		 { data: "fields.estadoReg"},

                     ]
            }

            if  (dataTableFacAbonosInitialized)  {



		            dataTableE = $("#tablaAbonosFacturacion").dataTable().fnDestroy();

                    }

                dataTableE = $('#tablaAbonosFacturacion').DataTable(dataTableOptionsFacAbonos);

	            dataTableFacAbonosInitialized  = true;
      }


// La quinta tabla

    if (valorTabla == 5)
    {

        let dataTableOptionsFacturacionDetalle  ={
   dom: 'Bfrtilp',
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info',
    },
  ],
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '150px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%', targets: 0 },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                       return btn;
                    },
                    "targets": 9
               }
            ],
	 pageLength: 3,
	  destroy: true,
	  language: {
		    processing: 'Procesando...',
		    lengthMenu: 'Mostrar _MENU_ registros',
		    zeroRecords: 'No se encontraron resultados',
		    emptyTable: 'Ningún dato disponible en esta tabla',
		    infoEmpty: 'Mostrando registros del 0 al 0 de un total de 0 registros',
		    infoFiltered: '(filtrado de un total de _MAX_ registros)',
		    search: 'Buscar:',
		    infoThousands: ',',
		    loadingRecords: 'Cargando...',
		    paginate: {
			      first: 'Primero',
			      last: 'Último',
			      next: 'Siguiente',
			      previous: 'Anterior',
		    }
			},
           ajax: {
                 url:"/load_dataFacturacionDetalle/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
        { data: "fields.consecutivo"},
                { data: "fields.fecha"},
                { data: "fields.nombreExamen"},
                { data: "fields.cantidad"},
                { data: "fields.valorUnitario"},
                { data: "fields.valorTotal"},
                { data: "fields.observaciones"},
                { data: "fields.tipoRegistro"},
		{ data: "fields.estadoReg"},
                     ]
            }

            if  (dataTableFacturacionDetalleInitialized)  {

		            dataTableC = $("#tablaFacturacionDetalle").dataTable().fnDestroy();

                    }

                dataTableC = $('#tablaFacturacionDetalle').DataTable(dataTableOptionsFacturacionDetalle);

	            dataTableFacturacionDetalleInitialized  = true;
      }






} // Cierra la function arranca

 $('.dt-button').css({
        'font-size': '12px',
        'padding': '5px 10px',
        'height': 'auto',
	'line-height': 1.2,
    });



const initDataTableLiquidacion = async () => {
	if  (dataTableLiquidacionInitialized)  {
		dataTable.destroy();

}
        var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var data =  {}   ;

        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
        valor=1
        liquidacionId = 1
        data['valor'] = valor;
        data['liquidacionId'] = liquidacionId;
	data['ingresoId'] = valor;
        data['tipoIngreso'] = 'INGRESO'

	// fecha actual
	let fecha = new Date();

	ano = fecha.getFullYear();
	mes = fecha.getMonth() ;
        mes = '0' + mes;

   mesAnterior = mes +1 ;

	dia = fecha.getDate();
        diaDesde = '01'
	dia='0' + dia;

       // desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
       // hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'

        desdeFecha = ano + '-01-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'

        desdeFactura=0;
        hastaFactura=0;


	data['desdeFecha'] = desdeFecha;
	data['hastaFecha'] = hastaFecha;
	data['desdeFactura'] = desdeFactura;
	data['hastaFactura'] = hastaFactura;
	data['bandera'] = 'Por Fecha';

        data = JSON.stringify(data);
        arrancaLiquidacion(1,data);
	    dataTableLiquidacionInitialized = true;

        arrancaLiquidacion(2,data);
	    dataTableLiquidacionDetalleInitialized = true;


        arrancaLiquidacion(3,data);
	    dataTableFacturacionInitialized = true;

        arrancaLiquidacion(4,data);
	    dataTableFacAbonosInitialized = true;

	 $('#tablaLiquidacion tbody tr:eq(0) .miLiquidacion').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript
	alert("se supone ya seleeciode liquidacion");

}

 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTableLiquidacion();
	
});


 /* FIN ONLOAD */


// desde aquip lo viejo

	
       /*--------------------------------------------
        Click to Edit Button
        --------------------------------------------
        --------------------------------------------*/

        $('body').on('click', '.editPostLiquidacion', function () {

	          var post_id = $(this).data('pk');
		var row = $(this).closest('tr'); // Encuentra la fila

		 alert("entre pk = " + post_id);



        var username_id = document.getElementById("username_id").value;
        var sede = document.getElementById("sede").value;

	document.getElementById("liquidacionId").value = '';
	document.getElementById("liquidacionId1").value = '';
	document.getElementById("ingresoId").value = '';
	document.getElementById("liquidacionIdA").value = '';



	$.ajax({
	           url: '/postConsultaLiquidacion/',
	            data : {post_id:post_id, username_id:username_id,'sede':sede},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

			alert("llegue con esta data" + data);
			alert("llegue con esta data.id" + data.id);

		var liquidacionId = data.id;

		$('#liquidacionId').val(data.id);
		$('#liquidacionId1').val(data.id);
		$('#liquidacionId2').val(data.id);
		$('#liquidacionIdA').val(data.id);

		console.log('liquidacionIdA = ', document.getElementById("liquidacionIdA").value)

		if (data.tipo == 'INGRESO')
		{
			$('#ingresoId').val(data.ingresoId1);
		}
		else
		{
			$('#triageId').val(data.triageId1);
		}

		$('#fecha').val(data.fecha);
		$('#tipoDoc_id').val(data.tipoDoc_id);
		$('#documento_id').val(data.documento_id);
		$('#tipoDoc').val(data.tipoDocumento);
		$('#pdocumento').val(data.documento);
		$('#paciente').val(data.paciente);
		$('#consecAdmision').val(data.consecAdmision);
		$('#nombreConvenio').val(data.nombreConvenio);
		$('#convenioId').val(data.convenioId);
		$('#observaciones').val(data.observaciones);
		$('#cama').val(data.dependenciaNombre);
		$('#servicio').val(data.servicioNombre);
		$('#salidaClinica').val(data.salidaClinica);


			// Colocar Totales

		$('#totalCopagos').val(data.totalCopagos);
		$('#totalCuotaModeradora').val(data.totalCuotaModeradora);
		$('#totalProcedimientos').val(data.totalProcedimientos);
		$('#totalSuministros').val(data.totalSuministros);
		$('#totalLiquidacion').val(data.totalLiquidacion);
		$('#valorApagar').val(data.totalAPagar);
		$('#anticipos').val(data.totalAnticipos);
		$('#totalAbonos').val(data.totalAbonos);
		$('#totalRecibido').val(data.totalRecibido);


	     var options = '<option value="=================="></option>';

		    const $id51 = document.querySelector("#lcups");


 	      		     $("#lcups").empty();

	                 $.each(data['Cups'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id51.appendChild(option);
 	      		      });

                     const $id425 = document.querySelector("#lsuministros");

 	      		     $("#lsuministros").empty();

	                 $.each(data['Suministros'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id425.appendChild(option);
 	      		      });


                     const $id477 = document.querySelector("#tipoPago");

 	      		     $("#tipoPago").empty();

	                 $.each(data['TiposPagos'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id477.appendChild(option);
 	      		      });


                     const $id437 = document.querySelector("#formaPago");

 	      		     $("#formaPago").empty();

	                 $.each(data['FormasPagos'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id437.appendChild(option);
 	      		      });


                     const $id880 = document.querySelector("#conveniosPaciente");

 	      		     $("#conveniosPaciente").empty();

	                 $.each(data['ConveniosPaciente'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id880.appendChild(option);
 	      		      });


                     const $id882 = document.querySelector("#conveniosPacienteHacia");

 	      		     $("#conveniosPacienteHacia").empty();

	                 $.each(data['ConveniosPaciente'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id882.appendChild(option);
 	      		      });



			var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			var ingresoId = document.getElementById("ingresoId").value;
				
		        data2['liquidacionId'] = data.id;

			alert("Voy a cargar los abonos de esta liquidacion= " + data2['liquidacionId']);
       
			document.getElementById("tipoIngreso").value = data.tipo;

			if (data.tipo == 'INGRESO')
			{

		        data2['ingresoId'] = ingresoId;
			data2['tipoIngreso'] = 'INGRESO'


			}
			else
			{
		        data2['triageId'] = data.triageId1;
			data2['tipoIngreso'] = 'TRIAGE'


			}

		        data2 = JSON.stringify(data2);


			document.getElementById("mensajesError").innerHTML = data.message;

		            arrancaLiquidacion(2,data2);
	  	            dataTableLiquidacionDetalleInitialized = true;

	       		     arrancaLiquidacion(4,data2);
			     dataTableFacAbonosInitialized = true;


                  },
	   		    error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });

        });



	/*--------------------------------------------
        Click to Edit Button PostFacturacon
        --------------------------------------------
        --------------------------------------------*/

        $('body').on('click', '.editPostFacturacion', function () {

          var post_id = $(this).data('pk');
      //    alert("pk1 = " + $(this).data('pk'));
        var username_id = document.getElementById("username_id").value;

	$.ajax({
	           url: '/postConsultaFacturacion/',
	            data : {post_id:post_id, username_id:username_id},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {
                     //   alert("Regrese");
                    //   alert("data="  + data);
			// Colocar Encabezadao
	  		// aqui debe llenar el dato parta posible ANULACION , REFACTURACION
		$('#Afactura').val(data.factura);
		$('#AfechaFactura').val(data.fechaFactura);
		$('#AtipoDoc_id').val(data.tipoDoc);
		$('#Adocumento_id').val(data.documento);
		$('#Apaciente').val(data.paciente);
		$('#AconsecAdmision').val(data.consecAdmision);
		$('#AnombreConvenio').val(data.nombreConvenio);

		 $('#Rfactura').val(data.factura);
		 $('#RfechaFactura').val(data.fechaFactura);
		 $('#RtipoDoc_id').val(data.tipoDoc);
		 $('#Rdocumento_id').val(data.documento);
		 $('#Rpaciente').val(data.paciente);
		 $('#RconsecAdmision').val(data.consecAdmision);
		 $('#RnombreConvenio').val(data.nombreConvenio);


			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;
		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
		        data2['liquidacionId'] = post_id;
		        data2 = JSON.stringify(data2);


		  arrancaLiquidacion(5,data2);
		    dataTableFacturacionDetalleInitialized = true;



			document.getElementById("mensajesError").innerHTML = data.message;

                  },
	   		    error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });

        });

	/*------------------------------------------
        --------------------------------------------
        Click to Button Aplicar Abonos
        --------------------------------------------
        --------------------------------------------*/

  $('body').on('click', '.createAplicarAbono', function () {
             
    var abonoId = $(this).data('pk');	
      
	  $.ajax({
                data: {'abonoId': abonoId},
	        url: "/buscoAbono/",
                type: "POST",
                dataType: 'json',
                success: function (data) {
		            $('#post_id').val('');
		            //  $('#postFormModalApliqueParcial').trigger("reset");
		         $('#modelHeadingAplique').html("Aplicar abono a Factura");
			
			$('#aabonoId').val(data.id);
			
			$('#avalorAbono').val(data.valor);
			$('#aSaldo').val(data.saldo);
			$('#atotalAplicado').val(data.totalAplicado);
			$('#aDescripcionAbono').val(data.descripcion);
			$('#avalorEnCurso').val(data.valorEnCurso);


  var options = '<option value="=================="></option>';

                     const $id477 = document.querySelector("#AtipoPago");

 	      		     $("#AtipoPago").empty();

	                 $.each(data['TiposPagos'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id477.appendChild(option);
 	      		      });



			$('#AtipoPago').val(data.tipoPago_id);
			$('#aformaPago').val(data.formaPago_id);


			if ( data.estadoReg =='A')
			{
			 $('#crearAplique').modal('show');
			}
			else
			{

			$("#mensajes").html('Abono Anulado !');
			}

                },
                error: function (data) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error                }
            });

	});

       /*------------------------------------------
        --------------------------------------------
        Create Post Code Abonos Pero para Aplicar
        --------------------------------------------
        --------------------------------------------*/

	$('#saveBtnApliqueAbonosFacturacion').click(function (e) {
		e.preventDefault();

			var avalorEnCurso = document.getElementById("avalorEnCurso").value;
			var avalorAbono = document.getElementById("avalorAbono").value;
			var aSaldo = document.getElementById("aSaldo").value;
			var aConvenio = document.getElementById("aConvenio").value;

			if ( avalorEnCurso > aSaldo)
			{

			 document.getElementById("mensajesAplique").innerHTML = 'No es posible aplicar mas que el Saldo del Abono';

			   return;
			}

  		  $.ajax({
                data: $('#postFormModalApliqueParcial').serialize(),
	        url: "/guardaApliqueAbonosFacturacion/",
                type: "POST",
                dataType: 'json',
                success: function (data) {
		  $("#mensajes").html(data.message);
                //  $('#postFormModalApliqueParcial').trigger("reset");
    		  $('#crearAplique').modal('hide');


			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;

			var valor = document.getElementById("liquidacionIdA").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;
			data2['liquidacionId'] = valor;


		        data2 = JSON.stringify(data2);

		  arrancaLiquidacion(4,data2);
		    dataTableFacAbonosInitialized = true;
		  arrancaLiquidacion(2,data2);
		    dataTableLiquidacionDetalleInitialized = true;

                },
                error: function (data) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error                }
            });
      });


	/*------------------------------------------
        --------------------------------------------
        Click to Button
        --------------------------------------------
        --------------------------------------------*/
        $('#createNewPostAbonosFacturacion').click(function () {
		var liquidacionId = document.getElementById("liquidacionId").value;
		document.getElementById("liquidacionId1").value =liquidacionId;
	
            $('#post_id').val('');
            $('#postFormCrearAbonosFacturacion').trigger("reset");
            $('#modelHeadingCrearAbonosFacturacion').html("Creacion Abonos en admision");
            $('#crearAbonosModelFacturacion').modal('show');
        });

       /*------------------------------------------
        --------------------------------------------
        Create Post Code Abonos
        --------------------------------------------
        --------------------------------------------*/
        $('#saveBtnCrearAbonosFacturacion').click(function (e) {
            e.preventDefault();
       		alert (" Entre a Grabar el abono");

            $.ajax({
                data: $('#postFormCrearAbonosFacturacion').serialize(),
	        url: "/guardaAbonosFacturacion/",
                type: "POST",
                dataType: 'json',
                success: function (data) {

		   $("#mensajes").html(data.message);
                  $('#postFormCrearAbonosFacturacion').trigger("reset");


			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;

		        data2 = JSON.stringify(data2);


		  arrancaLiquidacion(4,data2);
		    dataTableFacAbonosInitialized = true;
		  arrancaLiquidacion(2,data2);
		    dataTableLiquidacionDetalleInitialized = true;


 		 $('#crearAbonosModelFacturacion').modal('hide');
                },
                error: function (data) {
document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error                }
            });
	LeerTotales();
        });


	/*--------------------------------------------
        Click to Edit Button
        --------------------------------------------
        --------------------------------------------*/
        $('body').on('click', '.editPostLiquidacionDetalle', function () {

          var post_id = $(this).data('pk');


	$.ajax({
	           url: '/postConsultaLiquidacionDetalle/',
	            data : {post_id:post_id},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

                     //  alert("data="  + data);

			 $('#pk').val(data.pk);
	       	        $('#ldconsecutivo').val(data.consecutivo);

			$('#liquidacionDetalleId').val(data.id);

	       	        $('#ldcantidad').val(data.cantidad);
	       	        $('#ldvalorUnitario').val(data.valorUnitario);
	       	        $('#ldvalorTotal').val(data.valorTotal);
	       	        $('#ldobservaciones').val(data.observaciones);
	       	        $('#ldtipoRegistro').val(data.tipoRegistro);


   	     	var options = '<option value="=================="></option>';

		    const $id511 = document.querySelector("#ldcups");


 	      		     $("#ldcups").empty();

	                 $.each(data['Cups'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id511.appendChild(option);
 	      		      });


                     const $id4256 = document.querySelector("#ldsuministros");


 	      		     $("#ldsuministros").empty();

	                 $.each(data['Suministros'], function(key,value) {
                                    options +='<option value="' + value.id + '">' + value.nombre + '</option>';
                                    option = document.createElement("option");
                                    option.value = value.id;
                                    option.text = value.nombre;
                                    $id4256.appendChild(option);
 	      		      });


		 $('#ldcups').val(data.examen_id);
		 $('#ldsuministros').val(data.cums_id);

            $('#modelHeadingLiquidacionDetalle').html("Edicion Liquidacion");
            $('#crearModelLiquidacionDetalle').modal('show');

                  },
	   		    error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });

        });


       /*------------------------------------------
        --------------------------------------------
        Create LiquidacionDetalle
        --------------------------------------------
        --------------------------------------------*/
        $('#saveBtnCrearLiquidacionDetalle').click(function (e) {
            e.preventDefault();
            $(this).html('Sending..');

            $.ajax({
                data: $('#postFormLiquidacionDetalle').serialize(),
		  url: "/editarGuardarLiquidacionDetalle/",
                type: "POST",
                dataType: 'json',
                success: function (data) {
			printErrorMsg(data.error)
                    if ($.isEmptyObject(data.error)) {

                        //  $("input[name='description']").val('');
                        $('#crearModelLiquidacionDetalle').modal('hide');
                        $('.success-msg').css('display','block');
                        $('.success-msg').text(data.message);
                    }else{
                        printErrorMsg(data.error)
                    }
                    $('#postFormLiquidacionDetalle').trigger("reset");
	 	
			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
                        data2['liquidacionId'] = document.getElementById("liquidacionId").value;

		        data2 = JSON.stringify(data2);


			  arrancaLiquidacion(2,data2);
			    dataTableLiquidacionDetalleInitialized = true;

			LeerTotales();


			document.getElementById("mensajesError").innerHTML = data.message;

                },
                error: function (data) {
	document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error

                }
            });
	LeerTotales();
        });


	/*------------------------------------------
        --------------------------------------------
        Delete Post Code Abonos
        --------------------------------------------
        --------------------------------------------*/
        $("body").on("click",".deletePostAbonosFacturacion",function(){
            var current_object = $(this);
            var action = current_object.attr('data-action');
            var id = current_object.attr('data-pk');
		// alert("Voy a borrar el id abono = "+ id);
		   $.ajax({
	           url: '/postDeleteAbonosFacturacion/' ,
	            data : {'id':id},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
                        data2['liquidacionId'] = document.getElementById("liquidacionId").value;
		        data2 = JSON.stringify(data2);


		  arrancaLiquidacion(4,data2);
		    dataTableFacAbonosInitialized = true;
		   			

			document.getElementById("mensajesError").innerHTML = data.message;
                    },
	   		    error: function (request, status, error) {
			alert("Tengo ERROR");

			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	           });
	LeerTotales();
	});


	/*------------------------------------------
        --------------------------------------------
        Delete Post Liquidacion Detalle
        --------------------------------------------
        --------------------------------------------*/
        $("body").on("click",".borrarLiquidacionDetalle",function(){
            var current_object = $(this);
            var action = current_object.attr('data-action');
            var token = $("input[name=csrfmiddlewaretoken]").val();
            var id = current_object.attr('data-pk');

		   $.ajax({
	           url: '/postDeleteLiquidacionDetalle/' ,
	            data : {'id':id},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

		        	  $('.success-msg').css('display','block');
                        $('.success-msg').text(data.message);

			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
                        data2['liquidacionId'] = document.getElementById("liquidacionId").value;

		        data2 = JSON.stringify(data2);

			  arrancaLiquidacion(2,data2);
			    dataTableLiquidacionDetalleInitialized = true;


			LeerTotales();

			document.getElementById("mensajesError").innerHTML = data.message;
                    },
	   		    error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	           });
	});


        /*------------------------------------------
        --------------------------------------------
        Print Error Msg
        --------------------------------------------
        --------------------------------------------*/
        function printErrorMsg(msg) {
            $('.error-msg').find('ul').html('');
            $('.error-msg').css('display','block');
            $.each( msg, function( key, value ) {
                $(".error-msg").find("ul").append('<li>'+value+'</li>');
            });



        }



function AFacturar()
{

	alert ("Entre a facturar ");

 	var liquidacionId = document.getElementById("liquidacionId").value;
 	var username_id = document.getElementById("username_id").value;
	var tipoFactura = document.getElementById("tipoFactura").value;
	var sede = document.getElementById("sede").value;


		$.ajax({
	           url: '/facturarCuenta/',
	            data :
	            {'liquidacionId':liquidacionId, 'username_id':username_id, 'tipoFactura':tipoFactura,'sede':sede},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {
				$('#imprimir').val(data.Factura);

            	        var data2 =  {}   ;
        		data2['username'] = username;
    		        data2['sedeSeleccionada'] = sedeSeleccionada;
	    	        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;

	                var username_id = document.getElementById("username_id").value;
  	                data2['username_id'] = username_id;


		        data2['valor'] = liquidacionId;
			data2['liquidacionId'] = liquidacionId;
		        data2 = JSON.stringify(data2);

			// fecha actual
			let fecha = new Date();

			ano = fecha.getFullYear();
			mes = fecha.getMonth() + 1;
			dia = fecha.getDate();
		        diaDesde = '01'

		        desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
		        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'
		        desdeFactura=0;
		        hastaFactura=0;


			data2['desdeFecha'] = desdeFecha;
			data2['hastaFecha'] = hastaFecha;
			data2['desdeFactura'] = desdeFactura;
			data2['hastaFactura'] = hastaFactura;
			data2['bandera'] = 'Por Fecha';


		        data2 = JSON.stringify(data2);


                     if (data.message != 'Paciente NO tiene Salida Clinica. Consultar medico tratante !')
			{

			    arrancaLiquidacion(2,data2);
			    dataTableFacturacionInitialized = true;

			        arrancaLiquidacion(3,data2);
			    dataTableFacturacionInitialized = true;

		        arrancaLiquidacion(4,data2);
			    dataTableFacturacionInitialized = true;
		
		        arrancaLiquidacion(5,data2);
			    dataTableFacturacionInitialized = true;

			 window.location.reload();
			
			}



document.getElementById("mensajesError").innerHTML = data.message;
                  },
	   		    error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}

function AdicionarLiquidacion()
{

        var cups = document.getElementById("lcups").value;
        var suministros = document.getElementById("lsuministros").value;
        var cantidad = document.getElementById("cantidad").value;
        var valorUnitario = document.getElementById("valorUnitario").value;
        var valorTotal = document.getElementById("valorTotal").value;
        var observaciones = document.getElementById("lobservaciones").value;
        var username_id = document.getElementById("username_id").value;
        var tipoRegistro = document.getElementById("tipoRegistro").value;
 	var liquidacionId = document.getElementById("liquidacionId").value;


		$.ajax({
	           url: '/guardarLiquidacionDetalle/',
	            data :
	            {'cups':cups, 'suministros':suministros,'cantidad':cantidad,  'valorUnitario':valorUnitario,
			'valorTotal':valorTotal,'observaciones':observaciones,
			    'username_id':username_id, 'liquidacionId':liquidacionId, 'tipoRegistro':tipoRegistro},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {


			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
                        data2['liquidacionId'] = document.getElementById("liquidacionId").value;

		        data2 = JSON.stringify(data2);

		        arrancaLiquidacion(2,data2);
		    dataTableLiquidacionDetalleInitialized = true;

			LeerTotales();

		 document.getElementById("lcups").value = '';
	         document.getElementById("lsuministros").value = '';
	         document.getElementById("cantidad").value = '';
	         document.getElementById("valorUnitario").value = '';
	         document.getElementById("valorTotal").value = '';
	         document.getElementById("lobservaciones").value = '';




			document.getElementById("mensajesError").innerHTML = data.message;

                  },
	   		    error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}

function LeerTotales()
{

	// alert ("Entre a LeerTotales ");

 	var liquidacionId = document.getElementById("liquidacionId").value;

		$.ajax({
	           url: '/leerTotales/',
	            data :
	            {'liquidacionId':liquidacionId},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

		$('#totalCopagos').val(data.totalCopagos);
		$('#totalCuotaModeradora').val(data.totalCuotaModeradora);
		$('#totalProcedimientos').val(data.totalProcedimientos);
		$('#totalSuministros').val(data.totalSuministros);
		$('#totalLiquidacion').val(data.totalLiquidacion);
		$('#valorApagar').val(data.totalAPagar);
		$('#anticipos').val(data.totalAnticipos);
		$('#totalAbonos').val(data.totalAbonos);


			document.getElementById("mensajesError").innerHTML = data.message;
                  },
	   		    error: function (request, status, error) {
document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}


function AnularFactura()
{


 	var facturacionId = document.getElementById("Afactura").value;

		$.ajax({
	           url: '/anularFactura/',
	            data :
	            {'facturacionId':facturacionId},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {
				
			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
			data2['tipoIngreso'] = document.getElementById("tipoIngreso").value;

			var valor = document.getElementById("liquidacionId").value;
			var ingresoId = document.getElementById("ingresoId").value;

		        data2['valor'] = valor;
		        data2['ingresoId'] = ingresoId;
                        data2['liquidacionId'] = document.getElementById("liquidacionId").value;

			let fecha = new Date();

			ano = fecha.getFullYear();
			mes = fecha.getMonth() + 1;
			dia = fecha.getDate();
		        diaDesde = '01'

		        desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
		        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'
			//alert("desdefecha1 = "+ desdeFecha);
			// alert("hastafecha1 = "+ hastaFecha);
		        desdeFactura=0;
		        hastaFactura=0;


			data2['desdeFecha'] = desdeFecha;
			data2['hastaFecha'] = hastaFecha;
			data2['desdeFactura'] = desdeFactura;
			data2['hastaFactura'] = hastaFactura;
			data2['bandera'] = 'Por Fecha';
	
		        data2 = JSON.stringify(data2);

        arrancaLiquidacion(3,data2);
	    dataTableFacturacionInitialized = true;
 

		document.getElementById("mensajesError").innerHTML = data.message;

                  },
	   		    error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}


function ReFacturar()
{
	alert ("Entre Refacturar ");

 	var facturacionId = document.getElementById("Rfactura").value;
	alert("Factura No " + facturacionId);
	var username_id = document.getElementById("username_id").value;


		$.ajax({
	           url: '/reFacturar/',
	            data :
	            {'facturacionId':facturacionId, 'username_id':username_id},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {
				$('#imprimir').val(data.Factura);

            	        var data2 =  {}   ;
        		data2['username'] = username;
    		        data2['sedeSeleccionada'] = sedeSeleccionada;
	    	        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;

	                var username_id = document.getElementById("username_id").value;
  	                data2['username_id'] = username_id;
                     //   alert("numero de la liquidacionId = " + liquidacionId);

		        data2['valor'] = liquidacionId;
		        data2 = JSON.stringify(data2);


document.getElementById("mensajesError").innerHTML = data.message;

        arrancaLiquidacion(3,data2);
	    dataTableFacturacionInitialized = true;

                  },
	   		    error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}

function RefrescarLiquidacionDetalle()
{

			 var liquidacionId = document.getElementById("liquidacionId").value;


		$.ajax({
	           url: '/leerTotales/',
	            data :
	            {'liquidacionId':liquidacionId},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {

			

			$('#totalSuministros').val(data.totalSuministros);
			$('#totalProcedimientos').val(data.totalProcedimientos);
			$('#totalCopagos').val(data.totalCopagos);
			$('#totalCuotaModeradora').val(data.totalCuotaModeradora);
			$('#anticipos').val(data.totalAnticipos);
			$('#totalAbonos').val(data.totalAbonos);
			$('#totalRecibido').val(data.totalRecibido);
			$('#totalLiquidacion').val(data.totalLiquidacion);
			$('#valorApagar').val(data.totalAPagar);


			 var data2 =  {}   ;
			data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;

			 var valor = document.getElementById("liquidacionId").value;

		        data2['valor'] = valor;
		        data2['liquidacionId'] = valor;

		        data2 = JSON.stringify(data2);
		      arrancaLiquidacion(2,data2);
		    dataTableLiquidacionDetalleInitialized = true;


		document.getElementById("mensajes").innerHTML = data.message;

                  },
	   		    error: function (request, status, error) {
document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });




}


function ConsultarFacturas()
{
	alert("Entre Consultar Facturas");

        var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;


  	var desdeFactura = document.getElementById("fdesdeFactura").value;
        var hastaFactura = document.getElementById("fhastaFactura").value;

	alert ("desdeFactura = " + desdeFactura )
	alert ("hastaFactura  = " + hastaFactura  )
  	var fFechaDesde = document.getElementById("fFechaDesde").value;
    var fFechaHasta = document.getElementById("fFechaHasta").value;

    var data =  {}   ;
        		data['username'] = username;
    		        data['sedeSeleccionada'] = sedeSeleccionada;
	    	        data['nombreSede'] = nombreSede;
		        data['sede'] = sede;
  	                data['username_id'] = username_id;
		        data['valor'] = liquidacionId;

	data['desdeFecha'] = desdeFecha;
	data['hastaFecha'] = hastaFecha;
	data['desdeFactura'] = desdeFactura;
	data['hastaFactura'] = hastaFactura;

	if (desdeFactura > 0)
	{

		data['bandera'] = 'Factura';
		alert("Entre Bandera Por Factura");

	}
	else
	{
		data['bandera'] = 'Por Fecha';
		alert("Entre BanderaPor Fecha");
	}

        data = JSON.stringify(data);

        arrancaLiquidacion(3,data);
	    dataTableFacturacionInitialized = true;

}

function TrasladoConvenio()
{
	alert ("Entre a Trasladar Convenio ");

 	var liquidacionId = document.getElementById("liquidacionId").value;
 	var tipoIng = document.getElementById("tipoIng").value;
	alert("liquidacionId " + liquidacionId);
	alert("tipoIng " + tipoIng);
	var username_id = document.getElementById("username_id").value;
	var convenioId = document.getElementById("conveniosPaciente").value;
	var convenioIdHacia = document.getElementById("conveniosPacienteHacia").value;
	alert(" Desde convenio = " + convenioId )
	alert(" Nuevo convenioIdHacia = " + convenioIdHacia )


		$.ajax({
	           url: '/trasladarConvenio/',
	            data :
	            {'liquidacionId':liquidacionId, 'tipoIng':tipoIng, 'username_id':username_id, 'convenioId':convenioId, 'convenioIdHacia':convenioIdHacia},
	           type: 'POST',
	           dataType : 'json',
	  		success: function (data) {
			

            	        var data2 =  {}   ;
        		data2['username'] = username;
    		        data2['sedeSeleccionada'] = sedeSeleccionada;
	    	        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;

	                var username_id = document.getElementById("username_id").value;
  	                data2['username_id'] = username_id;
		        data2['valor'] = liquidacionId;
		        data2 = JSON.stringify(data2);

		                arrancaLiquidacion(1,data2);
            	    dataTableLiquidacionInitialized = true;

		                arrancaLiquidacion(2,data2);
            	    dataTableLiquidacionDetalleInitialized = true;


			document.getElementById("mensajes").innerHTML = data.message;


                  },
	   		    error: function (request, status, error) {
	   			   document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
	     });
}

function RefrescarPantalla() {

        var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var data =  {}   ;

        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
        valor=1
        liquidacionId = 1
        data['valor'] = valor;
        data['liquidacionId'] = liquidacionId;
	data['ingresoId'] = valor;
        data['tipoIngreso'] = 'INGRESO'

	// fecha actual
	let fecha = new Date();

	ano = fecha.getFullYear();
	mes = fecha.getMonth() + 1;
	dia = fecha.getDate();
        mes = '0' + mes;
        diaDesde = '01';
	dia='0' + dia;
        mesAnterior = mes +1 ;


        desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'

	 desdeFecha = ano + '-01-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'


        desdeFactura=0;
        hastaFactura=0;


	data['desdeFecha'] = desdeFecha;
	data['hastaFecha'] = hastaFecha;
	data['desdeFactura'] = desdeFactura;
	data['hastaFactura'] = hastaFactura;
	data['bandera'] = 'Por Fecha';

        data = JSON.stringify(data);
        arrancaLiquidacion(1,data);
	    dataTableLiquidacionInitialized = true;

}

function RefrescarFacturas() {

        var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var data =  {}   ;

        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
        valor=1
        data['valor'] = valor;
        data['liquidacionId'] = liquidacionId;
	data['ingresoId'] = valor;


	let fecha = new Date();

	ano = fecha.getFullYear();
	mes = fecha.getMonth() + 1;
	dia = fecha.getDate();
        mes = '0' + mes;
        diaDesde = '01';
	dia='0' + dia;
        mesAnterior = mes +1 ;

        desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'
	 desdeFecha = ano + '-01-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'

        desdeFactura=0;
        hastaFactura=0;

	data['desdeFecha'] = desdeFecha;
	data['hastaFecha'] = hastaFecha;
	data['desdeFactura'] = desdeFactura;
	data['hastaFactura'] = hastaFactura;
	data['bandera'] = 'Por Fecha';

        data = JSON.stringify(data);
        arrancaLiquidacion(3,data);
	    dataTableFacturacionInitialized = true;

}

