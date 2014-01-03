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

$(document).ready(function(){
	//On change, trigger this function
	$("#airline_select, #origin_select, #dest_select, #price_select, #select_date, #min_seats").change(function(){
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
	    		min_seat_count: seat }
	    });
	});

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

	function hider() {
		//Hide or Show table divs based on whether the table's tbody has content.
		if ($.trim($("#corp_tbody").html())=='') {
			$("#corporationtable").hide()
		}
		if ($.trim($("#corp_tbody").html())!='') {
			$("#corporationtable").show()
		}
		if ($.trim($("#char_tbody").html())=='') {
			$("#charactertable").hide()
		}
		if ($.trim($("#char_tbody").html())!='') {
			$("#charactertable").show()
		}
	}
});







