console.log('Hola Alberto Hi!')

let dataTable;
let dataTableB;
let dataTableC;
let dataTableD;
let dataTableF;
let dataTableG;
let dataTableH;
let dataTableI;

let dataTablePanelEnfermeriaInitialized = false;
let dataTableMedicamentosEnfermeriaInitialized = false;
let dataTableParaclinicosEnfermeriaEnfermeriaInitialized = false;
let dataTablePedidosEnfermeria = false;
let dataTablePedidosEnfermeriaDetalle = false;
let dataTableTurnosEnfermeria = false;
let dataTablePlaneacionEnfermeria = false;

var controlMed = 0;




$(document).ready(function() {

/*------------------------------------------
        --------------------------------------------
        Create Post Code Formulacion
        --------------------------------------------
        --------------------------------------------*/
        $('#BtnAdicionarFormulacionEnfermeria').click(function (e) {
            e.preventDefault();


   	   if (controlMed == 0)
   	   {
   	   var table10 = $('#tablaFormulacionEnfermeria').DataTable({scrollY: '80px', paging:false,  search:false,  scrollX: true,  scrollCollapse: true,  lengthMenu: [5]});   // accede de nuevo a la DataTable.
   	   controlMed=1;
   	   }
   	   else
   	   {
	  var table10 = $('#tablaFormulacionEnfermeria').DataTable();
   	   }

		
           var select3 = document.getElementById("medicamentos"); /*Obtener el SELECT */
      	   var medicamentos= select3.options[select3.selectedIndex].value; /* Obtener el valor */
      	   textMedicamentos = select3.options[select3.selectedIndex].innerText; //El texto de la opción seleccionada

           var dosis =  document.getElementById("dosis").value;

	        var select3 = document.getElementById("uMedidaDosis"); /*Obtener el SELECT */
      	   var uMedidaDosis= select3.options[select3.selectedIndex].value; /* Obtener el valor */
      	   textUMedidaDosis = select3.options[select3.selectedIndex].innerText; //El texto de la opción seleccionada

	         var select3 = document.getElementById("uMedidaDosis"); /*Obtener el SELECT */
      	   var uMedidaDosis= select3.options[select3.selectedIndex].value; /* Obtener el valor */
      	   textUMedidaDosis = select3.options[select3.selectedIndex].innerText; //El texto de la opción seleccionada


	         var select3 = document.getElementById("vias"); /*Obtener el SELECT */
      	   var viasAdministracion = select3.options[select3.selectedIndex].value; /* Obtener el valor */
      	   textViasAdministracion = select3.options[select3.selectedIndex].innerText; //El texto de la opción seleccionada
	
	        var cantidadMedicamento =  document.getElementById("cantidadMedicamento").value;

		

	    table10.row.add([ medicamentos, textMedicamentos, dosis,  textUMedidaDosis, textViasAdministracion, cantidadMedicamento   ,  '<i class="fa fa-trash"></i>']).draw(false);

        });


// aqui van los filtros de busqueda

});


function arrancaEnfermeria(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
        let dataTableOptionsPanelEnfermeria  ={
   dom: "<'row mb-1'<'col-sm-2'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-1'<'col-sm-5'i><'col-sm-7'p>>",
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
            scrollY: '475px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataPanelEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [

	{
	  "render": function ( data, type, row ) {
                        var btn = '';

              btn = btn + " <input type='radio'  name='ingresoEnfermeriaId' class='miIngresoEnfermeriaId form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                 { data: "fields.id"},
                 { data: "fields.tipoDoc" }, 
                { data: "fields.Documento"},
                { data: "fields.Nombre"},
                { data: "fields.Consec"},
                { data: "fields.edad"},
                { data: "fields.Empresa"},
                { data: "fields.FechaIngreso"},
                { data: "fields.servicioNombreIng"},
                { data: "fields.camaNombreIng"},
               { data: "fields.salidaClinica"},
		     { data: "fields.DxActual"}, 
                { data: "fields.numConvenios"},
		        { data: "fields.numPagos"},

                        ]
            }
	        
		   dataTable = $('#tablaPanelEnfermeria').DataTable(dataTableOptionsPanelEnfermeria);


  }


    if (valorTabla == 2)
    {
        let dataTableOptionsMedicamentosEnfermeria  ={
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
            scrollY: '125px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataMedicamentosEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

              btn = btn + " <input type='radio'  name='medicamentosId' class='miMedicamentosId form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },

	},
	{
	  "render": function ( data, type, row ) {
                        var btn = '';
     btn = btn + " <button class='Planear btn-primary ' data-pk='" + row.pk + "'>" + '<i class="fa-duotone fa-regular fa-thumbs-up"></i>' + "</button>";
                       return btn;
                    },

	},
           
                 { data: "fields.id"},
		{
			target: 2,
			visible: false
		},
		{
			target: 3,
			visible: false
		},
		{
			target: 4,
			visible: false
		},

                { data: "fields.folio"},
  
                { data: "fields.consecutivoMedicamento"},
                { data: "fields.cantidad"},
                { data: "fields.UnidadMedida"},
                { data: "fields.medicamento"},
                { data: "fields.frecuencia"},
                { data: "fields.diasTratamiento"},
                        ]
            }
	        
		   dataTable = $('#tablaMedicamentosEnfermeria').DataTable(dataTableOptionsMedicamentosEnfermeria);


  }


    if (valorTabla == 3)
    {
        let dataTableOptionsParaClinicosEnfermeria  ={
   dom: "<'row mb-1'<'col-sm-2'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
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
            scrollY: '475px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataParaClinicosEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [

	{
	  "render": function ( data, type, row ) {
                        var btn = '';

              btn = btn + " <input type='radio'  name='paraclinicoId' class='paraclinicoId form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                 { data: "fields.id"},
                 { data: "fields.medico" }, 
                { data: "fields.fecha"},
                { data: "fields.folio"},
                { data: "fields.tipo"},
                { data: "fields.consecutivo"},
                { data: "fields.cups"},
                { data: "fields.examen"},
                { data: "fields.cantidad"},


                        ]
            }
	        
		   dataTable = $('#tablaParaClinicosEnfermeria').DataTable(dataTableOptionsParaClinicosEnfermeria);


  }

    if (valorTabla == 4)
    {
        let dataTableOptionsPedidosEnfermeria  ={
   dom: "<'row mb-1'<'col-sm-2'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
            "<'row'<'col-sm-12'tr>>" + 
             "<'row mt-1'<'col-sm-5'i><'col-sm-7'p>>",
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
            scrollY: '75px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
	    "info": false,
		"showNEntries" : false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2,] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataPedidosEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miPedidosEnfermeria' class='miPedidosEnfermeria form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";

                       return btn;
                    },

	},

                { data: "fields.id"},
                { data: "fields.origen"},
		   { data: "fields.mov"}, 
                { data: "fields.servicio"},


                        ]
            }
	        
		   dataTable = $('#tablaPedidosEnfermeria').DataTable(dataTableOptionsPedidosEnfermeria);


  }



    if (valorTabla == 5)
    {
        let dataTableOptionsPedidosEnfermeriaDetalle  ={
  lengthMenu: [2, 4, 15],
           processing: true,
            serverSide: false,
            scrollY: '75px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
	    "info": false,
		"showNEntries" : false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },
		{  
                    "targets": 6
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
                 url:"/load_dataPedidosEnfermeriaDetalle/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miPedidosEnfermeriaDetalle' class='miPedidosEnfermeriaDetale form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
        		{ data: "fields.dosis"},
                { data: "fields.unidadDosis"},
                { data: "fields.suministro"},
                { data: "fields.viaAdministracion"},
                { data: "fields.cantidad"},

                        ]
            }
	        
		   dataTable = $('#tablaPedidosEnfermeriaDetalle').DataTable(dataTableOptionsPedidosEnfermeriaDetalle);


  }



    if (valorTabla == 6)
    {
        let dataTableOptionsTurnosEnfermeria  ={
   dom: "<'row mb-1'<'col-sm-2'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-1'<'col-sm-5'i><'col-sm-7'p>>",
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
            scrollY: '75px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
	    "info": false,
		"showNEntries" : false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataTurnosEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miTurnosEnfermeria' class='miTurnoEnfermeria form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
        		{ data: "fields.servicio"},
                { data: "fields.tipoNombre"},
                { data: "fields.plantaNombre"},
                { data: "fields.horario"},


                        ]
            }
	        
		   dataTable = $('#tablaTurnosEnfermeria').DataTable(dataTableOptionsTurnosEnfermeria);


  }


    if (valorTabla == 7)
    {
        let dataTableOptionsPlaneacionEnfermeria  ={
   dom: "<'row mb-1'<'col-sm-2'B><'col-sm-3'><'col-sm-6'f>>" + // B = Botones a la izquierda, f = filtro a la derecha
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-1'<'col-sm-5'i><'col-sm-7'p>>",
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
            scrollY: '75px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
	    "info": false,
		"showNEntries" : false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },
		{  
                    "targets": 13
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
                 url:"/load_dataPlaneacionEnfermeria/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miAplicacionEnfermeria' class='miAplicacionEnfermeria form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
        		{ data: "fields.fechaPlanea"},
                { data: "fields.turnoPlanea"},
                { data: "fields.enfermeraPlanea"},
                { data: "fields.fechaAplica"},
                { data: "fields.turnoAplica"},
                { data: "fields.enfermeraAplica"},
                { data: "fields.cantidadAplicada"},
                { data: "fields.dosis"},
                { data: "fields.medida"},
                { data: "fields.suministro"},
                { data: "fields.via"},
                { data: "fields.frecuencia"},
                { data: "fields.diasa"},

                        ]
            }
	        
		   dataTable = $('#tablaPlaneacionEnfermeria').DataTable(dataTableOptionsPlaneacionEnfermeria);


  }


  
}

const initDataTablePanelEnfermeria = async () => {
	if  (dataTablePanelEnfermeriaInitialized)  {
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

        arrancaEnfermeria(1,data);
	    dataTablePanelEnfermeriaInitialized = true;

        arrancaEnfermeria(6,data);
	    dataTableTurnosEnfermeriaInitialized = true;

}


 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTablePanelEnfermeria();
	 $('#tablaPanelEnfermeria tbody tr:eq(0) .miSol').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript

});


 /* FIN ONLOAD */



$('#tablaPanelEnfermeria tbody').on('click', '.miIngresoEnfermeriaId', function() {

	alert ("Seleccione Enfermeria");

	     var post_id = $(this).data('pk');
	ingresoId =   post_id;


	document.getElementById("ingresoId").value = ingresoId;

	

    	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var enfermeriaId=0;

         var data =  {}   ;
        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
	data['ingresoId'] = ingresoId;
	data['enfermeriaId'] = enfermeriaId;
	
 	    data = JSON.stringify(data);

	  $.ajax({
                data: {'ingresoId':ingresoId},
	        url: "/buscaDatosPacienteEnfermeria/",
                type: "POST",
                dataType: 'json',
                success: function (info) {
			
		document.getElementById("nombreTipoDoc").innerHTML = info[0].fields.nombreTipoDoc;
		document.getElementById("documento").innerHTML = info[0].fields.documento;
		document.getElementById("paciente").innerHTML = info[0].fields.paciente;
		document.getElementById("consecutivoAdmision").innerHTML = info[0].fields.consecutivoAdmision;
		document.getElementById("servicio").innerHTML = info[0].fields.servicio;
		document.getElementById("habitacion").innerHTML = info[0].fields.cama;

		document.getElementById("nombreTipoDocM").innerHTML = info[0].fields.nombreTipoDoc;
		document.getElementById("documentoM").innerHTML = info[0].fields.documento;
		document.getElementById("pacienteM").innerHTML = info[0].fields.paciente;
		document.getElementById("consecutivoAdmisionM").innerHTML = info[0].fields.consecutivoAdmision;
		document.getElementById("servicioM").innerHTML = info[0].fields.servicio;
		document.getElementById("habitacionM").innerHTML = info[0].fields.cama;


	



                },
            error: function (request, status, error) {
		alert("llegue con error ", error);
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error + ' ' + error
	   	    	}
            });



	     arrancaEnfermeria(2,data);
	     dataTableMedicamentosEnfermeriaInitialized = true;

	     arrancaEnfermeria(3,data);
	     dataTableParaclinicosEnfermeriaEnfermeriaInitialized = true;

	     arrancaEnfermeria(4,data);
	     dataTablePedidosEnfermeriaInitialized = true;

	     arrancaEnfermeria(5,data);
	     dataTablePedidosEnfermeriaDetalleInitialized = true;


	     arrancaEnfermeria(6,data);
	     dataTableTurnossEnfermeriaInitialized = true;


	     arrancaEnfermeria(7,data);
	     dataTablePlaneacionEnfermeriaInitialized = true;

      
  });


$('#tablaPedidosEnfermeria tbody').on('click', '.miPedidosEnfermeria', function() {

	alert ("Seleccione miPedidosEnfermeria");

	     var post_id = $(this).data('pk');
	enfermeriaId =   post_id;

	document.getElementById("enfermeriaId").value = enfermeriaId;

         var data =  {}   ;
        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
	data['enfermeriaId'] = enfermeriaId;

	 data = JSON.stringify(data);

  	 arrancaEnfermeria(5,data);
	 dataTablePedidosEnfermeriaDetalleInitialized = true;
      
  });



function ModalPedidosEnfermeriaCabezote()
{
	alert("ENTRE cargar modal CreaPedidosEnfermeriaCabezote");

	 $('#postFormModalCreaPedidosEnfermeria').trigger("reset");

            $('#modelHeadingPedidosEnfermeria').html("Creacon Pedidos Enfermeria");
            $('#creaModalPedidosEnfermeria').modal('show');     



}


function CreaPedidosEnfermeriaCabezote()
{

		alert("ENTRE CreaPedidosEnfermeriaCabezote");
	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
	var ingresoId = document.getElementById("ingresoId").value ;

        var enfermeriaTipoOrigen = document.getElementById("enfermeriaTipoOrigenx").value;
        var enfermeriaTipoMovimiento = document.getElementById("enfermeriaTipoMovimientox").value;
        var servicioEnfermeria = document.getElementById("servicioEnfermeria").value;

	alert("username_id: " + username_id );
	alert("enfermeriaTipoOrigen: " + enfermeriaTipoOrigen );
	alert("enfermeriaTipoMovimiento : " + enfermeriaTipoMovimiento  );
		
     $.ajax({

	        url: "/creaPedidosEnfermeriaCabezote/",
                data: {'ingresoId':ingresoId, 'username_id':username_id ,'sede':sede,'enfermeriaTipoOrigen':enfermeriaTipoOrigen,'enfermeriaTipoMovimiento':enfermeriaTipoMovimiento,'servicioEnfermeria':servicioEnfermeria},
                type: "POST",
                dataType: 'json',
                success: function (info) {
		document.getElementById("mensajes").innerHTML = 'Se actualiza cambio de estado';


	         var data =  {}   ;
	        data['username'] = username;
	        data['sedeSeleccionada'] = sedeSeleccionada;
	        data['nombreSede'] = nombreSede;
	        data['sede'] = sede;
	        data['username_id'] = username_id;
		   data['ingresoId'] = ingresoId;

	    data = JSON.stringify(data);

	        arrancaEnfermeria(4,data);

	        dataTablePedidosEnfermeriaInitialized = true;


                },
            error: function (request, status, error) {

		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error + ' ' + error
	   	    	}
            });
		   $('#creaModalPedidosEnfermeria').modal('hide');  


}



$('#tablaMedicamentosEnfermeria tbody').on('click', '.Planear', function() {

	alert ("A planear Meidcamentos");

	     var post_id = $(this).data('pk');
	alert ("post_id = " + post_id);
	var row = $(this).closest('tr'); // Encuentra la fila



	var table = $('#tablaMedicamentosEnfermeria').DataTable();  // Inicializa el DataTable jquery//
	
 	var rowindex = table.row(row).data(); // Obtiene los datos de la fila
       console.log("rowindex= " , rowindex);

	    	 dato1 = Object.values(rowindex);
		console.log(" fila seleccionad d evuelta dato1 = ",  dato1);
	        dato3 = dato1[2];
		console.log(" fila selecciona de vuelta dato3 = ",  dato3);
	        console.log ( "Suministro es =  = " , dato3.medicamento); 



	// Aquip cargar modal planeacion medicamentos
	 $('#postFormModalPlaneacionEnfermeria').trigger("reset");

            $('#modelHeadingPlaneacionEnfermeria').html("Creacon Pedidos Enfermeria");
		document.getElementById("dosisP").value =dato3.dosis;
		document.getElementById("medidaP").value = dato3.UnidadMedida;
		document.getElementById("suministroP").value = dato3.medicamento;
		document.getElementById("frecuenciaP").value = dato3.frecuencia;
		document.getElementById("diasTratamientoP").value = dato3.diasTratamientoP;
		document.getElementById("numeroPlaneos").value = 0;


            $('#ModalPlaneacionEnfermeria').modal('show');     




  });



function GuardarPlaneacion() 
{
	alert ("A Guardar planeacion medicamentos");

	     var post_id = $(this).data('pk');
	alert ("post_id = " + post_id);
	var ingresoId = post_id;


	document.getElementById("ingresoId").value = ingresoId;

	

    	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var enfermeriaId=0;

         var data =  {}   ;
        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;
	data['ingresoId'] = ingresoId;

	
 	    data = JSON.stringify(data);

	  $.ajax({
                data: {'ingresoId':ingresoId},
	        url: "/guardaPlaneacionEnfermeria/",
                type: "POST",
                dataType: 'json',
                success: function (info) {
			

                },
            error: function (request, status, error) {
		alert("llegue con error ", error);
		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error + ' ' + error
	   	    	}
            });




	     arrancaEnfermeria(6,data);
	     dataTableTurnossEnfermeriaInitialized = true;


	     arrancaEnfermeria(7,data);
	     dataTablePlaneacionEnfermeriaInitialized = true;

      
  };





// Medicamentos

function tableActionsFormulacionEnfermeria() {

   var table10 = $('#tablaFormulacionEnfermeria').DataTable({
                "language": {
                  "lengthMenu": "Display _MENU_ registros",
                   "search": "Filtrar registros:",
                    },
                processing: true,
                serverSide: false,
                scrollY: '100px',
	            scrollX: true,
	            scrollCollapse: true,
                paging:false,
                 columnDefs: [
                {
                    "render": function ( data, type, row ) {
                        var btn = '';
			  btn = btn + " <button class='btn btn-danger deleteRevisionSistemas' id='borraDiag'>" + '<i class="fa fa-trash"></i>' + "</button>";
                        return btn;
                    },
                    "targets": 13
               }
            ],
        lengthMenu: [5],
    columns:[
    //"dummy" configuration
        { visible: true }, //col 1
        { visible: true }, //col 2
        { visible: true }, //col 3
	  { visible: false }, //col 4
	  { visible: true }, //col 5
	  { visible: false }, //col 6
	  { visible: true }, //col 7


            ],
    });
}

// FIN MEDICAMENTOS


function GuardarPedido()
{

	// Formulacion
	alert("Entre a GRABAR PedidosEnfermeria");

     	var username = document.getElementById("username").value;
        var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var servicioAdmonEnfermeria = document.getElementById("servicioAdmonEnfermeria").value;
        var enfermeriaId = document.getElementById("enfermeriaId").value;


    const table10 = $('#tablaFormulacionEnfermeria').DataTable();
     var datos_tabla10 = table10.rows().data().toArray();

        formulacionEnfermeria=[]

	for(var i= 0; i < datos_tabla10.length; i++) {

	    formulacionEnfermeria.push({
	        "medicamentos"    : datos_tabla10[i][0] ,
	        "dosis"    : datos_tabla10[i][2],
	        "uMedidaDosis"    : datos_tabla10[i][3] ,
	      /*  "vias"    : datos_tabla10[i][4] , */
	        "viasAdministracion"    : datos_tabla10[i][4] ,
	        "cantidadMedicamento"    : datos_tabla10[i][5] ,

	      });
	   };

	    formulacionEnfermeria  = JSON.stringify(formulacionEnfermeria);

	    alert("Esto envio formulacionEnfermeri = " + formulacionEnfermeria)
    
 	// Fin Formulacion


  $.ajax({
            	   type: 'POST',
 	               url: '/adicionarFormulacionEnfermeria/',
  	               data: { 'username':username, 'sede':sede, 'username_id':username_id,'formulacionEnfermeria':formulacionEnfermeria,
                            'servicioAdmonEnfermeria':servicioAdmonEnfermeria,'enfermeriaId':enfermeriaId},
 	      		success: function (data) {

     			    $("#mensajes").html(data.message);

			document.getElementById("mensajes").innerHTML = data.message;

    	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var ingresoId = document.getElementById("ingresoId").value;
 
         var data =  {}   ;
        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;

	    data['ingresoId'] = ingresoId;
 	    data = JSON.stringify(data);

	    arrancaEnfermeria(4,data);
	    dataTablePedidosEnfermeriaInitialized = true;

	    arrancaEnfermeria(5,data);
	    dataTablePedidosEnfermeriaDetalleInitialized = true;

        // aqui inicializar tablaFormulacion etc

        /// Aqui inicializar combos
        $("servicioAdmonEnfermeria").prop('selectedIndex', 0);


        var tabla = $('#tablaFormulacionEnfermeria').DataTable();
        tabla.rows().remove().draw();


 	      		}, // cierra function sucess
 	      		error: function (request, status, error) {
 	      			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
 	      			

 	      		}, // cierra error function
  	        });  // cierra ajax


}


