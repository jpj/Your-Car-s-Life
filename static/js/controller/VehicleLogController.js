$(document).ready(function() {

	var logRecordDao = new LogRecordDao();
	var vehicleDao = new VehicleDao();
	var inputData = new LogRecordFilterInputData();

	// Odd/Even
	$("#vehicleLogRecord .record.item:odd").addClass("odd");
	$("#vehicleLogRecord .record.item:even").addClass("even");

	// Get Vehicle List
	var vehicleSelectListView = new VehicleSelectListView();
	vehicleDao.getVehicles(
		new VehicleFilterInputData(),
		vehicleSelectListView,
		function() {
			var selectedVehicle = vehicleSelectListView.getSelectedVehicle();
			// Get Log Records
			inputData.vehicleId = selectedVehicle.vehicleId;

			logRecordDao.getLogRecords(inputData, new LogRecordListView());

			// Click on log records
			$("#vehicleLogRecord .record.item").click(function() {
				var logRecordId = $(this).find(".id").text();
				var inputData = new LogRecordFilterInputData();
				inputData.logRecordId = logRecordId;
				inputData.vehicleId = selectedVehicle.vehicleId;

				var view = new LogRecordFormView();

				try {
					logRecordDao.getLogRecords(inputData, view, function() { view.openForm(); });
				} catch (e) {
					alert("Exception calling logRecordDao.getLogRecords: " + e);
				}
			});
		}
	);

	// Submit log record form
	$("#logRecordForm .form").submit(function(e) {
		e.preventDefault();

		var logRecord = new LogRecord();
		logRecord.logRecordId = $(this).find("*[name=logRecordId]").val();
		logRecord.vehicleId = $(this).find("*[name=vehicleId]").val();
		logRecord.date = $(this).find("*[name=date]").val();
		logRecord.created = $(this).find("*[name=created]").val();
		logRecord.modified = $(this).find("*[name=modified]").val();
		logRecord.odometer = $(this).find("*[name=odometer]").val();
		logRecord.gallons = $(this).find("*[name=gallons]").val();
		logRecord.octane = $(this).find("*[name=octane]").val();

		var view = new LogRecordFormView();
		logRecordDao.saveLogRecord(
			logRecord,
			view,
			function() {
				logRecordDao.getLogRecords(inputData, new LogRecordListView());
				view.closeForm();
			}
		);
	});

	// Clear and prime form for new record.
	$("#addNewRecord").click(function(e) {
		e.preventDefault();
		var view = new LogRecordFormView();
		var logRecord = new LogRecord();

		logRecord.vehicleId = vehicleSelectListView.getSelectedVehicle().vehicleId;
		logRecord.octane = 87;

		view.init();
		view.addLogRecord(logRecord);
		view.openForm();
		view.focusDateField();
	});

});
