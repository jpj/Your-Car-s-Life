function VehicleDao() {

	this.getVehicles = function(vehicleFilterInputData, view, callback) {
		getVehicles(vehicleFilterInputData, view, callback);
	};

	var getVehicles = function(inputData, view, callback) {

		$.ajax({
			url: YCLConstants.GET_VEHICLES_URL,
			data: {
				vehicleId: inputData.vehicleId != null ? inputData.vehicleId : ''
			},
			error: function() {
				alert("error contacting " + YCLConstants.GET_VEHICLES_URL);
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
						getVehicles(inputData, view, callback);
					}
				);
			}
		});

		var processRequest = function(xml) {
			view.init();

			$("vehicles vehicle", xml).each(function() {
				var vehicle = new Vehicle();
				vehicle.vehicleId = $(this).find("vehicleId").text();
				vehicle.name = $(this).find("name").text();
				vehicle.notes = $(this).find("notes").text();

				try {
					view.addVehicle(vehicle);
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
		};
	};
}
