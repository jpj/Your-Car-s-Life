$(document).ready( function() {


	/**
	 * If someone clicks the dipstick get the percentage of the
	 * height where they clicked it, enter the value, adjust
	 * the dipstick accordingly.
	 */
	$(".dipstick div").click(function(e) {
		var x = (($(this).height() - (e.pageY - $(this).offset().top)) / $(this).height()).toFixed(2);


		$("#addRecordDipstick").val( x );
		$(this).find("div").height( 100 - x*100 + "%" );
	});


	/**
	 * If someone makes an entry in the dipstick field then check that
	 * it is an appropriate value (>= 0 && <= 100) and adjust the
	 * dipstick accordingly.
	 */
	$("#addRecordDipstick").keyup(function() {
		if ( $(this).val() < 0.00 || $(this).val() > 1.00 ) {
			$(this).addClass("error");
		} else {
			$(this).removeClass("error");
			$(".dipstick div div").height( 100 - $(this).val()*100 + "%" );
		}
	});
});

