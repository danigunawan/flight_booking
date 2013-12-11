//
$(function (){
    $('#select_date').datepicker({
	    minDate: 0,
	    onSelect: function(theDate) {
	        $("#dataEnd").datepicker('option', 'minDate', new Date(theDate));
	    },
	    beforeShow: function() {
	        $('#ui-datepicker-div').css('z-index', 9999);
	    },
	    dateFormat: 'mm/dd/yy'
	   });
});

