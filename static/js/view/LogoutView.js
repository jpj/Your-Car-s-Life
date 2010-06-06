function LogoutView() {
	var msg = $("#logoutMessage");

	this.setMsg = function(m) {
		msg.text(m);
	}

	this.success = function() {
		window.location.pathname = YCLConstants.LOGOUT_SUCCESS_URL;
	}
}
