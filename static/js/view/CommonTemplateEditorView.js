function CommonTemplateEditorView() {
	
	var templateLoadMsg = $("#searchTemplateMessage");
	var templateSaveMsg = $(".saveTemplateMessage");
	var templateListMsg = $("#commonTemplateList .message");
	var templateSize = $("#templateSizeK");
	var templateId = $("#saveTemplateForm *[name=templateId]");
	var templateKey = $("#saveTemplateForm *[name=templateKey]");
	var templateDescription = $("#saveTemplateForm *[name=templateDescription]");
	var templateText = $("#saveTemplateForm *[name=templateText]");
	
	var addCommonTemplateForm = $("#addCommonTemplateForm");
	var preExistingDeletedTemplateForm = $("#preExistingDeletedTemplateForm");
	
	this.setTemplateLoadMsg = function(m) {
		templateLoadMsg.html( m );
	}
	
	this.setTemplateSaveMsg = function(m) {
		templateSaveMsg.html( m );
	}
	
	this.setTemplateListMsg = function(m) {
		templateListMsg.html( m );
	}
	
	this.setTemplateSize = function(m) {
		templateSize.html( m / 1000 );
	}
	
	this.hideTemplateListMsg = function() {
		templateListMsg.fadeOut(Constants.TOGGLE_TIME());
	}
	
	this.setTemplateId = function(id) {
		templateId.val( id );
	}
	
	this.setTemplateKey = function(key) {
		templateKey.val( key );
	}
	
	this.setTemplateDescription = function(desc) {
		templateDescription.val( desc );
	}
	
	this.setTemplateText = function(text) {
		templateText.val( text );
	}
	
	this.getTemplateText = function() {
		return templateText.val();
	}
	
	/* List */
	this.addCommonTemplateToList = function(commonTemplate) {
		var templateListFirstItem = $("#commonTemplateList .item.available:first");
		
		templateListFirstItem.find(".key").html( commonTemplate.key );
		templateListFirstItem.find(".key").attr("title", commonTemplate.key);
		templateListFirstItem.removeClass("available");
	}
	
	this.resetCommonTemplateList = function() {
		$("#commonTemplateList .item").addClass("available");
	}
	
	/* Pre-existing Template */
	this.showPreExistingDeletedTemplateForm = function() {
		addCommonTemplateForm.find("*[name=key]").attr("disabled", "disabled");
		addCommonTemplateForm.find("*[name=key]").blur();
		preExistingDeletedTemplateForm.slideDown(Constants.TOGGLE_TIME);
	}
}