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
let dataTableOptionsPedidosEnfermeria = false;
let dataTableOptionsPedidosEnfermeriaDetalle = false;





$(document).ready(function() {


// aqui van los filtros de busqueda

});


function arrancaEnfermeria(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
        let dataTableOptionsPanelEnfermeria  ={
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
            scrollY: '475px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataMedicamentosEnfermeria/" +  data,
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
                { data: "fields.paciente"},
                { data: "fields.folio"},
                { data: "fields.consecutivoMedicamento"},
                { data: "fields.cantidad"},
                { data: "fields.UnidadMedida"},
                { data: "fields.medicamento"},

                        ]
            }
	        
		   dataTable = $('#tablaMedicamentosEnfermeria').DataTable(dataTableOptionsMedicamentosEnfermeria);


  }


    if (valorTabla == 3)
    {
        let dataTableOptionsParaClinicosEnfermeria  ={
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
            scrollY: '475px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
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
            scrollY: '175px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
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




	    // arrancaEnfermeria(5,data);
	    // dataTablePedidosEnfermeriaDetalleInitialized = true;

      
  });


function CreaPedidosEnfermeriaCabezote()
{
	alert("ENTRE cargar modal CreaPedidosEnfermeriaCabezote");

	 $('#postFormModalCreaPedidosEnfermeria').trigger("reset");

            $('#modelHeadingPedidosEnfermeria').html("Creacon Pedidos Enfermeria");
            $('#creaModalPedidosEnfermeria').modal('show');     



}


function PedidosEnfermeriaCabezote()
{

		alert("ENTRE CreaPedidosEnfermeriaCabezote");
	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;

        var enfermeriaTipoOrigen = document.getElementById("enfermeriaTipoOrigen").value;
        var enfermeriaTipoMovimiento = document.getElementById("enfermeriaTipoMovimiento").value;
        var servicioEnfermeria = document.getElementById("servicioEnfermeria").value;



		
     $.ajax({
                data: {'username_id ':username_id ,'sede':sede,'enfermeriaTipoOrigen':enfermeriaTipoOrigen,'enfermeriaTipoMovimiento':enfermeriaTipoMovimiento,'servicioEnfermeria':servicioEnfermeria},
	        url: "/creaPedidosEnfermeriaCabezote/",
                type: "POST",
                dataType: 'json',
                success: function (info) {
		document.getElementById("mensajes").innerHTML = 'Se actualiza cambio de estado';

                },
            error: function (request, status, error) {

		document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error + ' ' + error
	   	    	}
            });
		   $('#creaModalPedidosEnfermeria').modal('hide');  


}

