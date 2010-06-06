		
function camel() {


	$.post(
		"/static/test.xml",
		{},
		function(xml) {

			//alert($("niner", xml).text());

			$(xml).find('item').each(
				function() {

					alert( $(this).attr('id') );

				}
			);

		}

	);
}


function addRecord() {
		
	
	$("#addRecordStatus").text("Adding Record...").show().fadeOut(2000);

	$("#addRecordDate").removeClass("error");
	$("#addRecordOdometer").removeClass("error");
	$("#addRecordGallons").removeClass("error");
	$("#addRecordOctane").removeClass("error");

	$("#addRecordDateError").html("");
	$("#addRecordOdometerError").html("");
	$("#addRecordGallonsError").html("");
	$("#addRecordOctaneError").html("");
	
	$.post(
		"/xml/addRecord.php",
		{
			date: $("#addRecordDate").attr('value'),
			odometer: $("#addRecordOdometer").attr('value'),
			gallons: $("#addRecordGallons").attr('value'),
			octane: $("#addRecordOctane").attr('value')
		},
		function(addRecordXml) {


			if ( $("errors", addRecordXml).text() == "true" ) {
	
				// There's an error.
				//
				// Right now we do nothing in particular whether
				// or not there is an error. But eventually we will.
				// This is where we distinguish.
	
				processError("addRecordDate", "date", addRecordXml);
				processError("addRecordOdometer", "odometer", addRecordXml);
				processError("addRecordGallons", "gallons", addRecordXml);
				processError("addRecordOctane", "octane", addRecordXml);
	
				if ( $("login", addRecordXml).text() != "" ) {
					//alert("not logged in");
					window.location = "/login.php";
				}
	
			} else {
	
				// Everything is good.
				$("#addRecordStatus").html( "New record created. Id: " + $("logRecordId", addRecordXml).text() );
	
			}


	 
		}
	);
	//alert('odometer: ' + $("#addRecordOdometer").attr('value') +
	//	'gallons: ' + $("#addRecordGallons").attr('value'));
	
	 
	
}


$(document).ready(function() {
	$("#addRecordForm").submit(function(e) {
		
		e.preventDefault();
		
		addRecord();
		
	});


	$("#poo").click(function(e) {
		e.preventDefault();
		camel();
	});
		


}); // End ready



function processError(id, param, xml) {
	if ( $(param, xml).text() != "" ) {
		$("#" + id).addClass("error");
		$("#" + id + "Error").html( $(param, xml).text() );
	}
}

