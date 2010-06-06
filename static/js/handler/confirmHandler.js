function doConfirm(obj) {

	if ( $("#" + obj.id).length <= 0 ) {
		$("body").prepend('<div id="' + obj.id + '" class="confirmBox draggable window"></div>');
	}
	var confirmBox = $("#" + obj.id);
	
	confirmBox.load(
		"confirmFragment.jhtml",
		{},
		function() {
			confirmBox.find(".confirm").click(function() {
				obj.confirm();
				windowHandler({
					src: confirmBox,
					callback: function() {
						confirmBox.remove();
					}
				});
			});
			confirmBox.find(".cancel").click(function() {
				if (typeof obj.cancel == "function") {
					obj.cancel();
				}
				windowHandler({
					src: confirmBox,
					callback: function() {
						confirmBox.remove();
					}
				});
			});
			
			if (typeof obj.message != "undefined") {
				confirmBox.find(".msg").html( obj.message );
			}
			
			confirmBox.css({
				top: obj.event.pageY,
				left: obj.event.pageX
			});
		}
	);
	
	windowHandler({
		src: confirmBox,
		state: "open"
	});
}