package com::le::ycl::controller::LoginXmlController;

use strict;
use com::le::common::controller::XmlOutputController;
use Modi::framework::mvc::ModelAndView;
use XML::LibXML;

use base qw(com::le::common::controller::XmlOutputController);

sub new {
	my $class = shift;
	my $self = {
		userDao => undef
	};
	return bless $self, $class;
}

sub createAndReturnXmlWithModelAndView {
	my $self = shift;
	my $request = shift;

	my $user = $self->{userDao}->getUserByLoginAndPassword($request->getParameter("login"), $request->getParameter("password"));

	my $doc = XML::LibXML->createDocument();

	$doc->setDocumentElement( $doc->createElement("loginInformation") );
	my $successElement = $doc->createElement("loginSuccess");

	if ( $user ) {
		$successElement->appendText("true");

		$request->getSession()->setAttribute("user", $user);
	} else {
		$successElement->appendText("false");
		my $errorElement = $doc->createElement("errorMessage");
		$errorElement->appendText("Login Failed.");
		$doc->getDocumentElement()->addChild($errorElement);
	}

	$doc->getDocumentElement()->addChild($successElement);

	return ($doc, new Modi::framework::mvc::ModelAndView($self->getViewName()));
}

sub setUserDao {
	my $self = shift;
	$self->{userDao} = shift;
}

1;

