$(document).ready(function() {
	var vehicleDao = new VehicleDao();

	var inputData = new VehicleFilterInputData();
	vehicleDao.getVehicles(inputData, new VehicleListView());
});
