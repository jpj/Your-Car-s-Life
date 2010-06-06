/**
 * callback:	function called when window is finished opening/closing.
 * owner:	jquery object of the owner (link/etc used to open the box)
 * src:		jquery object of the window
 * state:	open, close, toggle
 */
function windowHandler(window) {
	if (typeof window != "object") {
		alert("windowHandler: Invalid window object passed");
		return;
	}
	
	if (typeof window.src != "object") {
		alert("windowHandler: Can't operate on window without .src");
		return;
	}
	
	if (typeof window.state == "undefined") {
		window.state = "toggle";
	}
	
	var isOwnerAvailable = new Boolean(false);
	if (typeof window.owner == "object" && window.owner.length > 0) {
		isOwnerAvailable = true;
	}
	
	if ( (window.src.is(":visible") && window.state == "toggle") || window.state == "close" ) {
		window.src.slideUp(
			Constants.TOGGLE_TIME(),
			function() {
				if (isOwnerAvailable.valueOf()) {
					window.owner.removeClass("windowActive");
				}
				if (typeof window.callback == "function") {
					window.callback();
				}
			}
		);
	} else {
		if (isOwnerAvailable.valueOf()) {
			window.owner.addClass("windowActive");
		}
		
		window.src.css({"z-index" : ++Globals.highestWindow});
		window.src.slideDown(
			Constants.TOGGLE_TIME(),
			function() {
				if (typeof window.callback == "function") {
					window.callback();
				}
			}
		);
	}
	
	// May need to check if this function is already bound if
	// binding multiple times causes problems.
	if (window.src.hasClass("window")) {
		window.src.click(function() {
			$(this).css({"z-index" : ++Globals.highestWindow});
		});
	}
	
	if (window.src.hasClass("draggable")) {
		window.src.draggable({
			cursor: "move",
			handle: ".handle"
		});
	}
}