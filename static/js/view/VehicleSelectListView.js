var VehicleSelectListView = function() {

	var select = $("#vehicleId");

	this.init = function() {
	}

	this.finish = function() {
	}

	this.addVehicle = function(vehicle) {
		select.append('<option value="' + vehicle.vehicleId + '">' + vehicle.name + '</option>');
	}

	this.setErrorMessage = function(msg) {
		alert(msg);
	}

	this.getSelectedVehicle = function() {
		var vehicleElement = select.find("option:selected");
		var vehicle = new Vehicle();
		vehicle.vehicleId = vehicleElement.val();
		vehicle.name = vehicleElement.text();
		return vehicle;
	}
}
