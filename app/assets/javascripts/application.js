// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require plugins-min
//= require adminica/adminica_all-min
//= require adminica/adminica_datatables 
// adminica_ui
// adminica_forms
// adminica_mobile
// adminica_datatables
// adminica_calendar
// adminica_charts
// adminica_gallery
// adminica_various
// adminica_wizard
// adminica_load
//= require carriers
// require_tree .


$(document).ready(function() {   
	$("#contacto_estado").change(function() {
		var estado = $(this).val();
    	if(estado == "") estado="0";
		$.get('/contacto/cambio_estado/' + estado, function(data) {
			$("#ciu-dad").html(data);
        });
    });
});

$(document).ready(function() {   
	$("#site_state_id").change(function() {
		var state = $(this).val();
    	if(state == "") state="0";
    	$.get('/sites/update_city_select/' + state, function(data){
        	$("#change_state_city").html(data);
    	});
  	});
});

$(document).ready(function() {   
	$("#order_order_type_id").change(function() {
		var order_type = $(this).val();
    	if(order_type == "") order_type="0";
    	if(order_type == "0") {
    		$("#form_title").html("");
    		$("#description_title").html("");
    		$("#order_form").hide(200);
    		$("#form_quantity").hide();
    		$("#form_description").hide();
    		$("#form_temperature").hide();
    		$("#form_urgent").hide();
    	};
    	if(order_type == "1") {
    		//$("#form_title").html("Sample");
    		//$("#description_title").html("");
    		$("#order_form").show(200);
            $("#order_form2").show(200);
            $("#order_form3").show(200);
            $("#quick_order").hide();
    		//$("#form_quantity").show();
    		//$("#form_description").hide();
    		//$("#form_temperature").show();
    		//$("#form_urgent").show();
    	};
    	if(order_type == "2") {
			$("#form_title").html("Test");
    		$("#description_title").html("Requirements");
    		$("#order_form").show(200);
    		$("#form_quantity").hide();
    		$("#form_description").show();
    		$("#form_temperature").show();
    		$("#form_urgent").show();    	
		};
    	if(order_type == "3") {
			$("#form_title").html("Special Request");
    		$("#description_title").html("Special Request");
    		$("#order_form").show(200);
    		$("#form_quantity").hide();
    		$("#form_description").show();
    		$("#form_temperature").hide();
    		$("#form_urgent").hide();
        };
        if(order_type == "4") {
            //$("#form_title").html("Special Request");
            //$("#description_title").html("Special Request");
            $("#order_form").hide();
            $("#order_form2").hide();
            $("#order_form3").hide();
            $("#quick_order").show(200);
            //$("#form_quantity").hide();
            //$("#form_description").show();
            //$("#form_temperature").hide();
            //$("#form_urgent").hide();       
		};
   	});
});

$(document).ready(function() {   
	$("#order_delivery_site_id").change(function() {
		var delivery_site = $(this).val();
    	if(delivery_site == "0") {
    		$("#alternate_address").show();			
    	}
    	else {
    		$("#alternate_address").hide();
    	};
   	});
});