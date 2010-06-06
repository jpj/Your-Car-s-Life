/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var LogRecordFormView = function() {

	var formContainer = $("#logRecordForm");
	var form = $("#logRecordForm form");
	var dateField = form.find("*[name=date]");
	var errorField = $("#logRecordForm .message.error");
	var successField = $("#logRecordForm .message.success");
	var hasErrors = false;
	var hasSuccess = false;
	var logRecordCount = 0;
	var closeButton = formContainer.find(".close a");

	this.focusDateField = function() {
		dateField.focus();
	}

	this.closeForm = function() {
		formContainer.slideUp(500);
	}

	var closeForm = this.closeForm;

	closeButton.click(function(e) {
		e.preventDefault();
		closeForm();
	});

	this.init = function() {
		form.find(".input").val('');
		errorField.hide();
		successField.hide();
		//errorField.text('');
		errorField.find("ul li").remove();
		successField.text('');
	}

	this.clearMessages = function() {
		errorField.hide();
		successField.hide();
		errorField.find("ul li").remove();
		successField.text('');
	}

	this.finish = function() {
		if (hasErrors) {
			errorField.slideDown( 500 );
		}

		if (hasSuccess) {
			successField.slideDown( 500 );
		}
	}

	this.addLogRecord = function(logRecord) {
		if (logRecordCount > 0) {
			throw new Exception("LogRecordFormView only accepts one record.");
		}

		form.find(".input[name=logRecordId]").val( logRecord.logRecordId );
		form.find(".input[name=vehicleId]").val( logRecord.vehicleId );
		form.find(".input[name=date]").val( logRecord.date );
		form.find(".input[name=odometer]").val( logRecord.odometer );
		form.find(".input[name=gallons]").val( logRecord.gallons );
		form.find(".input[name=octane]").val( logRecord.octane );
		logRecordCount++;
	}

	this.setErrorMessage = function(msg) {
		hasErrors = true;
		errorField.find("ul").append("<li>" + msg + "</li>");
		errorField.slideDown( 500 );
	}

	// TODO
	// Accept optional param as field name to indicate field.
	this.addError = function(msg) {
		hasErrors = true;
		errorField.find("ul").append("<li>" + msg + "</li>");
	}

	this.setSuccessMessage = function(msg) {
		hasSuccess = true;
		successField.text(msg);
		successField.slideDown(500);
	}

	this.openForm = function() {
		if (form.find("input[name=logRecordId]").val() == "" || form.find("input[name=logRecordId]").val() == "0") {
			form.find("input[type=submit]").val("Add");
		} else {
			form.find("input[type=submit]").val("Update");
		}

		formContainer.slideDown(500);
	}
}
