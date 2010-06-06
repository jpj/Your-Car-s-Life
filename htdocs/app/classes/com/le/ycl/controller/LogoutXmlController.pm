package com::le::ycl::controller::LogoutXmlController;

use strict;
use com::le::common::controller::XmlOutputController;
use Modi::framework::mvc::ModelAndView;
use XML::LibXML;

use base qw(com::le::common::controller::XmlOutputController);

sub createAndReturnXmlWithModelAndView {
	my $self = shift;
	my $request = shift;

	my $doc = XML::LibXML->createDocument();

	$doc->setDocumentElement( $doc->createElement("logoutInformation") );
	my $successElement = $doc->createElement("logoutSuccess");

	$request->getSession()->setAttribute("user", undef);

	$successElement->appendText("true");
	$doc->getDocumentElement()->addChild($successElement);

	return ($doc, new Modi::framework::mvc::ModelAndView($self->getViewName()));
}

1;

