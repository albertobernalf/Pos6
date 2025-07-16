console.log('Hola Alberto Hi!')

let dataTable;
let dataTableB;
let dataTableC;
let dataTableD;
let dataTableF;
let dataTableG;
let dataTableH;
let dataTableI;

let dataTableEnviosRipsInitialized = false;
let dataTableEnviosRipsDetalleInitialized = false;
let dataTableDetalleRipsAdicionarInitialized = false;
let dataTableDetalleRipsInitialized = false;
let dataTableRipsTransaccionInitialized = false;
let dataTableRipsUsuariosInitialized = false;
let dataTableRipsProcedimientosInitialized = false;
let dataTableRipsHospitalizacionInitialized = false;
let dataTableRipsMedicamentosInitialized = false;
let dataTableRipsUrgenciasObsInitialized = false;


$(document).ready(function() {
    var table = $('#tablaEnviosRips').DataTable();
    
       $('#search').on('keyup', function() {
        var searchValue = this.value.split(' '); // Supongamos que los términos de búsqueda están separados por espacios
        
        // Aplica la búsqueda en diferentes columnas
        table
            .columns([3]) // Filtra en la primera columna
            .search(searchValue[0]) // Primer término de búsqueda
            .draw();

	  table
            .columns([9]) // Filtra en la segunda columna
            .search(searchValue[1]) // Segundo término de búsqueda
            .draw();


        
        table
            .columns([14]) // Filtra en la segunda columna
            .search(searchValue[1]) // Segundo término de búsqueda
            .draw();
    });
});


function arrancaEnviosRips(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
        let dataTableOptions  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
	    { width: '10%', targets: [2,3] },
	    { width: '10%', targets: [9,10] },
		{  
                    "targets": 16
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
                 url:"/load_dataEnviosRips/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

	     btn = btn + " <button class='miEnvioMinisterio btn-primary ' data-pk='" + row.pk + "'>" + '<i class="fa-duotone fa-regular fa-thumbs-up"></i>' + "</button>";


                       return btn;
                    },

	},

		{
			"render": function ( data, type, row ) {
                        var btn = '';

             btn = btn + " <input type='radio' name='miAutorizacion' class='miSol form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
		}
                    },

                { data: "fields.id"},
                { data: "fields.sedesClinica_id"},
		   { data: "fields.tipoNota"}, 
                { data: "fields.empresa_id"},
                { data: "fields.nombreEmpresa"},
                { data: "fields.fechaEnvio"},
                { data: "fields.fechaRespuesta"},
                { data: "fields.cantidadFacturas"},
                { data: "fields.cantidadPasaron"},
		{ data: "fields.cantidadRechazadas"},
                { data: "fields.estadoMinisterio"},
		 { data: "fields.fechaRegistro"},
		 { data: "fields.usuarioRegistro_id"},
		 { data: "fields.nombreRegistra"},
		  { data: "fields.nombreClinica"},
                        ]
            }
	        dataTable = $('#tablaEnviosRips').DataTable(dataTableOptions);

       // 	$('#tablaAutorizaciones tbody tr:eq(0) .miSol').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript



  }

    if (valorTabla == 2)
    {

        let dataTableOptionsDetalleRipsAdicionar  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                           btn = btn + " <input type='radio'  class='miFactura form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";
                       return btn;
                    },
                    "targets": 7
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
                 url:"/load_dataDetalleRipsAdicionar/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
  		{ data: "fields.id"},
                { data: "fields.factura"},
                { data: "fields.glosaId"},
                { data: "fields.fechaFactura"},
                { data: "fields.paciente"},
                { data: "fields.totalFactura"},
                { data: "fields.estado"},
                     ]
            }

            if  (dataTableDetalleRipsAdicionarInitialized)  {

		            dataTableB = $("#tablaDetalleRipsAdicionar").dataTable().fnDestroy();

                    }

                dataTableB = $('#tablaDetalleRipsAdicionar').DataTable(dataTableOptionsDetalleRipsAdicionar);

	            dataTableDetalleRipsAdicionarInitialized  = true;
      }


// la tres

    if (valorTabla == 3)
    {

        let dataTableOptionsDetalleRips  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
			      btn = btn + " <button class='miMinisterio btn-primary ' data-pk='" + row.pk + "'>" + '<i class="fa-duotone fa-regular fa-thumbs-up"></i>' + "</button>";
			      btn = btn + " <button class='miDetalle btn-primary ' data-pk='" + row.pk + "'>" + '<i class="fa fa-pencil"></i>' + "</button>";

                 	      btn = btn + " <button class='miBorrar btn-primary  ' data-action='post/" + row.pk + "/delete' data-pk='" + row.pk + "'>" + '<i class="fa fa-trash"></i>' + "</button>";

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
                 url:"/load_dataDetalleRips/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		 { data: "fields.id"},
                { data: "fields.numeroFactura"},
                { data: "fields.glosaId"},
                { data: "fields.cuv"},
                { data: "fields.estadoPasoMinisterio"},
                { data: "fields.rutaJsonRespuesta"},
                { data: "fields.rutaJsonFactura"},
                { data: "fields.rutaPdf"},
                { data: "fields.rutaZip"},
		 { data: "fields.usuarioRegistro_id"},
                     ]
            }

            if  (dataTableDetalleRipsInitialized)  {

		            dataTableC = $("#tablaDetalleRips").dataTable().fnDestroy();

                    }

                dataTableC = $('#tablaDetalleRips').DataTable(dataTableOptionsDetalleRips);

	            dataTableDetalleRipsInitialized  = true;
      }


// la cuatro

    if (valorTabla == 4)
    {

        let dataTableOptionsRipsTransaccion  ={
    dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miTransaccion form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

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
                 url:"/load_tablaRipsTransaccion/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	 { data: "fields.id"},
             	 { data: "fields.id"},
                { data: "fields.numDocumentoIdObligado"},
                { data: "fields.numNota"},
                { data: "fields.fechaRegistro"},
                { data: "fields.tipoNota_id"},
                { data: "fields.usuarioRegistro_id"},
                { data: "fields.ripsEnvio_id"},
                { data: "fields.sedesClinica_id"},
                     ]
            }

            if  (dataTableRipsTransaccionInitialized)  {

		            dataTableD = $("#tablaRipsTransaccion").dataTable().fnDestroy();

                    }

                dataTableD = $('#tablaRipsTransaccion').DataTable(dataTableOptionsRipsTransaccion);

	            dataTableRipsTransaccionInitialized  = true;
      }



// la cinco

    if (valorTabla == 5)
    {

        let dataTableOptionsRipsUsuarios  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miUsuarios form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },
                    "targets": 16
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
                 url:"/load_tablaRipsUsuarios/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	 { data: "fields.id"},
             	 { data: "fields.id"},
                { data: "fields.tipoDocumentoIdentificacion"},
                { data: "fields.tipoUsuario"},
                { data: "fields.fechaNacimiento"},
                { data: "fields.codSexo"},
                { data: "fields.codZonaTerritorialResidencia"},
                { data: "fields.incapacidad"},
                { data: "fields.consecutivo"},
                { data: "fields.fechaRegistro"},
                { data: "fields.codMunicipioResidencia_id"},
                { data: "fields.codPaisOrigen_id"},
                { data: "fields.codPaisResidencia_id"},
                { data: "fields.usuarioRegistro_id"},
                { data: "fields.numDocumentoIdentificacion"},
                { data: "fields.ripsDetalle_id"},
                { data: "fields.ripsTransaccion_id"},

                     ]
            }

            if  (dataTableRipsUsuariosInitialized)  {

		            dataTableE = $("#tablaRipsUsuarios").dataTable().fnDestroy();

                    }

                dataTableE = $('#tablaRipsUsuarios').DataTable(dataTableOptionsRipsUsuarios);

	            dataTableRipsUsuariosInitialized  = true;
      }


// la seis

    if (valorTabla == 6)
    {

        let dataTableOptionsRipsProcedimientos  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miProcedimientos form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },
                    "targets": 16
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
                 url:"/load_tablaRipsProcedimientos/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	 { data: "fields.id"},
              	 { data: "fields.id"},
                { data: "fields.codPrestador"},
                { data: "fields.fechaInicioAtencion"},
                { data: "fields.idMIPRES"},
                { data: "fields.numAutorizacion"},
                { data: "fields.numDocumentoIdentificacion"},
                { data: "fields.vrServicio"},
                { data: "fields.valorPagoModerador"},
                { data: "fields.numFEVPagoModerador"},
                { data: "fields.consecutivo"},
                { data: "fields.codComplicacion_id"},
                { data: "fields.codDiagnosticoPrincipal_id"},
                { data: "fields.codDiagnosticoRelacionado_id"},
                { data: "fields.codProcedimiento_id"},
                { data: "fields.codServicio_id"},
                { data: "fields.conceptoRecaudo_id"},

                { data: "fields.finalidadTecnologiaSalud_id"},
                { data: "fields.grupoServicios_id"},
                { data: "fields.modalidadGrupoServicioTecSal_id"},
                { data: "fields.tipoDocumentoIdentificacion_id"},
                { data: "fields.usuarioRegistro_id"},
                { data: "fields.viaIngresoServicioSalud_id"},
                { data: "fields.ripsDetalle_id"},
                { data: "fields.tipoPagoModerador_id"},



                     ]
            }

            if  (dataTableRipsProcedimientosInitialized)  {

		            dataTableF = $("#tablaRipsProcedimientos").dataTable().fnDestroy();

                    }

                dataTableF = $('#tablaRipsProcedimientos').DataTable(dataTableOptionsRipsProcedimientos);

	            dataTableRipsProcedimientosInitialized  = true;
      }



// la siete

    if (valorTabla == 7)
    {

        let dataTableOptionsRipsHospitalizacion  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miProcedimientos form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },
                    "targets": 20
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
                 url:"/load_tablaRipsHospitalizacion/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	 { data: "fields.id"},
  	 { data: "fields.id"},
                { data: "fields.codPrestador"},
                { data: "fields.fechaInicioAtencion"},
                { data: "fields.numAutorizacion"},
                { data: "fields.fechaEgreso"},
                { data: "fields.consecutivo"},
                { data: "fields.fechaRegistro"},
                { data: "fields.causaMotivoAtencion_id"},
                { data: "fields.codComplicacion_id"},
                { data: "fields.codDiagnosticoCausaMuerte_id"},
                { data: "fields.codDiagnosticoPrincipal_id"},
                { data: "fields.codDiagnosticoPrincipalE_id"},
                { data: "fields.codDiagnosticoRelacionadoE1_id"},
                { data: "fields.codDiagnosticoRelacionadoE2_id"},
                { data: "fields.codDiagnosticoRelacionadoE3_id"},
                { data: "fields.condicionDestinoUsuarioEgreso_id"},
                { data: "fields.usuarioRegistro_id"},
                { data: "fields.viaIngresoServicioSalud_id"},
                { data: "fields.ripsDetalle_id_id"},
                { data: "fields.ripsTiposNotas_id"},

                     ]
            }

            if  (dataTableRipsHospitalizacionInitialized)  {

		            dataTableG = $("#tablaRipsHospitalizacion").dataTable().fnDestroy();

                    }

                dataTableG = $('#tablaRipsHospitalizacion').DataTable(dataTableOptionsRipsHospitalizacion);

	            dataTableRipsHospitalizacionInitialized  = true;
      }



// la ocho

    if (valorTabla == 8)
    {

        let dataTableOptionsRipsMedicamentos  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miMedicamentos form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },
                    "targets": 15
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
                 url:"/load_tablaRipsMedicamentos/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		 { data: "fields.id"},
	 	  { data: "fields.codPrestador"},
	  { data: "fields.numAutorizacion"},
	  { data: "fields.idMIPRES"},
	  { data: "fields.fechaDispensAdmon"},
	  { data: "fields.nomTecnologiaSalud"},
	  { data: "fields.concentracionMedicamento"},
	  { data: "fields.cantidadMedicamento"},
	  { data: "fields.diasTratamiento"},
	  { data: "fields.numDocumentoIdentificacion"},
	{ data: "fields.vrUnitMedicamento"},
	  { data: "fields.vrServicio"},
	  { data: "fields.valorPagoModerador"},
	  { data: "fields.numFEVPagoModerador"},
	  { data: "fields.consecutivo"},
	


                     ]
            }

            if  (dataTableRipsMedicamentosInitialized)  {

		            dataTableH = $("#tablaRipsMedicamentos").dataTable().fnDestroy();

                    }

                dataTableH = $('#tablaRipsMedicamentos').DataTable(dataTableOptionsRipsMedicamentos);

	            dataTableRipsMedicamentosInitialized  = true;
      }



// la nueva

    if (valorTabla == 9)
    {

        let dataTableOptionsRipsUrgenciasObs  ={
   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
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
                          btn = btn + " <input type='radio' class='miUrgenciasObs form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },
                    "targets": 17
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
                 url:"/load_tablaRipsUrgenciasObs/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		 { data: "fields.id"},
                { data: "fields.codPrestador"},
                { data: "fields.fechaInicioAtencion"},
                { data: "fields.fechaEgreso"},
                { data: "fields.consecutivo"},
                { data: "fields.fechaRegistro"},
                { data: "fields.causaMotivoAtencion_id"},
                { data: "fields.codDiagnosticoCausaMuerte_id"},
                { data: "fields.codDiagnosticoPrincipal_id"},
                { data: "fields.codDiagnosticoPrincipalE_id"},
                { data: "fields.codDiagnosticoRelacionadoE1_id"},
                { data: "fields.codDiagnosticoRelacionadoE2_id"},
                { data: "fields.codDiagnosticoRelacionadoE3_id"},
                { data: "fields.condicionDestinoUsuarioEgreso_id"},
                { data: "fields.usuarioRegistro_id"},
                { data: "fields.ripsDetalle_id_id"},
                { data: "fields.ripsTipos_id"},
                     ]
            }

            if  (dataTableRipsUrgenciasObsInitialized)  {

		            dataTableG = $("#tablaRipsUrgenciasObs").dataTable().fnDestroy();

                    }

                dataTableG = $('#tablaRipsUrgenciasObs').DataTable(dataTableOptionsRipsUrgenciasObs);

	            dataTableRipsUrgenciasObsInitialized  = true;
      }




}

const initDataTableEnviosRips = async () => {
	if  (dataTableEnviosRipsInitialized)  {
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
 	    data = JSON.stringify(data);

	alert("sede = " + sede);

        arrancaEnviosRips(1,data);
	    dataTableEnviosRipsInitialized = true;
}

 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTableEnviosRips();
	 $('#tablaEnviosRips tbody tr:eq(0) .miSol').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript

});


 /* FIN ONLOAD */


 $('#tablaEnviosRips tbody').on('click', '.miSol', function() {

        var post_id = $(this).data('pk');
	var row = $(this).closest('tr'); // Encuentra la fila

        var data =  {}   ;

		var table = $('#tablaEnviosRips').DataTable();  // Inicializa el DataTable jquery 	      

  	        var rowindex = table.row(row).data(); // Obtiene los datos de la fila


	        console.log(" fila selecciona de vuelta AQUI PUEDE ESTAR EL PROBLEMA = " ,  table.row(row).data());
	        dato1 = Object.values(rowindex);
		console.log(" fila seleccionad d evuelta dato1 = ",  dato1);
	        dato3 = dato1[2];
		console.log(" fila selecciona de vuelta dato3 = ",  dato3);
	        console.log ( "dato10 empresa = " , dato3.empresa_id); 

		var id_empresa = dato3.empresa_id;  // jquery
		var tipoRips = dato3.tipoNota;  // jquery

		data['empresaId'] = id_empresa;
		data['envioRipsId'] = post_id;
		data['tipoRips'] = tipoRips;
		// data['factura_id'] = dato3.factura_id;

		alert("id_empresa = "  + id_empresa);
		alert("tipoRips = "  + tipoRips);
		alert("envioRipsId = "  +  post_id);
		// alert("factura_id = "  +  dato3.factura_id);

	        data = JSON.stringify(data);

		document.getElementById("empresaId").value = id_empresa;
		document.getElementById("envioRipsId").value = post_id;
		document.getElementById("tipoRips2").value = tipoRips;	

		document.getElementById("empresaId1").value = id_empresa;
		document.getElementById("envioRipsId1").value = post_id;
		document.getElementById("tipoRips1").value = tipoRips;

		document.getElementById("empresaId3").value = id_empresa;
		document.getElementById("envioRipsId3").value =post_id;
		document.getElementById("tipoRips3").value = tipoRips;

		 document.getElementById("envioRipsIdJ").value = post_id;
		 document.getElementById("EnvioRipsNo").value = post_id;


		   arrancaEnviosRips(2,data);
  			dataTableDetalleRipsAdicionarInitialized  = true;

		   arrancaEnviosRips(3,data);
  			dataTableDetalleRipsInitialized  = true;

		   arrancaEnviosRips(4,data);
 			 dataTableRipsTransaccionInitialized= true;

		   arrancaEnviosRips(5,data);
 			 dataTableRipsUsuariosInitialized= true;


		   arrancaEnviosRips(6,data);
 			 dataTableRipsProcedimientosInitialized= true;

		   arrancaEnviosRips(7,data);
 			 dataTableRipsHospitalizacionInitialized= true;

		   arrancaEnviosRips(8,data);
 			 dataTableRipsMedicamentosInitialized= true;

		   arrancaEnviosRips(9,data);
 			 dataTableRipsUrgenciasObsInitialized= true;


  });




$('#tablaEnviosRips tbody').on('click', '.miEnvioMinisterio', function() {

		alert("ENTRE envio  miniusterio");

	     var post_id = $(this).data('pk');
	var envioRipsId = document.getElementById("envioRipsId").value ;
	var row = $(this).closest('tr'); // Encuentra la fila

	// Nop estop toca por el DOM - html traer el valopr d ela columna



	tipoRips =   document.getElementById("tipoRips2").value ;
	alert("tipoRips = " +  tipoRips);



     
	$.ajax({

	        url: "/traerJsonEnvioRips/",
                data: {'envioRipsId':envioRipsId,'tipoRips':tipoRips},
                type: "POST",
                dataType: 'json',
                success: function (info) {

            $('#postFormRipsEnvioJson').trigger("reset");

  	
 				$('#valorJsonP').val(info[0].fields.valorJson);
				$('#envioRipsIdP').val(envioRipsId);


				

            $('#modelHeadingRipsEnvioJson').html("Detalle Envios Rips");
            $('#crearModelRipsEnvioJson').modal('show');

                },
                 error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });
      
  });






// FIN DE LO NUEVO



 $('#tablaDetalleRipsAdicionar tbody').on('click', '.miFactura', function() {

        var post_id = $(this).data('pk');
	var row = $(this).closest('tr'); // Encuentra la fila
	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
	var empresaId = document.getElementById("empresaId").value; 
	var envioRipsId = document.getElementById("envioRipsId").value ;
	var tipoRips = document.getElementById("tipoRips2").value ;


	var table = $('#tablaDetalleRipsAdicionar').DataTable();  // Inicializa el DataTable jquery 	      
        var rowindex = table.row(row).data(); // Obtiene los datos de la fila
        dato1 = Object.values(rowindex);
	console.log(" fila seleccionad d evuelta dato1 = ",  dato1);
        dato3 = dato1[2];
	console.log(" fila selecciona de vuelta dato3 = ",  dato3);
	console.log(" fila selecciona de vuelta dato3 = ",  dato3);
	console.log(" fila selecciona de vuelta dato3  glosaId= ",  dato3.glosaId);
	console.log(" fila selecciona de vuelta dato3 factura = ",  dato3.factura);


        var facturaId = dato3.factura;
        var glosaId = dato3.glosaId;

	$.ajax({

	        url: "/actualizarEmpresaDetalleRips/",
                data: {'facturaId':facturaId, 'glosaId':glosaId, 'empresaId':empresaId,'envioRipsId':envioRipsId, 'username_id':username_id, 'tipoRips':tipoRips},
                type: "POST",
                dataType: 'json',
                success: function (data2) {
	        var data =  {}   ;
	        data['username'] = username;
	        data['sedeSeleccionada'] = sedeSeleccionada;
	        data['nombreSede'] = nombreSede;
	        data['sede'] = sede;
	        data['username_id'] = username_id;
		data['empresaId'] = empresaId;
		data['envioRipsId'] = envioRipsId;
		data['tipoRips'] = tipoRips;

	        data = JSON.stringify(data);

		 arrancaEnviosRips(2,data);
  			dataTableDetalleRipsAdicionarInitialized  = true;
		   arrancaEnviosRips(3,data);
  			dataTableDetalleRipsInitialized  = true;


                },
                 error: function (request, status, error) {
	   			    $("#mensajes").html(" !  Reproduccion  con error !");
	   	    	}
            });

  });

 $('#tablaDetalleRips tbody').on('click', '.miDetalle', function() {

     var post_id = $(this).data('pk');


       var detalleRipsId = post_id;


	$.ajax({

	        url: "/traeDetalleRips/",
                data: {'detalleRipsId':post_id},
                type: "POST",
                dataType: 'json',
                success: function (info) {

            $('#postFormRipsDetalle').trigger("reset");

  	
 				$('#detalleRipsId').val(detalleRipsId);
				
  		        	$('#numeroFacturaT').val(info[0].fields.numeroFactura_id);
        	       	$('#cuv').val(info[0].fields.cuv);
	                $('#estadoPasoMinisterio').val(info[0].fields.estadoPasoMinisterio);
	                $('#rutaJsonRespuesta').val(info[0].fields.rutaJsonRespuesta);
	                $('#rutaJsonFactura').val(info[0].fields.rutaJsonFactura);
	                $('#fechaRegistro').val(info[0].fields.fechaRegistro);
	                $('#estadoReg').val(info[0].fields.estadoReg);
	                $('#ripsEnvios').val(info[0].fields.ripsEnvios_id);
	                $('#usuarioRegistro_id').val(info[0].fields.usuarioRegistro_id);
	                $('#estado').val(info[0].fields.estado);
	                $('#rutaPdf').val(info[0].fields.rutaPdf);
	                $('#rutaZip').val(info[0].fields.rutaZip);


            $('#modelHeadingRipsDetalle').html("Detalle Envios Rips");
            $('#crearModelRipsDetalle').modal('show');

                },
                 error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });



  });


/* ---------------------------------
Para borrar detalle rips
------------------------------------*/


$('#tablaDetalleRips tbody').on('click', '.miBorrar', function() {

	     var post_id = $(this).data('pk');

        var envioDetalleRipsId = post_id;
	var envioRipsId = document.getElementById("envioRipsId").value ;
	var empresaId = document.getElementById("empresaId").value ;


      
	$.ajax({

	        url: "/borrarDetalleRips/",
                data: {'envioDetalleRipsId':envioDetalleRipsId},
                type: "POST",
                dataType: 'json',
                success: function (info) {

		    $("#mensajes").html(info);

		  var data =  {}   ;
		var tipoRips = document.getElementById("tipoRips2").value;
tipoRips2
		var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
	        var username = document.getElementById("username").value;
	        var nombreSede = document.getElementById("nombreSede").value;
	    	var sede = document.getElementById("sede").value;
	        var username_id = document.getElementById("username_id").value;
		var empresaId = document.getElementById("empresaId").value; 

	        data['username'] = username;
	        data['sedeSeleccionada'] = sedeSeleccionada;
	        data['nombreSede'] = nombreSede;
	        data['sede'] = sede;
	        data['username_id'] = username_id;
		data['envioRipsId'] = envioRipsId;
		data['envioDetalleRipsId'] = envioDetalleRipsId;
		data['empresaId'] = empresaId;
		data['tipoRips'] = tipoRips;
	        data = JSON.stringify(data);

  	
	 		  arrancaEnviosRips(2,data);
  			dataTableDetalleRipsAdicionarInitialized  = true;
			   arrancaEnviosRips(3,data);
  			dataTableDetalleRipsInitialized  = true;
			   arrancaEnviosRips(4,data);
				

                },
                 error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });
      
  });



$('#tablaDetalleRips tbody').on('click', '.miMinisterio', function() {

		alert("Entre Factura Rips ");

	     var post_id = $(this).data('pk');
	var envioRipsId = document.getElementById("envioRipsId").value ;
	var row = $(this).closest('tr'); // Encuentra la fila

	var table = $('#tablaDetalleRips').DataTable();  // Inicializa el DataTable jquery//
	
 	var rowindex = table.row(row).data(); // Obtiene los datos de la fila
       console.log("rowindex= " , rowindex);

	
	var facturaId = table.row(0).cell(rowindex, 1).data();  // jquery

	      dato1 = Object.values(rowindex);
		console.log(" fila seleccionad d evuelta dato1 = ",  dato1);
	        dato3 = dato1[2];
		console.log(" fila selecciona de vuelta dato3 = ",  dato3);
	        console.log ( "la factura es =  = " , dato3.numeroFactura); 

	var facturaId = dato3.numeroFactura;
        var glosaId = dato3.glosaId;

		tipoRips =   document.getElementById("tipoRips2").value ;
	alert("tipoRips = " +  tipoRips);
	alert("facturaId = " +  facturaId);
	alert("envioRipsId = " + envioRipsId);
	alert("glosaId = " + glosaId);

     
	$.ajax({

	        url: "/traerJsonRips/",
                data: {'envioRipsId':envioRipsId,'facturaId':facturaId,'tipoRips':tipoRips,'glosaId':glosaId},
                type: "POST",
                dataType: 'json',
                success: function (info) {

            $('#postFormRipsJson').trigger("reset");

  				
 				$('#valorJson').val(info[0].fields.valorJson);
				$('#envioRipsIdJ').val(envioRipsId);

			

				if (tipoRips=='Glosa')
					{
					alert("Entre glosa");

					$('#facturaIdJ').val(glosaId);
					}
				else
					{
					$('#facturaIdJ').val(facturaId);
					}


				

            $('#modelHeadingRipsJson').html("Detalle Factura Rips");
            $('#crearModelRipsJson').modal('show');

                },
                 error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });
      
  });


	/*------------------------------------------
        --------------------------------------------
        Create GuardarDetalleRips
        --------------------------------------------
        --------------------------------------------*/


function GuardarDetalleRips()
{

            $.ajax({
                data: $('#postFormRipsDetalle').serialize(),
	        url: "/guardaDetalleRips/",
                type: "POST",
                dataType: 'json',
                success: function (data2) {
		   $("#mensajes").html(data2.message);
                  $('#postFormDetalleRips').trigger("reset");

	        var data =  {}   ;
		var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
	        var username = document.getElementById("username").value;
	        var nombreSede = document.getElementById("nombreSede").value;
	    	var sede = document.getElementById("sede").value;
	        var username_id = document.getElementById("username_id").value;


	        data['username'] = username;
	        data['sedeSeleccionada'] = sedeSeleccionada;
	        data['nombreSede'] = nombreSede;
	        data['sede'] = sede;
	        data['username_id'] = username_id;

		data['empresaId'] = empresaId;
		data['envioRipsId'] = envioRipsId;
	        data = JSON.stringify(data);

		  var tableA = $('#tablaDetalleRips').DataTable();
	          tableA.ajax.reload();

 		 $('#crearModelRipsDetalle').modal('hide');
                },
               error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });


}

	
function CrearEnviosRips()
{
	var sede = document.getElementById("sede").value;

	document.getElementById("sedesClinica_id").value =  sede;

            $.ajax({
                data: $('#postFormEnviosRips').serialize(),
	        url: "/guardaEnviosRips/",
                type: "POST",
                dataType: 'json',
                success: function (data2) {
		   $("#mensajes").html(data2.message);
                  $('#postFormEnviosRips').trigger("reset");

		var data =  {}   ;
	        data['username'] = username;
	       data['sedeSeleccionada'] = sedeSeleccionada;
	       data['nombreSede'] = nombreSede;
	      data['sede'] = sede;
	var tipoRips = document.getElementById("tipoRips2").value ;
	data['tipoRips'] = tipoRips;
	        data['username_id'] = username_id;
        data = JSON.stringify(data);
	
		

        arrancaEnviosRips(1,data);
	    dataTableEnviosRipsInitialized = true;


 		 $('#crearModelEnviosRips').modal('hide');
                },
            error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });


}



/*------------------------------------------
        --------------------------------------------
        EnvioRips
        --------------------------------------------
        --------------------------------------------*/

function EnvioRips()
{
    
	
	
            $('#post_id').val('');
            $('#postFormCrearEnviosRips').trigger("reset");
            $('#modelHeadingEnviosRips').html("Creacion Envios Rips");
var sede = document.getElementById("sede").value;
	document.getElementById("sedesClinica_id").value =  sede;
            $('#crearModelEnviosRips').modal('show');
        
}


function GenerarJsonRips()
{


	var envioRipsId = document.getElementById("envioRipsId1").value ;

	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
	var tipoRips = document.getElementById("tipoRips1").value;


        var username_id = document.getElementById("username_id").value;

            $.ajax({

	        url: "/generarJsonRips/",
		data: {'envioRipsId':envioRipsId, 'sede':sede, 'username_id':username_id,'tipoRips':tipoRips},
                type: "POST",
                dataType: 'json',
                success: function (data2) {

	
		var data =  {}   ;
	        data['username'] = username;
	       data['sedeSeleccionada'] = sedeSeleccionada;
	       data['nombreSede'] = nombreSede;
	      data['sede'] = sede;
	        data['username_id'] = username_id;
	        data = JSON.stringify(data);
	
		  var tableA = $('#tablaEnviosRips').DataTable();
	          tableA.ajax.reload();

		document.getElementById("mensajesError").innerHTML = data2.message;
                         },
               error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });


}


function EnviarJsonRips()
{


	var envioRipsId = document.getElementById("envioRipsId3").value ;

	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
	var tipoRips = document.getElementById("tipoRips3").value;


        var username_id = document.getElementById("username_id").value;

            $.ajax({

	        url: "/enviarJsonRips/",
		data: {'envioRipsId':envioRipsId, 'sede':sede, 'username_id':username_id,'tipoRips':tipoRips},
                type: "POST",
                dataType: 'json',
                success: function (data2) {
		
		var data =  {}   ;
	        data['username'] = username;
	       data['sedeSeleccionada'] = sedeSeleccionada;
	       data['nombreSede'] = nombreSede;
	      data['sede'] = sede;
	        data['username_id'] = username_id;
	        data = JSON.stringify(data);
	
		  var tableA = $('#tablaEnviosRips').DataTable();
	          tableA.ajax.reload();


		document.getElementById("mensajesError").innerHTML = data2.message;
                         },
               error: function (request, status, error) {
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });


}

function CerrarModalJson()
{

            $('#crearModelRipsJson').modal('hide');
}

function CerrarModalEnvioJson()
{

            $('#crearModelRipsEnvioJson').modal('hide');
}

function GuardarRadicacionRips()
{

	alert("Entre GuardarRadicacionRips");


	var envioRipsId = document.getElementById("EnvioRipsNo").value ;

	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var username_id = document.getElementById("username_id").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
	var fechaRadicacion = document.getElementById("fechaRadicacion").value;


        var username_id = document.getElementById("username_id").value;

            $.ajax({

	        url: "/guardarRadicacionRips/",
		data: {'envioRipsId':envioRipsId, 'sede':sede, 'username_id':username_id,'fechaRadicacion':fechaRadicacion},
                type: "POST",
                dataType: 'json',
                success: function (data2) {
		
		var data =  {}   ;
	        data['username'] = username;
	       data['sedeSeleccionada'] = sedeSeleccionada;
	       data['nombreSede'] = nombreSede;
	      data['sede'] = sede;
	        data['username_id'] = username_id;
	        data = JSON.stringify(data);
	


		document.getElementById("mensajesError").innerHTML = data2.message;
                         },
               error: function (request, status, error) {
			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
	   	    	}
            });
}

