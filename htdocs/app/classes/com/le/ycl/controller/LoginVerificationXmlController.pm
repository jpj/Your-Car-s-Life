package com::le::ycl::controller::LoginVerificationXmlController;

use strict;
use com::le::common::controller::XmlOutputController;
use com::le::ycl::util::YCLConstants;
use Modi::framework::mvc::ModelAndView;
use XML::LibXML;

use base qw(com::le::common::controller::XmlOutputController);

sub new {
	my $class = shift;
	my $self = {
	};
	return bless $self, $class;
}

sub createAndReturnXmlWithModelAndView {
	my $self = shift;
	my $request = shift;

	my $doc = undef;
	my $mav = new Modi::framework::mvc::ModelAndView();

	if ($self->verifyLogin($request)) {
		$doc = $self->createAndReturnXml($request);
		$mav->setViewName( $self->getViewName() );
	} else {
		$mav->setViewName( com::le::ycl::util::YCLConstants::ACCESS_DENIED_XML_VIEW );
	}

	return $doc, $mav;
}

sub verifyLogin {
	my $self = shift;
	my $request = shift;

	my $user = $request->getSession()->getAttribute("user");

	if ( $user && $user->getEnabled() ) {
		return 1;
	} else {
		return 0;
	}
}

#sub createAndReturnXml($request)

1;

