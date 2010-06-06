$(document).ready(function() {

	var Constants = new CONSTANTS();
	var loginFormView = new LoginFormView( $("#mainLoginForm") );

	$.ajax({
		url: Constants.LOGIN_CHECK_XML_URL(),
		type: "GET",
		error: function() {
			alert("Error in login check.");
		},
		success: function(xml) {
			if ( $("userLoggedIn", xml).text() == "true" ) {
				loginFormView.setMsg( "Already logged in. Forwarding..." );
				successfulLoginForward();
			} else {
				loadLoginForm( $("#mainLoginForm"), successfulLoginForward );
			}
		}
	});
	
	var successfulLoginForward = function() {
		location.href = Constants.LOGIN_SUCCESS_URL();
	};

});
