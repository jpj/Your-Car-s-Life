/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var LogRecord = function() {
	this.logRecordId;
	this.vehicleId;
	this.date;
	this.jsDate;
	this.created;
	this.modified;
	this.odometer;
	this.gallons;
	this.octane;

	this.toString = function() {
		var s =
			"LogRecord()\n" +
			"	logRecordId:	" + this.logRecordId + "\n" +
			"	vehicleId:	" + this.vehicleId + "\n" +
			"	date:	" + this.date + "\n" +
			"	jsDate:	" + this.jsDate + "\n" +
			"	created:	" + this.created + "\n" +
			"	modified:	" + this.modified + "\n" +
			"	odometer:	" + this.odometer + "\n" +
			"	gallons:	" + this.gallons + "\n" +
			"	octane:	" + this.octane + "\n" +
			"";

		return s;
	}
}
