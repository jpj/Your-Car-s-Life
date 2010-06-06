/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var LogRecordListView = function() {

	var previousLogRecord = null;

	var formatDate = function(dateString) {
		var d = new Date(dateString);
		var now = new Date();
		var format = "mmm d";

		if ( now.getFullYear() != d.getFullYear() ) {
			format = "mmm yyyy";
		}

		return d.format(format);
		//return parseInt( (now.getTime() - d.getTime()) / 1000 / 60 / 60 / 24 ); // Days ago
	}

	this.init = function() {
		$("#vehicleLogRecord .record.item[data-state=unavailable]").attr("data-state", "available");
	}

	this.finish = function() {
	}

	this.addLogRecord = function(logRecord) {
		var miles = previousLogRecord != null ? (logRecord.odometer - previousLogRecord.odometer).toFixed(1) : 0;
		var mpg =  previousLogRecord != null ? ( (logRecord.odometer - previousLogRecord.odometer) / logRecord.gallons ).toFixed(2) : 0;

		var firstItem = $("#vehicleLogRecord .record.item[data-state=available]:first");
		firstItem.find("*[data-id=logRecordId]").text( logRecord.logRecordId );
		//firstItem.find("*[data-id=date]").text( logRecord.date );
		firstItem.find("*[data-id=date]").text( formatDate(logRecord.jsDate) );
		firstItem.find("*[data-id=odometer]").text( logRecord.odometer );
		firstItem.find("*[data-id=gallons]").text( logRecord.gallons );
		firstItem.find("*[data-id=octane]").text( logRecord.octane );
		firstItem.find("*[data-id=miles]").text( miles ); // previousLogRecord != null ? (logRecord.odometer - previousLogRecord.odometer).toFixed(1) : "" );
		firstItem.find("*[data-id=mpg]").text( mpg ); // previousLogRecord != null ? ( (logRecord.odometer - previousLogRecord.odometer) / logRecord.gallons ).toFixed(2) : "" );
		firstItem.attr("data-state", "unavailable");

		var avgMpg = parseFloat($("#logRecordStats .mpg").text()).toFixed(2);
		var totalRecords = parseInt($("#logRecordStats .total").text());
		var totalMpg = parseFloat($("#logRecordStats .mpg").attr("data-totalmpg")).toFixed(2);

		totalRecords++;
		totalMpg = (parseFloat(totalMpg) + parseFloat(mpg)).toFixed(2);
		avgMpg = (totalMpg / totalRecords).toFixed(2);

		$("#logRecordStats .total").text( totalRecords );
		$("#logRecordStats .mpg").text( avgMpg );
		$("#logRecordStats .mpg").attr("data-totalmpg", totalMpg);

		previousLogRecord = logRecord;
	}

	this.setErrorMessage = function(msg) {
		alert(msg);
	}
}
