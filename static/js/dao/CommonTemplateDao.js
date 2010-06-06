function CommonTemplateDao() {

	this.getCommonTemplateByKey = function(key, view, callback) {
		getCommonTemplateByKey(key, view, callback);
	}
	
	this.getCommonTemplateList = function(view) {
		getCommonTemplateList(view);
	}
	
	this.updateCommonTemplate = function(commonTemplate, view) {
		updateCommonTemplate(commonTemplate, view);
	}
	
	this.updateCommonTemplateDeletedFlag = function(key, flag, view, callback) {
		updateCommonTemplateDeletedFlag(key, flag, view, callback);
	}
	
	this.addCommonTemplate = function(commonTemplate, view, callback) {
		addCommonTemplate(commonTemplate, view, callback);
	}

	var getCommonTemplateByKey = function(key, view, callback) {
		//alert("getCommonTemplateByKey called");
	
		view.setTemplateLoadMsg( "Processing..." );
	
		$.ajax({
			url: "getCommonTemplateByKey.jxml",
			data: { templateKey: key },
			error: function() {
				view.setTemplateLoadMsg( "Error retrieving xml" );
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						processRequest(xml);
					},
					function() {
						getCommonTemplateByKey(key, view, callback);
					}
				);
	
			}
		});
		
		var processRequest = function(xml) {
			if ( $("success", xml).text() == "true" ) {
				view.setTemplateId( $("template id", xml).text() );
				view.setTemplateKey( $("template key", xml).text() );
				view.setTemplateDescription( $("template description", xml).text() );
				view.setTemplateText( $("template text", xml).text() );
				
				view.setTemplateLoadMsg( "Successfully got template, " + $("template key", xml).text() );
				view.setTemplateSaveMsg( "Fresh Template: " + $("template key", xml).text() );
				view.setTemplateSize( view.getTemplateText().length );
				
				if (typeof callback == "function") {
					callback();
				}
			} else {
				view.setTemplateLoadMsg( $("error", xml).text() );
			}
		}
		
	}
	
	var getCommonTemplateList = function(view) {
		$.ajax({
			url: "getCommonTemplateList.jxml",
			error: function() {
				alert("error getting template list");
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						processRequest(xml);
					},
					function() {
						getCommonTemplateList(view);
					}
				);
			}
		});
		
		var processRequest = function(xml) {
			view.resetCommonTemplateList();
			$("template", xml).each(function() {
				var commonTemplate = new CommonTemplate();
				commonTemplate.id = $(this).find("id").text();
				commonTemplate.key = $(this).find("key").text();
				commonTemplate.description = $(this).find("description").text();
				commonTemplate.templateText = $(this).find("text").text();
				view.addCommonTemplateToList(commonTemplate);
			});
		}
	}
	
	var updateCommonTemplate = function(commonTemplate, view) {
		view.setTemplateSaveMsg("Processing...");
		
		$.ajax({
			url: "updateCommonTemplateByKey.jxml",
			data: {
				templateId:	commonTemplate.id,
				templateKey:	commonTemplate.key,
				templateText:	commonTemplate.templateText,
				templateDescription: commonTemplate.description
			},
			type: "POST",
			error: function() {
				view.setTemplateSaveMsg("Error. Could not save template.");
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						processRequest(xml);
					},
					function() {
						updateCommonTemplate(commonTemplate, view);
					}
				);
			}
		});
		
		var processRequest = function(xml) {
			if ( $("success", xml).text() == "false" ) {
				view.setTemplateSaveMsg( $("error", xml).text() );
			} else {
				view.setTemplateSaveMsg( "Template Saved" );
				getCommonTemplateList(view);
			}
		}
	}

	var updateCommonTemplateDeletedFlag = function(key, flag, view, callback) {
		view.setTemplateLoadMsg("Processing...");
		
		$.ajax({
			url: "updateCommonTemplateDeletedFlag.jxml",
			data: {
				templateKey:	key,
				templateFlag:	flag
			},
			type: "POST",
			error: function() {
				view.setTemplateLoadMsg("Error. Could not update template's deleted flag.");
			},
			success: function(xml) {
				handleRequest(
					xml,
					function() {
						processRequest(xml);
					},
					function() {
						updateCommonTemplateDeletedFlag(key, flag, view, callback);
					}
				);
			}
		});
		
		var processRequest = function(xml) {
			if ( $("success", xml).text() == "false" ) {
				view.setTemplateLoadMsg( $("error", xml).text() );
			} else {
				view.setTemplateLoadMsg( "Flag updated to " + flag + " for template " + key);
				if (typeof callback == "function") {
					callback();
				}
			}
		}
	}
	
	var addCommonTemplate = function(commonTemplate, view, callback) {
		//alert("addCommonTemplate adding");
		view.setTemplateLoadMsg("Processing...");
		
		$.ajax({
			url: "addCommonTemplate.jxml",
			data: {
				templateKey:	commonTemplate.key,
				templateText:	commonTemplate.templateText,
				templateDescription: commonTemplate.description
			},
			type: "POST",
			error: function() {
				view.setTemplateLoadMsg("Error. Could not add template.");
			},
			success: function(xml) {
				view.setTemplateLoadMsg("Handling Request...");
				handleRequest(
					xml,
					function() {
						view.setTemplateLoadMsg("Processing Request...");
						processRequest(xml);
					},
					function() {
						view.setTemplateLoadMsg("ReProcessing Request...");
						addCommonTemplate(commonTemplate, view, callback);
					}
				);
			}
		});
		
		var processRequest = function(xml) {
			if ( $("success", xml).text() == "false" ) {
				view.setTemplateLoadMsg( $("error", xml).text() );
				if ( $("preExistingDeletedTemplate", xml).text() == "true" ) {
					view.showPreExistingDeletedTemplateForm();
				}
			} else {
				view.setTemplateLoadMsg( "Template Added." );
				if (typeof callback == "function") {
					callback();
				}
			}
		}
	}

}