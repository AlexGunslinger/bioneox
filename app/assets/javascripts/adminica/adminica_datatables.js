function adminicaDataTables() {

if($(".datatable").length>0){
if($.fn.dataTable){
	// DataTables Config (more info can be found at http://www.datatables.net/)

	var table1 = $('#dt1 .datatable').dataTable( {
				"bJQueryUI": true,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[0,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				"sScrollX": "101%",
				"bScrollCollapse": true,
				"oLanguage": {
         			"sLengthMenu": 'Display <select>'+
           			'<option value="100">100</option>'+
           			'<option value="200">200</option>'+
           			'<option value="500">500</option>'+
           			'</select> records'
       			},
				"iDisplayLength": 100,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {

					$("#dt1 .dataTables_length > label > select").uniform();
					$("#dt1 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");

				}
	});

	var table_admin = $('#dtadmin .datatable').dataTable( {
				"bJQueryUI": true,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[0,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				"sScrollX": "101%",
				"bScrollCollapse": true,
				"oLanguage": {
         			"sLengthMenu": 'Display <select>'+
           			'<option value="100">100</option>'+
           			'<option value="200">200</option>'+
           			'<option value="500">500</option>'+
           			'</select> records'
       			},
				"iDisplayLength": 100,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {

					$("#dt1 .dataTables_length > label > select").uniform();
					$("#dt1 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");

				}
	});

	var table_carrier = $('#dtcarrier .datatable').dataTable( {
				"bJQueryUI": true,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[0,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				//"sScrollY": "101%",
				"sScrollX": "101%",
				"aoColumnDefs": [{ "bSortable": false, "aTargets": [4, 5, 6 ] }],
				"bScrollCollapse": true,
				"oLanguage": {
         			"sLengthMenu": 'Display <select>'+
           			'<option value="100">100</option>'+
           			'<option value="200">200</option>'+
           			'<option value="500">500</option>'+
           			'</select> records'
       			},
				"iDisplayLength": 100,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {

					$("#dt2 .dataTables_length > label > select").uniform();
					$("#dt2 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");

				},
				"aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
	});

	var table_onsite = $('#dtonsite .datatable').dataTable( {
				"bJQueryUI": true,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[0,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				//"sScrollY": "101%",
				"sScrollX": "101%",
				"aoColumnDefs": [{ "bSortable": false, "aTargets": [4, 5, 6 ] }],
				"bScrollCollapse": true,
				"oLanguage": {
         			"sLengthMenu": 'Display <select>'+
           			'<option value="100">100</option>'+
           			'<option value="200">200</option>'+
           			'<option value="500">500</option>'+
           			'</select> records'
       			},
				"iDisplayLength": 100,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {

					$("#dt2 .dataTables_length > label > select").uniform();
					$("#dt2 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");

				},
				"aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
	});

	var table_doctor = $('#dtdoctor .datatable').dataTable( {
				"bJQueryUI": true,
				"bPaginate": false,
				"sScrollX": "",
				"bSortClasses": false,
				"aaSorting": [[0,'asc']],
				"bAutoWidth": true,
				"bInfo": true,
				//"sScrollY": "101%",
				"sScrollX": "101%",
				"bScrollCollapse": true,
				"oLanguage": {
         			"sLengthMenu": 'Display <select>'+
           			'<option value="100">100</option>'+
           			'<option value="200">200</option>'+
           			'<option value="500">500</option>'+
           			'</select> records'
       			},
				"iDisplayLength": 100,
				"sPaginationType": "full_numbers",
				"bRetrieve": true,
				"fnInitComplete": function () {

					$("#dt3 .dataTables_length > label > select").uniform();
					$("#dt3 .dataTables_filter input[type=text]").addClass("text");
					$(".datatable").css("visibility","visible");

				}
	});




// DataTables Config - this reloads dataTables when it is placed in a hidden tab

	$(".tabs").tabs( {
        "show": function(event, ui) {
            var oTable = $('div.dataTables_scrollBody > table', ui.panel).dataTable();
            if ( oTable.length > 0 ) {
                oTable.fnAdjustColumnSizing();
                $(".tabs div.dataTables_scroll").css({
                    "display":"none",
                    "visibility":"visible"
                }).show();
            }
        }
    });

// DataTables Config - this reloads dataTables when it is placed in a closed accordion
	$( ".content_accordion" ).accordion( {
		"change": function(event, ui) {
			var oTable = $('div.dataTables_scrollBody > table', ui.panel).dataTable();
            if ( oTable.length > 0 ) {
                oTable.fnAdjustColumnSizing();
                $(".content_accordion div.dataTables_scroll").css({
                    "display":"none",
                    "visibility":"visible"
                }).show();
            }
		}
	});

	$(window).resize(function(){
        table1.fnAdjustColumnSizing();
        table_admin.fnAdjustColumnSizing();
        table_carrier.fnAdjustColumnSizing();
        table_doctor.fnAdjustColumnSizing();
        table_onsite.fnAdjustColumnSizing();
	});
}
}
}