package com::le::ycl::controller::LoginVerificationController;

use strict;
use com::le::ycl::util::YCLConstants;
use Modi::framework::mvc::ModelAndView;
use Modi::framework::mvc::Controller;

use base qw(Modi::framework::mvc::Controller);

sub new {
	my $class = shift;
	my $self = {
		verifiedViewName => undef,
		failedViewName => undef
	};
	return bless $self, $class;
}

sub handleRequest {
	my $self = shift;
	my $request = shift;

	my $mav = new Modi::framework::mvc::ModelAndView();

	if ($self->verifyLogin($request)) {
		$mav = $self->verifiedHandleRequest($request);
	} else {
		$mav->setViewName( com::le::ycl::util::YCLConstants::ACCESS_DENIED_VIEW );
	}

	return $mav;
}

sub verifiedHandleRequest {
	my $self = shift;
	my $request = shift;

	my $mav = new Modi::framework::mvc::ModelAndView($self->getViewName());
	return $mav;
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

sub setVerifiedViewName {
	my $self = shift;
	$self->{verifiedViewName} = shift;
}

sub getVerifiedViewName {
	my $self = shift;
	return $self->{verifiedViewName};
}

sub setFailedViewName {
	my $self = shift;
	$self->{failedViewName} = shift;
}

sub getFailedViewName {
	my $self = shift;
	return $self->{failedViewName};
}

#sub createAndReturnXml($request)

1;

