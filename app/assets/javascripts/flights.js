//
$(function (){
    $('#select_date').datepicker({
	    minDate: 0,
	    onSelect: function(theDate) {
	        $("#dataEnd").datepicker('option', 'minDate', new Date(theDate));
	        $(this).change();
	    },
	    beforeShow: function() {
	        $('#ui-datepicker-div').css('z-index', 9999);
	    },
	    dateFormat: 'mm/dd/yy'
	   });
});

//function enable(){
		//alert("meow");
//		$("#airline_select option[value="All"]").removeAttr('disabled');
//	}

$(document).ready(function(){

	$(".dropdowns").on("change", function(){
		//On change, trigger this function
		$("#airline_select, #origin_select, #dest_select, #price_select, #select_date, #min_seats").on("change",function(){
			//Load all select's values into variables
			var airline = $("#airline_select").val();
			var origin = $("#origin_select").val();
			var dest = $("#dest_select").val();
			var price = $("#price_select").val();
			var date = date_modify($("#select_date").val());
			var seat = $("#min_seats").val();
			//Fire an AJAX call to flights/filter
		    $.ajax({
		    	url: "flights/filter", type: "GET",
		    	//Pass in each variable as a parameter.
		    	data: { airline_id: airline, 
		    		origin_airport_id: origin, 
		    		dest_airport_id: dest, 
		    		price: price,
		    		departure_date: date,
		    		min_seat_count: seat },
		    	success: enable
		    });
		});
		//alert("meow");
	});

	function enable(){
		//alert("meow");
		$("#airline_select option[value='All']").removeAttr('disabled');
		$("#origin_select option[value='All']").removeAttr('disabled');
		$("#dest_select option[value='All']").removeAttr('disabled');
		$("#price_select option[value='All']").removeAttr('disabled');
	}

	function date_modify(date) {
		if (date.length == 0) {
			return date
		}
		else {
			var date_element = date.split( "/" )
			var proper_date = date_element[2] + "-" + date_element[0] + "-" + date_element[1]
			return proper_date
		}
	}
});







