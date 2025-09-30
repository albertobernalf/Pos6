console.log('Hola Alberto Hi Info!')

let dataTableRadiologia;
let dataTableLaboratorio;
let dataTableTerapia;
let dataTableNoQx;
let dataTableAntecedente;
let dataTableNotasEnfermeria;
let dataTableMedicamento;
let dataTableSignoVital;
let dataTableInterConsulta;



let dataTableRadiologiaInfoInitialized = false;
let dataTableLaboratorioInfoInitialized = false;
let dataTableTerapiaInfoInitialized = false;
let dataTableNoQxInfoInitialized = false;
let dataTableAntecedenteInfoInitialized = false;
let dataTableNotasEnfermeriaInfoInitialized = false;
let dataTableSignosVitalInfoInitialized = false;
let dataTableMedicamentoInfoInitialized = false;
let dataTableInterConsultaInfoInitialized = false;

function arrancaInfoClinico(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
	

        let dataTableOptionsInfoRadiologia  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoRadiologia/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
                { data: "fields.folio"},
                { data: "fields.fecha"},
                { data: "fields.fechaTomado"},
                { data: "fields.fechaReporte"},
                { data: "fields.examen"},
                { data: "fields.interpretacion"},
                { data: "fields.fechaInterpretacion"},
                { data: "fields.estado"},
            ]
            }

            if  (dataTableRadiologiaInfoInitialized )  {

		            dataTableRadiologia = $("#tablaInfoRadiologia").dataTable().fnDestroy();

                    }

	        dataTableRadiologia = $('#tablaInfoRadiologia').DataTable(dataTableOptionsInfoRadiologia);


	            dataTableRadiologiaInfoInitialized  = true;
      }


    if (valorTabla == 2)
    {
	

        let dataTableOptionsInfoLaboratorio  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoLaboratorio/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
                { data: "fields.folio"},
                { data: "fields.fecha"},
                { data: "fields.fechaTomado"},
                { data: "fields.fechaReporte"},
                { data: "fields.examen"},
                { data: "fields.interpretacion"},
                { data: "fields.fechaInterpretacion"},
                { data: "fields.estado"},
            ]
            }

            if  (dataTableLaboratorioInfoInitialized )  {

		            dataTableLaboratorio = $("#tablaInfoLaboratorio").dataTable().fnDestroy();

                    }

	        dataTableLaboratorio = $('#tablaInfoLaboratorio').DataTable(dataTableOptionsInfoLaboratorio);


	            dataTableRadiologiaInfoInitialized  = true;
      }



    if (valorTabla == 3)
    {
	

        let dataTableOptionsInfoTerapia  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoTerapia/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
                { data: "fields.folio"},
                { data: "fields.fecha"},
                { data: "fields.fechaTomado"},
                { data: "fields.fechaReporte"},
                { data: "fields.examen"},
                { data: "fields.interpretacion"},
                { data: "fields.fechaInterpretacion"},
                { data: "fields.estado"},
            ]
            }

            if  (dataTableTerapiaInfoInitialized )  {

		            dataTableTerapia = $("#tablaInfoTerapia").dataTable().fnDestroy();

                    }

	        dataTableTerapia = $('#tablaInfoTerapia').DataTable(dataTableOptionsInfoTerapia);


	            dataTableTerapiaInfoInitialized  = true;
      }



    if (valorTabla == 4)
    {
	

        let dataTableOptionsInfoNoQx  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoNoQx/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
                { data: "fields.folio"},
                { data: "fields.fecha"},
                { data: "fields.fechaTomado"},
                { data: "fields.fechaReporte"},
                { data: "fields.examen"},
                { data: "fields.interpretacion"},
                { data: "fields.fechaInterpretacion"},
                { data: "fields.estado"},
            ]
            }

            if  (dataTableNoQxInfoInitialized )  {

		            dataTableNoQx = $("#tablaInfoNoQx").dataTable().fnDestroy();

                    }

	        dataTableNoQx = $('#tablaInfoNoQx').DataTable(dataTableOptionsInfoNoQx);


	            dataTableNoQxInfoInitialized  = true;
      }



    if (valorTabla == 5)
    {
	

        let dataTableOptionsInfoAntecedente  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                       return btn;
                    },
                    "targets": 5
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
                 url:"/load_dataInfoAntecedente/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
		{ data: "fields.folio"},
                { data: "fields.fechaRegistro"},
                { data: "fields.tipo"},
                { data: "fields.descripcion"},
            ]
            }

            if  (dataTableAntecedenteInfoInitialized )  {

		            dataTableAntecedente = $("#tablaInfoAntecedente").dataTable().fnDestroy();

                    }

	        dataTableAntecedente = $('#tablaInfoAntecedente').DataTable(dataTableOptionsInfoAntecedente);


	            dataTableAntecedenteInfoInitialized  = true;
      }



    if (valorTabla == 6)
    {
	

        let dataTableOptionsInfoNotasEnfermeria  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                       return btn;
                    },
                    "targets": 4
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
                 url:"/load_dataInfoNotasEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
		{ data: "fields.folio"},
                { data: "fields.fechaRegistro"},
                { data: "fields.nota"},
            ]
            }

            if  (dataTableNotasEnfermeriaInfoInitialized )  {

		            dataTableNotasEnfermeria = $("#tablaInfoNotasEnfermeria").dataTable().fnDestroy();

                    }

	        dataTableNotasEnfermeria = $('#tablaInfoNotasEnfermeria').DataTable(dataTableOptionsInfoNotasEnfermeria);


	            dataTableNotasEnfermeriaInfoInitialized  = true;
      }


    if (valorTabla == 7)
    {
	

        let dataTableOptionsInfoMedicamento  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoMedicamento/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
		{ data: "fields.folio"},
                { data: "fields.fechaFormulado"},
                { data: "fields.formulado"},
                { data: "fields.suministroAplicado"},
                { data: "fields.consec"},
                { data: "fields.fechaPlanea"},
                { data: "fields.fechaAplica"},
                { data: "fields.cantidadAplicada"},

            ]
            }

            if  (dataTableMedicamentoInfoInitialized )  {

		            dataTableMedicamento = $("#tablaInfoMedicamento").dataTable().fnDestroy();

                    }

	        dataTableMedicamento = $('#tablaInfoMedicamento').DataTable(dataTableOptionsInfoMedicamento);


	            dataTableMedicamentoInfoInitialized  = true;
      }


    if (valorTabla == 8)
    {
	

        let dataTableOptionsInfoInterConsulta  ={

   dom: "<'row mb-1'<'col-sm-3'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5'i><'col-sm-7'p>>",
  buttons: [
    {
      extend: 'excelHtml5',
      text: '<i class="fas fa-file-excel"></i> ',
	// text: '<i class="bi bi-file-earmark-excel-fill"></i> Exportar Excel',
      titleAttr: 'Exportar a Excel',
      className: 'btn btn-success btn-sm',
    },
    {
      extend: 'pdfHtml5',
      text: '<i class="fas fa-file-pdf"></i> ',
      titleAttr: 'Exportar a PDF',
      className: 'btn btn-danger btn-sm',
    },
    {
      extend: 'print',
      text: '<i class="fa fa-print"></i> ',
      titleAttr: 'Imprimir',
      className: 'btn btn-info btn-sm',
    },
  ],
autoWidth: false,
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '200px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		  { width: '15%',  targets: [2,3] },
		{     "render": function ( data, type, row ) {
                        var btn = '';
                         // btn = btn + " <button   class='btn btn-primary editPostLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
                         //btn = btn + " <button   class='btn btn-primary borrarLiquidacionDetalle' data-pk='" + row.pk + "'>" + "</button>";
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
                 url:"/load_dataInfoInterConsulta/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{ data: "fields.id"},
		{ data: "fields.folio"},
                { data: "fields.fechaRegistro"},
                { data: "fields.tipo"},
                { data: "fields.medicoConsulta"},
                { data: "fields.descripcionConsulta"},
                { data: "fields.medicoResponde"},
                { data: "fields.respuestaConsulta"},


            ]
            }

            if  (dataTableInterConsultaInfoInitialized )  {

		            dataTableInterConsulta = $("#tablaInfoInterConsulta").dataTable().fnDestroy();

                    }

	        dataTableInterConsulta = $('#tablaInfoInterConsulta').DataTable(dataTableOptionsInfoInterConsulta);


	            dataTableInterConsultaInfoInitialized  = true;
      }




  }

/* ONLOAD */

const initDataTableInfoClinico = async () => {
	if  (dataTableRadiologiaInfoInitialized)  {
		dataTableRadiologiaInfo.destroy();

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
        var tipoDoc = document.getElementById("tipoDocPaciente").value;
        var documento = document.getElementById("documentoPaciente").value;
        var consec = document.getElementById("ingresoPaciente").value;
	data['tipoDoc'] = tipoDoc;
	data['documento'] = documento;
	data['consec'] = consec;

        data = JSON.stringify(data);


        arrancaInfoClinico(1,data);
	    dataTableRadiografiaInfoInitialized = true;

         arrancaInfoClinico(2,data);
	  dataTableLaboratorioInfoInitialized = true;

         arrancaInfoClinico(3,data);
	  dataTableTerapiaInfoInitialized = true;

         arrancaInfoClinico(4,data);
	  dataTableNoQxInfoInitialized = true;


         arrancaInfoClinico(5,data);
	  dataTableAntecedenteInfoInitialized = true;


         arrancaInfoClinico(6,data);
	  dataTableNotasEnfermeriaInfoInitialized = true;

	    arrancaInfoClinico(7,data);
	  dataTableMedicamentoInfoInitialized = true;

	    arrancaInfoClinico(8,data);
	  dataTableInterConsultaInfoInitialized = true;


}

 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTableInfoClinico();
	// $('#tablaClinico tbody tr:eq(0) .miClinico').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript

});


 /* FIN ONLOAD */


