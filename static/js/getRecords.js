var toggleTime = 500;


$(document).ready( function() {

	getLogRecords();

	$("#toggleTest").click( function(e) {
		e.preventDefault();
		$("#logRecord_370").after( "<div>Hi!</div>" );
	});

	$("#addNewRecord").click( function(e) {
		e.preventDefault();
		$("#logRecord_0").appendTo("#addNewRecordContainer");
		$("#addNewRecordContainer").show(toggleTime);
	});

	$("#refreshLog").click( function(e) {
		e.preventDefault();
		$(".logRecordHolder").remove();
		getLogRecords();
		/*
		$(".logRecordHolder").hide(
			toggleTime,
			function() {
				$(".logRecordHolder").remove();
				getLogRecords();
			}
		);
		*/
	});

	$("#addRecordForm").submit( function(e) {
		e.preventDefault();
		addRecord();
	});


});



function getLogRecords() {


	$.post (
		"xml/getRecords.php",
		{
		},
		function(xml) {


			//$("#logRecordStatsAverage").html( $("averageMPG", xml).text() );
			//$("#logRecordStatsTotalRecords").html( $("totalRecords", xml).text() );


			$("record", xml).each(function(i) {



				id = $(this).find("id").text();
				date = $(this).find("date").text();
				odometer = $(this).find("odometer").text();
				gallons = $(this).find("gallons").text();
				octane = $(this).find("octane").text();
				miles = $(this).find("miles").text();
				mpg = $(this).find("mpg").text();


				$("#logRecordContainer").append(
					"<div id=\"logRecord_" + id + "\" class=\"logRecord logRecordHolder\">" +
					$("#logRecordExample").html() +
					"</div>\n"
				);




				$("#logRecord_" + id + " .logRecordId").html( id );
				$("#logRecord_" + id + " .logRecordDate span").html( date );
				$("#logRecord_" + id + " .logRecordDate input").val( date );
				$("#logRecord_" + id + " .logRecordOdometer span").html( odometer );
				$("#logRecord_" + id + " .logRecordOdometer input").val( odometer );
				$("#logRecord_" + id + " .logRecordGallons span").html( gallons );
				$("#logRecord_" + id + " .logRecordGallons input").val( gallons );
				$("#logRecord_" + id + " .logRecordOctane span").html( octane );
				$("#logRecord_" + id + " .logRecordOctane input").val( octane );
				$("#logRecord_" + id + " .logRecordMiles").html( miles );
				$("#logRecord_" + id + " .logRecordMPG").html( mpg );


				$("#logRecord_" + id).show( toggleTime );



			});




			attachEvents();
			calculateMpg();

			//alert("done getting records!");
			// This is the place to calculate MPG and prev records and so on.




		}

	);




}


function insertLogRecordAfter(logRecordId, previousLogRecordId) {
	//alert("insertLogRecordAfter");


	$.get (
		"xml/getRecords.php",
		{
			logRecordId: logRecordId,
			previousLogRecordId: previousLogRecordId
		},
		function(xml) {


			//$("#logRecordStatsAverage").html( $("averageMPG", xml).text() );
			//$("#logRecordStatsTotalRecords").html( $("totalRecords", xml).text() );


			$("record", xml).each(function(i) {



				id = $(this).find("id").text();
				date = $(this).find("date").text();
				odometer = $(this).find("odometer").text();
				gallons = $(this).find("gallons").text();
				octane = $(this).find("octane").text();
				miles = $(this).find("miles").text();
				mpg = $(this).find("mpg").text();
				//alert("processing record " + id);



				if ( $("#logRecord_" + id).length > 0 ) {
					//alert("Cannot insertRecord " + id + " because it already exists!");
				} else {


					//$("#logRecord_" + id).length > 0
					$("#logRecord_" + previousLogRecordId).after(
						"<div id=\"logRecord_" + id + "\" class=\"logRecord logRecordHolder\">" +
						$("#logRecordExample").html() +
						"</div>\n"
					);




					$("#logRecord_" + id + " .logRecordId").html( id );
					$("#logRecord_" + id + " .logRecordDate span").html( date );
					$("#logRecord_" + id + " .logRecordDate input").val( date );
					$("#logRecord_" + id + " .logRecordOdometer span").html( odometer );
					$("#logRecord_" + id + " .logRecordOdometer input").val( odometer );
					$("#logRecord_" + id + " .logRecordGallons span").html( gallons );
					$("#logRecord_" + id + " .logRecordGallons input").val( gallons );
					$("#logRecord_" + id + " .logRecordOctane span").html( octane );
					$("#logRecord_" + id + " .logRecordOctane input").val( octane );
					$("#logRecord_" + id + " .logRecordMiles").html( miles );
					$("#logRecord_" + id + " .logRecordMPG").html( mpg );

					$("#logRecord_" + id + " .logRecordEntry").addClass( "logRecordFresh" );
					setTimeout("$(\"#logRecord_" + id + " .logRecordEntry\").removeClass( \"logRecordFresh\" )", 60000);


					$("#logRecord_" + id).show( toggleTime );


				}

			});




			attachEvents();

			calculateMpg();



		}

	);


	//alert("done insertLogRecordAfter");
}


function saveRecord(logRecordId) {
	$("#logRecord_" + logRecordId + " .logRecordEntry input").removeClass( "error" );
	$("#logRecord_" + logRecordId + " .logRecordMessage").removeClass( "messageError" );
	$("#logRecord_" + logRecordId + " .logRecordMessage").removeClass( "messageSuccess" );
	//alert("saving record " + logRecordId);
	//
	$.get(
		"xml/saveRecord.php",
		{
			logRecordId: $("#logRecord_" + logRecordId + " .logRecordId").html(),
			logRecordDate: $("#logRecord_" + logRecordId + " .logRecordDate input").val(),
			logRecordOdometer: $("#logRecord_" + logRecordId + " .logRecordOdometer input").val(),
			logRecordGallons: $("#logRecord_" + logRecordId + " .logRecordGallons input").val(),
			logRecordOctane: $("#logRecord_" + logRecordId + " .logRecordOctane input").val(),
			logRecordDipstick: "0.00"
		},
		function(xml) {

			var isError = new Boolean(false);
			var errors = new Array();

			$("error", xml).each( function() {
				isError = true;
				var errorKey = $(this).attr("id");
				var errorVal = $(this).text();
				//alert(errorKey + " - " + errorVal);
				//alert(errorKey);
				$("#logRecord_" + logRecordId + " ." + errorKey + " input").addClass( "error" );
				//alert( '$("#logRecord_" + logRecordId + " " + errorKey + " input").addClass("error"));

				errors[errors.length] = errorVal;
			});


			//alert("Error? " + isError + " " + $("logId", xml).text());
			if (isError == true) {
				$("#logRecord_" + logRecordId + " .logRecordMessage").addClass( "messageError" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").html( "An error occured: " );
				$("#logRecord_" + logRecordId + " .logRecordMessage").append( "<ul>" );
				for (i = 0; i < errors.length; i++) {
					$("#logRecord_" + logRecordId + " .logRecordMessage").append( "<li>" + errors[i] + "</li>" );
				}
				$("#logRecord_" + logRecordId + " .logRecordMessage").append( "</ul>" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").show( toggleTime );
			} else {
				$("#logRecord_" + logRecordId + " .logRecordDate span").html( $("#logRecord_" + logRecordId + " .logRecordDate input").val() );
				$("#logRecord_" + logRecordId + " .logRecordOdometer span").html( $("#logRecord_" + logRecordId + " .logRecordOdometer input").val() );
				$("#logRecord_" + logRecordId + " .logRecordGallons span").html( $("#logRecord_" + logRecordId + " .logRecordGallons input").val() );
				$("#logRecord_" + logRecordId + " .logRecordOctane span").html( $("#logRecord_" + logRecordId + " .logRecordOctane input").val() );

				// Hide inputs and show spans
				$("#logRecord_" + logRecordId + " .logRecordEntry span").slideToggle( toggleTime );
				$("#logRecord_" + logRecordId + " .logRecordEntry input").slideToggle( toggleTime );
				$("#logRecord_" + logRecordId + " .logRecordModify div").slideToggle( toggleTime );

				$("#logRecord_" + logRecordId + " .logRecordMessage").addClass( "messageSuccess" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").html( "Record Updated Successfully!" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").show(
					toggleTime,
					function() {
						setTimeout("$(\"#logRecord_" + logRecordId + " .logRecordMessage\").hide( toggleTime )", 2000);
					}
				);


				$("#logRecord_" + logRecordId + " .logRecordEntry").addClass( "logRecordFresh" );
				setTimeout("$(\"#logRecord_" + logRecordId + " .logRecordEntry\").removeClass( \"logRecordFresh\" )", 60000);

			}


		}
	);

}


function addRecord() {
	$("#logRecord_0 input").removeClass( "error" );
	$("#logRecord_0 .logRecordMessage").removeClass( "messageError" );
	$("#logRecord_0 .logRecordMessage").removeClass( "messageSuccess" );


	$.get(
		"xml/saveRecord.php",
		{
			logRecordId: 0,
			logRecordDate: $("#logRecord_0 .logRecordDate input").val(),
			logRecordOdometer: $("#logRecord_0 .logRecordOdometer input").val(),
			logRecordGallons: $("#logRecord_0 .logRecordGallons input").val(),
			logRecordOctane: $("#logRecord_0 .logRecordOctane input").val(),
			logRecordDipstick: $("#logRecord_0 .logRecordDipstick input").val()
		},
		function(xml) {

			var isError = new Boolean(false);
			var errors = new Array();

			$("error", xml).each( function() {
				isError = true;
				var errorKey = $(this).attr("id");
				var errorVal = $(this).text();
				//alert(errorKey + " - " + errorVal);
				//alert(errorKey);
				$("#logRecord_0 ." + errorKey + " input").addClass( "error" );
				//alert( '$("#logRecord_" + logRecordId + " " + errorKey + " input").addClass("error"));

				errors[errors.length] = errorVal;
			});


			if (isError == true) {
				$("#logRecord_0 .logRecordMessage").addClass( "messageError" );
				$("#logRecord_0 .logRecordMessage").html( "An error occured: " );
				$("#logRecord_0 .logRecordMessage").append( "<ul>" );
				for (i = 0; i < errors.length; i++) {
					$("#logRecord_0 .logRecordMessage").append( "<li>" + errors[i] + "</li>" );
				}
				$("#logRecord_0 .logRecordMessage").append( "</ul>" );
				$("#logRecord_0 .logRecordMessage").show( toggleTime );
			} else {

				$("#logRecord_0 .logRecordMessage").addClass( "messageSuccess" );
				$("#logRecord_0 .logRecordMessage").html( "Record " + $("logId", xml).text() + " Added Successfully!" );
				$("#logRecord_0 .logRecordMessage").show(
					toggleTime,
					function() {
						setTimeout("$(\"#logRecord_0 .logRecordMessage\").hide( toggleTime )", 2000);
					}
				);

				previousRecordId = $("previousRecordId", xml).text();
				nextRecordId = $("nextRecordId", xml).text();

				if (previousRecordId == 0) {
					if ( $("#logRecord_" + nextRecordId).length > 0 ) {
						// Insert before nextRecordId
						$("#logRecord_" + nextRecordId).before("<div>hi</div>");
					}
					// else do nothing.
				} else {
					if ( $("#logRecord_" + previousRecordId).length > 0 ) {
						//$("#logRecord_" + previousRecordId).after("<div>hi</div>");
						insertLogRecordAfter($("logId", xml).text(), previousRecordId);
						//setTimeout("calculateMpg()", 2000);
					}
				}
			}


		}
	);

}


function deleteRecord(logRecordId) {


	$("#logRecord_" + logRecordId + " .logRecordMessage").removeClass( "messageError" );
	$("#logRecord_" + logRecordId + " .logRecordMessage").removeClass( "messageSuccess" );


	$.get(
		"xml/deleteRecord.php",
		{
			logRecordId: logRecordId
		},
		function(xml) {

			var isError = new Boolean(false);
			var errors = new Array();

			$("error", xml).each( function() {
				isError = true;

				var errorKey = $(this).attr("id");
				var errorVal = $(this).text();

				errors[errors.length] = errorVal;
			});


			if (isError == true) {
				$("#logRecord_" + logRecordId + " .logRecordMessage").addClass( "messageError" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").html( "An error occured: " );
				$("#logRecord_" + logRecordId + " .logRecordMessage").append( "<ul>" );
				for (i = 0; i < errors.length; i++) {
					$("#logRecord_" + logRecordId + " .logRecordMessage").append( "<li>" + errors[i] + "</li>" );
				}
				$("#logRecord_" + logRecordId + " .logRecordMessage").append( "</ul>" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").show( toggleTime );
			} else {

				$("#logRecord_" + logRecordId + " .logRecordEntry").slideToggle( toggleTime );
				//$("#logRecord_" + logRecordId).slideToggle(
					//toggleTime,
					//function() {
						//$("#logRecord_" + logRecordId).remove();
					//}
				//);

				$("#logRecord_" + logRecordId + " .logRecordMessage").addClass( "messageSuccess" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").html( "Record Deleted Successfully!" );
				$("#logRecord_" + logRecordId + " .logRecordMessage").show( toggleTime );

			}
		}
	);
}



/**
 * Cancel Record Changes
 *
 * Cancels the editiing of a record. Basically just hides the text boxes
 * and shows the data.
 */
function cancelRecordChanges(logRecordId) {
	// Toggle the data and the inputs as well as the edit/save option.
	$("#logRecord_" + logRecordId + " .logRecordEntry span").slideToggle( toggleTime );
	$("#logRecord_" + logRecordId + " .logRecordEntry input").slideToggle( toggleTime );
	$("#logRecord_" + logRecordId + " .logRecordModify div").slideToggle( toggleTime );

	// Replace the input values with what is in the span tags incase they were changed.
	$("#logRecord_" + logRecordId + " .logRecordDate input").val( $("#logRecord_" + logRecordId + " .logRecordDate span").html() );
	$("#logRecord_" + logRecordId + " .logRecordOdometer input").val( $("#logRecord_" + logRecordId + " .logRecordOdometer span").html() );
	$("#logRecord_" + logRecordId + " .logRecordGallons input").val( $("#logRecord_" + logRecordId + " .logRecordGallons span").html() );
	$("#logRecord_" + logRecordId + " .logRecordOctane input").val( $("#logRecord_" + logRecordId + " .logRecordOctane span").html() );

	// Close any previously opened messaged for this record.
	$("#logRecord_" + logRecordId + " .logRecordMessage").hide( toggleTime );
}




/**
 * Calculate MPG
 *
 * Grab all the data; odometer and gallons, and calculate the milage and mpg
 * for each record.
 */
function calculateMpg() {
	var prevOdometer = 0;
	var averageMpg = 0;
	var totalRecords = 0;
	var totalMpg = 0.0;



	// Loop through each log record.
	$(".logRecordHolder").each( function(i) {

		var thisId = $(this).attr("id");


		// Either we don't have a previous record (1st record) or
		// it's the table headers. This should really be fixed so
		// they aren't read.
		if (isNaN(prevOdometer) || prevOdometer == 0) {
			$("#" + thisId + " .logRecordMiles").html( "-" );
			$("#" + thisId + " .logRecordMPG").html( "-" );
		} else {

			var miles = ( parseFloat($("#" + thisId + " .logRecordOdometer span").html()) - prevOdometer).toFixed(1);
			var mpg = (miles / $("#" + thisId + " .logRecordGallons span").html()).toFixed(2);

			// Fill in the fields
			$("#" + thisId + " .logRecordMiles").html( miles );
			$("#" + thisId + " .logRecordMPG").html( mpg );

			// incement total records and total mpg
			totalRecords++;
			totalMpg += parseFloat(mpg);

		}


		// set prev odometer to current reading for next record.
		prevOdometer = parseFloat( $("#" + thisId + " .logRecordOdometer span").html() );
	});



	// Now that we're done set the total number of records and average mpg for this set.
	$("#logRecordStatsAverage").html( (totalMpg/totalRecords).toFixed(2) );
	$("#logRecordStatsTotalRecords").html( totalRecords );

}




/**
 * Attach Events
 *
 * Attach the events to Edit, Delete, Save and Cancel after all the
 * records are drawn.
 */
function attachEvents() {


	// Loop through the records.
	$(".logRecord").each( function(i) {


		var thisId = $(this).attr("id");
		var logRecordId = $(this).find(".logRecordId").text();


		// Edit
		$(this).find("#logRecordEdit").click( function(e) {
			e.preventDefault();
			$("#" + thisId + " .logRecordEntry span").slideToggle( toggleTime );
			$("#" + thisId + " .logRecordEntry input").slideToggle( toggleTime );
			$("#" + thisId + " .logRecordModify div").slideToggle( toggleTime );
		});

		// Delete
		$(this).find("#logRecordDelete").click( function(e) {
			e.preventDefault();
			deleteRecord(logRecordId);
		});

		// Save
		$(this).find("#logRecordSave").click( function(e) {
			e.preventDefault();
			saveRecord(logRecordId);
		});

		// Cancle
		$(this).find("#logRecordCancel").click( function(e) {
			e.preventDefault();
			cancelRecordChanges(logRecordId);
		});
	});
}


