function LoginFormView(loginForm) {

	if ( typeof loginForm != "object" || loginForm.length < 1 ) {
		alert("Couldn't create new LoginFormView. Invalid loginFormect passed.");
		return;
	}

	var loginField = loginForm.find("*[name=login]");
	var passwordField = loginForm.find("*[name=password]");
	//var msg = loginForm.find(".loginMessage");
	var msg = $(".loginMessage");

	this.getForm = function() {
		return loginForm;
	}
	this.getLoginField = function() {
		return loginField.val();
	}
	this.getPasswordField = function() {
		return passwordField.val();
	}
	this.focusLoginField = function() {
		loginField.focus();
	}
	this.setMsg = function(m) {
		msg.text( m );
	}
	this.success = function() {
		window.location.href = window.location.href;
		//alert(window.location.href);
	}
}
