function LogRecordDao() {
	this.getLogRecords = function(logRecordFilterInputData, view, callback) {
		try {
			getLogRecords(logRecordFilterInputData, view, callback);
		} catch(e) {
			throw e;
		}
	}

	var getLogRecords = function(inputData, view, callback) {
		//alert("getting records for vehicle " + inputData.vehicleId)

		//var data = new Object();
		//if (inputData.logRecordId

		$.ajax({
			url: YCLConstants.GET_LOG_RECORDS_URL,
			data: {
				logRecordId: inputData.logRecordId != null ? inputData.logRecordId : '',
				vehicleId: inputData.vehicleId
			},
			error: function() {
				alert("error contacting " + YCLConstants.GET_LOG_RECORDS_URL);
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						//view.setTemplateLoadMsg("Processing Request...");
						try {
							processRequest(xml);
						} catch (e) {
							if ( typeof e == "object" ) {
								alert(e);
								view.setErrorMessage( e );
							} else {
								view.setErrorMessage( e );
							}
						}
					},
					function() {
						getLogRecords(inputData, view, callback);
					}
				);
			}
		});

		var processRequest = function(xml) {
			view.init();
			//alert("processRequest");

			$("logRecords logRecord", xml).each(function() {
				var logRecord = new LogRecord();
				logRecord.logRecordId = $(this).find("logRecordId").text();
				logRecord.vehicleId = $(this).find("vehicleId").text();
				logRecord.date = $(this).find("date").text();
				logRecord.jsDate = $(this).find("jsDate").text();
				logRecord.created = $(this).find("created").text();
				logRecord.modified = $(this).find("modified").text();
				logRecord.odometer = ( parseFloat( $(this).find("odometer").text() ) ).toFixed(1);
				logRecord.gallons = ( parseFloat($(this).find("gallons").text()) ).toFixed(3);
				logRecord.octane = $(this).find("octane").text();

				try {
					view.addLogRecord(logRecord);
				} catch (e) {
					throw e;
				}
			});

			try {
				view.finish();
			} catch (e) {
				throw e;
			}

			if (typeof callback == "function") {
				callback();
			}
		}
	}

	/**
	 * saveLogRecord
	 */
	this.saveLogRecord = function(logRecord, view, callback) {

		// TODO Test this

		var formData = {
			logRecordId	: logRecord.logRecordId,
			vehicleId	: logRecord.vehicleId,
			date		: logRecord.date,
			odometer	: logRecord.odometer,
			gallons		: logRecord.gallons,
			octane		: logRecord.octane
		};

		$.ajax({
			url: YCLConstants.SAVE_LOG_RECORD_URL,
			type: "POST",
			data: formData,
			error: function() {
				view.setErrorMessage("Error occured accessing url: " + YCLConstants.SAVE_LOG_RECORD_URL);
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						try {
							processRequest(xml);
						} catch (e) {
							view.setErrorMessage( e );
						}
					},
					function() {
						this.saveLogRecord(logRecord, view, callback);
					}
				);
			}
		});

		var processRequest = function(xml) {
			//view.init();
			view.clearMessages();
			if ( $("error", xml).length == 0 ) {
				view.setSuccessMessage( $("message", xml).text() );

				if (typeof callback == "function") {
					callback();
				}
			} else {
				$("error", xml).each(function() {
					// TODO
					// Optionally, pass in field name here
					view.addError( $(this).text() );
				});
			}


			view.finish();
		}
	}
}
