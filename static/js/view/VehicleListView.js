var VehicleListView = function() {

	this.init = function() {
		$("#vehicleRecords .record.item[data-state=unavailable]").attr("data-state", "available").attr("data-vehicleid", "").addClass("available");;
	}

	this.finish = function() {
	}

	this.addVehicle = function(vehicle) {
		//alert("ading vehicle " + vehicle.name);
		var firstItem = $("#vehicleRecords .record.item[data-state=available]:first");
		firstItem.attr("data-vehicleid", vehicle.vehicleId);
		firstItem.find("*[data-id=name]").text( vehicle.name );
		firstItem.find("*[data-id=notes]").text( vehicle.notes );
		firstItem.attr("data-state", "unavailable");
		firstItem.removeClass("available");
	}

	this.setErrorMessage = function(msg) {
		alert(msg);
	}
}
