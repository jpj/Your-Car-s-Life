/**
 * Load the login form and perform validation of user credentials, call
 * passed function upon successful login.
 *
 * @param	holder			JQuery object to place the login form.
 * @param	loginSuccessFunction	function() that will be called once
 *					successfully logged in.
 * @return	void
 */
function loadLoginForm(holder, loginSuccessFunction) {

	var Constants = new CONSTANTS();

	$.ajax({
		url: Constants.LOGIN_FRAGMENT_URL(),
		type: "GET",
		error: function() {
			alert("Error loading: " + Constants.LOGIN_FRAGMENT_URL());
		},
		success: function(data) {
			holder.html( data );
			handleSuggestions();
			var loginFormView = new LoginFormView( holder.find(".loginForm") );
			loginFormView.focusLoginField();
			
			//loginFormView.getForm().submit(function(e) {
			loginFormView.getForm().submit(function(e) {
				e.preventDefault();

				loginFormView.setMsg( "Verifying..." );
				
				$.ajax({
					url: Constants.LOGIN_XML_URL(),
					data: {
						login:		loginFormView.getLoginField(),
						password:	loginFormView.getPasswordField()
					},
					type: "POST",
					error: function() {
						loginFormView.setMsg( "Error contacting " + Constants.LOGIN_XML_URL() );
					},
					success: function(xml) {
						if ( $("success", xml).text() == "true" ) {
							loginFormView.setMsg( "Logging In..." );
							loginSuccessFunction();
						} else {
							loginFormView.setMsg( "Login Failed. Please try again." );
						}
					}
				});
			});
		}
	});

}

function isUserLoggedIn(xml) {
	if ( $("notLoggedIn", xml).text() == "true" ) {
		//alert("not logged in");
		return false;
	} else {
		//alert("logged in");
		return true;
	}
}

var handleEmergencyLogin = function(loginSuccessFunction) {
	
	var loginForm = $("#emergencyLoginForm");
	var loginFormHolder = loginForm.find(".holder");
	
	windowHandler({
		src: loginForm,
		state: "open"
	});
	
	loadLoginForm(
		loginFormHolder,
		function() {
			loginSuccessFunction();
			windowHandler({
				src: loginForm,
				callback: function() {
					loginFormHolder.html( "Emergency Login ");
				}
			});
		}
	);
}

var handleRequest = function(xml, loginSuccessFunction, loginFailedFunction) {
	if ( isUserLoggedIn(xml) == true ) {
		try {
			loginSuccessFunction();
		} catch (e) {
			throw e;
		}
	} else {
		handleEmergencyLogin(loginFailedFunction);
	}
}
