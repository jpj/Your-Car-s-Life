$(document).ready(function() {

	$(".suggestion").focus( Common.removeSuggestion ).blur( Common.applySuggestion );
	$(".suggestion").each( Common.applySuggestion );

	var userDao = new UserDao();
	
	$("#loginForm").submit(function(e) {
		e.preventDefault();

		var view = new LoginFormView( $(this) );

		view.setMsg("Logging in...");

		$(this).find(".suggestion").each( Common.removeSuggestion );
		userDao.getUserByLoginAndPassword(view);
		$(this).find(".suggestion").each( Common.applySuggestion );
	});

	$("#logout").click(function(e) {
		e.preventDefault();

		var view = new LogoutView();
		view.setMsg("Logging out...");
		userDao.logoutUser(view);
	});

});

