var Exception = function(_msg) {
	var msg = _msg;

	this.getMessage = function() {
		return msg;
	}

	this.toString = function() {
		return msg;
	}
}
