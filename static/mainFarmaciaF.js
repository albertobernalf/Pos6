console.log('Hola Alberto Hi!')

let dataTable;
let dataTableB;
let dataTableC;
let dataTableD;
let dataTableF;
let dataTableG;
let dataTableH;
let dataTableI;

let dataTablePanelFarmaciaInitialized = false;
let dataTableFarmaciaDespachosInitialized = false;
let dataTableFarmaciaDetalleInitialized = false;
let dataTableDespachosFarmaciaDispensaInitialized = false;
var controlMed = 0;


$(document).ready(function() {


// aqui van los filtros de busqueda

$('#tablaFormulacion tbody').on('click', 'tr', function () {
    confirm("Desea eliminar LA FILA: ");
       var tableL = $('#tablaFormulacion').DataTable();
      var fila = $(this).parents("tr")['prevObject']['0']['_DT_RowIndex'];
          alert("Fila a borrar = " + fila);
		var rows = tableL
			    .rows(fila)
			    .remove()
			    .draw();
		 document.getElementById("tablaFormulacion").deleteRow(fila-1);

});


/*------------------------------------------
        --------------------------------------------
        Create Post Code Formulacion
        --------------------------------------------
        --------------------------------------------*/
        $('#BtnAdicionarFormulacion').click(function (e) {
            e.preventDefault();


   	   if (controlMed == 0)
   	   {
   	   var table10 = $('#tablaFormulacion').DataTable({scrollY: '80px', paging:false,  search:false,  scrollX: true,  scrollCollapse: true,  lengthMenu: [5]});   // accede de nuevo a la DataTable.
   	   controlMed=1;
   	   }
   	   else
   	   {
	  var table10 = $('#tablaFormulacion').DataTable();
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




});


function arrancaFarmacia(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
        let dataTableOptionsPanelFarmacia  ={
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
                    "targets": 11
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
                 url:"/load_dataFarmacia/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miFarmacia' class='miSelFarmacia form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
                { data: "fields.origen"},
		   { data: "fields.mov"}, 
                { data: "fields.servicio"},
                { data: "fields.historia"},
		  { data: "fields.estado"},
		  { data: "fields.tipoDoc"},
		  { data: "fields.documento"},
		  { data: "fields.paciente"},
		  { data: "fields.servicio"},
		  { data: "fields.cama"},


                        ]
            }
	        
		   dataTable = $('#tablaPanelFarmacia').DataTable(dataTableOptionsPanelFarmacia);


  }


    if (valorTabla == 2)
    {
        let dataTableOptionsFarmaciaDespachos  ={
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
		{  
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
                 url:"/load_dataFarmaciaDespachos/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miFarmaciaDespachos' class='miFarmaciaDespachos form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
                { data: "fields.origen"},
		   { data: "fields.mov"}, 
                { data: "fields.servicio"},
                { data: "fields.historia"},
                        ]
            }
	        
		   dataTable = $('#tablaFarmaciaDespachos').DataTable(dataTableOptionsFarmaciaDespachos);


  }



    if (valorTabla == 3)
    {
        let dataTableOptionsFarmaciaDetalle  ={
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
                 url:"/load_dataFarmaciaDetalle/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miFarmaciaDetalle2' class='miFarmaciaDetalle form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


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
	        
		   dataTable = $('#tablaFarmaciaDetalle').DataTable(dataTableOptionsFarmaciaDetalle);


  }

    if (valorTabla == 4)
    {
        let dataTableOptionsFarmaciaDespachosDispensa  ={
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
            scrollY: '75px',
	    scrollX: true,
	    scrollCollapse: true,
            paging:false,
            columnDefs: [
		{ className: 'centered', targets: [0, 1, 2, 3, 4, 5] },
	    { width: '10%', targets: [2,3] },
		{  
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
                 url:"/load_dataFarmaciaDespachosDispensa/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
	{
	  "render": function ( data, type, row ) {
                        var btn = '';

		 btn = btn + " <input type='radio' name='miFarmaciaDespachosDispensa2' class='miFarmaciaDespachosDispensa form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";


                       return btn;
                    },

	},

                { data: "fields.id"},
                { data: "fields.despacho"},
	    	   { data: "fields.suministro"},
                { data: "fields.dosis"},
                { data: "fields.unidadDosis"},
                { data: "fields.via"},
                { data: "fields.cantidad"},

                        ]
            }
	        
		   dataTable = $('#tablaFarmaciaDespachosDispensa').DataTable(dataTableOptionsFarmaciaDespachosDispensa);


  }



  
}

const initDataTablePanelFarmacia = async () => {
	if  (dataTablePanelFarmaciaInitialized)  {
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

        arrancaFarmacia(1,data);
	    dataTablePanelFarmaciaInitialized = true;

        //arrancaFarmacia(3,data);
	    //dataTableFarmaciaDetalleInitialized = true;


        //arrancaFarmacia(2,data);
	    //dataTableFarmaciaDespachosInitialized = true;

        arrancaFarmacia(4,data);
	    dataTableFarmaciaDespachosDispensaInitialized = true;


}


 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTablePanelFarmacia();
	 $('#tablaPanelFarmacia tbody tr:eq(0) .miSol').prop('checked', true);  // Checkprimera fila el checkbox creo solo javascript

});


 /* FIN ONLOAD */


$('#tablaPanelFarmacia tbody').on('click', '.miSelFarmacia', function() {

		alert("ENTRE miSelFarmacia");

	     var post_id = $(this).data('pk');
	farmaciaId =   post_id;
	alert("farmaciaId = " +  farmaciaId);

	document.getElementById("farmaciaId").value = farmaciaId;

	

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
	data['farmaciaId'] = farmaciaId;
		//    data['farmaciaDetalleId'] = farmaciaDetalleId;

 	    data = JSON.stringify(data);

     $.ajax({
                data: {'farmaciaId':farmaciaId},
	        url: "/buscaDatosPaciente/",
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

		     arrancaFarmacia(3,data);
		     	dataTableFarmaciaDetalleInitialized = true;

        arrancaFarmacia(4,data);
	    dataTableFarmaciaDespachosDispensaInitialized = true;

	
      
  });



$('#tablaFarmaciaDetalle tbody').on('click', '.miFarmaciaDetalle', function() {

		alert("ENTRE tablaFarmaciaDetalle");

	     var post_id = $(this).data('pk');
	farmaciaDetalleId =   post_id;

	document.getElementById("farmaciaDetalle").value = farmaciaDetalleId;
	farmaciaId = document.getElementById("farmaciaId").value ;

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
	data['farmaciaDetalleId'] = farmaciaDetalleId;
	data['farmaciaId'] = farmaciaId;
 	    data = JSON.stringify(data);

	     arrancaFarmacia(4,data);
		     	dataTableFarmaciaDespachosDispensaInitialized = true;


  });


// Medicamentos

function tableActionsFormulacion() {

   var table10 = $('#tablaFormulacion').DataTable({
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


function AdicionarDespachosDispensa()
{

	// Formulacion
	alert("Entre a GRABAR despacho");

     	var username = document.getElementById("username").value;
        var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var farmaciaDetalleId = document.getElementById("farmaciaDetalle").value;
        var servicioAdmonEntrega = document.getElementById("servicioAdmonEntrega").value;
        var servicioAdmonRecibe = document.getElementById("servicioAdmonRecibe").value;
        var plantaEntrega = document.getElementById("plantaEntrega").value;
        var plantaRecibe = document.getElementById("plantaRecibe").value;
        var farmaciaId = document.getElementById("farmaciaId").value;


    const table10 = $('#tablaFormulacion').DataTable();
     var datos_tabla10 = table10.rows().data().toArray();

        formulacion=[]


	for(var i= 0; i < datos_tabla10.length; i++) {

	    formulacion.push({
	        "medicamentos"    : datos_tabla10[i][0] ,
	        "dosis"    : datos_tabla10[i][2],
	        "uMedidaDosis"    : datos_tabla10[i][3] ,
	      /*  "vias"    : datos_tabla10[i][4] , */
	        "viasAdministracion"    : datos_tabla10[i][4] ,
	        "cantidadMedicamento"    : datos_tabla10[i][5] ,

	      });
	   };

	    formulacion  = JSON.stringify(formulacion);

	    alert("Esto envio formulacion = " + formulacion)
    
 	// Fin Formulacion


  $.ajax({
            	   type: 'POST',
 	               url: '/adicionarDespachosDispensa/',
  	               data: { 'username':username, 'sede':sede, 'username_id':username_id,'formulacion':formulacion,
                            'farmaciaDetalleId':farmaciaDetalleId,'servicioAdmonEntrega':servicioAdmonEntrega, 'servicioAdmonRecibe':servicioAdmonRecibe,
                             	   'plantaEntrega':plantaEntrega, 'plantaRecibe':plantaRecibe, 'farmaciaId':farmaciaId},
 	      		success: function (data) {

     			    $("#mensajes").html(data.message);

			document.getElementById("mensajes").innerHTML = data.message;

    	var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
        var username = document.getElementById("username").value;
        var nombreSede = document.getElementById("nombreSede").value;
    	var sede = document.getElementById("sede").value;
        var username_id = document.getElementById("username_id").value;
        var farmaciaId = document.getElementById("farmaciaId").value;
        var farmaciaDetalleId = document.getElementById("farmaciaDetalle").value;
         var data =  {}   ;
        data['username'] = username;
        data['sedeSeleccionada'] = sedeSeleccionada;
        data['nombreSede'] = nombreSede;
        data['sede'] = sede;
        data['username_id'] = username_id;

	    data['farmaciaId'] = farmaciaId;
	    data['farmaciaDetalleId'] = farmaciaDetalleId;

 	    data = JSON.stringify(data);

        arrancaFarmacia(4,data);
	    dataTableFarmaciaDespachosDispensaInitialized = true;

        // aqui inicializar tablaFormulacion etc

        /// Aqui inicializar combos
        $("servicioAdmonEntrega").prop('selectedIndex', 0);
        $("plantaEntrega").prop('selectedIndex', 0);
        $("servicioAdmonRecibe").prop('selectedIndex', 0);
        $("plantaRecibe").prop('selectedIndex', 0);


        var tabla = $('#tablaFormulacion').DataTable();
        tabla.rows().remove().draw();


 	      		}, // cierra function sucess
 	      		error: function (request, status, error) {
 	      			document.getElementById("mensajesError").innerHTML = 'Error Contacte a su Administrador' + ': ' + error
 	      			

 	      		}, // cierra error function
  	        });  // cierra ajax


}


