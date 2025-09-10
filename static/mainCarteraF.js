console.log('Hola Alberto Hi!')

let dataTable;
let dataTableA;
let dataTableB;
let dataTableC;
let dataTableD;
let dataTableF;
let dataTableG;
let dataTableH;

let dataTableCajaInitialized = false;


$(document).ready(function() {
    var table = $('#tablaCaja').DataTable();
    
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


function arrancaCartera(valorTabla,valorData)
{
    data = {}
    data = valorData;

    if (valorTabla == 1)
    {
        let dataTableOptionsCaja  ={
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
                    "targets": 12
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
                 url:"/load_dataCaja/" +  data,
                 type: "POST",
                 dataSrc: ""
            },
            columns: [
		{
		  "render": function ( data, type, row ) {
                        var btn = '';
        		     btn = btn + " <input type='radio' name='caja' class='miCaja form-check-input ' data-pk='"  + row.pk + "'>" + "</input>";
                       return btn;
                    },

		},

                { data: "fields.id"},
                { data: "fields.fecha"},
                { data: "fields.entrega"},
                { data: "fields.efectivo"},
                { data: "fields.tarjetasDebito"},
                { data: "fields.tarjetasCredito"},
                { data: "fields.cheques"},
                { data: "fields.total"},
                { data: "fields.recibe"},
		{ data: "fields.superviza"},
		{ data: "fields.estadoCaja"},
                { data: "fields.servicio"},    

       ]
            }
	        dataTable = $('#tablaCaja').DataTable(dataTableOptionsCaja);
  }
}

const initDataTableCaja = async () => {
	if  (dataTableCajaInitialized)  {
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
	sedesClinica_id = sede;
	data['sedesClinica_id'] = sedesClinica_id
	data['facturaId'] = 1

        data = JSON.stringify(data);

         arrancaCartera(1,data);
	 dataTableCajaInitialized = true;


}

 // COMIENZA ONLOAD

window.addEventListener('load', async () => {
    await  initDataTableCaja();
	 

});


 /* FIN ONLOAD */


 $('#tablaCaja tbody').on('click', '.miCaja', function() {

        var post_id = $(this).data('pk');
        var cajaId = post_id;
	var row = $(this).closest('tr'); // Encuentra la fila
	alert("cajaId = " + cajaId);


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
	sedesClinica_id = sede;
	data['sedesClinica_id'] = sedesClinica_id

     $.ajax({
		data: {'cajaId':cajaId},
	        url: "/editarCaja/",
                type: "POST",
                dataType: 'json',
                success: function (info) {
		   $("#mensajes").html(info.message);

	$('#postFormCaja').trigger("reset");
	
		 $('#crearModelCaja').modal('show');
                },
            error: function (request, status, error) {
		document.getElementById("mensajesErrorModalCaja").innerHTML =  'Error' + ': ' + request.responseText;
	   	    	}
            });
  });





function GuardarCaja()
{
	
		var sedeSeleccionada = document.getElementById("sedeSeleccionada").value;
	        var username = document.getElementById("username").value;
	        var nombreSede = document.getElementById("nombreSede").value;
	    	var sede = document.getElementById("sede").value;


	    	var post_idGlo = document.getElementById("post_idGlo").innerHTML;
	    	var tipoGloDet = document.getElementById("tipoGloDet").innerHTML;
	        var glosaGloDet = document.getElementById("glosaGloDet").innerHTML;
	        var post_idGloDet = document.getElementById("post_idGloDet").innerHTML;
	        var motivoGlosa_idGloDet = document.getElementById("motivoGlosa_idGloDet").value;
	        var cantidadGlosadaGloDet = document.getElementById("cantidadGlosadaGloDet").value;
	        var cantidadAceptadaGloDet = document.getElementById("cantidadAceptadaGloDet").value;
	        var cantidadSoportadoGloDet = document.getElementById("cantidadSoportadoGloDet").value;
	        var valorGlosadoGloDet = document.getElementById("valorGlosadoGloDet").value;




            $.ajax({
                data: $('#postFormCaja').serialize(),
	        url: "/guardarCaja/",
                type: "POST",
                dataType: 'json',
                success: function (data2) {


			if (data2['Error'] == 'Si' )
				{
		
				document.getElementById("mensajesGloDet").innerHTML = data2['message']

					return ;
				}
	
				if (data2['Error'] == 'No' )
				{


				 $('#postFormGlosasDetalle').trigger("reset");


			filtrodata = JSON.stringify(data2['Data']);
	

			filtrodata = filtrodata.replace ('[','');
			filtrodata = filtrodata.replace (']','');
			filtro = JSON.parse(filtrodata);

		var data =  {}   ;
	        data['username'] = username;
		data['username_id'] = username_id;
	        data['sedeSeleccionada'] = sedeSeleccionada;
	        data['nombreSede'] = nombreSede;
	        data['sede'] = sede;
	        data['sedesClinica_id'] = sede;

		var cajaId = document.getElementById("cajaId").innerHTML; // jquery


	        data = JSON.stringify(data);
	
			 arrancaCartera(1,data);
			    dataTableCajanitialized = true;

 		 $('#crearModelCaja').modal('hide');


				}	// Cierra el if		

                },
            error: function (request, status, error) {
		document.getElementById("mensajesErrorModalCaja").innerHTML =  'Error' + ': ' + request.responseText;

	   	    	}
            });


}


