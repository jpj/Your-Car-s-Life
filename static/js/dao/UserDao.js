function UserDao() {

	this.getUserByLoginAndPassword = function(view) {

		var login = view.getLoginField();
		var password = view.getPasswordField();

		$.ajax({
			url: YCLConstants.LOGIN_XML_URL,
			data: {login: login, password: password},
			type: "POST",
			error: function() {
				alert("error calling " + YCLConstants.LOGIN_XML_URL);
			},
			success: function(xml) {
				if ( $("loginSuccess", xml).text() == "true" ) {
					view.setMsg("Login was successful!");
					view.success();
				} else {
					view.setMsg("Login failed.");
				}
			}
		});
	};

	this.logoutUser = function(view) {
		$.ajax({
			url: YCLConstants.LOGOUT_XML_URL,
			error: function() {
				alert("Error calling " + YCLConstants.LOGOUT_XML_URL);
			},
			success: function(xml) {
				if ( $("logoutSuccess", xml).text() == "true" ) {
					view.setMsg("Successfully logged out!");
					view.success();
				} else {
					// I sincerely doubt this would ever happen.
					// Actually, I don't think it's possible.
					view.setMsg("Logout failed! (?)");
				}
			}
		});
	};
}
