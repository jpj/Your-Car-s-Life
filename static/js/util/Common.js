var Common = {

	/**
 	* Apply the title attribute to any empty fields.
 	*/
	applySuggestion : function() {
		if ( $(this).val() == "" || $(this).val() == $(this).attr("title") ) {
			$(this).val($(this).attr("title"));
			$(this).addClass("suggestionStyle");
		}
	},
	
	/**
 	* Remove suggestions from any blank fields.
 	*/
	removeSuggestion : function() {
		if ( $(this).val() == $(this).attr("title") ) {
			$(this).val("");
			$(this).removeClass("suggestionStyle");
		}
	}

};
